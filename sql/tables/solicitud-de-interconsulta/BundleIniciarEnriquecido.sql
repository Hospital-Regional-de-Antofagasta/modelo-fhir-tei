/**
    Guarda los mensajes enviados por los establecimientos que originan la solicitud de interconsulta, ya pertinentes y con destino al hospital regional de antofagasta.
    Tabla de solo lectura.
*/
CREATE TABLE [dbo].[BundleIniciarEnriquecido] (
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID() CONSTRAINT PK_BUNDLEINICIARENRIQUECIDO PRIMARY KEY,


    -- ARRAY: [ { resourceType: "ABC", id: "123", ... }, { ... } ]
    -- OBJECT: { resourceType: "DEF", id: "456", ... }

    FHIR_Id VARCHAR(64) NOT NULL,
    FHIR_MessageHeaderLE VARCHAR(MAX) NOT NULL, -- OBJECT
    FHIR_ServiceRequestLE VARCHAR(MAX) NOT NULL, -- OBJECT
    FHIR_EncounterIniciarLE VARCHAR(MAX) NOT NULL, -- OBJECT
    FHIR_PatientLE VARCHAR(MAX) NOT NULL, -- OBJECT
    FHIR_ConditionDiagnosticoLE VARCHAR(MAX) NOT NULL, -- OBJECT
    FHIR_ObservationIndiceComorbilidadLE VARCHAR(MAX) NULL, -- OBJECT
    FHIR_ObservationDiscapacidadLE VARCHAR(MAX) NULL, -- OBJECT
    FHIR_ObservationIniciarCuidadorLE VARCHAR(MAX) NULL, -- OBJECT
    FHIR_ObservationResultadoExamen VARCHAR(MAX) NULL, -- ARRAY
    FHIR_AllergyIntoleranceIniciarLE VARCHAR(MAX) NULL, -- ARRAY
    FHIR_PractitionerRoleLE VARCHAR(MAX) NOT NULL, -- OBJECT
    FHIR_PractitionerProfesionalLE VARCHAR(MAX) NOT NULL, -- OBJECT
    FHIR_OrganizationLE VARCHAR(MAX) NOT NULL, -- OBJECT
    FHIR_QuestionnaireResponseIniciarLE VARCHAR(MAX) NULL, -- OBJECT
    FHIR_ServiceRequestExamenLE VARCHAR(MAX) NULL, -- ARRAY

    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
)