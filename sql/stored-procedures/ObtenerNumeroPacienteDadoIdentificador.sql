/**
    Obtiene el numero de paciennte dado un identificador del paciente.
    Si el tipo de identificador es RUT o RUT PROVISORIO y no se encuentra el identificador,
    se intentará buscar al paciente directamente por su RUT "legacy".
*/

CREATE OR ALTER PROCEDURE ObtenerNumeroPacienteDadoIdentificador
    @CodigoTipoIdentificador CHAR(2),
    @ValorIdentificador VARCHAR(64)
AS
BEGIN
    DECLARE
        @CODIGO_TIPO_IDENTIFICADOR_RUT CHAR(2) = '01',
        @CODIGO_TIPO_IDENTIFICADOR_RUT_PROVISORIO CHAR(2) = '02';

    IF NOT EXISTS (
        SELECT TOP (1) 1
        FROM [dbo].[TAB_FHIR_TipoIdentificadorPersona] tid
        WHERE tid.[Codigo] = @CodigoTipoIdentificador
    )
    BEGIN
        RAISERROR('El tipo de identificador ingresado no existe.', 16, 1)
        RETURN 1;
    END

    DECLARE @idIdentificadorPaciente UNIQUEIDENTIFIER = (
        SELECT TOP (1) ip.[Id]
        FROM [dbo].[IdentificadorPaciente] ip
        WHERE ip.[IdTipo] = @CodigoTipoIdentificador AND ip.[Valor] = @ValorIdentificador
    )

    IF (@idIdentificadorPaciente IS NULL)
    BEGIN
        IF (@CodigoTipoIdentificador <> @CODIGO_TIPO_IDENTIFICADOR_RUT 
            AND @CodigoTipoIdentificador <> @CODIGO_TIPO_IDENTIFICADOR_RUT_PROVISORIO)
        BEGIN
            RAISERROR('No se pudo encontrar al paciente mediante el identificador ingresado', 16, 1)
            RETURN 1;
        END

        DECLARE @posibleNumeroPaciente FLOAT = (
            SELECT TOP (1) 1
            FROM [dbo].[PAC_Paciente] pac
            WHERE UPPER(pac.[PAC_PAC_Rut]) = UPPER(@ValorIdentificador)
        );

        IF (@posibleNumeroPaciente IS NULL)
        BEGIN
            RAISERROR('No se pudo encontrar al paciente mediante el identificador ingresado, ni mediante su RUT legacy.', 16, 1)
            RETURN 1;
        END

        SELECT
            @posibleNumeroPaciente AS 'numero_paciente',
            NULL AS 'id_identificador';
        RETURN 0;
    END

    SELECT TOP (1)
        ip.[Id] AS 'id_identificador',
        ip.[NumeroPaciente] AS 'numero_paciente'
    FROM
        [dbo].[IdentificadorPaciente] ip
    WHERE
        ip.[IdTipo] = @CodigoTipoIdentificador AND
        ip.[Valor] = @ValorIdentificador
END