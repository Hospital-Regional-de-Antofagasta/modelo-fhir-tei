SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON


CREATE TABLE [dbo].[TAB_DEIS_SexoBiologico](
    [Id] [TINYINT] CONSTRAINT PK_DEIS_SEXOBIOLOGICO PRIMARY KEY (Id),
    [Codigo] [VARCHAR](10) NOT NULL UNIQUE,
    [Texto] [VARCHAR](15) NOT NULL,
    [Descripcion] [VARCHAR](200) NOT NULL,
    [Vigencia] BIT NOT NULL DEFAULT 1,
    [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código DEIS del sexo biológico.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_SexoBiologico', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre del sexo biológico.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_SexoBiologico', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'TAB_DEIS_SexoBiologico', @value=N'El sexo es la determinación hecha a través de la aplicación de criterios biológicos para clasificar a las personas como hombres o mujeres al momento de nacer.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_SexoBiologico'

INSERT INTO [dbo].[TAB_DEIS_SexoBiologico] ([Id], [Codigo], [Texto], [Descripcion])
VALUES
    (1, '1', 'Hombre', 'Persona que al nacer se observa anatómicamente que tiene a nivel genital pene, escroto y/o testículos.'),
    (2, '2', 'Mujer', 'Persona que al nacerse se observa anatómicamente que tiene a nivel genital vulva u orificio vaginal.'),
    (3, '3', 'Intersexual', 'Persona que al nacer se observa variaciones anatómicas en los órganos genitales del cuerpo que no permite clasificar de forma dicotómica en hombre o mujer. No constituye un tercer sexo.'),
    (4, '93', 'No Informado', 'Corresponde a los casos en que el Registro Civil realiza el cambio del Sexo Registral. En estos casos, es obligatorio capturar la variable de identidad de género.'),
    (5, '99', 'Desconocido', 'No es posible determinarlo al momento de la antención de salud.');