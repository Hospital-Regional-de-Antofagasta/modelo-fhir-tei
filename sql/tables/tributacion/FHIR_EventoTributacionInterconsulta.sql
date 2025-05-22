/* 2 */

CREATE TABLE [dbo].[TAB_FHIR_TipoEventoInterconsulta] (
    Id TINYINT NOT NULL CONSTRAINT PK_FHIR_TEI_TAB_TIPOEVENTOINTERCONSULTA PRIMARY KEY,
    Texto VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(200) NOT NULL
);

INSERT INTO [dbo].[TAB_FHIR_TipoEventoInterconsulta] (Id, Texto, Descripcion) VALUES
    (1, 'INICIAR', 'Emitido cuando el profesional genera una solicitud de interconsulta'),
    (2, 'REFERENCIAR', 'Emitido automáticamente luego de que una interconsulta ha sido '),
    (3, 'REVISAR', 'REVISAR'),
    (4, 'PRIORIZAR', 'PRIORIZAR'),
    (5, 'AGENDAR', 'AGENDAR'),
    (6, 'ATENDER', 'ATENDER'),
    (7, 'TERMINAR', 'TERMINAR')

CREATE TABLE [dbo].[FHIR_EventoTributacionInterconsulta] (
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT (NEWID()),
    IdInterconsulta BIGINT NOT NULL,
    IdTipoEvento TINYINT NOT NULL,
    -- IdTipoEventoRequerido TINYINT NULL,
    OrdenEnvio INT NOT NULL,

    CONSTRAINT PK_FHIR_EVENTOTRIBUTACIONINTERCONSULTA PRIMARY KEY (Id),
    CONSTRAINT FK_FHIR_TEI_EVENTOINTERCONSULTA_INTERCONSULTA FOREIGN KEY (IdInterconsulta) REFERENCES [dbo].[ListaEspera_Interconsulta] (Id),
    CONSTRAINT FK_FHIR_TEI_EVENTOINTERCONSULTA_TIPOEVENTOINTERCONSULTA FOREIGN KEY (IdTipoEvento) REFERENCES [dbo].[TAB_FHIR_TipoEventoInterconsulta] (Id),
    -- CONSTRAINT FK_FHIR_TEI_EVENTOINTERCONSULTA_TIPOEVENTOREQUERIDO FOREIGN KEY (IdTipoEventoRequerido) REFERENCES [dbo].[FHIR_TEI_TAB_TipoEventoInterconsulta] (Id),
);

CREATE TABLE [dbo].[TAB_FHIR_EstadoMensajeSalidaInterconsulta] (
    Id TINYINT NOT NULL,
    Texto VARCHAR(20) NOT NULL
    CONSTRAINT PK_TAB_FHIR_TIPOESTADOMENSAJESALIDAINTERCONSULTA PRIMARY KEY (Id)
);

INSERT INTO [dbo].[TAB_FHIR_EstadoMensajeSalidaInterconsulta] (Id, Texto) VALUES
(1, 'Pendiente'),
(2, 'Procesando'),
(3, 'Enviado'),
(4, 'No Enviado');


/* TODO: Agregar columnas para determinar hacia donde enviar el mensaje? */
CREATE TABLE [dbo].[TAB_FHIR_DestinoMensajeSalidaInterconsulta] (
    Id TINYINT NOT NULL,
    Texto VARCHAR(20) NOT NULL,
    CONSTRAINT PK_TAB_FHIR_DESTINOMENSAJESALIDAINTERCONSULTA PRIMARY KEY (Id)
)

INSERT INTO [dbo].[TAB_FHIR_DestinoMensajeSalidaInterconsulta] (Id, Texto) VALUES
(0, 'RAYEN'),
(1, 'MINSAL');

CREATE TABLE [dbo].[FHIR_MensajeSalidaInterconsulta] (
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT (NEWID()),
    IdEventoTributacion UNIQUEIDENTIFIER NOT NULL,
    
    IdEstadoMensajeSalida TINYINT NOT NULL,
    IdDestinoMensajeSalida TINYINT NOT NULL,

    MensajeJSON VARCHAR(MAX) NOT NULL,

    FechaEnvioExitoso DATETIME NULL,
    RespuestaExitosaJSON VARCHAR(MAX) NULL,


    CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),

    CONSTRAINT PK_FHIR_MSINTERCONSULTA PRIMARY KEY (Id),
    CONSTRAINT FK_FHIR_MSINTERCONSULTA_EVENTOTRIBUTACION FOREIGN KEY (IdEventoTributacion) REFERENCES [dbo].[FHIR_EventoTributacionInterconsulta] (Id),
    CONSTRAINT FK_FHIR_MSINTERCONSULTA_ESTADO FOREIGN KEY (IdEstadoMensajeSalida) REFERENCES [dbo].[TAB_FHIR_EstadoMensajeSalidaInterconsulta] (Id),
    CONSTRAINT FK_FHIR_MSINTERCONSULTA_DESTINO FOREIGN KEY (IdDestinoMensajeSalida) REFERENCES [dbo].[TAB_FHIR_DestinoMensajeSalidaInterconsulta] (Id)
);

CREATE TABLE [dbo].[FHIR_ErrorMensajeSalidaInterconsulta] (
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT (NEWID()),
    IdMensajeSalida UNIQUEIDENTIFIER NOT NULL,

    ErrorJSON VARCHAR(MAX) NOT NULL,

    CreatedAt DATETIME NOT NULL DEFAULT(GETDATE()),

    CONSTRAINT PK_FHIR_LOGERRORMSINTERCONSULTA PRIMARY KEY (Id),
    CONSTRAINT FK_FHIR_LOGERRORMSINTERCONSULTA_MSINTERCONSULTA FOREIGN KEY (IdMensajeSalida) REFERENCES [dbo].[FHIR_MensajeSalidaInterconsulta] (Id)
)
