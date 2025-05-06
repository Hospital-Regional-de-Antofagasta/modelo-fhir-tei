SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON

CREATE TABLE [dbo].[TAB_DEIS_EstadoCivil](
    [Id] [TINYINT] CONSTRAINT PK_DEIS_ESTADOCIVIL PRIMARY KEY,
    [Codigo] [VARCHAR](10) NOT NULL,
    [Texto] [VARCHAR](50) NOT NULL,
    [Vigencia] BIT NOT NULL DEFAULT 1,
    [CreatedBy] [VARCHAR](10) CONSTRAINT FK_DEIS_ESTADOCIVIL_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código DEIS del estado civil.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_EstadoCivil', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre del estado civil.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_EstadoCivil', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'TAB_DEIS_EstadoCivil', @value=N'El estado civil es la situación de un individuo en la sociedad, que deriva principalmente de sus relaciones de familia, y que lo habilita para ejercer derechos y contraer obligaciones civiles.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_DEIS_EstadoCivil'

INSERT INTO [dbo].[TAB_DEIS_EstadoCivil] ([Id], [Codigo], [Texto])
VALUES
    (1, '1', 'Soltero(a)'),
    (2, '2', 'Casado(a)'),
    (3, '3', 'Viudo(a)'),
    (4, '4', 'Divorciado(a)'),
    (5, '5', 'Separado(a) Judicialmente'),
    (6, '6', 'Conviviente Civil'),
    (7, '99', 'Desconocido');