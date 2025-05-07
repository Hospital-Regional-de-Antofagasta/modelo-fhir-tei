DROP TABLE IF EXISTS [dbo].[RelacionPersonaContactoPaciente];

CREATE TABLE [dbo].[RelacionPersonaContactoPaciente]
(
  IdPersonaContacto UNIQUEIDENTIFIER NOT NULL CONSTRAINT FK_RELACIONPERSONACONTACTOPACIENTE FOREIGN KEY REFERENCES PersonaContactoPaciente(Id),
  CodigoRelacion CHAR(1) NOT NULL CONSTRAINT FK_RELACIONPERSONACONTACTOPACIENTE_RELACION FOREIGN KEY REFERENCES TAB_FHIR_RelacionContactoPaciente(Codigo),
  CONSTRAINT PK_RELACIONPERSONACONTACTOPACIENTE PRIMARY KEY (IdPersonaContacto, CodigoRelacion),
  
  FHIR_Coding VARCHAR(MAX) NULL,

  [CreatedBy] [VARCHAR](10) NOT NULL CONSTRAINT FK_RELACIONPERSONACONTACTOPACIENTE_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]),
  [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
);

EXEC sys.sp_addextendedproperty @name=N'FHIR_Coding', @value=N'https://build.fhir.org/ig/Minsal-CL/SIGTEv2-IG/StructureDefinition-PatientLE-definitions.html#key_Patient.contact.relationship.coding' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RelacionPersonaContactoPaciente', @level2type=N'COLUMN',@level2name=N'FHIR_Coding'