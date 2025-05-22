/* 50 */
CREATE TABLE [dbo].[TAB_FHIR_UsoIdentificadorPersona] (
    Id TINYINT CONSTRAINT PK_FHIR_USOIDENTIFICADORPERSONA PRIMARY KEY (Id),
    Codigo VARCHAR(10) NOT NULL UNIQUE,
    Texto VARCHAR(50) NOT NULL,
    Vigencia BIT NOT NULL DEFAULT 1,
    [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
);

ALTER TABLE [dbo].[TAB_FHIR_UsoIdentificadorPersona] ADD
CONSTRAINT FK_FHIR_USOIDENTIFICADORPERSONA_USUARIO FOREIGN KEY(CreatedBy) REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]);

INSERT INTO [dbo].[TAB_FHIR_UsoIdentificadorPersona] ([Id], [Codigo], [Texto]) VALUES
    (1, 'usual', 'Común'),
    (2, 'official', 'Oficial'),
    (3, 'temp', 'Temporal'),
    (4, 'secondary', 'Secundario'),
    (5, 'old', 'Antiguo');