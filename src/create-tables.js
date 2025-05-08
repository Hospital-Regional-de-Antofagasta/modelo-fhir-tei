import "dotenv/config";
import fs from "fs";
import path from "path";

/**
 *
 * @param {object} params
 * @param {import("mssql").Transaction} params.tran
 * @param {string[]} params.sqlTableScriptsFilenames
 * @param {string} params.sqlAlterPacPacienteScriptFilename
 * @param {string} params.sqlAddConstraintsScriptFilename
 *
 */
export async function createTables({
  tran,
  sqlTableScriptsFilenames,
  sqlAlterPacPacienteScriptFilename,
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

  console.log("Agregando columnas nuevas a PAC_Paciente...");
  const alterPacPacienteQuery = fs.readFileSync(
    sqlAlterPacPacienteScriptFilename,
    "utf-8"
  );
  await tran.request().query(alterPacPacienteQuery);

  console.log("Creando constraints...");
  const addConstraintsQuery = fs.readFileSync(
    sqlAddConstraintsScriptFilename,
    "utf-8"
  );
  await tran.request().query(addConstraintsQuery);
}
