import "dotenv/config";
import { expect, beforeAll, afterAll, it, describe } from "@jest/globals";
import {
  getDatabaseConnection,
  cargarBundleIniciarEnriquecido,
} from "../utils.js";
import mssql from "mssql";
import { extraerBundleIniciarEnriquecido } from "./extraer-bundle-iniciar-enriquecido.js";
import {
  crearIdentificadorPaciente,
  crearPaciente,
  obtenerNumeroPacienteDadoIdentificador,
} from "./db.js";

const bundleIniciarEnriquecido = cargarBundleIniciarEnriquecido();

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

describe("Recibir evento iniciar enriquecido", () => {
  it("Debe utilizar al paciente existente si lo encuentra", async () => {
    expect.hasAssertions();
    if (pool === undefined) throw new Error();

    const tran = new mssql.Transaction(pool);
    await tran.begin();

    try {
      const { paciente } = await extraerBundleIniciarEnriquecido(
        tran,
        bundleIniciarEnriquecido
      );

      const { numero_paciente: numeroNuevoPaciente } = await crearPaciente(
        tran,
        paciente
      );

      const identificadorPaciente = paciente.identificadores[0];

      await crearIdentificadorPaciente(
        tran,
        numeroNuevoPaciente,
        identificadorPaciente
      );

      const { numero_paciente: numeroPacienteEncontrado } =
        await obtenerNumeroPacienteDadoIdentificador(
          tran,
          identificadorPaciente.id_tipo_identificador,
          identificadorPaciente.valor
        );

      expect(numeroNuevoPaciente).toBe(numeroPacienteEncontrado);

      await tran.rollback();
    } catch (error) {
      await tran.rollback();
      throw error;
    }
  });

  it("Debe crear un paciente si no lo encuentra", async () => {
    expect.hasAssertions();

    const tran = new mssql.Transaction(pool);
    await tran.begin();

    try {
      const { paciente } = await extraerBundleIniciarEnriquecido(
        tran,
        bundleIniciarEnriquecido
      );

      const identificadorPaciente = paciente.identificadores[0];

      await expect(
        obtenerNumeroPacienteDadoIdentificador(
          tran,
          identificadorPaciente.id_tipo_identificador,
          identificadorPaciente.valor
        )
      ).rejects.toHaveProperty("state", 44);

      const { numero_paciente } = await crearPaciente(tran, paciente);

      expect(numero_paciente).toBeDefined();

      await crearIdentificadorPaciente(
        tran,
        numero_paciente,
        identificadorPaciente
      );
      await tran.rollback();
    } catch (error) {
      await tran.rollback();
      throw error;
    }
  });
});
