/* 78 */
CREATE TABLE [dbo].[ListaEspera_TAB_JerarquiaSalud](
	[Id] BIGINT IDENTITY(1,1) CONSTRAINT PK_LE_JERARQUIASALUD PRIMARY KEY NOT NULL,
	[IdTipoJerarquiaSalud] [BIGINT] CONSTRAINT FK_LE_JERARQUIASALUD_TIPO FOREIGN KEY REFERENCES [dbo].[ListaEspera_TAB_TipoJerarquiaSalud]([Id]) NOT NULL DEFAULT SUSER_NAME(),
	[Codigo] INT NOT NULL,
	[Texto] [VARCHAR](100) NOT NULL,
	[Vigencia] BIT NOT NULL DEFAULT 1,
	[CreatedBy] [VARCHAR](10) CONSTRAINT FK_LE_JERARQUIASALUD_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);

EXEC sys.sp_addextendedproperty @name=N'IdTipoJerarquiaSalud', @value=N'Id del tipo de jereraquía, determina si es un servicio de salud o SEREMI.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_JerarquiaSalud', @level2type=N'COLUMN',@level2name=N'IdTipoJerarquiaSalud'

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código DEIS del servicio de salud o SEREMI.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_JerarquiaSalud', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre del servicio de salud o SEREMI.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_JerarquiaSalud', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'ListaEspera_TAB_JerarquiaSalud', @value=N'Esta tabla almacena las jerarquías de salud que están a cargo de establecimientos de salud.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_JerarquiaSalud'


INSERT INTO [dbo].[ListaEspera_TAB_JerarquiaSalud]
           ([Codigo]
		   ,[Texto]
           ,[IdTipoJerarquiaSalud])
     VALUES
		--Servicio de Salud
        (1,'Servicio de Salud Arica',1)
		,(2,'Servicio de Salud Iquique',1)
		,(3,'Servicio de Salud Antofagasta',1)
		,(4,'Servicio de Salud Atacama',1)
		,(5,'Servicio de Salud Coquimbo',1)
		,(6,'Servicio de Salud Valparaíso San Antonio',1)
		,(7,'Servicio de Salud Viña del Mar Quillota',1)
		,(8,'Servicio de Salud Aconcagua',1)
		,(9,'Servicio de Salud Metropolitana Norte',1)
		,(10,'Servicio de Salud Metropolitana Occidente',1)
		,(11,'Servicio de Salud Metropolitana Central',1)
		,(12,'Servicio de Salud Metropolitana Oriente',1)
		,(13,'Servicio de Salud Metropolitana Sur',1)
		,(14,'Servicio de Salud Metropolitana Sur Oriente',1)
		,(15,'Servicio de Salud Del Libertador B. O''Higgins',1)
		,(16,'Servicio de Salud Del Maule',1)
		,(17,'Servicio de Salud Ñuble',1)
		,(18,'Servicio de Salud Concepción',1)
		,(19,'Servicio de Salud Talcahuano',1)
		,(20,'Servicio de Salud Biobío',1)
		,(21,'Servicio de Salud Araucanía Sur',1)
		,(22,'Servicio de Salud Valdivia',1)
		,(23,'Servicio de Salud Osorno',1)
		,(24,'Servicio de Salud Del Reloncaví',1)
		,(25,'Servicio de Salud Aisén',1)
		,(26,'Servicio de Salud Magallanes',1)
		,(28,'Servicio de Salud Arauco',1)
		,(29,'Servicio de Salud Araucanía Norte',1)
		,(33,'Servicio de Salud Chiloé',1)
		,(95,'No Aplica/Hospital Digital',1)
		--SEREMIS
		,(15,'SEREMI De Arica y Parinacota',2)
		,(1,'SEREMI De Tarapacá',2)
		,(2,'SEREMI De Antofagasta',2)
		,(3,'SEREMI De Atacama',2)
		,(4,'SEREMI De Coquimbo',2)
		,(5,'SEREMI De Valparaíso',2)
		,(13,'SEREMI Metropolitana de Santiago',2)
		,(6,'SEREMI Del Libertador Gral. B. O''Higgins',2)
		,(7,'SEREMI Del Maule',2)
		,(16,'SEREMI Del Ñuble',2)
		,(8,'SEREMI Del Biobío',2)
		,(9,'SEREMI De La Araucanía',2)
		,(14,'SEREMI De Los Ríos',2)
		,(10,'SEREMI De Los Lagos',2)
		,(11,'SEREMI De Aisén del General Carlos Ibáñez del Campo',2)
		,(12,'SEREMI De Magallanes y la Antártica Chilena',2)


