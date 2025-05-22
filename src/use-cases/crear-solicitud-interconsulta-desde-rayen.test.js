import "dotenv/config";
import { beforeAll, afterAll, describe, it, expect } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import { crearSolicitudInterconsultaDesdeRayen } from "./crear-solicitud-interconsulta-desde-rayen.js";
import { createDBCache } from "./_db-cache.js";
import { generarPacientePruebaMaria } from "./_data-generator.js";
import { crearPaciente } from "./crear-paciente.js";
import { obtenerDiagnosticoCIE10 } from "./obtener-diagnostico-cie10.js";

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

function crearInterconsultaBasica(numero_paciente, idDiagnostico) {
  return {
    numero_paciente: numero_paciente,
    es_atencion_preferente: false,
    examenes_realizados: "Colonoscopia",
    fecha_solicitud: "2025-01-01",
    fundamentos_diagnostico: "Fundamentos diagnostico",
    id_diagnostico: idDiagnostico,
    id_especialidad_destino: "3",
    id_especialidad_origen: "3",
    id_establecimiento_origen: "2",
    id_estado_diagnostico: "2",
    id_modalidad_atencion: "1",
    id_prioridad: "1",
    id_referencia_destino: "1",
    id_referencia_origen: "1",
    identificador_fhir: "294ba3b5-9a5b-4a0b-9a5b-4a0b9a5b4a0b",
    identificador_rayen: "34a3b5b9-9a5b-4a0b-9a5b-4a0b9a5b4a0b",
    identificador_minsal: "47b5a238-228a-4114-a3c4-75a364006f0b",
    requiere_examen: false,
    tiene_resolutividad_aps: false,
    id_subespecialidad_destino: "1",
    id_motivo_derivacion: "1",
    motivo_especifico: "Motivo especifico",
  };
}

describe("Crear solicitud de interconsulta", () => {
  it("Debe crear una solicitud de interconsulta con los datos basicos", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const tran = pool.transaction();

    try {
      await tran.begin();

      const dbCache = await createDBCache(tran);
      const pacientePrueba = generarPacientePruebaMaria(dbCache);

      const { numero_paciente } = await crearPaciente(tran, pacientePrueba);

      const idDiagnostico = (await obtenerDiagnosticoCIE10(tran, "A02.9")).id;

      const idSolicitudInterconsulta =
        await crearSolicitudInterconsultaDesdeRayen(
          tran,
          crearInterconsultaBasica(numero_paciente, idDiagnostico)
        );

      expect(idSolicitudInterconsulta).toBeDefined();

      await tran.rollback();
    } catch (e) {
      await tran.rollback();
      throw e;
    }
  });

  it("Debe crear el estado y los eventos tributables de la interconsulta luego de ser creada", async () => {
    expect.hasAssertions();
    if (!pool) throw new Error();

    const tran = pool.transaction();

    try {
      await tran.begin();

      const dbCache = await createDBCache(tran);
      const pacientePrueba = generarPacientePruebaMaria(dbCache);

      const { numero_paciente } = await crearPaciente(tran, pacientePrueba);

      const idDiagnostico = (await obtenerDiagnosticoCIE10(tran, "A02.9")).id;

      const idSolicitudInterconsulta =
        await crearSolicitudInterconsultaDesdeRayen(
          tran,
          crearInterconsultaBasica(numero_paciente, idDiagnostico)
        );
      expect(idSolicitudInterconsulta).toBeDefined();

      const estadoCreado = (
        await tran.request().query(`
          SELECT
            tei.Texto
          FROM
            ListaEspera_EstadoInterconsulta ei
            JOIN TAB_FHIR_EstadoInterconsulta tei
              ON ei.IdEstado = tei.Id
          WHERE [IdInterconsulta] = ${idSolicitudInterconsulta}
      `)
      ).recordset[0];

      expect(estadoCreado.Texto).toMatch("A la espera de priorización");

      const eventosTributables = (
        await tran.request().query(`
        SELECT
          tev.[Texto],
          ev.[OrdenEnvio]
        FROM [FHIR_EventoTributacionInterconsulta] ev
          JOIN [TAB_FHIR_TipoEventoInterconsulta] tev
            ON ev.[IdTipoEvento] = tev.[Id]
        WHERE [IdInterconsulta] = ${idSolicitudInterconsulta}
        ORDER BY [OrdenEnvio] ASC
        `)
      ).recordset;

      expect(eventosTributables.length).toBe(4);

      expect(eventosTributables[0].Texto).toMatch("PRIORIZAR");
      expect(eventosTributables[0].OrdenEnvio).toBe(1);

      expect(eventosTributables[1].Texto).toMatch("AGENDAR");
      expect(eventosTributables[1].OrdenEnvio).toBe(2);

      expect(eventosTributables[2].Texto).toMatch("ATENDER");
      expect(eventosTributables[2].OrdenEnvio).toBe(3);

      expect(eventosTributables[3].Texto).toMatch("TERMINAR");
      expect(eventosTributables[3].OrdenEnvio).toBe(4);

      await tran.rollback();
    } catch (error) {
      await tran.rollback();
      throw error;
    }
  });
});
