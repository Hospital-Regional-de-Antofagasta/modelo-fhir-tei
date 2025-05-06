ALTER TABLE [dbo].[PAC_Paciente]
ADD
    -- 3.1. Estado Civil
    [IdEstadoCivil] [TINYINT] NULL,
    CONSTRAINT FK_PAC_PACIENTE_ESTADOCIVIL FOREIGN KEY ([IdEstadoCivil]) REFERENCES [dbo].[TAB_DEIS_EstadoCivil]([Id]),

    -- 3.2. Pueblos Indigenas u Originarios
    [PerteneceAPuebloOriginario] [BIT] NULL,
    [IdPuebloOriginario] [TINYINT] NULL,
    CONSTRAINT FK_PAC_PACIENTE_PUEBLOORIGINARIO FOREIGN KEY ([IdPuebloOriginario]) REFERENCES [dbo].[TAB_DEIS_PuebloOriginario]([Id]),
    [NombreOtroPuebloOriginario] [VARCHAR](25) NULL, 

    -- 3.3. Pueblos tribales: Afrochileno o Afrodescendiente
    [PerteneceAPuebloAfrodescendiente] [BIT] NULL,

    -- 3.4. Religión o Culto Declarado
    [IdReligion] [TINYINT] NULL,
    CONSTRAINT FK_PAC_PACIENTE_RELIGION FOREIGN KEY ([IdReligion]) REFERENCES [dbo].[TAB_DEIS_Religion]([Id]),

    -- 3.5. Situación de Discapacidad
    [EsDiscapacitado] [BIT] NULL,


    -- 6. Datos de dirección (ver 'DomicilioPaciente')

    -- 7.1. Teléfonos de contacto + 7.2. Correo electrónica (ver 'MedioContactoPaciente')


    


--   ALTER TABLE [dbo].[PAC_Paciente]
--   ADD
--     EstaActivo BIT NOT NULL DEFAULT(1),
--     CodigoGeneroAdministrativo VARCHAR(10) NOT NULL,
--     CodigoEstadoCivil CHAR(2) NULL,
--     CodigoSexoBiologico VARCHAR(10) NULL,
--     CodigoNacionalidad CHAR(3) NOT NULL,
--     CodigoPaisOrigen CHAR(3) NOT NULL,
--     CodigoReligion VARCHAR(2) NULL,
--     PerteneceAPuebloOriginarioChile BIT NOT NULL,
--     PerteneceAPuebloAfrodescendiente BIT NULL

--   CREATE TABLE [dbo].[PAC_PacienteExtendido]
--   (
--     FOREIGN KEY (NumeroPaciente) REFERENCES PAC_Paciente(PAC_PAC_Numero),

--     EstaActivo BIT NOT NULL DEFAULT(1),

--     /* https://hl7.org/fhir/R4/valueset-administrative-gender.html */
--     CodigoGeneroAdministrativo VARCHAR(10) NOT NULL,
--     FOREIGN KEY (CodigoGeneroAdministrativo) REFERENCES TAB_GeneroAdministrativo_V2(Codigo),

--     CodigoEstadoCivil CHAR(2) NULL,
--     FOREIGN KEY (CodigoEstadoCivil) REFERENCES TAB_EstadoCivil_V2(Codigo),

--     /* Extensiones */
--     CodigoSexoBiologico VARCHAR(10) NULL,
--     FOREIGN KEY (CodigoSexoBiologico) REFERENCES TAB_GeneroAdministrativo_V2(Codigo),

--     CodigoNacionalidad CHAR(3) NOT NULL,
--     FOREIGN KEY (CodigoNacionalidad) REFERENCES TAB_Pais_ISO3166_1N_V2(Codigo),

--     CodigoPaisOrigen CHAR(3) NOT NULL,
--     FOREIGN KEY (CodigoPaisOrigen) REFERENCES TAB_Pais_ISO3166_1N_V2(Codigo),

--     CodigoReligion VARCHAR(2) NULL,
--     FOREIGN KEY (CodigoReligion) REFERENCES TAB_Religion_V2(Codigo),

--     PerteneceAPuebloOriginarioChile BIT NOT NULL,
--     PerteneceAPuebloAfrodescendiente BIT NULL,

--     /* Propiedades complejas */

--     /*
--       https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.id
--       Identificador asignado por MINSAL
--     */
--     _Id VARCHAR(64) NULL,

--     _Link VARCHAR(MAX) NULL,
--     _GeneralPractitioner VARCHAR(MAX) NULL,



    [A] BIT