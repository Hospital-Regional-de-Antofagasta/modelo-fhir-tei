import "dotenv/config";
import { beforeAll, afterAll, describe, it, expect } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import { obtenerReferenciasDestino } from "./obtener-referencias-destino.js";

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

describe("Obtener referencias de destino", () => {
  it("Debe cargar las 5 referencias de destino definidas en FHIR", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const referencias = await obtenerReferenciasDestino(pool);
    expect(referencias.length).toEqual(5);
  });

  it("Debe encontrar la referencia de destino 'Nivel Secundario' dado su código FHIR '1'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const referencias = await obtenerReferenciasDestino(pool);
    const referenciaNivelSecundario = referencias.find(
      (referencia) => referencia.codigo_fhir === "1"
    );

    expect(referenciaNivelSecundario?.id).toBeDefined();
    expect(referenciaNivelSecundario?.codigo_fhir).toEqual("1");
    expect(referenciaNivelSecundario?.texto).toMatch("Nivel Secundario");
  });

  it("Debe encontrar la referencia de destino 'APS' dado su código FHIR '2'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const referencias = await obtenerReferenciasDestino(pool);
    const referenciaAPS = referencias.find(
      (referencia) => referencia.codigo_fhir === "2"
    );

    expect(referenciaAPS?.id).toBeDefined();
    expect(referenciaAPS?.codigo_fhir).toEqual("2");
    expect(referenciaAPS?.texto).toMatch("APS");
  });

  it("Debe encontrar la referencia de destino 'Extra Sistema' dado su código FHIR '3'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const referencias = await obtenerReferenciasDestino(pool);
    const referenciaExtraSistema = referencias.find(
      (referencia) => referencia.codigo_fhir === "3"
    );

    expect(referenciaExtraSistema?.id).toBeDefined();
    expect(referenciaExtraSistema?.codigo_fhir).toEqual("3");
    expect(referenciaExtraSistema?.texto).toMatch("Extra Sistema");
  });

  it("Debe encontrar la referencia de destino 'Hospital Digital' dado su código FHIR '4'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const referencias = await obtenerReferenciasDestino(pool);
    const referenciaHospitalDigital = referencias.find(
      (referencia) => referencia.codigo_fhir === "4"
    );

    expect(referenciaHospitalDigital?.id).toBeDefined();
    expect(referenciaHospitalDigital?.codigo_fhir).toEqual("4");
    expect(referenciaHospitalDigital?.texto).toMatch("Hospital Digital");
  });

  it("Debe encontrar la referencia de destino 'Establecimiento Alta Complejidad' dado su código FHIR '5'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const referencias = await obtenerReferenciasDestino(pool);
    const referenciaEstablecimientoDeAltaComplejidad = referencias.find(
      (referencia) => referencia.codigo_fhir === "5"
    );

    expect(referenciaEstablecimientoDeAltaComplejidad?.id).toBeDefined();
    expect(referenciaEstablecimientoDeAltaComplejidad?.codigo_fhir).toEqual(
      "5"
    );
    expect(referenciaEstablecimientoDeAltaComplejidad?.texto).toMatch(
      "Establecimiento Alta Complejidad"
    );
  });
});
