import "dotenv/config";
import { beforeAll, afterAll, describe, it, expect } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import { obtenerMotivosDerivacion } from "./obtener-motivos-derivacion.js";

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

describe("Obtener motivos de derivación", () => {
  it("Debe cargar los 5 motivos de derivación definidos en FHIR", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const paises = await obtenerMotivosDerivacion(pool);
    expect(paises.length).toEqual(5);
  });

  it("Debe encontrar el motivo 'Confirmación Diagnóstica' dado su código FHIR '1'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const motivos = await obtenerMotivosDerivacion(pool);
    const motivoConfirmacion = motivos.find(
      (motivo) => motivo.codigo_fhir === "1"
    );

    expect(motivoConfirmacion?.id).toBeDefined();
    expect(motivoConfirmacion?.codigo_fhir).toEqual("1");
    expect(motivoConfirmacion?.texto).toEqual("Confirmación Diagnóstica");
  });

  it("Debe encontrar el motivo 'Control especialista' dado su código FHIR '2'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const motivos = await obtenerMotivosDerivacion(pool);
    const motivoControlEspecialista = motivos.find(
      (motivo) => motivo.codigo_fhir === "2"
    );

    expect(motivoControlEspecialista?.id).toBeDefined();
    expect(motivoControlEspecialista?.codigo_fhir).toEqual("2");
    expect(motivoControlEspecialista?.texto).toEqual("Control Especialista");
  });

  it("Debe encontrar el motivo 'Realiza tratamiento' dado su código FHIR '3'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const motivos = await obtenerMotivosDerivacion(pool);
    const motivoRealizaTratamiento = motivos.find(
      (motivo) => motivo.codigo_fhir === "3"
    );

    expect(motivoRealizaTratamiento?.id).toBeDefined();
    expect(motivoRealizaTratamiento?.codigo_fhir).toEqual("3");
    expect(motivoRealizaTratamiento?.texto).toEqual("Realizar Tratamiento");
  });

  it("Debe encontrar el motivo 'Seguimiento' dado su código FHIR '4'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const motivos = await obtenerMotivosDerivacion(pool);
    const motivoSeguimiento = motivos.find(
      (motivo) => motivo.codigo_fhir === "4"
    );

    expect(motivoSeguimiento?.id).toBeDefined();
    expect(motivoSeguimiento?.codigo_fhir).toEqual("4");
    expect(motivoSeguimiento?.texto).toEqual("Seguimiento");
  });

  it("Debe encontrar el motivo 'Otro' dado su código FHIR '5'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const motivos = await obtenerMotivosDerivacion(pool);
    const motivoOtro = motivos.find((motivo) => motivo.codigo_fhir === "5");

    expect(motivoOtro?.id).toBeDefined();
    expect(motivoOtro?.codigo_fhir).toEqual("5");
    expect(motivoOtro?.texto).toEqual("Otro");
  });
});
