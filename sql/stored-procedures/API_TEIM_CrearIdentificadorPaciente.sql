CREATE OR ALTER PROCEDURE API_TEIM_CrearIdentificadorPaciente
    @NumeroPaciente FLOAT,
    @IdTipo TINYINT,
    @IdUso TINYINT = NULL,
    @Valor VARCHAR(64),
    @IdPaisEmisorDocumento SMALLINT
AS
BEGIN
    DECLARE @resultado TABLE (
        Id UNIQUEIDENTIFIER NOT NULL
    );

    -- TODO: Existe id tipo? Existe id uso? Existe numero paciente? existe pais emisor?

    INSERT INTO [dbo].[IdentificadorPaciente] (
        NumeroPaciente,
        IdTipo,
        IdUso,
        Valor,
        IdPaisEmisorDocumento
    )
    OUTPUT INSERTED.Id INTO @resultado
    VALUES (
        @NumeroPaciente,
        @IdTipo,
        @IdUso,
        @Valor,
        @IdPaisEmisorDocumento
    );

    SELECT TOP (1) Id as 'id'
    FROM @resultado;
END