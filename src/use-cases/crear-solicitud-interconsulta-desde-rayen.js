import mssql from "mssql";

/**
 * @param {TransactionOrConnectionPool} dbCon
 * @param {CrearSolicitudInterconsultaDesdeRAYENParams} params
 * @returns {Promise<{ id: string }>}
 */
export async function crearSolicitudInterconsultaDesdeRayen(dbCon, params) {
  const {
    numero_paciente,
    requiere_examen,
    es_atencion_preferente,
    tiene_resolutividad_aps,
    id_referencia_origen,
    id_referencia_destino,
    identificador_fhir,
    identificador_minsal,
    identificador_rayen,
    id_especialidad_origen,
    id_establecimiento_origen,
    id_especialidad_destino,
    id_subespecialidad_destino,
    id_diagnostico,
    id_estado_diagnostico,
    fundamentos_diagnostico,
    id_motivo_derivacion,
    motivo_especifico,
    examenes_realizados,
    fecha_solicitud,
    id_prioridad,
    id_modalidad_atencion,
  } = params;
  return (
    await dbCon
      .request()
      .input("NumeroPaciente", mssql.Float, numero_paciente)
      .input("RequiereExamen", mssql.Bit, requiere_examen)
      .input("EsAtencionPreferente", mssql.Bit, es_atencion_preferente)
      .input("TieneResolutividadAPS", mssql.Bit, tiene_resolutividad_aps)
      .input("IdReferenciaOrigen", mssql.TinyInt, id_referencia_origen)
      .input("IdReferenciaDestino", mssql.TinyInt, id_referencia_destino)
      .input("IdentificadorFHIR", mssql.VarChar(64), identificador_fhir)
      .input("IdentificadorMINSAL", mssql.VarChar(100), identificador_minsal)
      .input("IdentificadorRAYEN", mssql.VarChar(100), identificador_rayen)
      .input("IdEspecialidadOrigen", mssql.BigInt, id_especialidad_origen)
      .input("IdEstablecimientoOrigen", mssql.BigInt, id_establecimiento_origen)
      .input("IdEspecialidadDestino", mssql.BigInt, id_especialidad_destino)
      .input(
        "IdSubespecialidadDestino",
        mssql.BigInt,
        id_subespecialidad_destino
      )
      .input("IdDiagnostico", mssql.BigInt, id_diagnostico)
      .input("IdEstadoDiagnostico", mssql.BigInt, id_estado_diagnostico)
      .input(
        "FundamentosDiagnostico",
        mssql.VarChar(256),
        fundamentos_diagnostico
      )
      .input("IdMotivoDerivacion", mssql.BigInt, id_motivo_derivacion)
      .input("MotivoEspecifico", mssql.VarChar(256), motivo_especifico)
      .input("ExamenesRealizados", mssql.VarChar(256), examenes_realizados)
      .input("FechaSolicitud", mssql.DateTime, fecha_solicitud)
      .input("IdPrioridad", mssql.BigInt, id_prioridad)
      .input("IdModalidadAtencion", mssql.BigInt, id_modalidad_atencion)

      .execute("API_TEIM_CrearSolicitudInterconsultaDesdeRAYEN")
  ).recordset[0].id;
}
