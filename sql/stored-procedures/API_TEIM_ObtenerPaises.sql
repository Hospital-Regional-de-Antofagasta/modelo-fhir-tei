CREATE OR ALTER PROCEDURE API_TEIM_ObtenerPaises
AS
BEGIN
    SELECT
        Id AS 'id',
        CodigoFHIR AS 'codigo_fhir',
        Texto AS 'texto'
    FROM [dbo].[TAB_DEIS_Pais]
    WHERE Vigencia = 1 AND CodigoFHIR IS NOT NULL
END