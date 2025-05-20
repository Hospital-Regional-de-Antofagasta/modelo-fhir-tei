CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerReferenciasOrigen]
AS
BEGIN
    SELECT
        Id AS 'id',
        CodigoFHIR AS 'codigo_fhir',
        Texto AS 'texto'
    FROM [dbo].[ListaEspera_TAB_ReferenciaOrigen]
    WHERE Vigencia = 1 AND CodigoFHIR IS NOT NULL
END