/* 80 */
CREATE TABLE [dbo].[ListaEspera_TAB_TipoPrestacion](
	[Id] BIGINT IDENTITY(1,1) CONSTRAINT PK_LE_TIPOPRESTACION PRIMARY KEY NOT NULL,
	[Codigo] INT NOT NULL,
	[Texto] [VARCHAR](100) NOT NULL,
	[Vigencia] BIT NOT NULL DEFAULT 1,
	[CreatedBy] [VARCHAR](10) CONSTRAINT FK_LE_TIPOPRESTACION_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
)

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código del tipo de prestación.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_TipoPrestacion', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre del tipo de prestación solicitada por interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_TipoPrestacion', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'ListaEspera_TAB_TipoPrestacion', @value=N'Esta tabla almacena los tipos de prestaciones que pueden tener las interconsultas de lista de espera.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_TipoPrestacion'

INSERT INTO [dbo].[ListaEspera_TAB_TipoPrestacion]
           ([Codigo]
		   ,[Texto]
           ,[Vigencia])
     VALUES
           (1,'Consulta nueva de especialidad',1),
		   (2,'Control de especialidad',1),
		   (3,'Procedimiento diagnóstico o terapéutico',1),
		   (4,'Intervención Quirúrgica Electiva',1)

