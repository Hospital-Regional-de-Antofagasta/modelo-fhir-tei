CREATE OR ALTER PROCEDURE API_TEIM_ObtenerUsosIdentificadorPersona
AS
BEGIN
    SELECT
        Id AS 'id',
        Codigo AS 'codigo',
		Texto AS 'texto'
    FROM [dbo].[TAB_FHIR_UsoIdentificadorPersona]
    WHERE Vigencia = 1
END