import mssql from "mssql";

/**
 *
 * @param {TransactionOrConnectionPool} pool
 * @param {string} codigoCIE10
 * @returns {Promise<{ id: string; codigo_fhir: string; texto: string; }>}
 */
export async function obtenerDiagnosticoCIE10(pool, codigoCIE10) {
  const diagnostico = (
    await pool
      .request()
      .input("CodigoCIE10", mssql.VarChar(50), codigoCIE10)
      .execute("API_TEIM_ObtenerDiagnosticoDadoCodigoCIE10")
  ).recordset[0];

  return diagnostico;
}
