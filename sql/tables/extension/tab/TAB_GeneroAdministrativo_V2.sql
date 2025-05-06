IF OBJECT_ID('dbo.TAB_GeneroAdministrativo_V2') IS NULL BEGIN
  CREATE TABLE [dbo].[TAB_GeneroAdministrativo_V2]
  (
      Codigo VARCHAR(10) PRIMARY KEY,
      Nombre VARCHAR(20) NOT NULL
  )

  INSERT INTO [dbo].[TAB_GeneroAdministrativo_V2]
    (Codigo, Nombre)
  VALUES
    ('male', 'Masculino'),
    ('female', 'Femenino'),
    ('other', 'Otro'),
    ('unknown', 'Desconocido');
END