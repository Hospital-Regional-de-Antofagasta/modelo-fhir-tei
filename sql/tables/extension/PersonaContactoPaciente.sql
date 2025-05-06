IF OBJECT_ID(N'dbo.PersonaContactoPaciente', N'U') IS NULL BEGIN
  CREATE TABLE [dbo].[PersonaContactoPaciente]
  (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    NumeroPaciente FLOAT NOT NULL CONSTRAINT FK_PACIENTE_PERSONACONTACTO FOREIGN KEY (NumeroPaciente) REFERENCES [dbo].[PAC_Paciente](PAC_PAC_Numero),

    Nombre VARCHAR(50) NULL,
    ApellidoPaterno VARCHAR(50) NULL,
    ApellidoMaterno VARCHAR(50) NULL,

    /* https://hl7chile.cl/fhir/ig/clcore/1.9.2/StructureDefinition-IdContacto.html */
    FHIR_Identifier VARCHAR(MAX) NULL,
  );
END