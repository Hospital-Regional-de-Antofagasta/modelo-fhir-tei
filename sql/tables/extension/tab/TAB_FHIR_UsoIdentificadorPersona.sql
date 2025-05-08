SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON

DROP TABLE IF EXISTS [dbo].[TAB_FHIR_UsoIdentificadorPersona];

CREATE TABLE [dbo].[TAB_FHIR_UsoIdentificadorPersona] (
    Id TINYINT CONSTRAINT PK_FHIR_USOIDENTIFICADORPERSONA PRIMARY KEY (Id),
    Codigo VARCHAR(10) NOT NULL UNIQUE,
    Texto VARCHAR(50) NOT NULL,
    Vigencia BIT NOT NULL DEFAULT 1,
    [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
);

INSERT INTO [dbo].[TAB_FHIR_UsoIdentificadorPersona] ([Id], [Codigo], [Texto]) VALUES
    (1, 'usual', 'Usual'),
    (2, 'official', 'Oficial'),
    (3, 'temp', 'Temporal'),
    (4, 'secondary', 'Secundario'),
    (5, 'old', 'Antiguo');