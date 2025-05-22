/* 75 */
CREATE TABLE [dbo].[ListaEspera_TAB_Establecimiento](
	[Id] BIGINT IDENTITY(1,1) CONSTRAINT PK_LE_ESTABLECIMIENTO PRIMARY KEY NOT NULL,
	[IdComuna] [SMALLINT] CONSTRAINT FK_LE_ESTABLECIMIENTO_COMUNA FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_Comuna]([Id]) NOT NULL,
	[IdDependenciaJerarquica] [BIGINT] CONSTRAINT FK_LE_ESTABLECIMIENTO_JERARQUIASALUD FOREIGN KEY REFERENCES [dbo].[ListaEspera_TAB_JerarquiaSalud]([Id]) NOT NULL,
	[TipoEstablecimiento] VARCHAR(250) NULL,
	[Codigo] VARCHAR(10) NOT NULL,
	[Texto] [VARCHAR](200) NOT NULL,
	[Via] [VARCHAR](100) NULL,
	[Direccion] [VARCHAR](150) NULL,
	[Numero] [VARCHAR](20) NULL,
	[Vigencia] BIT NOT NULL DEFAULT 1,
	[CreatedBy] [VARCHAR](10) CONSTRAINT FK_LE_ESTABLECIMIENTO_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código DEIS del establecimiento de salud.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_Establecimiento', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre Oficial del establecimiento de salud.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_Establecimiento', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'IdComuna', @value=N'Id de la comuna en la que está el establecimiento de salud.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_Establecimiento', @level2type=N'COLUMN',@level2name=N'IdComuna'

EXEC sys.sp_addextendedproperty @name=N'Via', @value=N'Tipo de vía en la que se ubica el establecimiento de salud.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_Establecimiento', @level2type=N'COLUMN',@level2name=N'Via'

EXEC sys.sp_addextendedproperty @name=N'Direccion', @value=N'Nombre Oficial del establecimiento de salud.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_Establecimiento', @level2type=N'COLUMN',@level2name=N'Direccion'

EXEC sys.sp_addextendedproperty @name=N'Numero', @value=N'Nombre Oficial del establecimiento de salud.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_Establecimiento', @level2type=N'COLUMN',@level2name=N'Numero'

EXEC sys.sp_addextendedproperty @name=N'ListaEspera_TAB_Establecimiento', @value=N'Esta tabla almacena los servicios de salud a los cuales pueden pertenecer las interconsultas de lista de espera.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_Establecimiento'


