SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON


CREATE TABLE [dbo].[TAB_FHIR_UsoMedioContacto] (
  Id TINYINT CONSTRAINT PK_FHIR_USOMEDIOCONTACTO PRIMARY KEY (Id),
  Codigo VARCHAR(10) NOT NULL UNIQUE,
  Texto VARCHAR(50) NOT NULL,
  Vigencia BIT NOT NULL DEFAULT 1,
  [CreatedBy] [VARCHAR](10)  NOT NULL DEFAULT SUSER_NAME(),
  [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
);

INSERT INTO [dbo].[TAB_FHIR_UsoMedioContacto] ([Id], [Codigo], [Texto]) VALUES
  (1, 'home', 'Casa'),
  (2, 'work', 'Trabajo'),
  (3, 'temp', 'Temporal'),
  (4, 'old', 'Antiguo'),
  (5, 'mobile', 'Móvil');