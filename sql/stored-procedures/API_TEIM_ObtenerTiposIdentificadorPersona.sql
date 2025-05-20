CREATE OR ALTER PROCEDURE API_TEIM_ObtenerTiposIdentificadorPersona
AS
BEGIN
    SELECT
        Id AS 'id',
        Codigo AS 'codigo',
		Texto AS 'texto'
    FROM [dbo].[TAB_FHIR_TipoIdentificadorPersona]
END