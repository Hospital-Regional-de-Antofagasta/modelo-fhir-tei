/* 50 */
CREATE TABLE [dbo].[TAB_DEIS_EstadoCivil](
    [Id] [TINYINT] CONSTRAINT PK_DEIS_ESTADOCIVIL PRIMARY KEY (Id),
    [Codigo] [VARCHAR](10) NOT NULL UNIQUE,
    [Texto] [VARCHAR](50) NOT NULL,
    [Vigencia] BIT NOT NULL DEFAULT 1,
    [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);

ALTER TABLE [dbo].[TAB_DEIS_EstadoCivil] ADD
CONSTRAINT FK_DEIS_ESTADOCIVIL_USUARIO FOREIGN KEY (CreatedBy) REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]);


INSERT INTO [dbo].[TAB_DEIS_EstadoCivil] ([Id], [Codigo], [Texto])
VALUES
    (1, '1', 'Soltero(a)'),
    (2, '2', 'Casado(a)'),
    (3, '3', 'Viudo(a)'),
    (4, '4', 'Divorciado(a)'),
    (5, '5', 'Separado(a) Judicialmente'),
    (6, '6', 'Conviviente Civil'),
    (7, '99', 'Desconocido');
