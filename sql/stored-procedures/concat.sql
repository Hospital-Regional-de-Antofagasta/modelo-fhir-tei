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

GO

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

GO

CREATE OR ALTER PROCEDURE API_TEIM_CrearIdentificadorPaciente
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

GO

CREATE OR ALTER PROCEDURE API_TEIM_CrearPaciente
    -- @Rut VARCHAR(10), -- Tiene default. Reemplazar luego.
    @Nombre VARCHAR(40),
    @ApellidoPaterno VARCHAR(20),
    @ApellidoMaterno VARCHAR(20),
    @FechaNacimiento DATETIME,
    -- @Sexo CHAR(1), -- Es posible obtenerlo desde el código de sexo biológico.
    -- @EstadCivil VARCHAR(10), -- Es posible obtenerlo desde el código de estado civil.
    -- @FechaIngre DATETIME, -- Es la fecha actual
    -- @Origen VARCHAR(15), -- Tiene default.
    -- @FechaFallec DATETIME, -- Tiene default.
    -- @Prevision CHAR(8), -- Tiene default.
    -- @Codigo CHAR(8), -- Tiene default.
    -- @Soundex VARCHAR(8), -- Tiene default.

    -- Nuevos datos, si tiene = null es opcional.
    @IdSexoBiologico [TINYINT] = NULL,
    @IdIdentidadGenero [TINYINT],
    @IdNacionalidad [SMALLINT],
    @IdPaisOrigen [SMALLINT],
    @IdReligion [TINYINT] = NULL,
    @PerteneceAPuebloOriginario [BIT],
    @PerteneceAPuebloAfrodescendiente [BIT] = NULL,
    @IdPuebloOriginario [TINYINT] = NULL,
    -- @NombreOtroPuebloOriginario [VARCHAR](25) NULL, 
    @IdEstadoCivil [TINYINT] = NULL
    -- @TieneDiscapacidad [BIT] = NULL
AS
BEGIN
    -- DECLARE @sexoBiologicoLegacy CHAR(1) = (SELECT CASE @IdSexoBiologico
    --     WHEN 1 THEN 'M'
    --     WHEN 2 THEN 'F'
    --     ELSE 
    -- END);

    DECLARE @numeroPaciente FLOAT = 1 + ISNULL(
        (SELECT MAX(PAC_PAC_Numero) FROM [dbo].[PAC_Paciente]), 0);
    
    INSERT INTO [dbo].[PAC_Paciente] (
        [PAC_PAC_Numero],
        [PAC_PAC_Nombre],
        [PAC_PAC_ApellPater],
        [PAC_PAC_ApellMater],
        [PAC_PAC_FechaNacim],
        -- [PAC_PAC_Sexo],
        -- [PAC_PAC_EstadCivil],
        [PAC_PAC_FechaIngre],
        [IdSexoBiologico],
        [IdIdentidadGenero],
        [IdNacionalidad],
        [IdPaisOrigen],
        [IdEstadoCivil],
        [PerteneceAPuebloOriginario],
        [IdPuebloOriginario],
        [PerteneceAPuebloAfrodescendiente],
        [IdReligion]
    )
    VALUES (
        @numeroPaciente,
        @Nombre,
        @ApellidoPaterno,
        @ApellidoMaterno,
        @FechaNacimiento,
        GETDATE(),
        @IdSexoBiologico,
        @IdIdentidadGenero,
        @IdNacionalidad,
        @IdPaisOrigen,
        @IdEstadoCivil,
        @PerteneceAPuebloOriginario,
        @IdPuebloOriginario,
        @PerteneceAPuebloAfrodescendiente,
        @IdReligion
    );

    SELECT @numeroPaciente AS 'numero_paciente';
END

GO

/**
 * Crea una solicitud de interconsulta desde RAYEN.
 * Se asume que la solicitud se encuentra marcada como pertinente y que el destino es este mismo hospital.
 */
CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_CrearSolicitudInterconsulta]
    @NumeroPaciente FLOAT,
    @RequiereExamen BIT,
    @EsAtencionPreferente BIT,
    @TieneResolutividadAPS BIT,

    @IdReferenciaOrigen TINYINT,
    @IdReferenciaDestino TINYINT,

    @IdentificadorFHIR VARCHAR(64),
    @IdentificadorMINSAL VARCHAR(100),
    @IdentificadorRAYEN VARCHAR(100),

    @IdEspecialidadOrigen BIGINT,
    @IdEstablecimientoOrigen BIGINT,
    @IdEstablecimientoDestino BIGINT,
    @IdEspecialidadDestino BIGINT,
    @IdSubespecialidadDestino BIGINT = NULL,


    @IdDiagnostico BIGINT,
    @IdEstadoDiagnostico BIGINT, -- unconfirmed | provisional | differential | confirmed | refuted | entered-in-error -- Debería ser un tinyint
    @FundamentosDiagnostico VARCHAR(256),
    
    @IdMotivoDerivacion BIGINT,
    @MotivoEspecifico VARCHAR(256),
    @ExamenesRealizados VARCHAR(256),
    @FechaSolicitud DATETIME,
    @IdPrioridad BIGINT,
    @IdModalidadAtencion BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @resultado TABLE (
        Id UNIQUEIDENTIFIER
    );

    DECLARE @idHospitalRegionalAntofagasta BIGINT = (
        SELECT TOP 1 Id
        FROM ListaEspera_TAB_Establecimiento
        WHERE Codigo = '103100'
    );

    DECLARE @idSistemaRAYEN BIGINT = (
        SELECT TOP 1 Id
        FROM ListaEspera_TAB_SistemaOrigen
        WHERE Codigo = '5'
    );

    INSERT INTO [dbo].[ListaEspera_Interconsulta] (
        NumeroPaciente,
        IdSistemaOrigen,

        RequiereExamen,
        EsAtencionPreferente,
        TieneResolutividadAPS,

        IdReferenciaOrigen,
        IdReferenciaDestino,

        IdentificadorFHIR,
        IdentificadorMINSAL,
        IdentificadorOrigen,

        IdEspecialidadOrigen,
        IdEstablecimientoOrigen,
        IdEstablecimientoDestino,
        IdEspecialidadDestino,
        IdSubespecialidadDestino,


        IdDiagnostico,
        IdEstadoDiagnostico, -- unconfirmed | provisional | differential | confirmed | refuted | entered-in-error
        FundamentosDiagnostico,
        IdMotivoDerivacion,
        MotivoEspecifico,
        ExamenesRealizados,
        FechaSolicitud,
        IdPrioridad,
        IdModalidadAtencion
    )
    OUTPUT INSERTED.Id INTO @resultado
    VALUES (
        @NumeroPaciente,
        @idSistemaRAYEN,

        @RequiereExamen,
        @EsAtencionPreferente,
        @TieneResolutividadAPS,

        @IdReferenciaOrigen,
        @IdReferenciaDestino,

        @IdentificadorFHIR,
        @IdentificadorMINSAL,
        @IdentificadorRAYEN,

        @IdEspecialidadOrigen,
        @IdEstablecimientoOrigen,
        @idHospitalRegionalAntofagasta,
        @IdEspecialidadDestino,
        @IdSubespecialidadDestino,

        @IdDiagnostico,
        @IdEstadoDiagnostico, -- unconfirmed | provisional | differential | confirmed | refuted | entered-in-error
        @FundamentosDiagnostico,
        @IdMotivoDerivacion,
        @MotivoEspecifico,
        @ExamenesRealizados,
        @FechaSolicitud,
        @IdPrioridad,
        @IdModalidadAtencion
    );

    SELECT Id AS 'id' FROM @resultado;
END

GO

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

GO

CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerDiagnosticoDadoCodigoSNOMED]
    @CodigoSNOMED VARCHAR(50)
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
        AND Codigo = @CodigoSNOMED
        AND IdTipoCodificacionDiagnostica = 3
END

GO

CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerEspecialidades]
AS
BEGIN
    SELECT
        Id AS 'id',
        CodigoFHIR AS 'codigo_fhir',
		IdTipoEspecialidad AS 'id_tipo_especialidad',
        DESCRIPCION_DEIS_ESPECIALIDAD AS 'texto'
    FROM [dbo].PRLE_ESPECIALIDADES
    WHERE vigencia = 1 AND CodigoFHIR IS NOT NULL
	order by CAST(IdTipoEspecialidad AS INTEGER) asc, CAST(CodigoFHIR AS INTEGER) asc
END

GO

CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerEstablecimientoDadoCodigoDEIS]
    @CodigoDEIS VARCHAR(10)
AS
BEGIN
    SELECT TOP (1)
        Id AS 'id',
        Codigo AS 'codigo_deis',
        Texto AS 'texto'
    FROM [dbo].ListaEspera_TAB_Establecimiento
    WHERE Vigencia = 1
    	AND Codigo = @CodigoDEIS;
END

GO

CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerEstadosDiagnostico]
AS
BEGIN
    SELECT
        Id AS 'id',
        Codigo AS 'codigo',
        Texto AS 'texto'
    FROM [dbo].[ListaEspera_TAB_EstadoDiagnostico]
    WHERE Vigencia = 1
END

GO

CREATE OR ALTER PROCEDURE API_TEIM_ObtenerIdentidadesGenero
AS
BEGIN
    SELECT
        Id AS 'id',
        CodigoFHIR AS 'codigo_fhir',
        Texto AS 'texto'
    FROM [dbo].[TAB_DEIS_IdentidadGenero]
    WHERE Vigencia = 1 AND CodigoFHIR IS NOT NULL
END

GO

CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerModalidadesAtencion]
AS
BEGIN
    SELECT
        Id AS 'id',
        Codigo AS 'codigo',
        Texto AS 'texto'
    FROM [dbo].[ListaEspera_TAB_ModalidadAtencion]
    WHERE Vigencia = 1
END

GO

CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerMotivosDerivacion]
AS
BEGIN
    SELECT
        Id AS 'id',
        Codigo AS 'codigo',
        Texto AS 'texto'
    FROM [dbo].[ListaEspera_TAB_MotivoDerivacion]
    WHERE Vigencia = 1
