CREATE OR ALTER PROCEDURE ObtenerIdentidadGeneroDadoCodigoDEIS
    @CodigoDEIS VARCHAR(10)
AS
BEGIN
    IF NOT EXISTS (SELECT TOP(1) 1 FROM [dbo].[TAB_DEIS_IdentidadGenero] WHERE Codigo = @CodigoDEIS) BEGIN
        RAISERROR('No existe la "identidad de genero" con el código DEIS "%s".', 16, 44, @CodigoDEIS);
        RETURN 1;
    END

    SELECT
        Id AS 'id',
        Texto AS 'texto'
    FROM [dbo].[TAB_DEIS_IdentidadGenero] WHERE Codigo = @CodigoDEIS;
END