IF OBJECT_ID(N'dbo.TAB_RelacionContactoPaciente', N'U') IS NULL BEGIN
  CREATE TABLE [dbo].[TAB_RelacionContactoPaciente]
  (
    Codigo CHAR(1) PRIMARY KEY,
    Nombre VARCHAR(30) NOT NULL,
    Vigente BIT DEFAULT 1 NOT NULL
  );

  INSERT INTO [dbo].[TAB_RelacionContactoPaciente]
    (Codigo, Nombre)
  VALUES
    ('C', 'Contacto de emergencia'),
    ('E', 'Empleador'),
    ('F', 'Entidad federal'),
    ('I', 'Compañia de seguros'),
    ('N', 'Pariente más cercano'),
    ('S', 'Entidad estatal'),
    ('U', 'Desconocido');
END

