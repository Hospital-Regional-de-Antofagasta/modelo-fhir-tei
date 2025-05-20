import "dotenv/config";
import { beforeAll, afterAll, describe, it, expect } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import { obtenerPaises } from "./obtener-paises.js";

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

describe("Obtener paises", () => {
  it("Debe cargar los 249 paises definidos en FHIR", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const paises = await obtenerPaises(pool);
    expect(paises.length).toEqual(249);
  });

  it("Debe encontrar al pais 'Chile' dado su código de país '152'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const paises = await obtenerPaises(pool);
    const paisChile = paises.find((pais) => pais.codigo_fhir === "152");

    expect(paisChile?.id).toBeDefined();
    expect(paisChile?.codigo_fhir).toEqual("152");
    expect(paisChile?.texto).toEqual("Chile");
  });

  it("Debe encontrar al pais 'Colombia' dado su código de pais '170'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const paises = await obtenerPaises(pool);
    const paisColombia = paises.find((pais) => pais.codigo_fhir === "170");

    expect(paisColombia?.id).toBeDefined();
    expect(paisColombia?.codigo_fhir).toEqual("170");
    expect(paisColombia?.texto).toEqual("Colombia");
  });

  it("Debe encontrar al pais 'Uruguay' dado su código de pais '858'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const paises = await obtenerPaises(pool);
    const paisUruguay = paises.find((pais) => pais.codigo_fhir === "858");

    expect(paisUruguay?.id).toBeDefined();
    expect(paisUruguay?.codigo_fhir).toEqual("858");
    expect(paisUruguay?.texto).toEqual("Uruguay");
  });
});
