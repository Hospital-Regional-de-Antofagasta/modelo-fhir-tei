CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerEstablecimientoDadoCodigoDEIS]
    @CodigoDEIS VARCHAR(10)
AS
BEGIN
    SELECT TOP (1)
        Id AS 'id',
        Codigo AS 'codigo_deis',
        Texto AS 'texto'
    FROM [dbo].ListaEspera_TAB_Establecimiento
    WHERE Vigencia = 1
    	AND Codigo = @CodigoDEIS;
END