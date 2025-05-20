import "dotenv/config";
import { beforeAll, afterAll, describe, it, expect } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import { obtenerPaises } from "./obtener-paises.js";
import { obtenerUsosIdentificadorPersona } from "./obtener-usos-identificador-persona.js";

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

describe("Obtener usos de identificador de persona", () => {
  it("Debe cargar los 5 usos definidos en FHIR", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const usos = await obtenerUsosIdentificadorPersona(pool);
    expect(usos.length).toEqual(5);
  });

  // Los usos son:  'usual', 'official', 'temp', 'secondary' y 'old'

  it("Debe encontrar el uso 'Común' dado su codigo FHIR 'usual'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const usos = await obtenerUsosIdentificadorPersona(pool);
    const usoUsual = usos.find((uso) => uso.codigo_fhir === "usual");

    expect(usoUsual?.id).toBeDefined();
    expect(usoUsual?.codigo_fhir).toEqual("usual");
    expect(usoUsual?.texto).toMatch("Común");
  });

  it("Debe encontrar el uso 'Oficial' dado su codigo FHIR 'official'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const usos = await obtenerUsosIdentificadorPersona(pool);
    const usoOfficial = usos.find((uso) => uso.codigo_fhir === "official");

    expect(usoOfficial?.id).toBeDefined();
    expect(usoOfficial?.codigo_fhir).toEqual("official");
    expect(usoOfficial?.texto).toMatch("Oficial");
  });

  it("Debe encontrar el uso 'Temporal' dado su codigo FHIR 'temp'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const usos = await obtenerUsosIdentificadorPersona(pool);
    const usoTemp = usos.find((uso) => uso.codigo_fhir === "temp");

    expect(usoTemp?.id).toBeDefined();
    expect(usoTemp?.codigo_fhir).toEqual("temp");
    expect(usoTemp?.texto).toMatch("Temporal");
  });

  it("Debe encontrar el uso 'Secundario' dado su codigo FHIR 'secondary'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const usos = await obtenerUsosIdentificadorPersona(pool);
    const usoSecondary = usos.find((uso) => uso.codigo_fhir === "secondary");

    expect(usoSecondary?.id).toBeDefined();
    expect(usoSecondary?.codigo_fhir).toEqual("secondary");
    expect(usoSecondary?.texto).toMatch("Secundario");
  });

  it("Debe encontrar el uso 'Antiguo' dado su codigo FHIR 'old'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const usos = await obtenerUsosIdentificadorPersona(pool);
    const usoOld = usos.find((uso) => uso.codigo_fhir === "old");

    expect(usoOld?.id).toBeDefined();
    expect(usoOld?.codigo_fhir).toEqual("old");
    expect(usoOld?.texto).toMatch("Antiguo");
  });
});
