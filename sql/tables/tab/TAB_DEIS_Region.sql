/* 100 */
CREATE TABLE [dbo].[TAB_DEIS_Region]
(
    [Id] TINYINT CONSTRAINT PK_DEIS_REGION PRIMARY KEY (Id),
    [Codigo] [VARCHAR](10) NOT NULL UNIQUE,
    [Texto] [VARCHAR](100) NOT NULL,
    [Vigencia] BIT NOT NULL DEFAULT 1,
    [CodigoFHIR] VARCHAR(10) NULL,
    [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);

ALTER TABLE [dbo].[TAB_DEIS_Region] ADD
CONSTRAINT FK_DEIS_REGION_USUARIO FOREIGN KEY (CreatedBy) REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]);


INSERT INTO [dbo].[TAB_DEIS_Region]
    ([Id], [Codigo], [CodigoFHIR], [Texto])
VALUES
    (1, '01', '01', 'Tarapacá'),
    (2, '02', '02', 'Antofagasta'),
    (3, '03', '03', 'Atacama'),
    (4, '04', '04', 'Coquimbo'),
    (5, '05', '05', 'Valparaíso'),
    (6, '06', '06', 'Libertador General Bernardo O''Higgins'),
    (7, '07', '07', 'Maule'),
    (8, '08', '08', 'Biobío'),
    (9, '09', '09', 'La Araucanía'),
    (10, '10', '10', 'Los Lagos'),
    (11, '11', '11', 'Aysén del General Carlos Ibáñez del Campo'),
    (12, '12', '12', 'Magallanes y de la Antártica Chilena'),
    (13, '13', '13', 'Metropolitana de Santiago'),
    (14, '14', '14', 'Los Ríos'),
    (15, '15', '15', 'Arica y Parinacota'),
    (16, '16', '16', 'Ñuble'),
    (17, '99', NULL, 'Desconocido');

