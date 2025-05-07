IF OBJECT_ID(N'dbo.PersonaContactoPaciente', N'U') IS NULL BEGIN
  CREATE TABLE [dbo].[PersonaContactoPaciente]
  (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    NumeroPaciente FLOAT NOT NULL CONSTRAINT FK_PACIENTE_PERSONACONTACTO FOREIGN KEY (NumeroPaciente) REFERENCES [dbo].[PAC_Paciente](PAC_PAC_Numero),

    Nombre VARCHAR(50) NULL,
    ApellidoPaterno VARCHAR(50) NULL,
    ApellidoMaterno VARCHAR(50) NULL,

    Rut VARCHAR(10) NULL,

    /* https://hl7chile.cl/fhir/ig/clcore/1.9.2/StructureDefinition-IdContacto.html */
    FHIR_Identifier VARCHAR(MAX) NULL,

    [CreatedBy] [VARCHAR](10) NOT NULL CONSTRAINT FK_PERSONACONTACTO_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]),
	  [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
  );
END