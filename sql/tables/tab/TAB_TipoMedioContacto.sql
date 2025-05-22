/* 50 */
CREATE TABLE [dbo].[TAB_TipoMedioContacto] (
  Id TINYINT CONSTRAINT PK_TIPOMEDIOCONTACTO PRIMARY KEY (Id),
  Texto VARCHAR(50) NOT NULL,
  Vigencia BIT NOT NULL DEFAULT 1,
  [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
  [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
);


ALTER TABLE [dbo].[TAB_TipoMedioContacto] ADD
CONSTRAINT FK_TIPOMEDIOCONTACTO_USUARIO FOREIGN KEY (CreatedBy) REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]);


INSERT INTO [dbo].[TAB_TipoMedioContacto] ([Id], [Texto]) VALUES
  (1, 'Telefono Móvil'),
  (2, 'Telefono Fijo'),
  (3, 'Correo Electrónico');
