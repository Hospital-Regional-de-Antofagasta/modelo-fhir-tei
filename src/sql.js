import "dotenv/config";
import mssql from "mssql";
import * as fs from "fs";
import * as path from "path";

const tablesPath = path.join(".", "sql", "tables");

function getScriptsPaths(/** @type {string} */ scriptsDirectoryPath) {
  return fs
    .readdirSync(scriptsDirectoryPath)
    .filter((filename) => filename.endsWith(".sql"))
    .map((filename) => path.join(scriptsDirectoryPath, filename));
}

const mainTablesFilenames = getScriptsPaths(tablesPath);

const tabExtensionTableFilenames = getScriptsPaths(
  path.join(tablesPath, "extension", "tab")
);

const extensionTableFilenames = getScriptsPaths(
  path.join(tablesPath, "extension")
);

async function createTable(
  /** @type {string} */ scriptPath,
  /** @type {mssql.Transaction}*/ tran
) {
  console.log(`Ejecutando script '${path.basename(scriptPath)}'`);
  const sql = fs.readFileSync(scriptPath, "utf-8");
  await tran.request().query(sql);
}

const { DB_USER, DB_PASSWORD, DB_HOST, DB_NAME, DB_PORT } = process.env;

mssql
  .connect({
    server: String(DB_HOST),
    database: String(DB_NAME),
    user: String(DB_USER),
    password: String(DB_PASSWORD),
    options: {
      trustServerCertificate: true,
      encrypt: false,
    },
  })
  .then(async (con) => {
    console.log("Conectado a la base de datos");

    console.log("Iniciando transacción");
    const tran = new mssql.Transaction(con);
    await tran.begin();

    await tran
      .request()
      .input(
        "command1",
        mssql.NVarChar(2000),
        "ALTER TABLE ? NOCHECK CONSTRAINT ALL"
      )
      .execute("sp_MSforeachtable");

    try {
      console.log("Creando tablas principales");
      for (const mainTableFilename of mainTablesFilenames) {
        await createTable(mainTableFilename, tran);
      }

      console.log("Creando tablas TAB de extension");

      for (const tabExtensionTableFilename of tabExtensionTableFilenames) {
        await createTable(tabExtensionTableFilename, tran);
      }

      console.log("Creando tablas de extension");

      for (const extensionTableFilename of extensionTableFilenames) {
        await createTable(extensionTableFilename, tran);
      }
      // await createTables(tabExtensionTablesScripts, con);
    } catch (error) {
      console.error(error);
    }

    await tran
      .request()
      .input(
        "command1",
        mssql.NVarChar(2000),
        "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"
      )
      .execute("sp_MSforeachtable");

    await tran.commit();

    // const res = (await con.request().query("SELECT DB_NAME();")).recordset;

    console.log("OK");

    await con.close();
  });
