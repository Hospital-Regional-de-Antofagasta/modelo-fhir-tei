CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerPueblosOriginarios]
AS
BEGIN
    SELECT
        Id AS 'id',
        CodigoFHIR AS 'codigo_fhir',
        Texto AS 'texto'
    FROM [dbo].[TAB_DEIS_PuebloOriginario]
    WHERE Vigencia = 1 AND CodigoFHIR is not NULL
END