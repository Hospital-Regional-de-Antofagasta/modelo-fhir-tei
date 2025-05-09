import "dotenv/config";
import fs from "fs";
import path from "path";

/**
 *
 * @param {object} params
 * @param {import("mssql").Transaction} params.tran
 * @param {string[]} params.sqlTableScriptsFilenames
 * @param {string[]} params.sqlAlterScriptsFilenames
 * @param {string} params.sqlAddConstraintsScriptFilename
 *
 */
export async function createTables({
  tran,
  sqlTableScriptsFilenames,
  sqlAlterScriptsFilenames,
  sqlAddConstraintsScriptFilename,
}) {
  for (const createTableScriptFilename of sqlTableScriptsFilenames) {
    console.log(
      `Creando tabla '${path.basename(createTableScriptFilename)}'...`
    );
    const createTableQuery = fs.readFileSync(
      createTableScriptFilename,
      "utf-8"
    );
    await tran.request().query(createTableQuery);
  }

  console.log("Modificando tablas...");
  for (const alterTableScriptFilename of sqlAlterScriptsFilenames) {
    const alterTableQuery = fs.readFileSync(alterTableScriptFilename, "utf-8");
    await tran.request().query(alterTableQuery);
  }

  console.log("Creando constraints...");
  const addConstraintsQuery = fs.readFileSync(
    sqlAddConstraintsScriptFilename,
    "utf-8"
  );
  await tran.request().query(addConstraintsQuery);
}
