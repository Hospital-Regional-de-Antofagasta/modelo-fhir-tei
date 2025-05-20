import "dotenv/config";
import { beforeAll, afterAll, describe, it, expect } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import { obtenerModalidadesAtencion } from "./obtener-modalidades-atencion.js";

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

describe("Obtener modalidades de atención", () => {
  it("Debe cargar las 3 modalidades de atención definidas en FHIR", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const modalidades = await obtenerModalidadesAtencion(pool);
    expect(modalidades.length).toEqual(3);
  });

  // Las modalidades son 1: 'Presencial', 2: 'Remota', 3: 'Telemedicina';

  it("Debe encontrar la modalidad 'Presencial' dado su código FHIR '1'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const modalidades = await obtenerModalidadesAtencion(pool);
    const modalidadPresencial = modalidades.find(
      (modalidad) => modalidad.codigo_fhir === "1"
    );

    expect(modalidadPresencial?.id).toBeDefined();
    expect(modalidadPresencial?.codigo_fhir).toEqual("1");
    expect(modalidadPresencial?.texto).toMatch("Presencial");
  });

  it("Debe encontrar la modalidad 'Remota' dado su código FHIR '2'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const modalidades = await obtenerModalidadesAtencion(pool);
    const modalidadRemota = modalidades.find(
      (modalidad) => modalidad.codigo_fhir === "2"
    );

    expect(modalidadRemota?.id).toBeDefined();
    expect(modalidadRemota?.codigo_fhir).toEqual("2");
    expect(modalidadRemota?.texto).toMatch("Remota");
  });

  it("Debe encontrar la modalidad 'Telemedicina' dado su código FHIR '3'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const modalidades = await obtenerModalidadesAtencion(pool);
    const modalidadTelemedicina = modalidades.find(
      (modalidad) => modalidad.codigo_fhir === "3"
    );

    expect(modalidadTelemedicina?.id).toBeDefined();
    expect(modalidadTelemedicina?.codigo_fhir).toEqual("3");
    expect(modalidadTelemedicina?.texto).toMatch("Telemedicina");
  });
});
