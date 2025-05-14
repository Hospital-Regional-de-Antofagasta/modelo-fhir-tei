CREATE OR ALTER PROCEDURE ObtenerSexoBiologicoDadoCodigoFHIR
    @CodigoFHIR VARCHAR(10)
AS
BEGIN
    DECLARE @codigoDEIS VARCHAR(10) = (SELECT CASE
        WHEN @CodigoFHIR = 'male' THEN '1'
        WHEN @CodigoFHIR = 'female' THEN '2'
        WHEN @CodigoFHIR = 'other' THEN '3' -- TODO: Revisar si este es el mapeo correspondiente.
        WHEN @CodigoFHIR = 'unknown' THEN '99'
        ELSE NULL
    END);

    IF NOT EXISTS (SELECT TOP(1) 1 FROM [dbo].[TAB_DEIS_SexoBiologico] WHERE Codigo = @codigoDEIS) BEGIN
        RAISERROR('No existe el "sexo biológico" con el código FHIR "%s".', 16, 44, @CodigoFHIR);
        RETURN 1;
    END

    SELECT
        Id AS 'id',
        Texto AS 'texto'
    FROM [dbo].[TAB_DEIS_SexoBiologico] WHERE Codigo = @codigoDEIS;
END