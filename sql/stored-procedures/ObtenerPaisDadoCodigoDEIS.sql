CREATE OR ALTER PROCEDURE ObtenerPaisDadoCodigoDEIS
    @CodigoDEIS VARCHAR(10)
AS
BEGIN
    IF NOT EXISTS (SELECT TOP(1) 1 FROM [dbo].[TAB_DEIS_Pais] WHERE Codigo = @CodigoDEIS) BEGIN
        RAISERROR('No existe el "país" con el código DEIS "%s".', 16, 44, @CodigoDEIS);
        RETURN 1;
    END

    SELECT
        Id AS 'id',
        Texto AS 'texto'
    FROM [dbo].[TAB_DEIS_Pais] WHERE Codigo = @CodigoDEIS;
END