END

GO

/**
    Obtiene el numero de paciennte dado un identificador del paciente.
    -- Si el tipo de identificador es RUT o RUT PROVISORIO y no se encuentra el identificador,
    -- se intentará buscar al paciente directamente por su RUT "legacy".
*/

CREATE OR ALTER PROCEDURE API_TEIM_ObtenerNumeroPacienteDadoIdentificador
    @IdTipoIdentificador TINYINT,
    @ValorIdentificador VARCHAR(64)
AS
BEGIN
    DECLARE
        @CODIGO_TIPO_IDENTIFICADOR_RUT CHAR(2) = '01',
        @CODIGO_TIPO_IDENTIFICADOR_RUT_PROVISORIO CHAR(2) = '02';
    
    IF NOT EXISTS (
        SELECT TOP (1) 1
        FROM [dbo].[TAB_FHIR_TipoIdentificadorPersona] tid
        WHERE tid.[Id] = @IdTipoIdentificador
    )
    BEGIN
        RAISERROR('El tipo de identificador ingresado no existe.', 16, 50)
        RETURN 1;
    END

    DECLARE @codigoTipoIdentificador CHAR(2) = (
        SELECT TOP (1) tid.[Codigo]
        FROM [dbo].[TAB_FHIR_TipoIdentificadorPersona] tid
        WHERE tid.[Id] = @IdTipoIdentificador
    );

    DECLARE @idIdentificadorPaciente UNIQUEIDENTIFIER = (
        SELECT TOP (1) ip.[Id]
        FROM [dbo].[IdentificadorPaciente] ip
        WHERE
            ip.[IdTipo] = @IdTipoIdentificador
            AND ip.[Valor] = @ValorIdentificador
    )

    IF (@idIdentificadorPaciente IS NULL)
    BEGIN
        IF (@codigoTipoIdentificador <> @CODIGO_TIPO_IDENTIFICADOR_RUT 
            AND @codigoTipoIdentificador <> @CODIGO_TIPO_IDENTIFICADOR_RUT_PROVISORIO)
        BEGIN
            RAISERROR('No se pudo encontrar al paciente mediante el identificador ingresado', 16, 44)
            RETURN 1;
        END

        DECLARE @posibleNumeroPaciente FLOAT = (
            SELECT TOP (1) pac.[PAC_PAC_Numero]
            FROM [dbo].[PAC_Paciente] pac
            WHERE UPPER(pac.[PAC_PAC_Rut]) = UPPER(@ValorIdentificador)
        );

        IF (@posibleNumeroPaciente IS NULL)
        BEGIN
            RAISERROR('No se pudo encontrar al paciente mediante el identificador ingresado, ni mediante su RUT legacy.', 16, 44)
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
        ip.[Id] = @idIdentificadorPaciente
    RETURN 0;
END

GO

CREATE OR ALTER PROCEDURE API_TEIM_ObtenerPaises
AS
BEGIN
    SELECT
        Id AS 'id',
        CodigoFHIR AS 'codigo_fhir',
        Texto AS 'texto'
    FROM [dbo].[TAB_DEIS_Pais]
    WHERE Vigencia = 1 AND CodigoFHIR IS NOT NULL
END

GO

CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerPrioridades]
AS
BEGIN
    SELECT
        Id AS 'id',
        Codigo AS 'codigo',
        Texto AS 'texto'
    FROM [dbo].[ListaEspera_TAB_PrioridadCaso]
    WHERE Vigencia = 1
END

GO

CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerReferenciasDestino]
AS
BEGIN
    SELECT
        Id AS 'id',
        Codigo AS 'codigo',
        Texto AS 'texto'
    FROM [dbo].[ListaEspera_TAB_ReferenciaDestino]
    WHERE Vigencia = 1
END

GO

CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerReferenciasOrigen]
AS
BEGIN
    SELECT
        Id AS 'id',
        Codigo AS 'codigo',
        Texto AS 'texto'
    FROM [dbo].[ListaEspera_TAB_ReferenciaOrigen]
    WHERE Vigencia = 1
END

GO

CREATE OR ALTER PROCEDURE ObtenerSexoBiologicoDadoCodigoFHIR
AS
BEGIN
    SELECT
        Id AS 'id',
        CodigoFHIR AS 'codigo_fhir',
        Texto AS 'texto'
    FROM [dbo].[TAB_DEIS_SexoBiologico]
    WHERE CodigoFHIR IS NOT NULL
END

GO

CREATE OR ALTER PROCEDURE API_TEIM_ObtenerTiposIdentificadorPersona
AS
BEGIN
    SELECT
        Id AS 'id',
        Codigo AS 'codigo',
		Nombre AS 'texto'
    FROM [dbo].[TAB_FHIR_TipoIdentificadorPersona]
END

GO

CREATE OR ALTER PROCEDURE API_TEIM_ObtenerUsosIdentificadorPersona
AS
BEGIN
    SELECT
        Id AS 'id',
        Codigo AS 'codigo',
		Texto AS 'texto'
    FROM [dbo].[TAB_FHIR_UsoIdentificadorPersona]
    WHERE Vigencia = 1
END