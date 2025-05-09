import "dotenv/config";
import path from "path";
import { getDatabaseConnection, getFilenamesRecursively } from "./utils.js";
import { dropTables } from "./drop-tables.js";
import { createTables } from "./create-tables.js";

const { DB_USER, DB_PASSWORD, DB_HOST, DB_NAME, DB_PORT } = process.env;

const MODO = process.argv[4];

if (
  MODO !== "drop-tables" &&
  MODO !== "create-tables" &&
  MODO !== "drop-and-create-tables"
) {
  throw new Error("Modo incorrecto");
}

let sqlTableScriptsFilenames = getFilenamesRecursively(
  path.join(".", "sql", "tables")
);

const sqlAlterScriptsFilenames = sqlTableScriptsFilenames.filter((f) =>
  f.endsWith(".alter.sql")
);

const sqlAddConstraintsScriptFilename = sqlTableScriptsFilenames.find((f) =>
  f.endsWith("constraints.add.sql")
);

const sqlDropConstraintsScriptFilename = sqlTableScriptsFilenames.find((f) =>
  f.endsWith("constraints.drop.sql")
);

const sqlDropTablesScriptFilename = sqlTableScriptsFilenames.find((f) =>
  f.endsWith("tables.drop.sql")
);

if (
  sqlDropConstraintsScriptFilename === undefined ||
  sqlDropTablesScriptFilename === undefined ||
  sqlAlterScriptsFilenames.length === 0 ||
  sqlAddConstraintsScriptFilename === undefined
) {
  throw new Error("No se encontraron todos los scripts");
}

sqlTableScriptsFilenames = sqlTableScriptsFilenames.filter(
  (f) =>
    !f.endsWith(".alter.sql") &&
    !f.endsWith(".drop.sql") &&
    !f.endsWith(".add.sql")
);

getDatabaseConnection({
  DB_USER,
  DB_PASSWORD,
  DB_HOST,
  DB_NAME,
  DB_PORT,
}).then(async (con) => {
  console.log("Conectado a la base de datos");

  const tran = con.transaction();

  console.log("Iniciando transacción...");
  await tran.begin();

  try {
    if (MODO === "drop-tables") {
      await dropTables({
        tran,
        sqlDropConstraintsScriptFilename,
        sqlDropTablesScriptFilename,
      });
    } else if (MODO === "create-tables") {
      await createTables({
        tran,
        sqlTableScriptsFilenames,
        sqlAlterScriptsFilenames,
        sqlAddConstraintsScriptFilename,
      });
    } else if (MODO === "drop-and-create-tables") {
      await dropTables({
        tran,
        sqlDropConstraintsScriptFilename,
        sqlDropTablesScriptFilename,
      });

      await createTables({
        tran,
        sqlTableScriptsFilenames,
        sqlAlterScriptsFilenames,
        sqlAddConstraintsScriptFilename,
      });
    }

    console.log("Confirmando transacción...");
    await tran.commit();
  } catch (error) {
    console.error(error);
    console.log("Revirtiendo transacción...");
    await tran.rollback();
  }

  console.log("Listo ✅");
  await con.close();
});
