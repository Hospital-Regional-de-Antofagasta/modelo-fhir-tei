/**
 * @param {TransactionOrConnectionPool} pool
 * @param {string} idInterconsulta
 */
export async function emitirEventoPriorizar(pool, idInterconsulta) {
  return pool.request().input("IdInterconsulta", idInterconsulta).query(`
  `);
}
