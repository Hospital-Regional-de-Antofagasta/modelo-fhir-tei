CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerReferenciasDestino]
AS
BEGIN
    SELECT
        Id AS 'id',
        Codigo AS 'codigo',
        Texto AS 'texto'
    FROM [dbo].[ListaEspera_TAB_ReferenciaDestino]
    WHERE Vigencia = 1
END