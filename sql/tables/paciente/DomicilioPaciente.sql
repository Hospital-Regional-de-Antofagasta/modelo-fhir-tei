/* 20 */
CREATE TABLE [dbo].[DomicilioPaciente]
(
  Id UNIQUEIDENTIFIER CONSTRAINT PK_DOMICILIOPACIENTE PRIMARY KEY DEFAULT NEWID(),

  NumeroPaciente FLOAT NOT NULL,

  -- Requerido para tributar a FHIR.
  IdUso TINYINT NOT NULL,
  
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

ALTER TABLE [dbo].[DomicilioPaciente] ADD
CONSTRAINT FK_DOMICILIO_PACIENTE FOREIGN KEY (NumeroPaciente) REFERENCES [dbo].[PAC_Paciente](PAC_PAC_Numero),
CONSTRAINT FK_DOMICILIO_USO FOREIGN KEY (IdUso) REFERENCES [dbo].[TAB_FHIR_UsoDomicilioPersona](Id),
CONSTRAINT FK_DOMICILIO_COMUNA FOREIGN KEY (IdComuna) REFERENCES [dbo].[TAB_DEIS_Comuna](Id),
CONSTRAINT FK_DOMICILIO_TIPOVIA FOREIGN KEY (IdTipoVia) REFERENCES [dbo].[TAB_DEIS_TipoVia](Id),
CONSTRAINT FK_DOMICILIO_CREATEDBY FOREIGN KEY (CreatedBy) REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]),
CONSTRAINT FK_DOMICILIO_DELETEDBY FOREIGN KEY (DeletedBy)REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]);
