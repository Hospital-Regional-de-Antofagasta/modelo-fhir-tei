
CREATE TABLE [dbo].[DomicilioPrestador]
(
  Id UNIQUEIDENTIFIER CONSTRAINT PK_DOMICILIOPRESTADOR PRIMARY KEY DEFAULT NEWID(),

  IdPrestador UNIQUEIDENTIFIER NOT NULL,
    
  -- Capitulo 4 inciso 1.3. Comuna
  IdComuna SMALLINT NOT NULL,

  -- Capitulo 4 inciso 1.5.1. Tipo de vía
  IdTipoVia TINYINT NULL,

  -- Capitulo 4 inciso 1.5.2. Nombre de vía
  NombreCalle VARCHAR(100) NOT NULL,

  -- Capitulo 4 inciso 1.5.3. Numero
  NumeroCalle VARCHAR(10) NULL,

  -- Capitulo 4 inciso 1.5.4. Anexo de dirección
  AnexoCalle VARCHAR(200) NULL,

  -- Capitulo 4 inciso 1.7. Sistema de coordenadas (obligatorio, pero de momento es imposible implementarlo)
  Latitud VARCHAR(20) NULL,
  Longitud VARCHAR(20) NULL,

  CodigoPostal VARCHAR(10) NULL,

  [CreatedBy] [VARCHAR](10) NOT NULL ,
  [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),

  [DeletedBy] [VARCHAR](10) NULL,
  [DeletedAt] DATETIME NULL
);
-- EXEC sys.sp_addextendedproperty @name=N'FHIR_Line', @value=N'https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.address.line' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DomicilioPrestador', @level2type=N'COLUMN',@level2name=N'FHIR_Line'
