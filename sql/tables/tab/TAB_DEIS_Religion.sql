SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON


CREATE TABLE [dbo].[TAB_DEIS_Religion](
    [Id] [TINYINT] CONSTRAINT PK_DEIS_RELIGION PRIMARY KEY (Id),
    [Codigo] [VARCHAR](10) NOT NULL UNIQUE,
    [Texto] [VARCHAR](50) NOT NULL,
    [Vigencia] BIT NOT NULL DEFAULT 1,
    [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código DEIS de la religion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_Religion', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre de la religion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_Religion', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'TAB_DEIS_Religion', @value=N'Sistema compuesto por creencias y prácticas acerca de lo considerado como divino o sagrado, tanto personales como colectivas de tipo existencial y espiritual.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_Religion'

INSERT INTO [dbo].[TAB_DEIS_Religion] ([Id], [Codigo], [Texto])
VALUES
    (1, '1', 'Católica'),
    (2, '2', 'Evangelélica'),
    (3, '3', 'Testigo de Jehová'),
    (4, '4', 'Judaica'),
    (5, '5', 'Mormón'),
    (6, '6', 'Musulmana'),
    (7, '7', 'Ortodoxa'),
    (8, '8', 'Otra religión o credo'),
    (9, '9', 'Ninguna, ateo, agnóstico'),
    (10, '99', 'Desconocido');