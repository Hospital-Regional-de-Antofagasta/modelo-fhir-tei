CREATE TABLE [dbo].[ListaEspera_EstadoInterconsulta](
	[IdEstado] [bigint] NOT NULL,
	[IdInterconsulta] [bigint] NOT NULL,
	[CreatedBy] [varchar](10) NOT NULL DEFAULT (suser_name()),
	[CreatedAt] [datetime] NOT NULL DEFAULT (getdate()),
    CONSTRAINT [PK_LE_ESTADO_INTERCONSULTA] PRIMARY KEY ([IdEstado] ASC,[IdInterconsulta] ASC,[CreatedAt] ASC)
)