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
    @IdEstablecimientoDestino BIGINT,
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

    DECLARE @idHospitalRegionalAntofagasta BIGINT = (
        SELECT TOP 1 Id
        FROM ListaEspera_TAB_Establecimiento
        WHERE Codigo = '103100'
    );

    DECLARE @idSistemaRAYEN BIGINT = (
        SELECT TOP 1 Id
        FROM ListaEspera_TAB_SistemaOrigen
        WHERE Codigo = '5'
    );

    INSERT INTO [dbo].[ListaEspera_Interconsulta] (
        NumeroPaciente,
        IdSistemaOrigen,

        RequiereExamen,
        EsAtencionPreferente,
        TieneResolutividadAPS,

        IdReferenciaOrigen,
        IdReferenciaDestino,

        IdentificadorFHIR,
        IdentificadorMINSAL,
        IdentificadorOrigen,

        IdEspecialidadOrigen,
        IdEstablecimientoOrigen,
        IdEstablecimientoDestino,
        IdEspecialidadDestino,
        IdSubespecialidadDestino,


        IdDiagnostico,
        IdEstadoDiagnostico, -- unconfirmed | provisional | differential | confirmed | refuted | entered-in-error
        FundamentosDiagnostico,
        IdMotivoDerivacion,
        MotivoEspecifico,
        ExamenesRealizados,
        FechaSolicitud,
        IdPrioridad,
        IdModalidadAtencion
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
        @IdModalidadAtencion
    );

    SELECT Id AS 'id' FROM @resultado;
END