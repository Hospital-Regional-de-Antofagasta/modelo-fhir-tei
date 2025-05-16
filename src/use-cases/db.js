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

/**
 * @param {TransactionOrConnectionPool} tran
 * @param {SolicitudInterconsultaExtraida} solicitudInterconsultaExtraida
 * @returns {Promise<{ id: string }>}
 */
export async function crearSolicitudInterconsulta(
  tran,
  solicitudInterconsultaExtraida
) {
  const {
    numero_paciente,
    id_motivo_cierre_interconsulta,
    requiere_examen,
    es_atencion_preferente,
    tiene_resolutividad_aps,
    referencia_origen,
    fundamento_priorizacion,
    id_especialidad_destino,
    id_subespecialidad_destino,
    modalidad_atencion,
    motivo_derivacion,
    prioridad,
    referencia_destino,
    fhir_id,
    fhir_identifier_minsal,
    fhir_identifier_origin,
    created_by,
  } = solicitudInterconsultaExtraida;

  const resultado = (
    await tran
      .request()
      .input("NumeroPaciente", mssql.Float, numero_paciente)
      .input(
        "IdMotivoCierreInterconsulta",
        mssql.TinyInt,
        id_motivo_cierre_interconsulta
      )
      .input("RequiereExamen", mssql.Bit, requiere_examen)
      .input("EsAtencionPreferente", mssql.Bit, es_atencion_preferente)
      .input("TieneResolutividadAPS", mssql.Bit, tiene_resolutividad_aps)
      .input("ReferenciaOrigen", mssql.VarChar(10), referencia_origen)
      .input(
        "FundamentoPriorizacion",
        mssql.VarChar(250),
        fundamento_priorizacion
      )
      .input("IdEspecialidadDestino", mssql.SmallInt, id_especialidad_destino)
      .input(
        "IdSubEspecialidadDestino",
        mssql.SmallInt,
        id_subespecialidad_destino
      )
      .input("ModalidadAtencion", mssql.VarChar(20), modalidad_atencion)
      .input("Prioridad", mssql.VarChar(20), prioridad)
      .input("ReferenciaDestino", mssql.VarChar(32), referencia_destino)
      .input("MotivoDerivacion", mssql.VarChar(20), motivo_derivacion)
      .input("FHIR_Id", mssql.VarChar(64), fhir_id)
      .input(
        "FHIR_Identifier_MINSAL",
        mssql.VarChar(64),
        fhir_identifier_minsal
      )
      .input(
        "FHIR_Identifier_Origin",
        mssql.VarChar(64),
        fhir_identifier_origin
      )
      .input("CreatedBy", mssql.VarChar(10), created_by)
      .execute("CrearSolicitudInterconsulta")
  ).recordset[0];

  return {
    id: resultado.id,
  };
}
