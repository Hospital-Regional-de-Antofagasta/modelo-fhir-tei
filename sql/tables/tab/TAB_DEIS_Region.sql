/****** Object:  Table [dbo].[TAB_DEIS_Region]   Script Date: 06-11-2024 15:09:23 ******/
SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON


CREATE TABLE [dbo].[TAB_DEIS_Region]
(
    [Id] TINYINT CONSTRAINT PK_DEIS_REGION PRIMARY KEY (Id),
    [Codigo] [VARCHAR](10) NOT NULL UNIQUE,
    [Texto] [VARCHAR](100) NOT NULL,
    [Vigencia] BIT NOT NULL DEFAULT 1,
    [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
) ON [PRIMARY]

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código DEIS de la región.', @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_Region', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre de la región.', @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_Region', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'TAB_DEIS_Region', @value=N'Esta tabla almacena las regiones de Chile.', @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_Region'

INSERT INTO [dbo].[TAB_DEIS_Region]
    ([Id], [Codigo], [Texto])
VALUES
    (1, '01', 'Tarapacá'),
    (2, '02', 'Antofagasta'),
    (3, '03', 'Atacama'),
    (4, '04', 'Coquimbo'),
    (5, '05', 'Valparaíso'),
    (6, '06', 'Libertador General Bernardo O''Higgins'),
    (7, '07', 'Maule'),
    (8, '08', 'Biobío'),
    (9, '09', 'La Araucanía'),
    (10, '10', 'Los Lagos'),
    (11, '11', 'Aysén del General Carlos Ibáñez del Campo'),
    (12, '12', 'Magallanes y de la Antártica Chilena'),
    (13, '13', 'Metropolitana de Santiago'),
    (14, '14', 'Los Ríos'),
    (15, '15', 'Arica y Parinacota'),
    (16, '16', 'Ñuble'),
    (17, '99', 'Desconocido');

