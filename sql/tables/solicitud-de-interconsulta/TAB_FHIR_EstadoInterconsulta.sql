/* 80 */
CREATE TABLE [dbo].[TAB_FHIR_EstadoInterconsulta](
	[Id] BIGINT IDENTITY(1,1) CONSTRAINT PK_TAB_FHIR_ESTADOINTERCONSULTA PRIMARY KEY NOT NULL,
	[Codigo] VARCHAR(1) NOT NULL CONSTRAINT UQ_TAB_FHIR_ESTADOINTERCONSULTA_CODIGO UNIQUE,
	[Texto] [VARCHAR](100) NOT NULL,
	[Vigencia] BIT NOT NULL DEFAULT 1,
	[CreatedBy] [VARCHAR](10) CONSTRAINT FK_TAB_FHIR_ESTADOINTERCONSULTA_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
)
EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código del estado.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_FHIR_EstadoInterconsulta', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre del estado.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_FHIR_EstadoInterconsulta', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'TAB_FHIR_EstadoInterconsulta', @value=N'Esta tabla almacena los estados de las interconsultas según FHIR.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_FHIR_EstadoInterconsulta'

INSERT INTO [dbo].[TAB_FHIR_EstadoInterconsulta]
           ([Codigo], [Texto])
     VALUES
           ('1', 'A la espera de referencia'),
		   ('2', 'A la espera de revisión'),
		   ('3', 'A la espera de priorización'),
		   ('4', 'A la espera de agendamiento'),
		   ('5', 'En espera de la atención'),
		   ('6', 'A la espera de cierre'),
		   ('7', 'Cerrada')

