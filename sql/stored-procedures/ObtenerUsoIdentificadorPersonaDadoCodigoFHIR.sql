CREATE OR ALTER PROCEDURE ObtenerUsoIdentificadorPersonaDadoCodigoFHIR
    @CodigoFHIR VARCHAR(10)
AS
BEGIN
    IF NOT EXISTS (SELECT TOP(1) 1 FROM [dbo].[TAB_FHIR_UsoIdentificadorPersona] WHERE Codigo = @CodigoFHIR) BEGIN
        RAISERROR('No existe el "uso de identificador de persona" con el código FHIR "%s".', 16, 44, @CodigoFHIR);
        RETURN 1;
    END

    SELECT
        Id AS 'id',
        Texto AS 'texto'
    FROM [dbo].[TAB_FHIR_UsoIdentificadorPersona] WHERE Codigo = @CodigoFHIR;
END