import "dotenv/config";
import { beforeAll, afterAll, describe, it, expect } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import { obtenerPrioridadesSolicitud } from "./obtener-prioridades-solicitud.js";

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

describe("Obtener prioridades de solicitud", () => {
  it("Debe cargar las 4 prioridades de solicitud definidas en FHIR", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const prioridades = await obtenerPrioridadesSolicitud(pool);
    expect(prioridades.length).toEqual(4);
  });

  it("Debe encontrar la prioridad 'Rutina' dado su código FHIR 'routine", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const prioridades = await obtenerPrioridadesSolicitud(pool);
    const prioridadRutina = prioridades.find(
      (sb) => sb.codigo_fhir === "routine"
    );

    expect(prioridadRutina?.id).toBeDefined();
    expect(prioridadRutina?.codigo_fhir).toEqual("routine");
    expect(prioridadRutina?.texto).toEqual("Normal (no urgente)");
  });

  it("Debe encontrar la prioridad 'Urgente' dado su código FHIR 'urgent'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const prioridades = await obtenerPrioridadesSolicitud(pool);
    const prioridadUrgente = prioridades.find(
      (sb) => sb.codigo_fhir === "urgent"
    );

    expect(prioridadUrgente?.id).toBeDefined();
    expect(prioridadUrgente?.codigo_fhir).toEqual("urgent");
    expect(prioridadUrgente?.texto).toEqual("Urgente");
  });

  it("Debe encontrar la prioridad 'Asap' dado su código FHIR 'asap'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const prioridades = await obtenerPrioridadesSolicitud(pool);
    const prioridadAsap = prioridades.find((sb) => sb.codigo_fhir === "asap");

    expect(prioridadAsap?.id).toBeDefined();
    expect(prioridadAsap?.codigo_fhir).toEqual("asap");
    expect(prioridadAsap?.texto).toEqual("Tan pronto como sea posible");
  });

  it("Debe encontrar la prioridad 'Stat' dado su código FHIR 'stat'", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const prioridades = await obtenerPrioridadesSolicitud(pool);
    const prioridadStat = prioridades.find((sb) => sb.codigo_fhir === "stat");

    expect(prioridadStat?.id).toBeDefined();
    expect(prioridadStat?.codigo_fhir).toEqual("stat");
    expect(prioridadStat?.texto).toEqual("Inmediatamente");
  });
});
