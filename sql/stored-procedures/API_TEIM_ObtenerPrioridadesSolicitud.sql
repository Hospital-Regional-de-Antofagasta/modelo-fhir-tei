CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerPrioridadesSolicitud]
AS
BEGIN
    SELECT
        Id AS 'id',
        Codigo AS 'codigo_fhir',
        Texto AS 'texto'
    FROM [dbo].[TAB_FHIR_PrioridadSolicitud]
    WHERE Vigencia = 1 AND Codigo is not NULL
END