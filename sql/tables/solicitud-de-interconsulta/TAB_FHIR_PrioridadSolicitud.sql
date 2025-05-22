/* 80 */
CREATE TABLE [dbo].[TAB_FHIR_PrioridadSolicitud](
	[Id] [tinyint] NOT NULL PRIMARY KEY,
	[Codigo] VARCHAR(10) NOT NULL,
	[Texto] [varchar](50) NOT NULL,
	[Vigencia] BIT DEFAULT 1 NOT NULL,
	[CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
);

INSERT INTO [dbo].[TAB_FHIR_PrioridadSolicitud] (Id, Codigo, Texto) VALUES
(1, 'routine', 'Normal (no urgente)'),
(2, 'urgent', 'Urgente'),
(3, 'asap', 'Tan pronto como sea posible'),
(4, 'stat', 'Inmediatamente');