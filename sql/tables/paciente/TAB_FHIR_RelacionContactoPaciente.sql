DROP TABLE IF EXISTS [dbo].[TAB_FHIR_RelacionContactoPaciente];


CREATE TABLE [dbo].[TAB_FHIR_RelacionContactoPaciente]
(
  Id TINYINT CONSTRAINT PK_FHIR_RELACIONCONTACTOPACIENTE PRIMARY KEY (Id),
  Codigo CHAR(1) NOT NULL UNIQUE,
  Nombre VARCHAR(30) NOT NULL,
  Vigente BIT DEFAULT 1 NOT NULL,

  [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
  [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
);
EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'https://hl7.org/fhir/R4/valueset-patient-contactrelationship.html' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_FHIR_RelacionContactoPaciente', @level2type=N'COLUMN',@level2name=N'Codigo'

INSERT INTO [dbo].[TAB_FHIR_RelacionContactoPaciente]
  (Id, Codigo, Nombre)
VALUES
  (1, 'C', 'Contacto de emergencia'),
  (2, 'E', 'Empleador'),
  (3, 'F', 'Entidad federal'),
  (4, 'I', 'Compañia de seguros'),
  (5, 'N', 'Pariente más cercano'),
  (6, 'S', 'Entidad estatal'),
  (7, 'U', 'Desconocido');