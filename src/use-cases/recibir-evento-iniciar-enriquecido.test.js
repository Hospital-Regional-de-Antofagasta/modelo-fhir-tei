import "dotenv/config";
import { describe, expect, test, beforeAll, afterAll, it } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import mssql from "mssql";
import fs from "fs";
import path from "path";

function obtenerBundleIniciarEnriquecido() {
  const bundleIniciarEnriquecido = fs.readFileSync(
    path.join(".", "src", "use-cases", "bundle-iniciar-enriquecido.json"),
    "utf-8"
  );

  return JSON.parse(bundleIniciarEnriquecido);
}
const bundleIniciarEnriquecido = obtenerBundleIniciarEnriquecido();

async function obtenerNumeroPacienteDadoIdentificador(
  /** @type {import("mssql").Transaction} */ tran,
  /** @type {string}  */ codigoTipoIdentificador,
  /** @type {string}  */ valorIdentificador
) {
  try {
    const { recordset: resultadoObtenerNumeroPaciente } = await tran
      .request()
      .input("CodigoTipoIdentificador", codigoTipoIdentificador)
      .input("ValorIdentificador", valorIdentificador)
      .execute("ObtenerNumeroPacienteDadoIdentificador");

    return {
      numero_paciente: resultadoObtenerNumeroPaciente[0]["numero_paciente"],
      id_identificador: resultadoObtenerNumeroPaciente[0]["id_identificador"],
    };
  } catch (error) {
    if (
      error instanceof mssql.MSSQLError &&
      error.code === "EREQUEST" &&
      error["state"] === 44
    ) {
      return null;
    }
    throw error;
  }
}

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

async function obtenerIdentificadorSexoBiologico(
  /** @type {import("mssql").Transaction} */ tran,
  /** @type {string}  */ codigoFHIR
) {
  const mapFHIRToDEIS = {
    male: "1",
    female: "2",
    other: "3",
    unknown: "5",
  };

  const codigo = mapFHIRToDEIS[codigoFHIR];

  return (
    await tran
      .request()
      .input("Codigo", codigo)
      .query(
        `SELECT Id AS 'id' FROM [dbo].[TAB_DEIS_SexoBiologico] WHERE Codigo = @Codigo;`
      )
  ).recordset[0].id;
}

async function obtenerIdentificadorIdentidadGenero(
  /** @type {import("mssql").Transaction} */ tran,
  /** @type {string}  */ codigoFHIR
) {
  return (
    await tran
      .request()
      .input("Codigo", codigoFHIR)
      .query(
        `SELECT Id AS 'id' FROM [dbo].[TAB_DEIS_IdentidadGenero] WHERE Codigo = @Codigo;`
      )
  ).recordset[0].id;
}

async function obtenerIdentificadorPais(
  /** @type {import("mssql").Transaction} */ tran,
  /** @type {string}  */ codigoFHIR
) {
  return (
    await tran
      .request()
      .input("Codigo", codigoFHIR)
      .query(
        `SELECT Id AS 'id' FROM [dbo].[TAB_DEIS_Pais] WHERE Codigo = @Codigo;`
      )
  ).recordset[0].id;
}

