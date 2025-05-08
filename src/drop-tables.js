import "dotenv/config";
import fs from "fs";

/**
 *
 * @param {object} params
 * @param {import("mssql").Transaction} params.tran
 * @param {string} params.sqlDropConstraintsScriptFilename
 * @param {string} params.sqlDropTablesScriptFilename
 *
 */
export async function dropTables({
  tran,
  sqlDropConstraintsScriptFilename,
  sqlDropTablesScriptFilename,
}) {
  console.info("Eliminando constraints...");
  const dropConstraintsQuery = fs.readFileSync(
    sqlDropConstraintsScriptFilename,
    "utf-8"
  );
  await tran.request().query(dropConstraintsQuery);

  console.info("Eliminando tablas...");
  const dropTablesQuery = fs.readFileSync(sqlDropTablesScriptFilename, "utf-8");
  await tran.request().query(dropTablesQuery);
}
