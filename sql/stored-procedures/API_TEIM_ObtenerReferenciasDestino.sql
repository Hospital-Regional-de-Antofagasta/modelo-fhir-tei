CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerReferenciasDestino]
AS
BEGIN
    SELECT
        Id AS 'id',
        CodigoFHIR AS 'codigo_fhir',
        Texto AS 'texto'
    FROM [dbo].[ListaEspera_TAB_ReferenciaDestino]
    WHERE Vigencia = 1 AND CodigoFHIR IS NOT NULL
END