/**
 * @param {TransactionOrConnectionPool} dbCon
 * @returns {Promise<{ id: string, codigo_fhir: string; texto: string }[]>}
 */
export async function obtenerPaises(dbCon) {
  return (await dbCon.request().execute("API_TEIM_ObtenerPaises")).recordset;
}
