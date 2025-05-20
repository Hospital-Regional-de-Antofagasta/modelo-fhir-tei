import "dotenv/config";
import { beforeAll, afterAll, describe, it, expect } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import { obtenerPueblosOriginarios } from "./obtener-pueblos-originarios.js";

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

describe("Obtener pueblos originarios", () => {
  it("Debe cargar los 11 pueblos originarios definidos en FHIR", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const pueblos = await obtenerPueblosOriginarios(pool);
    expect(pueblos.length).toEqual(11);
  });

  it("Debe encontrar el pueblo originario 'Mapuche' dado su código FHIR '01'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const pueblos = await obtenerPueblosOriginarios(pool);
    const puebloMapuche = pueblos.find((pueblo) => pueblo.codigo_fhir === "01");

    expect(puebloMapuche?.id).toBeDefined();
    expect(puebloMapuche?.codigo_fhir).toEqual("01");
    expect(puebloMapuche?.texto).toMatch("Mapuche");
  });

  it("Debe encontrar el pueblo originario 'Aymara' dado su código FHIR '02'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const pueblos = await obtenerPueblosOriginarios(pool);
    const puebloAymara = pueblos.find((pueblo) => pueblo.codigo_fhir === "02");

    expect(puebloAymara?.id).toBeDefined();
    expect(puebloAymara?.codigo_fhir).toEqual("02");
    expect(puebloAymara?.texto).toMatch("Aymara");
  });

  it("Debe encontrar el pueblo originario 'Rapa Nui' dado su código FHIR '03'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const pueblos = await obtenerPueblosOriginarios(pool);
    const puebloRapaNui = pueblos.find((pueblo) => pueblo.codigo_fhir === "03");

    expect(puebloRapaNui?.id).toBeDefined();
    expect(puebloRapaNui?.codigo_fhir).toEqual("03");
    expect(puebloRapaNui?.texto).toMatch("Rapa Nui");
  });

  it("Debe encontrar el pueblo originario 'Lickanantay' dado su código FHIR '04'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const pueblos = await obtenerPueblosOriginarios(pool);
    const puebloLickanantay = pueblos.find(
      (pueblo) => pueblo.codigo_fhir === "04"
    );

    expect(puebloLickanantay?.id).toBeDefined();
    expect(puebloLickanantay?.codigo_fhir).toEqual("04");
    expect(puebloLickanantay?.texto).toMatch("Lickanantay");
  });

  it("Debe encontrar el pueblo originario 'Quechua' dado su código FHIR '05'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const pueblos = await obtenerPueblosOriginarios(pool);
    const puebloQuechua = pueblos.find((pueblo) => pueblo.codigo_fhir === "05");

    expect(puebloQuechua?.id).toBeDefined();
    expect(puebloQuechua?.codigo_fhir).toEqual("05");
    expect(puebloQuechua?.texto).toMatch("Quechua");
  });

  it("Debe encontrar el pueblo originario 'Colla' dado su código FHIR '06'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const pueblos = await obtenerPueblosOriginarios(pool);
    const puebloColla = pueblos.find((pueblo) => pueblo.codigo_fhir === "06");

    expect(puebloColla?.id).toBeDefined();
    expect(puebloColla?.codigo_fhir).toEqual("06");
    expect(puebloColla?.texto).toMatch("Colla");
  });

  it("Debe encontrar el pueblo originario 'Diaguita' dado su código FHIR '07'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const pueblos = await obtenerPueblosOriginarios(pool);
    const puebloDiaguita = pueblos.find(
      (pueblo) => pueblo.codigo_fhir === "07"
    );

    expect(puebloDiaguita?.id).toBeDefined();
    expect(puebloDiaguita?.codigo_fhir).toEqual("07");
    expect(puebloDiaguita?.texto).toMatch("Diaguita");
  });

  it("Debe encontrar el pueblo originario 'Kawésqar' dado su código FHIR '08'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const pueblos = await obtenerPueblosOriginarios(pool);
    const puebloKawesqar = pueblos.find(
      (pueblo) => pueblo.codigo_fhir === "08"
    );

    expect(puebloKawesqar?.id).toBeDefined();
    expect(puebloKawesqar?.codigo_fhir).toEqual("08");
    expect(puebloKawesqar?.texto).toMatch("Kawésqar");
  });

  it("Debe encontrar el pueblo originario 'Yagán' dado su código FHIR '09'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const pueblos = await obtenerPueblosOriginarios(pool);
    const puebloYagan = pueblos.find((pueblo) => pueblo.codigo_fhir === "09");

    expect(puebloYagan?.id).toBeDefined();
    expect(puebloYagan?.codigo_fhir).toEqual("09");
    expect(puebloYagan?.texto).toMatch("Yagán");
  });

  it("Debe encontrar el pueblo originario 'Chango' dado su código FHIR '11'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const pueblos = await obtenerPueblosOriginarios(pool);
    const puebloChango = pueblos.find((pueblo) => pueblo.codigo_fhir === "11");

    expect(puebloChango?.id).toBeDefined();
    expect(puebloChango?.codigo_fhir).toEqual("11");
    expect(puebloChango?.texto).toMatch("Chango");
  });

  it("Debe encontrar el pueblo originario 'Otro' dado su código FHIR '10'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const pueblos = await obtenerPueblosOriginarios(pool);
    const puebloOtro = pueblos.find((pueblo) => pueblo.codigo_fhir === "10");

    expect(puebloOtro?.id).toBeDefined();
    expect(puebloOtro?.codigo_fhir).toEqual("10");
    expect(puebloOtro?.texto).toMatch("Otro");
  });
});
