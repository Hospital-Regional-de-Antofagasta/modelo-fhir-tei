SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON


DROP TABLE IF EXISTS [dbo].[TAB_TipoMedioContacto];

CREATE TABLE [dbo].[TAB_TipoMedioContacto] (
  Id TINYINT CONSTRAINT PK_TIPOMEDIOCONTACTO PRIMARY KEY (Id),
  Texto VARCHAR(50) NOT NULL,
  Vigencia BIT NOT NULL DEFAULT 1,
  [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
  [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
);

INSERT INTO [dbo].[TAB_TipoMedioContacto] ([Id], [Texto]) VALUES
  (1, 'Telefono Móvil'),
  (2, 'Telefono Fijo'),
  (3, 'Correo Electrónico');
