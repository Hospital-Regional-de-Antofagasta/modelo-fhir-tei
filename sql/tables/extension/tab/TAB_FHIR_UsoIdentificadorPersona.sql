SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON

IF OBJECT_ID(N'dbo.TAB_FHIR_UsoIdentificadorPersona', N'U') IS NULL BEGIN  
    CREATE TABLE [dbo].[TAB_FHIR_UsoIdentificadorPersona] (
        Id TINYINT CONSTRAINT PK_FHIR_USOIDENTIFICADORPERSONA PRIMARY KEY,
        Codigo VARCHAR(10) NOT NULL UNIQUE,
        Texto VARCHAR(50) NOT NULL,
        Vigencia BIT NOT NULL DEFAULT 1,
        [CreatedBy] [VARCHAR](10) CONSTRAINT FK_FHIR_USOIDENTIFICADORPERSONA_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
        [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
    );

    INSERT INTO [dbo].[TAB_FHIR_UsoIdentificadorPersona] ([Id], [Codigo], [Texto]) VALUES
        (1, 'usual', 'Usual'),
        (2, 'official', 'Oficial'),
        (3, 'temp', 'Temporal'),
        (4, 'secondary', 'Secundario'),
        (5, 'old', 'Antiguo');
END