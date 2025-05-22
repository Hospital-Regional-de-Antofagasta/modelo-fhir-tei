/**
 * Crea una solicitud de interconsulta desde RAYEN.
 * Se asume que la solicitud se encuentra marcada como pertinente y que el destino es este mismo hospital.
 */
CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_CrearSolicitudInterconsultaDesdeRAYEN]
    @NumeroPaciente FLOAT,
    @RequiereExamen BIT,
    @EsAtencionPreferente BIT,
    @TieneResolutividadAPS BIT,

    @IdReferenciaOrigen TINYINT,
    @IdReferenciaDestino TINYINT,

    @IdentificadorFHIR VARCHAR(64),
    @IdentificadorMINSAL VARCHAR(100),
    @IdentificadorRAYEN VARCHAR(100),

    @IdEspecialidadOrigen BIGINT,
    @IdEstablecimientoOrigen BIGINT,
    @IdEspecialidadDestino BIGINT,
    @IdSubespecialidadDestino BIGINT = NULL,


    @IdDiagnostico BIGINT,
    @IdEstadoDiagnostico BIGINT, -- unconfirmed | provisional | differential | confirmed | refuted | entered-in-error -- Debería ser un tinyint
    @FundamentosDiagnostico VARCHAR(256),
    
    @IdMotivoDerivacion BIGINT,
    @MotivoEspecifico VARCHAR(256),
    @ExamenesRealizados VARCHAR(256),
    @FechaSolicitud DATETIME,
    @IdPrioridad BIGINT,
    @IdModalidadAtencion BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @resultado TABLE (
        Id BIGINT
    );

    DECLARE 
        @idHospitalRegionalAntofagasta BIGINT = (SELECT TOP 1 [Id]
                                                    FROM [dbo].[ListaEspera_TAB_Establecimiento]
                                                    WHERE [Codigo] = '103100'), --Hospital Dr. Leonardo Guzmán (Antofagasta)
        @idSistemaRAYEN BIGINT = (SELECT TOP 1 [Id]
                                    FROM [dbo].[ListaEspera_TAB_SistemaOrigen]
                                    WHERE [Codigo] = '5'), --INTEGRACIÓN RAYEN
        @idEstadoInicial BIGINT = (SELECT TOP 1 [Id]
                                    FROM [dbo].[TAB_FHIR_EstadoInterconsulta]
                                    WHERE [Codigo] = '3') --A la espera de priorización

    INSERT INTO [dbo].[ListaEspera_Interconsulta] (
        [NumeroPaciente],
        [IdSistemaOrigen],
        [RequiereExamen],
        [EsAtencionPreferente],
        [TieneResolutividadAPS],
        [IdReferenciaOrigen],
        [IdReferenciaDestino],
        [IdentificadorFHIR],
        [IdentificadorMINSAL],
        [IdentificadorOrigen],
        [IdEspecialidadOrigen],
        [IdEstablecimientoOrigen],
        [IdEstablecimientoDestino],
        [IdEspecialidadDestino],
        [IdSubespecialidadDestino],
        [IdDiagnostico],
        [IdEstadoDiagnostico], -- unconfirmed | provisional | differential | confirmed | refuted | entered-in-error
        [FundamentosDiagnostico],
        [IdMotivoDerivacion],
        [MotivoEspecifico],
        [ExamenesRealizados],
        [FechaSolicitud],
        [IdPrioridad],
        [IdModalidadAtencion],
        [IdTipoPrestacion]
    )
    OUTPUT INSERTED.Id INTO @resultado
    VALUES (
        @NumeroPaciente,
        @idSistemaRAYEN,
        @RequiereExamen,
        @EsAtencionPreferente,
        @TieneResolutividadAPS,
        @IdReferenciaOrigen,
        @IdReferenciaDestino,
        @IdentificadorFHIR,
        @IdentificadorMINSAL,
        @IdentificadorRAYEN,
        @IdEspecialidadOrigen,
        @IdEstablecimientoOrigen,
        @idHospitalRegionalAntofagasta,
        @IdEspecialidadDestino,
        @IdSubespecialidadDestino,
        @IdDiagnostico,
        @IdEstadoDiagnostico, -- unconfirmed | provisional | differential | confirmed | refuted | entered-in-error
        @FundamentosDiagnostico,
        @IdMotivoDerivacion,
        @MotivoEspecifico,
        @ExamenesRealizados,
        @FechaSolicitud,
        @IdPrioridad,
        @IdModalidadAtencion,
        1
    );

	INSERT INTO [dbo].[ListaEspera_EstadoInterconsulta]
           ([IdEstado]
           ,[IdInterconsulta])
     VALUES
           (@idEstadoInicial
           ,(SELECT TOP(1) Id AS 'id' FROM @resultado))


	INSERT INTO [dbo].[FHIR_EventoTributacionInterconsulta]
           ([IdInterconsulta]
           ,[IdTipoEvento]
           ,[OrdenEnvio])
    SELECT (SELECT TOP(1) Id AS 'id' FROM @resultado)
	       ,[Id]
           ,row_number() OVER (ORDER BY [Id] ASC)
	FROM [dbo].[TAB_FHIR_TipoEventoInterconsulta]
	WHERE [Id] > 3


    SELECT Id AS 'id' FROM @resultado;
END