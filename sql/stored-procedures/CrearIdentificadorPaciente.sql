CREATE OR ALTER PROCEDURE CrearIdentificadorPaciente
    @NumeroPaciente FLOAT,
    @IdTipo TINYINT,
    @IdUso TINYINT = NULL,
    @Valor VARCHAR(64),
    @IdPaisEmisorDocumento SMALLINT,
    @CreatedBy VARCHAR(10)
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
        IdPaisEmisorDocumento,
        CreatedBy,
        CreatedAt
    )
    OUTPUT INSERTED.Id INTO @resultado
    VALUES (
        @NumeroPaciente,
        @IdTipo,
        @IdUso,
        @Valor,
        @IdPaisEmisorDocumento,
        @CreatedBy,
        GETDATE()
    );

    SELECT TOP (1) Id as 'id_identificador'
    FROM @resultado;
END