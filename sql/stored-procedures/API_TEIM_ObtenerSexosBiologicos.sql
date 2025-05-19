CREATE OR ALTER PROCEDURE API_TEIM_ObtenerSexosBiologicos
AS
BEGIN
    SELECT
        Id AS 'id',
        CodigoFHIR AS 'codigo_fhir',
        Texto AS 'texto'
    FROM [dbo].[TAB_DEIS_SexoBiologico]
    WHERE CodigoFHIR IS NOT NULL
END