import "dotenv/config";
import { beforeAll, afterAll, describe, it, expect } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import { obtenerIdentidadesGenero } from "./obtener-identidades-genero.js";

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

describe("Obtener identidades de genero", () => {
  it("Debe cargar las 7 identidades de genero definidas en FHIR", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const identidades = await obtenerIdentidadesGenero(pool);
    expect(identidades.length).toEqual(7);
  });

  it("Debe encontrar la identidad de genero 'Masculino' dado su código FHIR '1'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const identidades = await obtenerIdentidadesGenero(pool);
    const identidadMasculino = identidades.find(
      (identidad) => identidad.codigo_fhir === "1"
    );

    expect(identidadMasculino?.id).toBeDefined();
    expect(identidadMasculino?.codigo_fhir).toEqual("1");
    expect(identidadMasculino?.texto).toMatch("Masculino");
  });

  it("Debe encontrar la identidad de genero 'Femenina' dado su código FHIR '2'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const identidades = await obtenerIdentidadesGenero(pool);
    const identidadFemenina = identidades.find(
      (identidad) => identidad.codigo_fhir === "2"
    );

    expect(identidadFemenina?.id).toBeDefined();
    expect(identidadFemenina?.codigo_fhir).toEqual("2");
    expect(identidadFemenina?.texto).toMatch("Femenina");
  });

  it("Debe encontrar la identidad de genero 'Transgénero Masculino' dado su código FHIR '3'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const identidades = await obtenerIdentidadesGenero(pool);
    const identidadTransgeneroMasculino = identidades.find(
      (identidad) => identidad.codigo_fhir === "3"
    );

    expect(identidadTransgeneroMasculino?.id).toBeDefined();
    expect(identidadTransgeneroMasculino?.codigo_fhir).toEqual("3");
    expect(identidadTransgeneroMasculino?.texto).toMatch(
      "Transgénero Masculino"
    );
  });

  it("Debe encontrar la identidad de genero 'Transgénero Femenina' dado su código FHIR '4'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const identidades = await obtenerIdentidadesGenero(pool);
    const identidadTransgeneroFemenina = identidades.find(
      (identidad) => identidad.codigo_fhir === "4"
    );

    expect(identidadTransgeneroFemenina?.id).toBeDefined();
    expect(identidadTransgeneroFemenina?.codigo_fhir).toEqual("4");
    expect(identidadTransgeneroFemenina?.texto).toMatch("Transgénero Femenina");
  });

  it("Debe encontrar la identidad de genero 'No binarie' dado su código FHIR '5'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const identidades = await obtenerIdentidadesGenero(pool);
    const identidadNoBinarie = identidades.find(
      (identidad) => identidad.codigo_fhir === "5"
    );

    expect(identidadNoBinarie?.id).toBeDefined();
    expect(identidadNoBinarie?.codigo_fhir).toEqual("5");
    expect(identidadNoBinarie?.texto).toMatch("No Binarie");
  });

  it("Debe encontrar la identidad de genero 'Otra' dado su código FHIR '6'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const identidades = await obtenerIdentidadesGenero(pool);
    const identidadOtra = identidades.find(
      (identidad) => identidad.codigo_fhir === "6"
    );

    expect(identidadOtra?.id).toBeDefined();
    expect(identidadOtra?.codigo_fhir).toEqual("6");
    expect(identidadOtra?.texto).toMatch("Otra");
  });

  it("Debe encontrar la identidad de genero 'No revelado' dado su código FHIR '7'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const identidades = await obtenerIdentidadesGenero(pool);
    const identidadNoRevelado = identidades.find(
      (identidad) => identidad.codigo_fhir === "7"
    );

    expect(identidadNoRevelado?.id).toBeDefined();
    expect(identidadNoRevelado?.codigo_fhir).toEqual("7");
    expect(identidadNoRevelado?.texto).toMatch("No Revelado");
  });
});
