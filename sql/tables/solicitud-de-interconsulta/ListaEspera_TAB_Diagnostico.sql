/* 80 */
CREATE TABLE [dbo].[ListaEspera_TAB_Diagnostico] (
	[Id] BIGINT IDENTITY(1,1) CONSTRAINT PK_LE_DIAGNOSTICO PRIMARY KEY ([Id]) NOT NULL,
	[IdTipoCodificacionDiagnostica] BIGINT CONSTRAINT FK_LE_DIAGNOSTICO_TIPOCODIFICACION FOREIGN KEY REFERENCES [dbo].[ListaEspera_TAB_TipoCodificacionDiagnostica]([Id]) NOT NULL,
	[Codigo] [VARCHAR](50) NOT NULL,
	[Texto] [VARCHAR](250) NOT NULL,
	[Vigencia] BIT NOT NULL DEFAULT 1,
	[CreatedBy] [VARCHAR](10) CONSTRAINT FK_LE_DIAGNOSTICO_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);

EXEC sys.sp_addextendedproperty @name=N'IdTipoCodificacionDiagnostica', @value=N'Identificador de la codificación diagnóstica del diagnóstico.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_Diagnostico', @level2type=N'COLUMN',@level2name=N'IdTipoCodificacionDiagnostica'

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código DEIS del diagnóstico.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_Diagnostico', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre del diagnóstico.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_Diagnostico', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'ListaEspera_TAB_Diagnostico', @value=N'Esta tabla almacena los diagnósticos que pueden tener las interconsultas de lista de espera.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_Diagnostico'


INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A00.X', 'CÓLERA', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A00.0', 'CÓLERA DEBIDO A VIBRIO CHOLERAE O1, BIOTIPO CHOLERAE', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A00.1', 'CÓLERA DEBIDO A VIBRIO CHOLERAE O1, BIOTIPO EL TOR', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A00.9', 'CÓLERA, NO ESPECIFICADO', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A01.X', 'FIEBRES TIFOIDEA Y PARATIFOIDEA', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A01.0', 'FIEBRE TIFOIDEA', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A01.1', 'FIEBRE PARATIFOIDEA A', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A01.2', 'FIEBRE PARATIFOIDEA B', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A01.3', 'FIEBRE PARATIFOIDEA C', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A01.4', 'FIEBRE PARATIFOIDEA, NO ESPECIFICADA', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A02.X', 'OTRAS INFECCIONES DEBIDAS A SALMONELLA', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A02.0', 'ENTERITIS DEBIDA A SALMONELLA', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A02.1', 'SEPSIS DEBIDA A SALMONELLA', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A02.2', 'INFECCIONES LOCALIZADAS DEBIDAS A SALMONELLA', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A02.8', 'OTRAS INFECCIONES ESPECIFICADAS COMO DEBIDAS A SALMONELLA', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A02.9', 'INFECCIÓN DEBIDA A SALMONELLA, NO ESPECIFICADA', 1, SUSER_NAME(), '03/31/2025 11:41:42 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A03.X', 'SHIGELOSIS', 1, SUSER_NAME(), '03/31/2025 11:41:43 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A03.0', 'SHIGELOSIS DEBIDA A SHIGELLA DYSENTERIAE', 1, SUSER_NAME(), '03/31/2025 11:41:43 AM' ) 
INSERT INTO [dbo].[ListaEspera_TAB_Diagnostico] ( IdTipoCodificacionDiagnostica, Codigo, Texto, Vigencia, CreatedBy, CreatedAt)
		 VALUES ( 1, 'A03.1', 'SHIGELOSIS DEBIDA A SHIGELLA FLEXNERI', 1, SUSER_NAME(), '03/31/2025 11:41:43 AM' );