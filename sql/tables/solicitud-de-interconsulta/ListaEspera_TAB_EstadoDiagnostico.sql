/* 50 */
CREATE TABLE [dbo].[ListaEspera_TAB_EstadoDiagnostico]
(
    [Id] [bigint] NOT NULL PRIMARY KEY IDENTITY(1, 1),
    [CodigoFHIR] [varchar](20) NULL,
    [Texto] [varchar](100) NULL,
    Vigencia BIT NOT NULL DEFAULT 1
);

INSERT INTO [dbo].[ListaEspera_TAB_EstadoDiagnostico]
    (CodigoFHIR, Texto)
VALUES
    ('provisional', 'Presuntivo'),
    ('confirmed', 'Confirmado'),
    ('unconfirmed', 'No confirmado'),
    ('differential', 'Diferencial'),
    ('refuted', 'Refutado'),
    ('entered-in-error', 'Ingresado por error');