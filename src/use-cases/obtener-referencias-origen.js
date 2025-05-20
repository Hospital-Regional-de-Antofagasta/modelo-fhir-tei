/**
 * @param {TransactionOrConnectionPool} dbCon
 * @returns {Promise<{ id: string, codigo_fhir: string; texto: string }[]>}
 */
export async function obtenerReferenciasOrigen(dbCon) {
  return (await dbCon.request().execute("API_TEIM_ObtenerReferenciasOrigen"))
    .recordset;
}
