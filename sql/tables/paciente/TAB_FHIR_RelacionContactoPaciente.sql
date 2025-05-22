/* 50 */
CREATE TABLE [dbo].[TAB_FHIR_RelacionContactoPaciente]
(
  Id TINYINT CONSTRAINT PK_FHIR_RELACIONCONTACTOPACIENTE PRIMARY KEY (Id),
  Codigo CHAR(1) NOT NULL UNIQUE,
  Nombre VARCHAR(30) NOT NULL,
  Vigente BIT DEFAULT 1 NOT NULL,

  [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
  [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
);

ALTER TABLE [dbo].[TAB_FHIR_RelacionContactoPaciente] ADD
CONSTRAINT FK_FHIR_RELACIONCONTACTOPACIENTE_USUARIO FOREIGN KEY (CreatedBy) REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]);

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