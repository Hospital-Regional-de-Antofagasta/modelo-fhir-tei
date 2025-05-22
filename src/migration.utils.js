import { getFilenamesRecursively } from "./utils.js";
import path from "path";
import fs from "fs";
import mssql from "mssql";

/**
 *
 * @param {import('mssql').Transaction} tran
 * @param {string} tableScriptPath
 */
async function createTable(tran, tableScriptPath) {
  const tableName = tableScriptPath.split("\\").pop()?.replace(".sql", "");
  const { existe } = (
    await tran
      .request()
      .output("existe", mssql.Bit)
      .query(
        `SELECT @existe = CASE WHEN (OBJECT_ID('dbo.${tableName}', 'U') IS NOT NULL) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END;`
      )
  ).output;

  if (!existe) {
    console.log(`⚡ Executing ${tableScriptPath}...`);
    const query = fs.readFileSync(tableScriptPath, "utf-8");
    await tran.request().query(query);
  } else {
    console.warn(`👀 Skipping table '${tableName}' as it already exists...`);
  }
}

/**
 *
 * @param {import('mssql').Transaction|import('mssql').ConnectionPool} tran
 */
export async function createUtilFunctions(tran) {
  await tran.request().query(`
      CREATE OR ALTER FUNCTION dbo._ExisteColumnaEnTabla (
        @NombreTabla varchar(100),
        @NombreColumna varchar(100)
      )
      RETURNS BIT
      AS
      BEGIN
        DECLARE @resultado BIT;

        IF EXISTS (
          SELECT 1 FROM sys.columns WHERE Name = @NombreColumna AND Object_ID = OBJECT_ID(@NombreTabla, 'U')
        ) BEGIN
          SET @resultado = 1;
        END ELSE BEGIN
          SET @resultado = 0;
        END

        RETURN @resultado
      END
    `);
  await tran.request().query(`
    CREATE OR ALTER FUNCTION dbo._ObtenerColumnasPK (
      @NombreTabla varchar(100)
    )
    RETURNS TABLE
    AS RETURN
      SELECT column_name as NombreColumna
      FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC 
      INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
          ON TC.CONSTRAINT_TYPE = 'PRIMARY KEY' 
          AND TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME 
          AND 'dbo.' + KU.table_name = @NombreTabla
  `);
}

/**
 * @param {import('mssql').Transaction} tran
 */
export async function migrateUp(tran) {
  await createUtilFunctions(tran);
  await createBaseTables(tran);

  const scripts = getFilenamesRecursively(path.join(".", "sql", "tables"))
    .filter((f) => f.endsWith(".sql") && !f.endsWith(".down.sql"))
    .map((f) => {
      const priority = fs
        .readFileSync(f, "utf-8")
        .match(/\/\* (\d+) \*\//)?.[1];

      const parentDir = f.split("\\").at(-2) ?? "???";

      return {
        path: f,
        priority: priority ? parseInt(priority) : -1,
        parentDir: parentDir,
      };
    })
    .filter((f) => f.priority >= 0 && f.parentDir !== "base")
    .sort((a, b) => b.priority - a.priority);

  for (const table of scripts) {
    await createTable(tran, table.path);
  }

  await createStoredProcedures(tran);
}

/**
 * @param {import('mssql').Transaction} tran
 */
async function createBaseTables(tran) {
  const scripts = getFilenamesRecursively(
    path.join(".", "sql", "tables", "base")
  )
    .filter((f) => f.endsWith(".sql"))
    .map((f) => {
      const priority = fs
        .readFileSync(f, "utf-8")
        .match(/\/\* (\d+) \*\//)?.[1];

      return {
        path: f,
        tableName: f.split("\\").pop()?.replace(".sql", ""),
        priority: priority ? parseInt(priority) : -1,
      };
    })
    .filter((f) => f.priority >= 0)
    .sort((a, b) => b.priority - a.priority);

  for (const table of scripts) {
    await createTable(tran, table.path);
  }
}

/**
 * @param {import('mssql').Transaction} tran
 */
export async function migrateDown(tran) {
  const scripts = getFilenamesRecursively(path.join(".", "sql", "tables"))
    .filter((f) => f.endsWith(".sql") && !f.endsWith(".up.sql"))
    .map((f) => {
      const priority = fs
        .readFileSync(f, "utf-8")
        .match(/\/\* (\d+) \*\//)?.[1];

      const parentDir = f.split("\\").at(-2) ?? "???";

      return {
        path: f,
        tableName: f.split("\\").pop()?.replace(".sql", ""),
        priority: priority ? parseInt(priority) : -1,
        parentDir: parentDir,
        isDownScript: f.endsWith(".down.sql"),
      };
    })
    .filter((f) => f.priority >= 0 && f.parentDir !== "base")
    .sort((a, b) => a.priority - b.priority);

  for (const table of scripts) {
    if (table.isDownScript) {
      console.log(`⚡ Executing ${table.path}...`);
      const query = fs.readFileSync(table.path, "utf-8");
      await tran.request().query(query);
    } else {
      console.info(`🧨 Dropping table '${table.tableName}'...`);
      await tran
        .request()
        .query(`DROP TABLE IF EXISTS [dbo].[${table.tableName}];`);
    }
  }

  await tran.request().query(`
      DROP FUNCTION IF EXISTS dbo._ExisteColumnaEnTabla;
      DROP FUNCTION IF EXISTS dbo._ObtenerColumnasPK;
    `);
}

/**
 * @param {import('mssql').Transaction} tran
 */
export async function createStoredProcedures(tran) {
  const storedProcedureFilenames = getFilenamesRecursively(
    path.join(".", "sql", "stored-procedures")
  ).filter((f) => f.endsWith(".sql"));

  for (const spFilename of storedProcedureFilenames) {
    console.log(`⚡ Executing ${spFilename}...`);
    const query = fs.readFileSync(spFilename, "utf-8");
    await tran.request().query(query);
  }
}
