/**
 * @param {TransactionOrConnectionPool} dbCon
 * @returns {Promise<{ id: string, codigo_fhir: string; texto: string }[]>}
 */
export async function obtenerMotivosDerivacion(dbCon) {
  return (await dbCon.request().execute("API_TEIM_ObtenerMotivosDerivacion"))
    .recordset;
}
