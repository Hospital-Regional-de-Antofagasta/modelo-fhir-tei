/* 50 */
CREATE TABLE [dbo].[TAB_DEIS_Religion](
    [Id] [TINYINT] CONSTRAINT PK_DEIS_RELIGION PRIMARY KEY (Id),
    [Codigo] [VARCHAR](10) NOT NULL UNIQUE,
    [Texto] [VARCHAR](50) NOT NULL,
    [Vigencia] BIT NOT NULL DEFAULT 1,
    [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);

ALTER TABLE [dbo].[TAB_DEIS_Religion] ADD
CONSTRAINT FK_DEIS_RELIGION_USUARIO FOREIGN KEY (CreatedBy) REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]);


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