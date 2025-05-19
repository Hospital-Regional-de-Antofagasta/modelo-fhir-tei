CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerMotivosDerivacion]
AS
BEGIN
    SELECT
        Id AS 'id',
        Codigo AS 'codigo',
        Texto AS 'texto'
    FROM [dbo].[ListaEspera_TAB_MotivoDerivacion]
    WHERE Vigencia = 1
END