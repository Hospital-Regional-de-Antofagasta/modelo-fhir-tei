
DROP TABLE IF EXISTS [dbo].[TAB_FHIR_TipoIdentificadorPersona];

CREATE TABLE [dbo].[TAB_FHIR_TipoIdentificadorPersona] (
    Id TINYINT CONSTRAINT PK_FHIR_TIPOIDENTIFICADORPERSONA PRIMARY KEY,
    Codigo CHAR(2) NOT NULL UNIQUE,
    Nombre VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(100) NOT NULL,

    [CreatedBy] [VARCHAR](10) CONSTRAINT FK_FHIR_TIPOIDENTIFICADORPERSONA_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
);

INSERT INTO [dbo].[TAB_FHIR_TipoIdentificadorPersona]
    (Id, Codigo, Nombre, Descripcion)
VALUES
    (1, '01', 'RUN', 'Rol Único Nacional'),
    (2, '02', 'RUN Provisorio', 'RUN provisorio (Artículo 44)'),
    (3, '03', 'RUN Madre', 'RUN Madre (para recién nacido)'),
    (4, '04', 'Número Folio', 'Número Folio Comprobante de Parto chileno'),
    (5, '05', 'PPN', 'Pasaporte'),
    (6, '06', 'Documento de identificación del país de origen', 'Documento de identificación del país de origen'),
    (7, '07', 'Acta de nacimiento del país de origen', 'Acta de nacimiento del país de origen'),
    (8, '08', 'NIP', 'Número de Identificación Provisorio (NIP)'),
    (9, '09', 'NIC', 'Número Identificatorio para cotizar (NIC)'),
    (10, '10', 'IPA', 'Identificación Provisoria del Apoderado (IPA)'),
    (11, '11', 'IPE', 'Identificación Provisoria del Escolar (IPE)'),
    (12, '12', 'Número de Ficha Clínica Sistema Local', 'Número de Ficha Clínica Sistema Local'),
    (13, '13', 'RNPI', 'Registro Nacional de Prestadores Individuales'),
    (14, '14', 'OTRO', 'Otro tipo de identificador');