import "dotenv/config";
import { beforeAll, afterAll, describe, it, expect } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import { crearIdentificadorPaciente, crearPaciente } from "./crear-paciente.js";
import { createDBCache } from "./_db-cache.js";
import {
  generarPacientePruebaJuanManuelLopezPerez,
  generarPacientePruebaMaria,
} from "./_data-generator.js";
import { obtenerIdentificadoresPacienteDadoNumeroPaciente } from "./obtener-paciente-dado-numero-paciente";
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

describe("Crear identificadores paciente", () => {
  it("Debe crear los identificadores del paciente 'Maria'", async () => {
    expect.hasAssertions();

    if (!pool) throw new Error();

    const dbCache = await createDBCache(pool);
    const tran = pool.transaction();

    try {
      await tran.begin();

      const pacientePrueba = generarPacientePruebaMaria(dbCache);

      const numeroPacienteCreado = (await crearPaciente(tran, pacientePrueba))
        .numero_paciente;

      for (const identificador of pacientePrueba.identificadores) {
        await crearIdentificadorPaciente(
          tran,
          numeroPacienteCreado,
          identificador
        );
      }

      const identificadoresCreados = (
        await obtenerIdentificadoresPacienteDadoNumeroPaciente(
          tran,
          numeroPacienteCreado
        )
      ).map(
        /** @returns {IdentificadorPacienteExtraido} */ (i) => {
          return {
            id_uso: i.id_uso ?? undefined,
            id_pais_emisor_documento: i.id_pais_emisor_documento,
            id_tipo_identificador: i.id_tipo,
            valor: i.valor,
          };
        }
      );

      expect(identificadoresCreados).not.toHaveLength(0);
      expect(identificadoresCreados).toEqual(pacientePrueba.identificadores);

      await tran.rollback();
    } catch (error) {
      await tran.rollback();
      throw error;
    }
  });

  it("Debe crear los identificadores del paciente 'Juan Manuel Lopez Perez'", async () => {
    expect.hasAssertions();

    if (!pool) throw new Error();

    const dbCache = await createDBCache(pool);
    const tran = pool.transaction();

    try {
      await tran.begin();

      const pacientePrueba = generarPacientePruebaJuanManuelLopezPerez(dbCache);

      const numeroPacienteCreado = (await crearPaciente(tran, pacientePrueba))
        .numero_paciente;

      for (const identificador of pacientePrueba.identificadores) {
        await crearIdentificadorPaciente(
          tran,
          numeroPacienteCreado,
          identificador
        );
      }

      const identificadoresCreados = (
        await obtenerIdentificadoresPacienteDadoNumeroPaciente(
          tran,
          numeroPacienteCreado
        )
      )
        .map(
          /** @returns {IdentificadorPacienteExtraido} */ (i) => {
            return {
              id_uso: i.id_uso ?? undefined,
              id_pais_emisor_documento: i.id_pais_emisor_documento,
              id_tipo_identificador: i.id_tipo,
              valor: i.valor,
            };
          }
        )
        .sort((i1, i2) => {
          return `${i1.id_tipo_identificador}-${i1.id_uso}-${i1.id_pais_emisor_documento}`.localeCompare(
            `${i2.id_tipo_identificador}-${i2.id_uso}-${i2.id_pais_emisor_documento}`
          );
        });

      expect(identificadoresCreados).not.toHaveLength(0);
      expect(identificadoresCreados).toEqual(pacientePrueba.identificadores);

      await tran.rollback();
    } catch (error) {
      await tran.rollback();
      throw error;
    }
  });
});
