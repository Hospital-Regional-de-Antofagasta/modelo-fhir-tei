CREATE OR ALTER PROCEDURE [dbo].[CrearSolicitudInterconsulta]
    @NumeroPaciente FLOAT,
    @IdMotivoCierreInterconsulta TINYINT,
    @RequiereExamen BIT,
    @EsAtencionPreferente BIT,
    @TieneResolutividadAPS BIT,
    @ReferenciaOrigen VARCHAR(10),
    @FundamentoPriorizacion VARCHAR(250),
    @IdEspecialidadDestino SMALLINT,
    @IdSubEspecialidadDestino SMALLINT,
    @MotivoNoPertinencia VARCHAR(250),
    @ModalidadAtencion VARCHAR(20),
    @Prioridad VARCHAR(20),
    @ReferenciaDestino VARCHAR(32),
    @MotivoDerivacion VARCHAR(20),
    @FHIR_Id VARCHAR(64),
    @FHIR_Identifier_MINSAL VARCHAR(64),
    @FHIR_Identifier_Origin VARCHAR(64),
    @CreatedBy VARCHAR(10)
AS
BEGIN
    DECLARE @resultado TABLE (
        Id UNIQUEIDENTIFIER
    );

    INSERT INTO [dbo].[SolicitudInterconsulta] (
        NumeroPaciente,
        IdMotivoCierreInterconsulta,
        RequiereExamen,
        EsAtencionPreferente,
        TieneResolutividadAPS,
        ReferenciaOrigen,
        FundamentoPriorizacion,
        Estado,
        IdEspecialidadDestino,
        IdSubEspecialidadDestino,
        TipoPertinencia,
        MotivoNoPertinencia,
        ModalidadAtencion,
        Prioridad,
        ReferenciaDestino,
        MotivoDerivacion,
        FHIR_Id,
        FHIR_Identifier_MINSAL,
        FHIR_Identifier_Origin,
        CreatedBy
    )
    OUTPUT INSERTED.Id INTO @resultado
    VALUES (
        @NumeroPaciente,
        @IdMotivoCierreInterconsulta,
        @RequiereExamen,
        @EsAtencionPreferente,
        @TieneResolutividadAPS,
        @ReferenciaOrigen,
        @FundamentoPriorizacion,
        'ESPERANDO_PRIORIZACION',
        @IdEspecialidadDestino,
        @IdSubEspecialidadDestino,
        'PERTINENTE',
        @MotivoNoPertinencia,
        @ModalidadAtencion,
        @Prioridad,
        @ReferenciaDestino,
        @MotivoDerivacion,
        @FHIR_Id,
        @FHIR_Identifier_MINSAL,
        @FHIR_Identifier_Origin,
        @CreatedBy
    );

    SELECT Id AS 'id' FROM @resultado;
END