CREATE TABLE [dbo].[FHIR_TEI_TAB_TipoEventoInterconsulta] (
    Id TINYINT NOT NULL CONSTRAINT PK_FHIR_TEI_TAB_TIPOEVENTOINTERCONSULTA PRIMARY KEY,
    
    Texto VARCHAR(50) NOT NULL CHECK (TipoEvento IN (
        'INICIAR',
        'REFERENCIAR',
        'REVISAR',
        'PRIORIZAR',
        'AGENDAR',
        'ATENDER',
        'TERMINAR'
    )),

    Descripcion VARCHAR(200) NOT NULL
)

INSERT INTO [dbo].[FHIR_TEI_TAB_TipoEventoInterconsulta] (Id, Texto, Descripcion) VALUES
    (1, 'INICIAR', 'Emitido cuando el profesional genera una solicitud de interconsulta'),
    (2, 'REFERENCIAR', 'Emitido automáticamente luego de que una interconsulta ha sido '),
    (3, 'REVISAR', 'REVISAR', ''),
    (4, 'PRIORIZAR', 'PRIORIZAR', ''),
    (5, 'AGENDAR', 'AGENDAR', ''),
    (6, 'ATENDER', 'ATENDER', ''),
    (7, 'TERMINAR', 'TERMINAR', '')