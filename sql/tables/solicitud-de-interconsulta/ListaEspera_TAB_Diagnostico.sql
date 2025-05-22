/* 50 */
CREATE TABLE [dbo].[ListaEspera_TAB_Diagnostico]
(
    [Id] [bigint] NOT NULL PRIMARY KEY IDENTITY(1, 1),
    [Codigo] [varchar](50) NOT NULL,
    [Texto] [varchar](250) NOT NULL,
    Vigencia BIT NOT NULL DEFAULT 1,
    [IdTipoCodificacionDiagnostica] [int] NOT NULL
);

INSERT INTO dbo.[ListaEspera_TAB_Diagnostico]
    (Codigo, Texto, IdTipoCodificacionDiagnostica)
VALUES
    ('A00', 'Enfermedad', 1);
