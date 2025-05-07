IF OBJECT_ID(N'dbo.DomicilioPaciente', N'U') IS NULL BEGIN
  CREATE TABLE [dbo].[DomicilioPaciente]
  (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),

    NumeroPaciente FLOAT NOT NULL CONSTRAINT FK_DOMICILIO_PACIENTE FOREIGN KEY REFERENCES [dbo].[PAC_Paciente](PAC_PAC_Numero),

    -- FHIR_Line VARCHAR(200) NOT NULL,

    IdUso TINYINT NOT NULL CONSTRAINT FK_DOMICILIO_USO FOREIGN KEY REFERENCES [dbo].[TAB_FHIR_UsoDomicilioPersona](Id),

    -- Capitulo 4 inciso 1.1. Región
    -- IdRegion CHAR(2) NULL CONSTRAINT FK_DOMICILIO_REGION FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_Region](Id),
    
    -- -- Capitulo 4 inciso 1.2. Provincia
    -- IdProvincia CHAR(3) NULL CONSTRAINT FK_DOMICILIO_PROVINCIA FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_Provincia](Id),
    
    -- Capitulo 4 inciso 1.3. Comuna
    IdComuna CHAR(5) NOT NULL CONSTRAINT FK_DOMICILIO_COMUNA FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_Comuna](Id),

    -- Capitulo 4 inciso 1.5.1. Tipo de vía
    IdTipoVia TINYINT NOT NULL CONSTRAINT FK_DOMICILIO_TIPOVIA FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_TipoVia](Id),

    -- Capitulo 4 inciso 1.5.2. Nombre de vía
    NombreCalle VARCHAR(100) NOT NULL,

    -- Capitulo 4 inciso 1.5.3. Numero
    NumeroCalle VARCHAR(10) NOT NULL,

    -- Capitulo 4 inciso 1.5.4. Anexo de dirección
    AnexoCalle VARCHAR(200) NULL,

    -- Capitulo 4 inciso 1.7. Sistema de coordenadas
    Latitud VARCHAR(20) NULL,
    Longitud VARCHAR(20) NULL,
    CodigoPostal VARCHAR(10) NULL,

    [CreatedBy] [VARCHAR](10) NOT NULL CONSTRAINT FK_DOMICILIO_CREATEDBY FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]),
	  [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),

    [DeletedBy] [VARCHAR](10) NULL CONSTRAINT FK_DOMICILIO_DELETEDBY FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]),
	  [DeletedAt] DATETIME NULL
  );
  -- EXEC sys.sp_addextendedproperty @name=N'FHIR_Line', @value=N'https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.address.line' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DomicilioPaciente', @level2type=N'COLUMN',@level2name=N'FHIR_Line'
END