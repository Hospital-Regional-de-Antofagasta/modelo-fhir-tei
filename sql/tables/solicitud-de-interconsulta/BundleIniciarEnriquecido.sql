/**
    Guarda los mensajes enviados por los establecimientos que originan la solicitud de interconsulta, ya pertinentes y con destino al hospital regional de antofagasta.
    Tabla de solo lectura.
*/
CREATE TABLE [dbo].[FHIR_BundleIniciarEnriquecido] (
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID() CONSTRAINT PK_BUNDLEINICIARENRIQUECIDO PRIMARY KEY,

    FHIR_Bundle VARCHAR(MAX) NOT NULL,

    ProfesionalDTO VARCHAR(MAX) NOT NULL,

    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
)