import "dotenv/config";
import mssql from "mssql";
import * as fs from "fs";
import * as path from "path";

const baseTablesScripts = fs
  .readdirSync(path.join(".", "sql", "tables"))
  .filter((f) => f.endsWith(".sql"))
  .map((f) => path.join(".", "sql", "tables", f));

const tabExtensionTablesScripts = fs
  .readdirSync(path.join(".", "sql", "tables", "extension", "tab"))
  .filter((f) => f.endsWith(".sql"))
  .map((f) => path.join(".", "sql", "tables", "extension", "tab", f));

// .filter((x) => x.endsWith(".sql"));
// .map((x) => fs.readFileSync(path.join(__dirname, "sql", x), "utf-8"))

async function createTables(
  /** @type {string[]} */ tableScripts,
  /** @type {mssql.ConnectionPool}*/ connectionPool
) {
  for (const tableScript of tableScripts) {
    try {
      const sql = fs.readFileSync(tableScript, "utf-8");
      await new mssql.Request(connectionPool).query(sql);
    } catch (error) {
      console.error(error);
    }
  }
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

    try {
      await createTables(baseTablesScripts, con);
      // await createTables(tabExtensionTablesScripts, con);
    } catch (error) {
      throw error;
    }

    // const res = (await con.request().query("SELECT DB_NAME();")).recordset;

    console.log("OK");

    await con.close();
  });
