import "dotenv/config";
import { beforeAll, afterAll, describe, it, expect } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import { obtenerReferenciasOrigen } from "./obtener-referencias-origen.js";

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

describe("Obtener referencias de origen", () => {
  it("Debe cargar las 3 referencias de origen definidas en FHIR", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const referencias = await obtenerReferenciasOrigen(pool);
    expect(referencias.length).toEqual(3);
  });

  it("Debe encontrar la referencia de origen 'APS' dado su código FHIR '1'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const referencias = await obtenerReferenciasOrigen(pool);
    const referenciaAPS = referencias.find(
      (referencia) => referencia.codigo_fhir === "1"
    );

    expect(referenciaAPS?.id).toBeDefined();
    expect(referenciaAPS?.codigo_fhir).toEqual("1");
    expect(referenciaAPS?.texto).toMatch("APS");
  });

  it("Debe encontrar la referencia de origen 'Urgencia' dado su código FHIR '2'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const referencias = await obtenerReferenciasOrigen(pool);
    const referenciaUrgencia = referencias.find(
      (referencia) => referencia.codigo_fhir === "2"
    );

    expect(referenciaUrgencia?.id).toBeDefined();
    expect(referenciaUrgencia?.codigo_fhir).toEqual("2");
    expect(referenciaUrgencia?.texto).toMatch("Urgencia");
  });

  it("Debe encontrar la referencia de origen 'Derivación' dado su código FHIR '3'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const referencias = await obtenerReferenciasOrigen(pool);
    const referenciaDerivacion = referencias.find(
      (referencia) => referencia.codigo_fhir === "3"
    );
    expect(referenciaDerivacion?.id).toBeDefined();
    expect(referenciaDerivacion?.codigo_fhir).toEqual("3");
    expect(referenciaDerivacion?.texto).toMatch("Derivación");
  });
});
