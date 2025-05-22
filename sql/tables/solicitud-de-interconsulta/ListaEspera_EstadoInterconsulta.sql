/* 20 */
CREATE TABLE [dbo].[ListaEspera_EstadoInterconsulta](
	[IdEstado] [bigint] NOT NULL,
	[IdInterconsulta] [bigint] NOT NULL,
	[CreatedBy] [varchar](10) NOT NULL DEFAULT (suser_name()),
	[CreatedAt] [datetime] NOT NULL DEFAULT (getdate()),
    CONSTRAINT [PK_LE_ESTADO_INTERCONSULTA] PRIMARY KEY ([IdEstado] ASC,[IdInterconsulta] ASC,[CreatedAt] ASC)
)


ALTER TABLE [dbo].[ListaEspera_EstadoInterconsulta] ADD
-- CONSTRAINT [FK_LE_ESTADOINTERCONSULTA_ESTADO] FOREIGN KEY([IdEstado])
-- REFERENCES [dbo].[ListaEspera_TAB_EstadoInterconsulta] ([Id]),
CONSTRAINT [FK_LE_ESTADOINTERCONSULTA_INTERCONSULTA] FOREIGN KEY([IdInterconsulta])
REFERENCES [dbo].[ListaEspera_Interconsulta] ([Id]),

CONSTRAINT [FK_LE_ESTADOINTERCONSULTA_USUARIO] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Segu_Usuarios] ([Segu_Usr_Cuenta])
