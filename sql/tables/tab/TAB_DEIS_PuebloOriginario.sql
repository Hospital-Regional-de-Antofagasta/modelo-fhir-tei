/* 50 */
CREATE TABLE [dbo].[TAB_DEIS_PuebloOriginario](
    [Id] [TINYINT] CONSTRAINT PK_DEIS_PUEBLOORIGINARIO PRIMARY KEY (Id),
    [Codigo] [VARCHAR](10) NOT NULL UNIQUE,
    [Texto] [VARCHAR](50) NOT NULL,
    [Vigencia] BIT NOT NULL DEFAULT 1,
    CodigoFHIR VARCHAR(10),
    [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);

ALTER TABLE [dbo].[TAB_DEIS_PuebloOriginario] ADD
CONSTRAINT FK_DEIS_PUEBLOORIGINARIO_USUARIO FOREIGN KEY (CreatedBy) REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]);

INSERT INTO [dbo].[TAB_DEIS_PuebloOriginario] ([Id], [Codigo], CodigoFHIR, [Texto])
VALUES
    (1, '1', '1', 'Mapuche'),
    (2, '2', '2', 'Aymara'),
    (3, '3', '3', 'Rapa Nui o Pascuense'),
    (4, '4', '4', 'Lickanantay'),
    (5, '5', '5', 'Quechua'),
    (6, '6', '6', 'Colla'),
    (7, '7', '7', 'Diaguita'),
    (8, '8', '8', 'Kawésqar'),
    (9, '9', '9', 'Yagán'),
    (10, '11', '11', 'Chango'),
    (11, '10', '10', 'Otro');
    