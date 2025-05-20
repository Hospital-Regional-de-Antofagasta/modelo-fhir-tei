import "dotenv/config";
import { beforeAll, afterAll, describe, it, expect } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import { crearIdentificadorPaciente, crearPaciente } from "./crear-paciente.js";
import { obtenerPacienteDadoNumeroPaciente } from "./obtener-paciente-dado-numero-paciente.js";
import { createDBCache } from "./_db-cache.js";
import {
  generarPacientePruebaJuanManuelLopezPerez,
  generarPacientePruebaMaria,
} from "./_data-generator.js";

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

describe("Crear paciente y obtener paciente creado", () => {
  it("Debe crear a paciente 'María', mujer de género no revelado nacida el 30 de diciembre de 1997 en Argentina, con nacionalidad Chilena.", async () => {
    expect.hasAssertions();

    if (!pool) throw new Error();

    const dbCache = await createDBCache(pool);

    const idIdentidadGeneroNoRevelada =
      dbCache.obtenerIdentidadGeneroDadoCodigoFHIR("7").id;
    const idSexoBiologicoMujer =
      dbCache.obtenerSexoBiologicoDadoCodigoFHIR("female").id;
    const idPaisChile = dbCache.obtenerPaisDadoCodigoFHIR("152").id;
    const idPaisArgentina = dbCache.obtenerPaisDadoCodigoFHIR("032").id;

    const tran = pool.transaction();

    try {
      await tran.begin();

      const pacienteMaria = generarPacientePruebaMaria(dbCache);

      const numeroPacienteCreado = (await crearPaciente(tran, pacienteMaria))
        .numero_paciente;

      expect(numeroPacienteCreado).toBeDefined();

      const pacienteCreado = await obtenerPacienteDadoNumeroPaciente(
        tran,
        numeroPacienteCreado
      );

      expect(pacienteCreado.nombre).toEqual("María");
      expect(pacienteCreado.nombre_social).toBeUndefined();
      expect(pacienteCreado.apellido_paterno).toBeUndefined();
      expect(pacienteCreado.apellido_materno).toBeUndefined();
      expect(pacienteCreado.fecha_nacimiento.toISOString()).toMatch(
        "1997-12-30"
      );
      expect(pacienteCreado.id_sexo_biologico).toEqual(idSexoBiologicoMujer);
      expect(pacienteCreado.id_identidad_genero).toEqual(
        idIdentidadGeneroNoRevelada
      );
      expect(pacienteCreado.id_nacionalidad).toEqual(idPaisChile);
      expect(pacienteCreado.id_pais_origen).toEqual(idPaisArgentina);
      expect(pacienteCreado.pertenece_a_pueblo_originario).toEqual(false);
      expect(pacienteCreado.id_pueblo_originario).toBeUndefined();

      await tran.rollback();
    } catch (error) {
      await tran.rollback();
      throw error;
    }
  });

  it("Debe crear a paciente 'Juan Manuel Lopez Perez', RUT 9.640.474-3, hombre de género masculino nacido el 4 de enero de 2001 en Chile, perteneciente al pueblo originario 'Chango'.", async () => {
    expect.hasAssertions();

    if (!pool) throw new Error();

    const dbCache = await createDBCache(pool);

    const tran = pool.transaction();

    try {
      await tran.begin();

      const idIdentidadGeneroMasculina =
        dbCache.obtenerIdentidadGeneroDadoCodigoFHIR("1").id;
      const idSexoBiologicoHombre =
        dbCache.obtenerSexoBiologicoDadoCodigoFHIR("male").id;
      const idPaisChile = dbCache.obtenerPaisDadoCodigoFHIR("152").id;
      const idPuebloOriginarioChango =
        dbCache.obtenerPuebloOriginarioDadoCodigoFHIR("11").id;

      const pacienteJuanManuelLopezPerez =
        generarPacientePruebaJuanManuelLopezPerez(dbCache);

      const { numero_paciente } = await crearPaciente(
        tran,
        pacienteJuanManuelLopezPerez
      );

      expect(numero_paciente).toBeDefined();

      for (const identificador of pacienteJuanManuelLopezPerez.identificadores) {
        await crearIdentificadorPaciente(tran, numero_paciente, identificador);
      }

      const pacienteEncontrado = await obtenerPacienteDadoNumeroPaciente(
        tran,
        numero_paciente
      );

      expect(pacienteEncontrado.nombre).toEqual("Juan Manuel");
      expect(pacienteEncontrado.nombre_social).toBeUndefined();
      expect(pacienteEncontrado.apellido_paterno).toEqual("Lopez");
      expect(pacienteEncontrado.apellido_materno).toEqual("Perez");
      expect(pacienteEncontrado.fecha_nacimiento.toISOString()).toMatch(
        "2001-01-05"
      );
      expect(pacienteEncontrado.id_sexo_biologico).toEqual(
        idSexoBiologicoHombre
      );
      expect(pacienteEncontrado.id_identidad_genero).toEqual(
        idIdentidadGeneroMasculina
      );
      expect(pacienteEncontrado.id_nacionalidad).toEqual(idPaisChile);
      expect(pacienteEncontrado.id_pais_origen).toEqual(idPaisChile);
      expect(pacienteEncontrado.pertenece_a_pueblo_originario).toEqual(true);
      expect(pacienteEncontrado.id_pueblo_originario).toEqual(
        idPuebloOriginarioChango
      );

      await tran.rollback();
    } catch (error) {
      await tran.rollback();
      throw error;
    }
  });
});
