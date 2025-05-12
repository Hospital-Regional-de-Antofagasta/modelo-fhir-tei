CREATE TABLE [dbo].[MensajeSalida]
(
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID () CONSTRAINT PK_MENSAJESALIDA PRIMARY KEY,
    
    IdInterconsulta UNIQUEIDENTIFIER NOT NULL,
    TipoEvento VARCHAR(50) NOT NULL CHECK (TipoEvento IN (
        'INICIAR',
        'REFERENCIAR',
        'REVISAR',
        'PRIORIZAR',
        'AGENDAR',
        'ATENDER',
        'TERMINAR'
    )),

    BundleDTO VARCHAR(MAX) NOT NULL,
    
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