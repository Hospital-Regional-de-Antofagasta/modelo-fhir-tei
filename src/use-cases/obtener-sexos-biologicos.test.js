import "dotenv/config";
import { beforeAll, afterAll, describe, it, expect } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import { obtenerSexosBiologicos } from "./obtener-sexos-biologicos.js";

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

describe("Obtener sexos biológicos", () => {
  it("Debe cargar los 4 sexos biológicos definidos en FHIR", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const sexosBiologicos = await obtenerSexosBiologicos(pool);
    expect(sexosBiologicos.length).toEqual(4);
  });

  it("Debe encontrar al sexo biológico 'Hombre' dado su código FHIR 'male'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const sexosBiologicos = await obtenerSexosBiologicos(pool);
    const sbMasculino = sexosBiologicos.find((sb) => sb.codigo_fhir === "male");

    expect(sbMasculino?.id).toBeDefined();
    expect(sbMasculino?.codigo_fhir).toEqual("male");
    expect(sbMasculino?.texto).toEqual("Hombre");
  });

  it("Debe encontrar al sexo biológico 'Mujer' dado su código FHIR 'female'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const sexosBiologicos = await obtenerSexosBiologicos(pool);
    const sbFemenino = sexosBiologicos.find(
      (sb) => sb.codigo_fhir === "female"
    );

    expect(sbFemenino?.id).toBeDefined();
    expect(sbFemenino?.codigo_fhir).toEqual("female");
    expect(sbFemenino?.texto).toEqual("Mujer");
  });

  it("Debe encontrar al sexo biológico 'Otro' - homologado como 'Intersexual' - dado su código FHIR 'other'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const sexosBiologicos = await obtenerSexosBiologicos(pool);
    const sbOtro = sexosBiologicos.find((sb) => sb.codigo_fhir === "other");

    expect(sbOtro?.id).toBeDefined();
    expect(sbOtro?.codigo_fhir).toEqual("other");
    expect(sbOtro?.texto).toEqual("Intersexual");
  });

  it("Debe encontrar al sexo biológico 'Desconocido' dado su código FHIR 'unknown'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const sexosBiologicos = await obtenerSexosBiologicos(pool);
    const sbDesconocido = sexosBiologicos.find(
      (sb) => sb.codigo_fhir === "unknown"
    );

    expect(sbDesconocido?.id).toBeDefined();
    expect(sbDesconocido?.codigo_fhir).toEqual("unknown");
    expect(sbDesconocido?.texto).toEqual("Desconocido");
  });
});
