/* 80 */
CREATE TABLE [dbo].[ListaEspera_TAB_TipoJerarquiaSalud](
	[Id] BIGINT IDENTITY(1,1) CONSTRAINT PK_LE_TIPOJERARQUIASALUD PRIMARY KEY NOT NULL,
	[Codigo] INT NOT NULL,
	[Texto] [VARCHAR](100) NOT NULL,
	[Vigencia] BIT NOT NULL DEFAULT 1,
	[CreatedBy] [VARCHAR](10) CONSTRAINT FK_LE_TIPOJERARQUIASALUD_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código del tipo de jerarquía de salud.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_TipoJerarquiaSalud', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre del tipo de jerarquía de salud.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_TipoJerarquiaSalud', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'ListaEspera_TAB_TipoJerarquiaSalud', @value=N'Esta tabla almacena los tipos de jerarquías de salud que están a cargo de establecimientos de salud.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_TipoJerarquiaSalud'

INSERT INTO [dbo].[ListaEspera_TAB_TipoJerarquiaSalud]
           ([Codigo]
		   ,[Texto]
           ,[Vigencia])
     VALUES
           (1,'Servicio de Salud',1),
		   (2,'SEREMI',1);

