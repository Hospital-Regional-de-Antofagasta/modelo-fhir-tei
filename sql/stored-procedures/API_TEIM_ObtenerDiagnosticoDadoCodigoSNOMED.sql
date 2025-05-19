CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerDiagnosticoDadoCodigoSNOMED]
    @CodigoSNOMED VARCHAR(50)
AS
BEGIN
    SELECT TOP (1)
        Id AS 'id',
        Codigo AS 'codigo',
        Texto AS 'texto'
    FROM dbo.[ListaEspera_TAB_Diagnostico]
    WHERE
        1 = 1
        AND Vigencia = 1
        AND Codigo = @CodigoSNOMED
        AND IdTipoCodificacionDiagnostica = 3
END