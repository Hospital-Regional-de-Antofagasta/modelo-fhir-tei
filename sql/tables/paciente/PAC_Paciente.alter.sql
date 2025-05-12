ALTER TABLE [dbo].[PAC_Paciente]
ADD
    /* DEIS */
    -- Capitulo 2 inciso 1.2. Numero de identificación (ver 'IdentificadorPaciente')

    -- Capitulo 2 inciso 2.3. Sexo bíologico
    IdSexoBiologico [TINYINT] NULL,

    -- Capitulo 2 inciso 2.4. Identidad de género
    IdIdentidadGenero [TINYINT] NULL,

    -- Capitulo 2 inciso 2.5. Nacionalidad
    IdNacionalidad [SMALLINT] NULL,

    -- Capitulo 2 inciso 2.6. País de origen
    IdPaisOrigen [SMALLINT] NULL,

    -- Capitulo 2 inciso 3.1. Estado Civil
    [IdEstadoCivil] [TINYINT] NULL,

    -- Capitulo 2 inciso 3.2. Pueblos Indigenas u Originarios
    [PerteneceAPuebloOriginario] [BIT] NULL,
    [IdPuebloOriginario] [TINYINT] NULL,
    [NombreOtroPuebloOriginario] [VARCHAR](25) NULL, 

    -- Capitulo 2 inciso 3.3. Pueblos tribales: Afrochileno o Afrodescendiente
    [PerteneceAPuebloAfrodescendiente] [BIT] NULL,

    -- Capitulo 2 inciso 3.4. Religión o Culto Declarado
    [IdReligion] [TINYINT] NULL

    -- -- Capitulo 2 inciso 3.5. Situación de Discapacidad
    -- [TieneDiscapacidad] [BIT] NULL

    -- Capitulo 2 inciso 6. Datos de dirección (ver 'DomicilioPaciente')

    -- Capitulo 2 inciso 7. Datos de contacto (ver 'MedioContactoPaciente')

    -- X.X. Solo FHIR