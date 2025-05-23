CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerEstadosDiagnostico]
AS
BEGIN
    SELECT
        Id AS 'id',
        CodigoFHIR AS 'codigo_fhir',
        Texto AS 'texto'
    FROM [dbo].[ListaEspera_TAB_EstadoDiagnostico]
    WHERE Vigencia = 1 AND CodigoFHIR is not NULL
END