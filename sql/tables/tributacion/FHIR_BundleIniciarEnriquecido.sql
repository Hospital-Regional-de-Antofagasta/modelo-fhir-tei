/**
    Guarda los mensajes enviados por los establecimientos que originan la solicitud de interconsulta, ya pertinentes y con destino al hospital regional de antofagasta.
    Tabla de solo lectura.
*/
CREATE TABLE [dbo].[FHIR_BundleIniciarEnriquecido] (
    -- Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID() CONSTRAINT PK_BUNDLEINICIARENRIQUECIDO PRIMARY KEY,

    IdSolicitudInterconsulta BIGINT NOT NULL,
    BundleOriginal VARCHAR(MAX) NOT NULL,

    -- EstablecimientoSolicitanteDTO VARCHAR(MAX) NOT NULL,
    -- PrestadorSolicitanteDTO VARCHAR(MAX) NOT NULL,
    -- Otros DTO para facil acceso.

    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
)

ALTER TABLE [dbo].[FHIR_BundleIniciarEnriquecido] ADD
CONSTRAINT FK_FHIR_BUNDLEINICIARENRIQUECIDO_SOLICITUDINTERCONSULTA FOREIGN KEY (IdSolicitudInterconsulta) REFERENCES [dbo].[ListaEspera_Interconsulta](Id);
