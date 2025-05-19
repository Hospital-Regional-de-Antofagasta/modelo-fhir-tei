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