CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerDiagnosticoDadoCodigoCIE10]
    @CodigoCIE10 VARCHAR(50)
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
        AND Codigo = @CodigoCIE10
        AND IdTipoCodificacionDiagnostica = 1
END