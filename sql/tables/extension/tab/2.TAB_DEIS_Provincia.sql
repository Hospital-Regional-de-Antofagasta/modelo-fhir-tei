/****** Object:  Table [dbo].[TAB_DEIS_Provincia]   Script Date: 06-11-2024 15:09:23 ******/
SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON

CREATE TABLE [dbo].[TAB_DEIS_Provincia](
	[Id] SMALLINT CONSTRAINT PK_DEIS_PROVINCIA PRIMARY KEY NOT NULL,
	[Codigo] [VARCHAR](10) NOT NULL UNIQUE,
	[Texto] [VARCHAR](100) NOT NULL,
	[IdRegion] [TINYINT] CONSTRAINT FK_DEIS_PROVINCIA_REGION FOREIGN KEY REFERENCES [dbo].[TAB_DEIS_Region]([Id]) NOT NULL,
	[Vigencia] BIT NOT NULL DEFAULT 1,
	[CreatedBy] [VARCHAR](10) CONSTRAINT FK_DEIS_PROVINCIA_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
) ON [PRIMARY]

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código DEIS de la provincia.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_Provincia', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre de la provincia.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_Provincia', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'IdRegion', @value=N'Id de la región a la que pertenece la provincia.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_Provincia', @level2type=N'COLUMN',@level2name=N'IdRegion'

EXEC sys.sp_addextendedproperty @name=N'TAB_DEIS_Provincia', @value=N'Esta tabla almacena las provincias de Chile.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_Provincia'

INSERT INTO [dbo].[TAB_DEIS_Provincia]
	([Id], [Codigo], [Texto], [IdRegion])
VALUES
	(1, '011', 'Iquique', 1),
	(2, '014', 'Tamarugal', 1),
	(3, '021', 'Antofagasta', 2),
	(4, '022', 'El Loa', 2),
	(5, '023', 'Tocopilla', 2),
	(6, '031', 'Copiapó', 3),
	(7, '032', 'Chañaral', 3),
	(8, '033', 'Huasco', 3),
	(9, '041', 'Elqui', 4),
	(10, '042', 'Choapa', 4),
	(11, '043', 'Limarí', 4),
	(12, '051', 'Valparaíso', 5),
	(13, '052', 'Isla De Pascua', 5),
	(14, '053', 'Los Andes', 5),
	(15, '054', 'Petorca', 5),
	(16, '055', 'Quillota', 5),
	(17, '056', 'San Antonio', 5),
	(18, '057', 'San Felipe De Aconcagua', 5),
	(19, '058', 'Marga Marga', 5),
	(20, '061', 'Cachapoal', 6),
	(21, '062', 'Cardenal Caro', 6),
	(22, '063', 'Colchagua', 6),
	(23, '071', 'Talca', 7),
	(24, '072', 'Cauquenes', 7),
	(25, '073', 'Curicó', 7),
	(26, '074', 'Linares', 7),
	(27, '081', 'Concepción', 8),
	(28, '082', 'Arauco', 8),
	(29, '083', 'Biobío', 8),
	(30, '091', 'Cautín', 9),
	(31, '092', 'Malleco', 9),
	(32, '101', 'Llanquihue', 10),
	(33, '102', 'Chiloé', 10),
	(34, '103', 'Osorno', 10),
	(35, '104', 'Palena', 10),
	(36, '111', 'Coihaique', 11),
	(37, '112', 'Capitán Prat', 11),
	(38, '113', 'Aisén', 11),
	(39, '114', 'General Carrera', 11),
	(40, '121', 'Magallanes', 12),
	(41, '122', 'Antártica Chilena', 12),
	(42, '123', 'Tierra del Fuego', 12),
	(43, '124', 'Ultima Esperanza', 12),
	(44, '131', 'Santiago', 13),
	(45, '132', 'Cordillera', 13),
	(46, '133', 'Chacabuco', 13),
	(47, '134', 'Maipo', 13),
	(48, '135', 'Melipilla', 13),
	(49, '136', 'Talagante', 13),
	(50, '141', 'Valdivia', 14),
	(51, '142', 'Ranco', 14),
	(52, '151', 'Arica', 15),
	(53, '152', 'Parinacota', 15),
	(54, '161', 'Diguillín', 16),
	(55, '162', 'Itata', 16),
	(56, '163', 'Punilla', 16),
	(57, '999', 'Desconocida', 17);