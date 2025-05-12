CREATE TABLE [dbo].[SolicitudInterconsulta]
(
    Id UNIQUEIDENTIFIER NOT NULL CONSTRAINT PK_SOLICITUDINTERCONSULTA PRIMARY KEY,
    NumeroPaciente FLOAT NOT NULL,


    -- EXTENSIONS
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

    IdentificadorMINSAL VARCHAR(64),
    IdentificadorInternoMINSAL VARCHAR(64),
    IdentificadorOrigen VARCHAR(64),

    ModalidadAtencion  VARCHAR(20) NOT NULL CHECK (ModalidadAtencion in (
        'PRESENCIAL', 'REMOTA', 'TELEMEDICINA'
    )),
    Prioridad VARCHAR(20) NOT NULL CHECK (Prioridad IN ('ROUTINE', 'URGENT', 'ASAP', 'STAT'))


);