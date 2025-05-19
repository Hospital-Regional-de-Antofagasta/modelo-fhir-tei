CREATE OR ALTER PROCEDURE API_TEIM_ObtenerIdentidadesGenero
AS
BEGIN
    SELECT
        Id AS 'id',
        CodigoFHIR AS 'codigo_fhir',
        Texto AS 'texto'
    FROM [dbo].[TAB_DEIS_IdentidadGenero]
    WHERE Vigencia = 1 AND CodigoFHIR IS NOT NULL
END