import "dotenv/config";
import { describe, expect, test, beforeAll, afterAll } from "@jest/globals";
import { getDatabaseConnection } from "../utils.js";
import mssql from "mssql";

async function dbConn(dbConfig) {
  let conn = null;

  return () => {
    if (conn === null) {
      conn = await getDatabaseConnection({
        DB_USER: process.env.DB_USER,
        DB_PASSWORD: process.env.DB_PASSWORD,
        DB_HOST: process.env.DB_HOST,
        DB_NAME: process.env.DB_NAME,
        DB_PORT: process.env.DB_PORT,
  
      });
    }

    return conn;
  
  }

  
}

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

    return resultadoObtenerNumeroPaciente;
  } catch (error) {
    return null;
  }
}

describe("Debe realizar los pasos necesarios para poder continuar con el proceso.", () => {
  test("Debe crear un paciente si no lo encuentra", async () => {
    expect.hasAssertions();

    const con = await dbConn();
    const tran = con.transaction();

    await tran.begin();

    const resultadoObtenerNumeroPaciente =
      await obtenerNumeroPacienteDadoIdentificador(tran, "01", "11867161-9");

    expect(resultadoObtenerNumeroPaciente).toBeNull();

    const { recordset: resultadoCrearPaciente } = await tran
      .request()
      .input("Nombre", mssql.VarChar(40), "Paciente")
      .input("ApellidoPaterno", mssql.VarChar(20), "ApellidoPaterno")
      .input("ApellidoMaterno", mssql.VarChar(20), "ApellidoMaterno")
      .input("FechaNacimiento", mssql.DateTime, new Date())
      .input("IdSexoBiologico", mssql.TinyInt, null)
      .input("IdIdentidadGenero", mssql.TinyInt, 1)
      .input("IdNacionalidad", mssql.SmallInt, 1)
      .input("IdPaisOrigen", mssql.SmallInt, 1)
      .input("IdReligion", mssql.TinyInt, null)
      .input("PerteneceAPuebloOriginario", mssql.Bit, false)
      .input("PerteneceAPuebloAfrodescendiente", mssql.Bit, false)
      .input("IdPuebloOriginario", mssql.TinyInt, null)
      .execute("CrearPaciente");

    expect(resultadoCrearPaciente).toHaveLength(1);
    expect(resultadoCrearPaciente[0].numero_paciente).toBe(1);

    await tran.rollback();
  });

  afterAll(async () => {
    const con = await dbConn();
    await con.close();
  })
});
