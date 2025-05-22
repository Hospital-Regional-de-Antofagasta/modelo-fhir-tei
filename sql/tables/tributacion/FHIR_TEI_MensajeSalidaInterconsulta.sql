CREATE TABLE [dbo].[FHIR_TEI_MensajeSalidaInterconsulta]
(
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID () CONSTRAINT PK_MENSAJESALIDAINTERCONSULTA PRIMARY KEY,
    
    IdInterconsulta BIGINT NOT NULL
    CONSTRAINT FK_MENSAJESALIDA_INTERCONSULTA_IDINTERCONSULTA FOREIGN KEY REFERENCES [dbo].[ListaEspera_Interconsulta](Id),

    IdTipoEvento VARCHAR(50) NOT NULL CONSTRAINT FK_MENSAJESALIDAINTERCONSULTA_TIPOEVENTOINTERCONSULTA FOREIGN KEY REFERENCES [dbo].[FHIR_TEI_TAB_TipoEventoInterconsulta](Texto),

    MensajeJSON VARCHAR(MAX) NOT NULL,

);

    
    EstadoEnvioMINSAL VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE' CHECK (
        EstadoEnvioMINSAL IN (
            'PENDIENTE',
            'PROCESANDO',
            'ENVIADO',
            'ERROR',
            'SIN_REINTENTOS_DISPONIBLES'
        )
    ),
    EstadoEnvioOrigen VARCHAR(20) NULL CHECK (
        EstadoEnvioOrigen IN (
            'PENDIENTE',
            'PROCESANDO',
            'ENVIADO',
            'ERROR',
            'SIN_REINTENTOS_DISPONIBLES'
        )
    ),
    CantidadReintentosDisponiblesEnvioMINSAL TINYINT NOT NULL DEFAULT 3,
    CantidadReintentosDisponiblesEnvioOrigen TINYINT NULL,

    RespuestaMINSAL VARCHAR(MAX) NULL,
    RespuestaOrigen VARCHAR(MAX) NULL,

    CreatedAt DATETIME NOT NULL DEFAULT GETDATE (),
);