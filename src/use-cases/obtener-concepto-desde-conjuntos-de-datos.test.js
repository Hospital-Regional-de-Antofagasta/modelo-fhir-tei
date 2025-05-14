import "dotenv/config";
import { expect, beforeAll, afterAll, it } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import {
  obtenerIdentidadGeneroDadoCodigoDEIS,
  obtenerPaisDadoCodigoDEIS,
  obtenerSexoBiologicoDadoCodigoFHIR,
  obtenerTipoIdentificadorPersonaDadoCodigoFHIR,
  obtenerUsoIdentificadorPersonaDadoCodigoFHIR,
} from "./db.js";

/** @type {import("mssql").ConnectionPool | undefined} */
let pool = undefined;

beforeAll(async () => {
  pool = await getDatabaseConnection({
    DB_USER: process.env.DB_USER,
    DB_PASSWORD: process.env.DB_PASSWORD,
    DB_HOST: process.env.DB_HOST,
    DB_NAME: process.env.DB_NAME,
    DB_PORT: process.env.DB_PORT,
  });
});

afterAll(async () => {
  if (pool) {
    pool.close();
    pool = undefined;
  }
});

it("Debe obtener la identidad de genero 'Masculino' a partir de su código DEIS (1)", async () => {
  expect.hasAssertions();
  if (!pool) throw new Error();

  const { texto } = await obtenerIdentidadGeneroDadoCodigoDEIS(pool, "1");
  expect(texto).toEqual("Masculino");
});

it("Debe obtener el sexo biologico 'Mujer' a partir de su código FHIR (female)", async () => {
  expect.hasAssertions();
  if (!pool) throw new Error();

  const { texto } = await obtenerSexoBiologicoDadoCodigoFHIR(pool, "female");
  expect(texto).toEqual("Mujer");
});

it("Debe obtener el país 'Chile' a partir de su código DEIS (152)", async () => {
  expect.hasAssertions();
  if (!pool) throw new Error();

  const { texto } = await obtenerPaisDadoCodigoDEIS(pool, "152");
  expect(texto).toEqual("Chile");
});

it("Debe obtener el tipo de identificador 'RUN' a partir de su código FHIR (01)", async () => {
  expect.hasAssertions();
  if (!pool) throw new Error();

  const { texto } = await obtenerTipoIdentificadorPersonaDadoCodigoFHIR(
    pool,
    "01"
  );

  expect(texto).toEqual("RUN");
});

it("Debe obtener el uso de identificador 'Secundario' a partir de su código FHIR ('secondary')", async () => {
  expect.hasAssertions();
  if (!pool) throw new Error();

  const { texto } = await obtenerUsoIdentificadorPersonaDadoCodigoFHIR(
    pool,
    "secondary"
  );
  expect(texto).toEqual("Secundario");
});