INSERT INTO [dbo].[ListaEspera_TAB_Establecimiento]
        ([IdComuna]
		,[IdDependenciaJerarquica]
		,[TipoEstablecimiento]
		,[Codigo]
		,[Texto]
		,[Via]
		,[Direccion]
		,[Numero])
     VALUES
        ((SELECT TOP (1) [Id] FROM [dbo].[TAB_DEIS_Comuna] WHERE [CodigoFHIR] = '02101'),(SELECT TOP (1) [Id] FROM [dbo].[ListaEspera_TAB_JerarquiaSalud] WHERE [Codigo] = '2' AND [IdTipoJerarquiaSalud] = 2),'Clínica Dental','200524','Centro Odontológico Uno Salud Dental Antofagasta','Avenida','Manuel Antonio Matta, Local 2','2001-2013')
		,((SELECT TOP (1) [Id] FROM [dbo].[TAB_DEIS_Comuna] WHERE [CodigoFHIR] = '02101'),(SELECT TOP (1) [Id] FROM [dbo].[ListaEspera_TAB_JerarquiaSalud] WHERE [Codigo] = '2' AND [IdTipoJerarquiaSalud] = 2),'Clínica Dental','200644','Centro Odontológico Uno Salud Dental Antofagasta 2','Calle','Almirante Juan José Latorre , Piso 2','2318')
		,((SELECT TOP (1) [Id] FROM [dbo].[TAB_DEIS_Comuna] WHERE [CodigoFHIR] = '02201'),(SELECT TOP (1) [Id] FROM [dbo].[ListaEspera_TAB_JerarquiaSalud] WHERE [Codigo] = '2' AND [IdTipoJerarquiaSalud] = 2),'Clínica Dental','200791','Centro Odontológico Uno Salud Dental Calama','Calle','Eleuterio Ramírez','1961')
		,((SELECT TOP (1) [Id] FROM [dbo].[TAB_DEIS_Comuna] WHERE [CodigoFHIR] = '02101'),(SELECT TOP (1) [Id] FROM [dbo].[ListaEspera_TAB_JerarquiaSalud] WHERE [Codigo] = '2' AND [IdTipoJerarquiaSalud] = 2),'Clínica','103203','Clínica Antofagasta','Calle','Matta','1945')
		,((SELECT TOP (1) [Id] FROM [dbo].[TAB_DEIS_Comuna] WHERE [CodigoFHIR] = '02101'),(SELECT TOP (1) [Id] FROM [dbo].[ListaEspera_TAB_JerarquiaSalud] WHERE [Codigo] = '2' AND [IdTipoJerarquiaSalud] = 2),'Centro de Salud Privado','200245','Instituto Teletón Antofagasta','Avenida','Angamos','0475')
		,((SELECT TOP (1) [Id] FROM [dbo].[TAB_DEIS_Comuna] WHERE [CodigoFHIR] = '02101'),(SELECT TOP (1) [Id] FROM [dbo].[ListaEspera_TAB_JerarquiaSalud] WHERE [Codigo] = '2' AND [IdTipoJerarquiaSalud] = 2),'Clínica','103215','Clínica Oriente','Calle','Talca','861')
		,((SELECT TOP (1) [Id] FROM [dbo].[TAB_DEIS_Comuna] WHERE [CodigoFHIR] = '02101'),(SELECT TOP (1) [Id] FROM [dbo].[ListaEspera_TAB_JerarquiaSalud] WHERE [Codigo] = '2' AND [IdTipoJerarquiaSalud] = 2),'Hospital','103210','Hospital Militar del Norte','Avenida','Borgoño','957')
		,((SELECT TOP (1) [Id] FROM [dbo].[TAB_DEIS_Comuna] WHERE [CodigoFHIR] = '02101'),(SELECT TOP (1) [Id] FROM [dbo].[ListaEspera_TAB_JerarquiaSalud] WHERE [Codigo] = '2' AND [IdTipoJerarquiaSalud] = 2),'Centro de Salud Privado','103244','Policlínico del Trabajador AChS Antofagasta','Avenida','Grecia','840')
		,((SELECT TOP (1) [Id] FROM [dbo].[TAB_DEIS_Comuna] WHERE [CodigoFHIR] = '02101'),(SELECT TOP (1) [Id] FROM [dbo].[ListaEspera_TAB_JerarquiaSalud] WHERE [Codigo] = '2' AND [IdTipoJerarquiaSalud] = 2),'Laboratorio Clínico','201048','LABORATORIO CAZE Salud','Calle','Díaz Gana 1090','1090')
		,((SELECT TOP (1) [Id] FROM [dbo].[TAB_DEIS_Comuna] WHERE [CodigoFHIR] = '02101'),(SELECT TOP (1) [Id] FROM [dbo].[ListaEspera_TAB_JerarquiaSalud] WHERE [Codigo] = '2' AND [IdTipoJerarquiaSalud] = 2),'Laboratorio Clínico','200528','Laboratorio Clínico Angamos','Calle','Manuel Verbal, Piso 4','1201')
		,((SELECT TOP (1) [Id] FROM [dbo].[TAB_DEIS_Comuna] WHERE [CodigoFHIR] = '02101'),(SELECT TOP (1) [Id] FROM [dbo].[ListaEspera_TAB_JerarquiaSalud] WHERE [Codigo] = '2' AND [IdTipoJerarquiaSalud] = 2),'Laboratorio Clínico','200254','Laboratorio Clínico Kausay','Avenida','Bernardo O''Higgins, Oficina 1202','1338')
		,((SELECT TOP (1) [Id] FROM [dbo].[TAB_DEIS_Comuna] WHERE [CodigoFHIR] = '02101'),(SELECT TOP (1) [Id] FROM [dbo].[ListaEspera_TAB_JerarquiaSalud] WHERE [Codigo] = '2' AND [IdTipoJerarquiaSalud] = 2),'Laboratorio Clínico','201096','Natural CELL','Calle','Eduardo Orchard 1351','1351')