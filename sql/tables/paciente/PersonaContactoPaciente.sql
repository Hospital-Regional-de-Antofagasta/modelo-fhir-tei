/* 20 */
CREATE TABLE [dbo].[PersonaContactoPaciente]
(
  Id UNIQUEIDENTIFIER DEFAULT NEWID() CONSTRAINT PK_PERSONACONTACTO PRIMARY KEY (Id),
  NumeroPaciente FLOAT NOT NULL,

  Nombre VARCHAR(50) NULL,
  ApellidoPaterno VARCHAR(50) NULL,
  ApellidoMaterno VARCHAR(50) NULL,

  Rut VARCHAR(10) NULL,

  -- /* https://hl7chile.cl/fhir/ig/clcore/1.9.2/StructureDefinition-IdContacto.html */
  -- FHIR_Identifier VARCHAR(MAX) NULL,

  [CreatedBy] [VARCHAR](10) NOT NULL,
  [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
);

ALTER TABLE [dbo].[PersonaContactoPaciente] ADD
CONSTRAINT FK_PACIENTE_PERSONACONTACTO FOREIGN KEY (NumeroPaciente) REFERENCES [dbo].[PAC_Paciente](PAC_PAC_Numero),
CONSTRAINT FK_PERSONACONTACTO_USUARIO FOREIGN KEY (CreatedBy) REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]);
