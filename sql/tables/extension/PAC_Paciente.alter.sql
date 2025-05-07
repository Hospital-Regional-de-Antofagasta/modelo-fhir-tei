IF OBJECT_ID('dbo.PAC_Paciente') IS NOT NULL BEGIN
    ALTER TABLE [dbo].[PAC_Paciente]
    ADD
        /* DEIS */
        -- Capitulo 2 inciso 1.2. Numero de identificación (ver 'IdentificadorPaciente')

        -- Capitulo 2 inciso 2.3. Sexo bíologico
        IdSexoBiologico [TINYINT] NULL CONSTRAINT FK_PAC_PACIENTE_SEXOBILOGICO FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_SexoBiologico]([Id]),

        -- Capitulo 2 inciso 2.4. Identidad de género
        IdIdentidadGenero [TINYINT] NULL CONSTRAINT FK_PAC_PACIENTE_IDENTIDADGENERO FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_IdentidadGenero]([Id]),

        -- Capitulo 2 inciso 2.5. Nacionalidad
        IdNacionalidad [SMALLINT] NULL CONSTRAINT FK_PAC_PACIENTE_NACIONALIDAD FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_Pais]([Id]),

        -- Capitulo 2 inciso 2.6. País de origen
        IdPaisOrigen [SMALLINT] NULL CONSTRAINT FK_PAC_PACIENTE_PAISORIGEN FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_Pais]([Id]),

        -- Capitulo 2 inciso 3.1. Estado Civil
        [IdEstadoCivil] [TINYINT] NULL CONSTRAINT FK_PAC_PACIENTE_ESTADOCIVIL FOREIGN KEY ([IdEstadoCivil]) REFERENCES [dbo].[TAB_DEIS_EstadoCivil]([Id]),

        -- Capitulo 2 inciso 3.2. Pueblos Indigenas u Originarios
        [PerteneceAPuebloOriginario] [BIT] NULL,
        [IdPuebloOriginario] [TINYINT] NULL CONSTRAINT FK_PAC_PACIENTE_PUEBLOORIGINARIO FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_PuebloOriginario]([Id]),
        [NombreOtroPuebloOriginario] [VARCHAR](25) NULL, 

        -- Capitulo 2 inciso 3.3. Pueblos tribales: Afrochileno o Afrodescendiente
        [PerteneceAPuebloAfrodescendiente] [BIT] NULL,

        -- Capitulo 2 inciso 3.4. Religión o Culto Declarado
        [IdReligion] [TINYINT] NULL CONSTRAINT FK_PAC_PACIENTE_RELIGION FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_Religion]([Id]),

        -- Capitulo 2 inciso 3.5. Situación de Discapacidad
        [TieneDiscapacidad] [BIT] NULL

        -- Capitulo 2 inciso 6. Datos de dirección (ver 'DomicilioPaciente')

        -- Capitulo 2 inciso 7. Datos de contacto (ver 'MedioContactoPaciente')

        -- X.X. Solo FHIR
END