
IF OBJECT_ID('dbo.TAB_DEIS_TipoVia') IS NULL BEGIN
  CREATE TABLE [dbo].[TAB_DEIS_TipoVia]
  (
    Id TINYINT CONSTRAINT PK_DEIS_TIPOVIA PRIMARY KEY,
    Codigo VARCHAR(5) NOT NULL UNIQUE,
    Nombre VARCHAR(50) NOT NULL,
    Vigente BIT DEFAULT 1 NOT NULL,

    [CreatedBy] [VARCHAR](10) CONSTRAINT FK_DEIS_TIPOVIA_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
  );

  INSERT INTO [dbo].[TAB_DEIS_TipoVia] (Id, Codigo, Nombre) VALUES
      (1, '1', 'Calle'),
      (2, '2', 'Avenida'),
      (3, '3', 'Pasaje'),
      (4, '4', 'Camino'),
      (5, '5', 'Carretera'),
      (6, '6', 'Callejón'),
      (7, '7', 'Paseo'),
      (8, '8', 'Escalera'),
      (9, '9', 'Otro'),
      (10, '10', 'Rotonda');
END