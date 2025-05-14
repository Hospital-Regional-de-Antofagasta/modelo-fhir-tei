CREATE OR ALTER PROCEDURE GuardarBundleIniciarEnriquecido
    @IdSolicitudInterconsulta UNIQUEIDENTIFIER,
    @BundleIniciarEnriquecido VARCHAR(MAX)
AS
BEGIN
    INSERT INTO [dbo].[FHIR_BundleIniciarEnriquecido] (
        IdSolicitudInterconsulta,
        BundleOriginal,
        CreatedAt
    ) VALUES (
        @IdSolicitudInterconsulta,
        @BundleIniciarEnriquecido,
        GETDATE()
    );
END