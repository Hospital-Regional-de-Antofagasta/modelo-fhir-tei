IF OBJECT_ID(N'dbo.TAB_TipoIdentificadorPersona', N'U') IS NULL BEGIN
  CREATE TABLE [dbo].[TAB_TipoIdentificadorPersona] (
      Codigo CHAR(2) PRIMARY KEY,
      Nombre VARCHAR(50) NOT NULL,
      Descripcion VARCHAR(100) NOT NULL
  )

  INSERT INTO [dbo].[TAB_TipoIdentificadorPersona]
    (Codigo, Nombre, Descripcion)
  VALUES
  ('01', 'RUN', 'Rol Único Nacional'),
  ('02', 'RUN Provisorio', 'RUN provisorio (Artículo 44)'),
  ('03', 'RUN Madre', 'RUN Madre (para recién nacido)'),
  ('04', 'Número Folio', 'Número Folio Comprobante de Parto chileno'),
  ('05', 'PPN', 'Pasaporte'),
  ('06', 'Documento de identificación del país de origen', 'Documento de identificación del país de origen'),
  ('07', 'Acta de nacimiento del país de origen', 'Acta de nacimiento del país de origen'),
  ('08', 'NIP', 'Número de Identificación Provisorio (NIP)'),
  ('09', 'NIC', 'Número Identificatorio para cotizar (NIC)'),
  ('10', 'IPA', 'Identificación Provisoria del Apoderado (IPA)'),
  ('11', 'IPE', 'Identificación Provisoria del Escolar (IPE)'),
  ('12', 'Número de Ficha Clínica Sistema Local', 'Número de Ficha Clínica Sistema Local'),
  ('13', 'RNPI', 'Registro Nacional de Prestadores Individuales'),
  ('14', 'OTRO', 'Otro tipo de identificador');
END