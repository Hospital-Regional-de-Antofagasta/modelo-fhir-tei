import "dotenv/config";
import { beforeAll, afterAll, describe, it, expect } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import { obtenerEstadosDiagnostico } from "./obtener-estados-diagnostico.js";

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

describe("Obtener estados de diagnóstico", () => {
  it("Debe cargar los 6 estados de diagnóstico definidos en FHIR", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const estados = await obtenerEstadosDiagnostico(pool);
    expect(estados.length).toEqual(6);
  });

  it("Debe encontrar el estado 'Presuntivo' dado su código FHIR 'provisional'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const estados = await obtenerEstadosDiagnostico(pool);
    const estadoPresuntivo = estados.find(
      (estado) => estado.codigo_fhir === "provisional"
    );

    expect(estadoPresuntivo?.id).toBeDefined();
    expect(estadoPresuntivo?.codigo_fhir).toEqual("provisional");
    expect(estadoPresuntivo?.texto).toMatch("Presuntivo");
  });

  it("Debe encontrar el estado 'Confirmado' dado su código FHIR 'confirmed'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const estados = await obtenerEstadosDiagnostico(pool);
    const estadoConfirmado = estados.find(
      (estado) => estado.codigo_fhir === "confirmed"
    );

    expect(estadoConfirmado?.id).toBeDefined();
    expect(estadoConfirmado?.codigo_fhir).toEqual("confirmed");
    expect(estadoConfirmado?.texto).toMatch("Confirmado");
  });

  it("Debe encontrar el estado 'No confirmado' dado su código FHIR 'unconfirmed'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const estados = await obtenerEstadosDiagnostico(pool);
    const estadoNoConfirmado = estados.find(
      (estado) => estado.codigo_fhir === "unconfirmed"
    );

    expect(estadoNoConfirmado?.id).toBeDefined();
    expect(estadoNoConfirmado?.codigo_fhir).toEqual("unconfirmed");
    expect(estadoNoConfirmado?.texto).toMatch("No confirmado");
  });

  it("Debe encontrar el estado 'Diferencial' dado su código FHIR 'differential'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const estados = await obtenerEstadosDiagnostico(pool);
    const estadoDiferencial = estados.find(
      (estado) => estado.codigo_fhir === "differential"
    );

    expect(estadoDiferencial?.id).toBeDefined();
    expect(estadoDiferencial?.codigo_fhir).toEqual("differential");
    expect(estadoDiferencial?.texto).toMatch("Diferencial");
  });

  it("Debe encontrar el estado 'Refutado' dado su código FHIR 'refuted'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const estados = await obtenerEstadosDiagnostico(pool);
    const estadoRefutado = estados.find(
      (estado) => estado.codigo_fhir === "refuted"
    );

    expect(estadoRefutado?.id).toBeDefined();
    expect(estadoRefutado?.codigo_fhir).toEqual("refuted");
    expect(estadoRefutado?.texto).toMatch("Refutado");
  });

  it("Debe encontrar el estado 'Ingresado por error' dado su código FHIR 'entered-in-error'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const estados = await obtenerEstadosDiagnostico(pool);
    const estadoIngresadoPorError = estados.find(
      (estado) => estado.codigo_fhir === "entered-in-error"
    );

    expect(estadoIngresadoPorError?.id).toBeDefined();
    expect(estadoIngresadoPorError?.codigo_fhir).toEqual("entered-in-error");
    expect(estadoIngresadoPorError?.texto).toMatch("Ingresado por error");
  });
});
