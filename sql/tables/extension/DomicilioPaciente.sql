IF OBJECT_ID(N'dbo.DomicilioPaciente', N'U') IS NULL BEGIN
  CREATE TABLE [dbo].[DomicilioPaciente]
  (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),

    NumeroPaciente FLOAT NOT NULL CONSTRAINT FK_DOMICILIO_PACIENTE FOREIGN KEY REFERENCES [dbo].[PAC_Paciente](PAC_PAC_Numero),

    -- FHIR_Line VARCHAR(200) NOT NULL,
    CodigoUso VARCHAR(10) NOT NULL CONSTRAINT FK_DOMICILIO_USO FOREIGN KEY REFERENCES [dbo].[TAB_UsoDomicilioPersona](Codigo),


    
    -- IdPais CHAR(3) NULL CONSTRAINT FK_DOMICILIO_PAIS FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_Pais](Id),
    -- IdRegion CHAR(2) NULL CONSTRAINT FK_DOMICILIO_REGION FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_Region](Id),
    -- IdProvincia CHAR(3) NULL CONSTRAINT FK_DOMICILIO_PROVINCIA FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_Provincia](Id),
    IdComuna CHAR(5) NULL CONSTRAINT FK_DOMICILIO_COMUNA FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_Comuna](Id),

    VigenteDesde DATETIME NULL,
    VigenteHasta DATETIME NULL,

    Latitud FLOAT NULL,
    Longitud FLOAT NULL,

    -- EnSituacionDeCalle BIT NULL,
  );
  -- EXEC sys.sp_addextendedproperty @name=N'FHIR_Line', @value=N'https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.address.line' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DomicilioPaciente', @level2type=N'COLUMN',@level2name=N'FHIR_Line'
END