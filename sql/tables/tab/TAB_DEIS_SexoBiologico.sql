/* 50 */
CREATE TABLE [dbo].[TAB_DEIS_SexoBiologico](
    [Id] [TINYINT] CONSTRAINT PK_DEIS_SEXOBIOLOGICO PRIMARY KEY (Id),
    [Codigo] [VARCHAR](10) NOT NULL UNIQUE,
    [Texto] [VARCHAR](15) NOT NULL,
    [Descripcion] [VARCHAR](200) NOT NULL,
    [Vigencia] BIT NOT NULL DEFAULT 1,
    CodigoFHIR VARCHAR(10),
    [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);
ALTER TABLE [dbo].[TAB_DEIS_SexoBiologico] ADD
CONSTRAINT FK_DEIS_SEXOBIOLOGICO_USUARIO FOREIGN KEY (CreatedBy) REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]);

INSERT INTO [dbo].[TAB_DEIS_SexoBiologico] ([Id], [Codigo], CodigoFHIR, [Texto], [Descripcion])
VALUES
    (1, '1', 'male', 'Hombre', 'Persona que al nacer se observa anatómicamente que tiene a nivel genital pene, escroto y/o testículos.'),
    (2, '2', 'female', 'Mujer', 'Persona que al nacerse se observa anatómicamente que tiene a nivel genital vulva u orificio vaginal.'),
    (3, '3', 'other', 'Intersexual', 'Persona que al nacer se observa variaciones anatómicas en los órganos genitales del cuerpo que no permite clasificar de forma dicotómica en hombre o mujer. No constituye un tercer sexo.'),
    (4, '93', NULL, 'No Informado', 'Corresponde a los casos en que el Registro Civil realiza el cambio del Sexo Registral. En estos casos, es obligatorio capturar la variable de identidad de género.'),
    (5, '99', 'unknown', 'Desconocido', 'No es posible determinarlo al momento de la antención de salud.');