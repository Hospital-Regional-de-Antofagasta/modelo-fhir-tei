CREATE OR ALTER PROCEDURE CrearPaciente
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
    DECLARE @resultado TABLE (
        PAC_PAC_Numero FLOAT
    );

    -- DECLARE @sexoBiologicoLegacy CHAR(1) = (SELECT CASE @IdSexoBiologico
    --     WHEN 1 THEN 'M'
    --     WHEN 2 THEN 'F'
    --     ELSE 
    -- END);


    
    INSERT INTO [dbo].[PAC_Paciente] (
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
    OUTPUT INSERTED.PAC_PAC_Numero INTO @resultado
    VALUES (
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

    SELECT PAC_PAC_Numero AS 'numero_paciente' FROM @resultado;
END