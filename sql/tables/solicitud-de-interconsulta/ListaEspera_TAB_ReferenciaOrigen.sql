/* 50 */
CREATE TABLE [dbo].[ListaEspera_TAB_ReferenciaOrigen](
	[Id] [tinyint] NOT NULL CONSTRAINT PK_LE_TAB_REFERENCIAORIGEN PRIMARY KEY,
	[Codigo] VARCHAR(2) NOT NULL,
	[Texto] [varchar](50) NOT NULL,
	[Vigencia] BIT DEFAULT 1 NOT NULL,
	[CodigoFHIR] VARCHAR(10),
	[CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
)

INSERT INTO [dbo].[ListaEspera_TAB_ReferenciaOrigen] (Id, Codigo, CodigoFHIR, Texto) VALUES
(1, '1', '1', 'APS'),
(2, '2', '2', 'Urgencia'),
(3, '3', '3', 'Derivacion');