import "dotenv/config";
import { beforeAll, afterAll, describe, it, expect } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import { crearPaciente } from "./crear-paciente.js";
import { obtenerPaises } from "./obtener-paises.js";
import { obtenerIdentidadesGenero } from "./obtener-identidades-genero.js";
import { obtenerSexosBiologicos } from "./obtener-sexos-biologicos.js";
import { obtenerPacienteDadoNumeroPaciente } from "./obtener-paciente-dado-numero-paciente.js";
import { obtenerPueblosOriginarios } from "./obtener-pueblos-originarios.js";

/** @type {import("mssql").ConnectionPool | undefined} */
let pool = undefined;

/** @type{Map<string, { codigo_fhir: string, texto: string, id: string }[]>} */
const dbCache = new Map();

beforeAll(async () => {
  pool = await getDatabaseConnection({
    DB_USER: process.env.DB_USER,
    DB_PASSWORD: process.env.DB_PASSWORD,
    DB_HOST: process.env.DB_HOST,
    DB_NAME: process.env.DB_NAME,
    DB_PORT: process.env.DB_PORT,
  });

  dbCache.set("sexosBiologicos", await obtenerSexosBiologicos(pool));
  dbCache.set("identidadesGenero", await obtenerIdentidadesGenero(pool));
  dbCache.set("paises", await obtenerPaises(pool));
  dbCache.set("pueblosOriginarios", await obtenerPueblosOriginarios(pool));
});

afterAll(async () => {
  if (pool) {
    pool.close();
    pool = undefined;
  }
});

function obtenerIdentidadGeneroDadoCodigoFHIR(codigoFhir) {
  const found = dbCache
    .get("identidadesGenero")
    ?.find((identidad) => identidad.codigo_fhir === codigoFhir);
  if (found === undefined) throw new Error();
  return found;
}

function obtenerSexoBiologicoDadoCodigoFHIR(codigoFhir) {
  const found = dbCache
    .get("sexosBiologicos")
    ?.find((sexo) => sexo.codigo_fhir === codigoFhir);
  if (found === undefined) throw new Error();
  return found;
}

function obtenerPaisDadoCodigoFHIR(codigoFhir) {
  const found = dbCache
    .get("paises")
    ?.find((pais) => pais.codigo_fhir === codigoFhir);
  if (found === undefined) throw new Error();
  return found;
}

function obtenerPuebloOriginarioDadoCodigoFHIR(codigoFhir) {
  const found = dbCache
    .get("pueblosOriginarios")
    ?.find((pueblo) => pueblo.codigo_fhir === codigoFhir);
  if (found === undefined) throw new Error();
  return found;
}

describe("Crear paciente y obtener paciente creado", () => {
  it("Debe crear a paciente 'María', mujer con género no revelado nacida el 30 de diciembre de 1997 en Argentina, con nacionalidad Chilena.", async () => {
    expect.hasAssertions();

    if (!pool) throw new Error();

    const tran = pool.transaction();

    try {
      await tran.begin();

      const idIdentidadGeneroNoRevelada =
        obtenerIdentidadGeneroDadoCodigoFHIR("7").id;
      const idSexoBiologicoMujer =
        obtenerSexoBiologicoDadoCodigoFHIR("female").id;
      const idPaisChile = obtenerPaisDadoCodigoFHIR("152").id;
      const idPaisArgentina = obtenerPaisDadoCodigoFHIR("032").id;

      const { numero_paciente } = await crearPaciente(tran, {
        fecha_nacimiento: "1997-12-30",
        id_sexo_biologico: idSexoBiologicoMujer,
        id_identidad_genero: idIdentidadGeneroNoRevelada,
        id_nacionalidad: idPaisChile,
        id_pais_origen: idPaisArgentina,
        pertenece_a_pueblo_originario: false,
      });
      expect(numero_paciente).toBeDefined();

      const pacienteEncontrado = await obtenerPacienteDadoNumeroPaciente(
        tran,
        numero_paciente
      );

      expect(pacienteEncontrado.nombre).toBeUndefined();
      expect(pacienteEncontrado.nombre_social).toBeUndefined();
      expect(pacienteEncontrado.apellido_paterno).toBeUndefined();
      expect(pacienteEncontrado.apellido_materno).toBeUndefined();
      expect(pacienteEncontrado.fecha_nacimiento.toISOString()).toMatch(
        "1997-12-30"
      );
      expect(pacienteEncontrado.id_sexo_biologico).toEqual(
        idSexoBiologicoMujer
      );
      expect(pacienteEncontrado.id_identidad_genero).toEqual(
        idIdentidadGeneroNoRevelada
      );
      expect(pacienteEncontrado.id_nacionalidad).toEqual(idPaisChile);
      expect(pacienteEncontrado.id_pais_origen).toEqual(idPaisArgentina);
      expect(pacienteEncontrado.pertenece_a_pueblo_originario).toEqual(false);
      expect(pacienteEncontrado.id_pueblo_originario).toBeUndefined();

      await tran.rollback();
    } catch (error) {
      await tran.rollback();
      throw error;
    }
  });

  it("Debe crear a paciente 'Juan Manuel Lopez Perez', hombre con género masculino nacido el 4 de enero de 2001 en Chile, con nacionalidad Chilena, perteneciente al pueblo originario 'Chango'.", async () => {
    expect.hasAssertions();

    if (!pool) throw new Error();

    const tran = pool.transaction();

    try {
      await tran.begin();

      const idIdentidadGeneroMasculina =
        obtenerIdentidadGeneroDadoCodigoFHIR("1").id;
      const idSexoBiologicoHombre =
        obtenerSexoBiologicoDadoCodigoFHIR("male").id;
      const idPaisChile = obtenerPaisDadoCodigoFHIR("152").id;
      const idPuebloOriginarioChango =
        obtenerPuebloOriginarioDadoCodigoFHIR("11").id;

      const { numero_paciente } = await crearPaciente(tran, {
        nombre: "Juan Manuel",
        apellido_paterno: "Lopez",
        apellido_materno: "Perez",
        fecha_nacimiento: "2001-01-05",
        id_sexo_biologico: idSexoBiologicoHombre,
        id_identidad_genero: idIdentidadGeneroMasculina,
        id_nacionalidad: idPaisChile,
        id_pais_origen: idPaisChile,
        pertenece_a_pueblo_originario: true,
        id_pueblo_originario: idPuebloOriginarioChango,
      });
      expect(numero_paciente).toBeDefined();

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
