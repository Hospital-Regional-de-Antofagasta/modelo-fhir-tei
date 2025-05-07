SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON

DROP TABLE IF EXISTS [dbo].[TAB_DEIS_PuebloOriginario];

CREATE TABLE [dbo].[TAB_DEIS_PuebloOriginario](
    [Id] [TINYINT] CONSTRAINT PK_DEIS_PUEBLOORIGINARIO PRIMARY KEY,
    [Codigo] [VARCHAR](10) NOT NULL UNIQUE,
    [Texto] [VARCHAR](50) NOT NULL,
    [Vigencia] BIT NOT NULL DEFAULT 1,
    [CreatedBy] [VARCHAR](10) CONSTRAINT FK_DEIS_PUEBLOORIGINARIO_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código DEIS del pueblo originario.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_PuebloOriginario', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre del pueblo originario.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_PuebloOriginario', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'TAB_DEIS_PuebloOriginario', @value=N'Son los descendientes de las agrupaciones humanas que existen en el territorio nacional desde tiempos precolombinos, que conservan manifestaciones étnicas y culturales propias o parte de ellas, siendo para ellos la tierra el fundamento principal de su existencia y cultura.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_PuebloOriginario'

INSERT INTO [dbo].[TAB_DEIS_PuebloOriginario] ([Id], [Codigo], [Texto])
VALUES
    (1, '1', 'Mapuche'),
    (2, '2', 'Aymara'),
    (3, '3', 'Rapa Nui o Pascuense'),
    (4, '4', 'Lickanantay'),
    (5, '5', 'Quechua'),
    (6, '6', 'Colla'),
    (7, '7', 'Diaguita'),
    (8, '8', 'Kawésqar'),
    (9, '9', 'Yagán'),
    (10, '11', 'Chango'),
    (11, '10', 'Otro');
    