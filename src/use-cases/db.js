import mssql from "mssql";

/**
 * @param {TransactionOrConnectionPool} tran
 * @param {string} codigoFHIR
 * @returns {Promise<{ id: string; texto: string; }>}
 */
export async function obtenerSexoBiologicoDadoCodigoFHIR(tran, codigoFHIR) {
  const item = (
    await tran
      .request()
      .input("CodigoFHIR", codigoFHIR)
      .execute("ObtenerSexoBiologicoDadoCodigoFHIR")
  ).recordset[0];

  return {
    id: String(item.id),
    texto: String(item.texto),
  };
}

/**
 * @param {TransactionOrConnectionPool} tran
 * @param {string} codigoDEIS
 * @returns {Promise<{ id: string; texto: string; }>}
 */
export async function obtenerIdentidadGeneroDadoCodigoDEIS(tran, codigoDEIS) {
  const item = (
    await tran
      .request()
      .input("CodigoDEIS", codigoDEIS)
      .execute("ObtenerIdentidadGeneroDadoCodigoDEIS")
  ).recordset[0];

  return {
    id: String(item.id),
    texto: String(item.texto),
  };
}

/**
 * @param {TransactionOrConnectionPool} tran
 * @param {string} codigoDEIS
 * @returns {Promise<{ id: string; texto: string; }>}
 */
export async function obtenerPaisDadoCodigoDEIS(tran, codigoDEIS) {
  const item = (
    await tran
      .request()
      .input("CodigoDEIS", codigoDEIS)
      .execute("ObtenerPaisDadoCodigoDEIS")
  ).recordset[0];

  return {
    id: String(item.id),
    texto: String(item.texto),
  };
}

/**
 * @param {TransactionOrConnectionPool} tran
 * @param {string} codigoFHIR
 * @returns {Promise<{ id: string; texto: string; }>}
 */
export async function obtenerTipoIdentificadorPersonaDadoCodigoFHIR(
  tran,
  codigoFHIR
) {
  const item = (
    await tran
      .request()
      .input("CodigoFHIR", codigoFHIR)
      .execute("ObtenerTipoIdentificadorPersonaDadoCodigoFHIR")
  ).recordset[0];

  return {
    id: String(item.id),
    texto: String(item.texto),
  };
}

/**
 * @param {TransactionOrConnectionPool} tran
 * @param {string} codigoFHIR
 * @returns {Promise<{ id: string; texto: string; }>}
 */
export async function obtenerUsoIdentificadorPersonaDadoCodigoFHIR(
  tran,
  codigoFHIR
) {
  const item = (
    await tran
      .request()
      .input("CodigoFHIR", codigoFHIR)
      .execute("ObtenerUsoIdentificadorPersonaDadoCodigoFHIR")
  ).recordset[0];

  return {
    id: String(item.id),
    texto: String(item.texto),
  };
}

/**
 * @param {TransactionOrConnectionPool} tran
 * @param {string} idTipoIdentificador
 * @param {string} valorIdentificador
 * @returns {Promise<{ numero_paciente: string; id_identificador: string; }>}
 */
export async function obtenerNumeroPacienteDadoIdentificador(
  tran,
  idTipoIdentificador,
  valorIdentificador
) {
  const res = (
    await tran
      .request()
      .input("IdTipoIdentificador", idTipoIdentificador)
      .input("ValorIdentificador", valorIdentificador)
      .execute("ObtenerNumeroPacienteDadoIdentificador")
  ).recordset[0];

  return {
    numero_paciente: res.numero_paciente,
    id_identificador: res.id_identificador,
  };
}

/**
 * @param {TransactionOrConnectionPool} tran
 * @param {PacienteExtraido} paciente
 * @returns {Promise<{ numero_paciente: number }>}
 */
export async function crearPaciente(tran, paciente) {
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

  return {
    numero_paciente: resultadoCrearPaciente[0].numero_paciente,
  };
}

/**
 * @param {TransactionOrConnectionPool} tran
 * @param {number} numeroPaciente
 * @param {PacienteExtraido["identificadores"][number]} identificadorPaciente
 */
export async function crearIdentificadorPaciente(
  tran,
  numeroPaciente,
  identificadorPaciente
) {
  return await tran
    .request()
    .input("NumeroPaciente", mssql.Float, numeroPaciente)
    .input("IdTipo", mssql.TinyInt, identificadorPaciente.id_tipo_identificador)
    .input("IdUso", mssql.TinyInt, identificadorPaciente.id_uso)
    .input("Valor", mssql.VarChar(64), identificadorPaciente.valor)
    .input(
      "IdPaisEmisorDocumento",
      mssql.SmallInt,
      identificadorPaciente.id_pais_emisor_documento
    )
    .input("CreatedBy", mssql.VarChar(10), "system")
    .execute("CrearIdentificadorPaciente");
}
