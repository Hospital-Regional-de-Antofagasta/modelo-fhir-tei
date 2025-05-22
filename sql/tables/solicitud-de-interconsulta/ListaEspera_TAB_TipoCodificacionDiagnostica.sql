/* 81 */
CREATE TABLE [dbo].[ListaEspera_TAB_TipoCodificacionDiagnostica](
	[Id] BIGINT IDENTITY(1,1) CONSTRAINT PK_LE_TIPOCODIFICACIONDIAGNOSTICA PRIMARY KEY NOT NULL,
	[Codigo] INT NOT NULL,
	[Texto] [VARCHAR](100) NOT NULL,
	[Vigencia] BIT NOT NULL DEFAULT 1,
	[CreatedBy] [VARCHAR](10) CONSTRAINT FK_LE_TIPOCODIFICACIONDIAGNOSTICA_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código del tipo de codificación diagnóstica.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_TipoCodificacionDiagnostica', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre de la codificación diagnóstica.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_TipoCodificacionDiagnostica', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'ListaEspera_TAB_TipoCodificacionDiagnostica', @value=N'Esta tabla almacena las diferentes codificaciones que pueden tener los diagnósticos de las interconsultas de lista de espera.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_TipoCodificacionDiagnostica'

INSERT INTO [dbo].[ListaEspera_TAB_TipoCodificacionDiagnostica]
           ([Codigo]
		   ,[Texto]
           ,[Vigencia])
     VALUES
		(0,'SIN CODIFICACIÓN',1),
        (1,'CIE10',1),
		(2,'CIE11',1),
		(3,'SNOMED-CT',1);