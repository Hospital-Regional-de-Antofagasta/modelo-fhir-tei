CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_CrearDiagnosticoSNOMED]
    @CodigoSNOMED VARCHAR(50),
    @Texto VARCHAR(250)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @resultado TABLE (Id BIGINT);

    INSERT INTO dbo.[ListaEspera_TAB_Diagnostico] (Codigo, Texto, IdTipoCodificacionDiagnostica)
    OUTPUT INSERTED.Id INTO @resultado
    VALUES (@CodigoSNOMED, @Texto, 3);

    SELECT Id AS 'id' FROM @resultado;
END