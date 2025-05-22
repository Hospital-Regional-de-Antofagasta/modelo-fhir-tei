/* 10 */
CREATE TABLE [dbo].[ListaEspera_EstadoInterconsulta](
	[IdEstado] BIGINT CONSTRAINT FK_LE_ESTADOINTERCONSULTA_ESTADO FOREIGN KEY REFERENCES [dbo].[TAB_FHIR_EstadoInterconsulta]([Id]) NOT NULL,
	[IdInterconsulta] BIGINT CONSTRAINT FK_LE_ESTADOINTERCONSULTA_INTERCONSULTA FOREIGN KEY REFERENCES [dbo].[ListaEspera_Interconsulta]([Id]) NOT NULL,
	
	[CreatedBy] [VARCHAR](10) CONSTRAINT FK_LE_ESTADOINTERCONSULTA_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),

	CONSTRAINT PK_LE_ESTADO_INTERCONSULTA PRIMARY KEY ([IdEstado],[IdInterconsulta]),
);

EXEC sys.sp_addextendedproperty @name=N'IdEstado', @value=N'Id del estado.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_EstadoInterconsulta', @level2type=N'COLUMN',@level2name=N'IdEstado'

EXEC sys.sp_addextendedproperty @name=N'IdInterconsulta', @value=N'Id de la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_EstadoInterconsulta', @level2type=N'COLUMN',@level2name=N'IdInterconsulta'

EXEC sys.sp_addextendedproperty @name=N'ListaEspera_EstadoInterconsulta', @value=N'Esta tabla almacena los estados por los que pasan las interconsultas.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_EstadoInterconsulta'


