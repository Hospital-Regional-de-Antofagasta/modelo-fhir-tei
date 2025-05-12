CREATE OR ALTER PROCEDURE GuardarBundleIniciarEnriquecido
    @IdSolicitudInterconsulta UNIQUEIDENTIFIER,
    @EstablecimientoSolicitanteDTO VARCHAR(MAX),
    @PrestadorSolicitanteDTO VARCHAR(MAX)
AS
BEGIN
    INSERT INTO [dbo].[BundleIniciarEnriquecido] (
        IdSolicitudInterconsulta,
        EstablecimientoSolicitanteDTO,
        PrestadorSolicitanteDTO
    ) VALUES (
        @IdSolicitudInterconsulta,
        @EstablecimientoSolicitanteDTO,
        @PrestadorSolicitanteDTO
    );
END