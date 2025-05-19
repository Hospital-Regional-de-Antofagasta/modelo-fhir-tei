CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_CrearDiagnosticoCIE10]
    @CodigoCIE10 VARCHAR(50),
    @Texto VARCHAR(250)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @resultado TABLE (Id BIGINT);

    INSERT INTO dbo.[ListaEspera_TAB_Diagnostico] (Codigo, Texto, IdTipoCodificacionDiagnostica)
    OUTPUT INSERTED.Id INTO @resultado
    VALUES (@CodigoCIE10, @Texto, 1);

    SELECT Id AS 'id' FROM @resultado;
END