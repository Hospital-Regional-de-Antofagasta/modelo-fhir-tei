

CREATE TABLE [dbo].[ListaEspera_TAB_ReferenciaDestino](
	[Id] [tinyint] NOT NULL CONSTRAINT PK_LE_TAB_REFERENCIADESTINO PRIMARY KEY,
	[Codigo] VARCHAR(2) NOT NULL,
	[Texto] [varchar](50) NOT NULL,
	[Vigencia] BIT DEFAULT 1 NOT NULL,
	[CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
);

INSERT INTO [dbo].[ListaEspera_TAB_ReferenciaDestino] (Id, Codigo, Texto) VALUES
(1, '1', 'APS'),
(2, '2', 'Nivel Secundario'),
(3, '3', 'Extra Sistema'),
(4, '4', 'Hospital Digital'),
(5, '5', 'Establecimiento Alta Complejidad');
