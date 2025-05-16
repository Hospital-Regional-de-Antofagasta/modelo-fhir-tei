CREATE TABLE [dbo].[ListaEspera_TAB_SistemaOrigen](
	[Id] [bigint] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_LE_SISTEMAORIGEN] PRIMARY KEY,
	[Codigo] [int] NOT NULL,
	[Texto] [varchar](100) NOT NULL,
	[Vigencia] [bit] NOT NULL DEFAULT ((1)),
	[CreatedBy] [varchar](10) NOT NULL DEFAULT (suser_name()) ,
	[CreatedAt] [datetime] NOT NULL DEFAULT (getdate())
)

ALTER TABLE [dbo].[ListaEspera_TAB_SistemaOrigen]  WITH CHECK ADD  CONSTRAINT [FK_LE_SISTEMAORIGEN_USUARIO] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Segu_Usuarios] ([Segu_Usr_Cuenta])

ALTER TABLE [dbo].[ListaEspera_TAB_SistemaOrigen] CHECK CONSTRAINT [FK_LE_SISTEMAORIGEN_USUARIO]

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código del sistema de origen.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_SistemaOrigen', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre del sistema de origen.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_SistemaOrigen', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'ListaEspera_TAB_SistemaOrigen', @value=N'Esta tabla almacena los sistemas de origen de una Interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_SistemaOrigen'


GO

