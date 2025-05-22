import mssql from "mssql";
import * as fs from "fs";
import * as path from "path";

export function getFilenamesRecursively(/** @type {string} */ directory) {
  const dirents = fs.readdirSync(directory, {
    withFileTypes: true,
  });

  const /** @type {string[]} */ filenames = [];

  for (const file of dirents.filter((d) => d.isFile())) {
    filenames.push(path.join(directory, file.name));
  }

  for (const dir of dirents.filter((d) => d.isDirectory())) {
    const directoryFilenames = getFilenamesRecursively(
      path.join(directory, dir.name)
    );

    filenames.push(...directoryFilenames);
  }

  return filenames;
}

/**
 * @param {object} params
 * @param {string} [params.DB_USER]
 * @param {string} [params.DB_PASSWORD]
 * @param {string} [params.DB_HOST]
 * @param {string} [params.DB_NAME]
 * @param {string} [params.DB_PORT]
 */
export function getDatabaseConnection({
  DB_USER,
  DB_PASSWORD,
  DB_HOST,
  DB_PORT,
  DB_NAME,
}) {
  return mssql.connect({
    server: String(DB_HOST),
    database: String(DB_NAME),
    user: String(DB_USER),
    port: Number(DB_PORT),
    password: String(DB_PASSWORD),
    connectionTimeout: 30000,
    options: {
      trustServerCertificate: true,
      encrypt: false,
    },
  });
}

/**
 * @returns {object}
 */
export function cargarBundleIniciarEnriquecido() {
  const bundleIniciarEnriquecido = fs.readFileSync(
    path.join(".", "src", "bundle-iniciar-enriquecido.json"),
    "utf-8"
  );

  return JSON.parse(bundleIniciarEnriquecido);
}
