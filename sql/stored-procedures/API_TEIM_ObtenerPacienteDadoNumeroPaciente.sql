CREATE OR ALTER PROCEDURE API_TEIM_ObtenerPacienteDadoNumeroPaciente
    @NumeroPaciente FLOAT
AS
BEGIN
    SELECT
        pac.[PAC_PAC_Numero] AS 'numero_paciente',
        -- pac.[PAC_PAC_Rut] AS 'rut',
        CASE
            WHEN LEN(TRIM(pac.[PAC_PAC_Nombre])) = 0 THEN NULL
            ELSE TRIM(pac.[PAC_PAC_Nombre])
        END AS 'nombre',
        ns.[PAC_PAC_NombreSocial] AS 'nombre_social',
        CASE
            WHEN LEN(TRIM(pac.[PAC_PAC_ApellPater])) = 0 THEN NULL
            ELSE TRIM(pac.[PAC_PAC_ApellPater])
        END AS 'apellido_paterno',
        CASE
            WHEN LEN(TRIM(pac.[PAC_PAC_ApellMater])) = 0 THEN NULL 
            ELSE TRIM(pac.[PAC_PAC_ApellMater])
        END AS 'apellido_materno',

        pac.[PAC_PAC_FechaNacim] AS 'fecha_nacimiento',
        -- pac.[PAC_PAC_Sexo] AS 'sexo',
        -- pac.[PAC_PAC_Religion] AS 'Religion',
        -- pac.[PAC_PAC_EstadCivil] AS 'EstadCivil',
        -- pac.[PAC_PAC_FechaIngre] AS 'FechaIngre',
        -- pac.[PAC_PAC_FechaModif] AS 'FechaModif',
        CASE
            WHEN pac.[PAC_PAC_FechaFallec] = '1900-01-01' THEN NULL
            ELSE pac.[PAC_PAC_FechaFallec]
        END AS 'fecha_fallecimiento',

        -- pac.[PAC_PAC_NroPasaporte] AS 'NroPasaporte',
        -- pac.[PAC_PAC_Etnia] AS 'Etnia',
        -- pac.[PAC_PAC_Nacionalidad] AS 'Nacionalidad',
        -- pac.[NAC_Ide] AS ' AS',
        -- pac.[PAC_PAC_PacTrans] AS 'PacTrans',
        -- pac.[PAC_RutProvisorio] AS 'rovisorio',
        -- pac.[PAC_PAC_IdentidadGenero] AS 'IdentidadGenero',

        pac.[IdSexoBiologico] AS 'id_sexo_biologico',
        pac.[IdIdentidadGenero] AS 'id_identidad_genero',
        pac.[IdNacionalidad] AS 'id_nacionalidad',
        pac.[IdPaisOrigen] AS 'id_pais_origen',
        pac.[IdEstadoCivil] AS 'id_estado_civil',
        pac.[PerteneceAPuebloAfrodescendiente] AS 'pertenece_a_pueblo_afrodescendiente',
        pac.[PerteneceAPuebloOriginario] AS 'pertenece_a_pueblo_originario',
        pac.[IdPuebloOriginario] AS 'id_pueblo_originario',
        pac.[NombreOtroPuebloOriginario] AS 'nombre_otro_pueblo_originario',
        pac.[IdReligion] AS 'id_religion'
    FROM [dbo].[PAC_Paciente] pac
        LEFT JOIN [dbo].[PAC_NombreSocial] ns
            ON pac.[PAC_PAC_Numero] = ns.[PAC_PAC_Numero]
    WHERE pac.[PAC_PAC_Numero] = @NumeroPaciente
END