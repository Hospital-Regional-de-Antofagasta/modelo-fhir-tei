SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON

DROP TABLE IF EXISTS [dbo].[TAB_DEIS_IdentidadGenero];
CREATE TABLE [dbo].[TAB_DEIS_IdentidadGenero](
    [Id] [TINYINT] CONSTRAINT PK_DEIS_IDENTIDADGENERO PRIMARY KEY,
    [Codigo] [VARCHAR](10) NOT NULL UNIQUE,
    [Texto] [VARCHAR](25) NOT NULL,
    [Descripcion] [VARCHAR](200) NOT NULL,
    [Vigencia] BIT NOT NULL DEFAULT 1,
    [CreatedBy] [VARCHAR](10) CONSTRAINT FK_DEIS_IDENTIDADGENERO_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código DEIS de la identidad de género.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_IdentidadGenero', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre de la identidad de género.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_IdentidadGenero', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'TAB_DEIS_IdentidadGenero', @value=N'La definición de "identidad de género" es independiente del sexo biológico y su determinante es "la vivencia interna e individual del género tal como cada persona la siente profundamente". Esta definición se estableció en los Principios de Yogyakarta, que norman la aplicación de la legislación internacional de derechos humanos en relación a la orientación sexual y la identidad de género desde el año 2007.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_IdentidadGenero'

INSERT INTO [dbo].[TAB_DEIS_IdentidadGenero] ([Id], [Codigo], [Texto], [Descripcion])
VALUES
    (1, '1', 'Masculino', 'La persona de sexo "Hombre" asignado al nacer, que se identifica a si misma como de género masculino. También se le conoco como "cisgénero masculino".'),
    (2, '2', 'Femenina', 'La persona de sexo "Mujer" asignado al nacer, que se identifica a sí misma como de género femenino. También se le conoce como "cisgénero femenino".'),
    (3, '4', 'Transgénero Masculino', 'La persona de sexo "Mujer" asignado al nacer, que se identifica a si misma como de género masculino.'),
    (4, '5', 'Transgénero Femenina', 'La persona de sexo "Hombre" asignado al nacer, que se identifica a asi misma como de género femenino.'),
    (5, '6', 'No Binarie', 'La persona que no se identifica con ninguno de los géneros convencionales (femenino o masculino).'),
    (6, '7', 'Otra', 'Otra identidad de género no descrita previamente.'),
    (7, '8', 'No Revelado', 'La persona no desea revelar su identidad de género.');