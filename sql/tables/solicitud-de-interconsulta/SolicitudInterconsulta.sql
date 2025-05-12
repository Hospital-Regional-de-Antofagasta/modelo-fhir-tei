CREATE TABLE [dbo].[SolicitudInterconsulta]
(
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID() CONSTRAINT PK_SOLICITUDINTERCONSULTA PRIMARY KEY,
    NumeroPaciente FLOAT NOT NULL,

    -- INICIO EXTENSIONES
    IdMotivoCierreInterconsulta TINYINT NULL,
    RequiereExamen BIT NULL,
    EsAtencionPreferente BIT NULL,
    TieneResolutividadAPS BIT NULL,
    ReferenciaOrigen VARCHAR(10) NULL CHECK (ReferenciaOrigen IN ('APS', 'URGENCIA', 'DERIVACION')),
    FundamentoPriorizacion VARCHAR(250) NULL,
    Estado VARCHAR(20) NOT NULL CHECK (Estado IN (
        'ESPERANDO_REFERENCIA',
        'ESPERANDO_REVISION',
        'ESPERANDO_PRIORIZACION',
        'ESPERANDO_AGENDAMIENTO',
        'ESPERANDO_ATENCION',
        'ESPERANDO_CIERRE',
        'CERRADA'
    )) DEFAULT ('ESPERANDO_REFERENCIA'),

    -- REFERENCES TAB_DEIS_EspecialidadMedica x WHERE x.Tipo IN 'GENERAL', 'ODONTOLOGICA'
    IdEspecialidadDestino SMALLINT NULL,

    -- REFERENCES TAB_DEIS_EspecialidadMedica x WHERE x.Tipo IN 'GENERAL', 'ODONTOLOGICA'
    IdSubEspecialidadDestino SMALLINT NULL,

    TipoPertinencia VARCHAR(20) NOT NULL CHECK (TipoPertinencia IN (
        'PERTINENTE', 
        'NO_PERTINENTE', 
        'PERTINENTE_INCOMPLETA'
    )),

    MotivoNoPertinencia VARCHAR(250) NULL,

    -- FIN EXTENSIONES

    ModalidadAtencion  VARCHAR(20) NOT NULL CHECK (ModalidadAtencion in (
        'PRESENCIAL', 'REMOTA', 'TELEMEDICINA'
    )),

    Prioridad VARCHAR(20) NOT NULL CHECK (Prioridad IN ('ROUTINE', 'URGENT', 'ASAP', 'STAT')),

    ReferenciaDestino VARCHAR(32) NOT NULL CHECK (ReferenciaDestino IN ('NIVEL_SECUNDARIO', 'APS', 'EXTRA_SISTEMA', 'HOSPITAL_DIGITAL', 'ESTABLECIMIENTO_ALTA_COMPLEJIDAD')),

    MotivoDerivacion VARCHAR(20) NOT NULL CHECK (MotivoDerivacion IN (
        'CONFIRMACION', 'CONTROL_ESPECIALISTA', 'REALIZA_TRATAMIENTO', 'SEGUIMIENTO', 'OTRO'
    )),

    -- INICIO FHIR
    FHIR_Id VARCHAR(64) NULL,
    FHIR_Identifier_MINSAL VARCHAR(64) NULL,
    FHIR_Identifier_Origin VARCHAR(64) NULL,
    -- FIN FHIR

    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy VARCHAR(10) NOT NULL DEFAULT 'SYSTEM',
    DeletedAt DATETIME NULL,
    DeletedBy VARCHAR(10) NULL,
);

