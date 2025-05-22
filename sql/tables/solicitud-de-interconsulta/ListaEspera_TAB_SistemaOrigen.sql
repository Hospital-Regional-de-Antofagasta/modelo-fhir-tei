/* 80 */
CREATE TABLE [dbo].[ListaEspera_TAB_SistemaOrigen](
	[Id] BIGINT IDENTITY(1,1) CONSTRAINT PK_LE_SISTEMAORIGEN PRIMARY KEY NOT NULL,
	[Codigo] INT NOT NULL,
	[Texto] [VARCHAR](100) NOT NULL,
	[Vigencia] BIT NOT NULL DEFAULT 1,
	[CreatedBy] [VARCHAR](10) CONSTRAINT FK_LE_SISTEMAORIGEN_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
)

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código del sistema de origen.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_SistemaOrigen', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre del sistema de origen.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_SistemaOrigen', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'ListaEspera_TAB_SistemaOrigen', @value=N'Esta tabla almacena los sistemas de origen de una Interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_SistemaOrigen'


INSERT INTO [dbo].[ListaEspera_TAB_SistemaOrigen]
	([Codigo],
	[Texto])
VALUES
	(0,'Historico'),
	(1,'SICLOPE Atención Ambulatoria'),
	(2,'SICLOPE Atención Hospitalaria'),
	(3,'Urgencias'),
	(4,'Agenda'),
	(5,'INTEGRACIÓN RAYEN')