async function extraerPacienteDesdeBundle(
  /** @type {import("mssql").Transaction} */ tran,
  /** @type {object} */ bundle
) {
  const { resource: paciente } = bundle.entry.find(
    (e) => e.resource.resourceType === "Patient"
  );

  const name = paciente.name.find((n) => n.use === "official");

  const codigoIdentidadGenero = paciente.extension.find(
    (e) =>
      e.url ===
      "https://hl7chile.cl/fhir/ig/clcore/StructureDefinition/IdentidadDeGenero"
  ).valueCodeableConcept.coding[0].code;

  const codigoNacionalidad = paciente.extension.find(
    (e) =>
      e.url ===
      "https://hl7chile.cl/fhir/ig/clcore/StructureDefinition/CodigoPaises"
  ).valueCodeableConcept.coding[0].code;

  const codigoPaisOrigen = paciente.extension.find(
    (e) =>
      e.url ===
      "https://interoperabilidad.minsal.cl/fhir/ig/tei/StructureDefinition/PaisOrigenMPI"
  ).valueCodeableConcept.coding[0].code;

  const pertenecientePuebloOriginario = paciente.extension.find(
    (e) =>
      e.url ===
      "https://interoperabilidad.minsal.cl/fhir/ig/tei/StructureDefinition/PueblosOriginariosPerteneciente"
  ).valueBoolean;

  const pertenecientePuebloAfrodescendiente = paciente.extension.find(
    (e) =>
      e.url ===
      "https://interoperabilidad.minsal.cl/fhir/ig/tei/StructureDefinition/PueblosAfrodescendiente"
  ).valueBoolean;

  return {
    nombre: name.given.join(" "),
    apellido_paterno: name.family,
    apellido_materno: name._family.extension[0].valueString,

    fecha_nacimiento: paciente.birthDate,

    id_sexo_biologico: await obtenerIdentificadorSexoBiologico(
      tran,
      paciente.gender
    ),
    id_identidad_genero: await obtenerIdentificadorIdentidadGenero(
      tran,
      codigoIdentidadGenero
    ),
    id_religion: null,
    id_nacionalidad: await obtenerIdentificadorPais(tran, codigoNacionalidad),
    id_pais_origen: await obtenerIdentificadorPais(tran, codigoPaisOrigen),
    pertenece_a_pueblo_originario: pertenecientePuebloOriginario,
    pertenece_a_pueblo_afrodescendiente: pertenecientePuebloAfrodescendiente,
    id_pueblo_originario: null,
  };
}

it("Debe crear un paciente si no lo encuentra", async () => {
  expect.hasAssertions();

  const tran = new mssql.Transaction(pool);
  try {
    await tran.begin();

    const paciente = await extraerPacienteDesdeBundle(
      tran,
      bundleIniciarEnriquecido
    );

    expect(paciente).not.toBeNull();

    const resultadoObtenerNumeroPaciente =
      await obtenerNumeroPacienteDadoIdentificador(tran, "01", "11867161-9");

    expect(resultadoObtenerNumeroPaciente).toBeNull();

    const { recordset: resultadoCrearPaciente } = await tran
      .request()
      .input("Nombre", mssql.VarChar(40), paciente.nombre)
      .input("ApellidoPaterno", mssql.VarChar(20), paciente.apellido_paterno)
      .input("ApellidoMaterno", mssql.VarChar(20), paciente.apellido_materno)
      .input("FechaNacimiento", mssql.DateTime, paciente.fecha_nacimiento)
      .input("IdSexoBiologico", mssql.TinyInt, paciente.id_sexo_biologico)
      .input("IdIdentidadGenero", mssql.TinyInt, paciente.id_identidad_genero)
      .input("IdNacionalidad", mssql.SmallInt, paciente.id_nacionalidad)
      .input("IdPaisOrigen", mssql.SmallInt, paciente.id_pais_origen)
      .input("IdReligion", mssql.TinyInt, paciente.id_religion)
      .input(
        "PerteneceAPuebloOriginario",
        mssql.Bit,
        paciente.pertenece_a_pueblo_originario
      )
      .input(
        "PerteneceAPuebloAfrodescendiente",
        mssql.Bit,
        paciente.pertenece_a_pueblo_afrodescendiente
      )
      .input("IdPuebloOriginario", mssql.TinyInt, paciente.id_pueblo_originario)
      .execute("CrearPaciente");

    expect(resultadoCrearPaciente).toHaveLength(1);

    const numeroPaciente = resultadoCrearPaciente[0].numero_paciente;
    expect(numeroPaciente).toBe(1);

    await tran
      .request()
      .input("NumeroPaciente", mssql.Float, numeroPaciente)
      .input("IdTipo", mssql.TinyInt, 1)
      .input("IdUso", mssql.TinyInt, null)
      .input("Valor", mssql.VarChar(64), "11867161-9")
      .input("IdPaisEmisorDocumento", mssql.SmallInt, 1)
      .input("CreatedBy", mssql.VarChar(10), "system")
      .execute("CrearIdentificadorPaciente");

    await tran.rollback();
  } catch (error) {
    await tran.rollback();
    throw error;
  }
});
