DECLARE @idInterconsulta BIGINT;
SELECT TOP (1)
@idInterconsulta = Id
--NumeroPaciente,
--IdSistemaOrigen,
--IdentificadorOrigen,
--IdEspecialidadOrigen,
--CodigoPoliclinicoOrigen,
--NumeroFolioNominaOrigen,
--IdEstablecimientoOrigen,
--IdReferenciaOrigen,
--RutProfesionalOrigen,
--CodigoTipoProfesionalOrigen,
--ProcedenciaProfesionalOrigen,
--IdEstablecimientoDestino,
--IdReferenciaDestino,
--IdEspecialidadDestino,
--IdSubespecialidadDestino,
--IdProcedimientoIntervencionDestino,
--IdDiagnostico,
--IdEstadoDiagnostico,
--FundamentosDiagnostico,
--IdMotivoDerivacion,
--MotivoEspecifico,
--RequiereExamen,
--ExamenesRealizados,
--EsAtencionPreferente,
--TieneResolutividadAPS,
--FechaSolicitud,
--IdTipoPrestacion,
--IdentificadorFHIR,
--IdentificadorMINSAL,
--IdentificadorSIGTE,
--CodigoProblemaSaludAuge,
--IdPrioridad,
--FundamentoPriorizacion,
--PrioritizedBy,
--PrioritizedAt,
--IdCausalSalida,
--FechaSalida,
--MotivoNoPertinencia,
--IdModalidadAtencion,
--CreatedBy,
--CreatedAt
FROM ListaEspera_Interconsulta

DECLARE @msg VARCHAR(MAX) = '
{
	"messageHeader": {
		"eventCode": "priorizar",
		"software": "agenda.hra.afta.cl",
		"endpoint": "http://agenda.hospitalantofagasta.gob.cl"
	},
	"serviceRequest": {
		"id": "id-temporal-reasignable",
		"requiere"
	}
}
';

SET @msg = JSON_MODIFY(@msg, '$.serviceRequest.id', @idInterconsulta);

SELECT @msg;


