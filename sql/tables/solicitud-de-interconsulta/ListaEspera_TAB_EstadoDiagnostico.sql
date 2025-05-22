/* 80 */
CREATE TABLE [dbo].[ListaEspera_TAB_EstadoDiagnostico](
	[Id] BIGINT IDENTITY(1,1) CONSTRAINT PK_ESTADODIAGNOSTICO PRIMARY KEY NOT NULL,
	[Codigo] INT NOT NULL,
	[Texto] [VARCHAR](100) NOT NULL,
	[Vigencia] BIT NOT NULL DEFAULT 1,
	[CreatedBy] [VARCHAR](10) CONSTRAINT FK_ESTADODIAGNOSTICO_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
	[CodigoFHIR] VARCHAR(20) NULL
);

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código del estado del diagnóstico.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_EstadoDiagnostico', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre del estado del diagnóstico.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_EstadoDiagnostico', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'ListaEspera_TAB_EstadoDiagnostico', @value=N'Esta tabla almacena los tipos de diagnóstico.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_EstadoDiagnostico'


INSERT INTO [dbo].[ListaEspera_TAB_EstadoDiagnostico]
           ([Codigo]
		   ,[Texto]
           ,[CodigoFHIR])
     VALUES
('1', 'Presuntivo (hipótesis diagnóstica)', 'provisional'),
('2', 'Confirmado', 'confirmed'),
('10', 'No confirmado', 'unconfirmed'),
('11', 'Diferencial', 'differential'),
('12', 'Refutado', 'refuted'),
('13', 'Ingresado por error', 'entered-in-error')