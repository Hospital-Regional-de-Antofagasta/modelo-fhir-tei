/* 50 */
CREATE TABLE [dbo].[ListaEspera_TAB_SistemaOrigen](
	[Id] [bigint] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_LE_SISTEMAORIGEN] PRIMARY KEY,
	[Codigo] [int] NOT NULL,
	[Texto] [varchar](100) NOT NULL,
	[Vigencia] [bit] NOT NULL DEFAULT ((1)),
	[CreatedBy] [varchar](10) NOT NULL DEFAULT (suser_name()) ,
	[CreatedAt] [datetime] NOT NULL DEFAULT (getdate())
)

INSERT INTO [dbo].[ListaEspera_TAB_SistemaOrigen] ( Codigo, Texto) VALUES
(1, 'Historico'),
(2, 'Integración con Rayen'),
(3, 'SICLOPE (Atención abierta)'),
(4, 'SICLOPE (Atención cerrada)');

ALTER TABLE [dbo].[ListaEspera_TAB_SistemaOrigen] ADD
CONSTRAINT [FK_LE_SISTEMAORIGEN_USUARIO] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Segu_Usuarios] ([Segu_Usr_Cuenta]);
