SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON

IF OBJECT_ID(N'dbo.TAB_FHIR_UsoDomicilioPersona', N'U') IS NULL BEGIN  
    CREATE TABLE [dbo].[TAB_FHIR_UsoDomicilioPersona] (
        Id TINYINT CONSTRAINT PK_FHIR_USODOMICILIOPERSONA PRIMARY KEY,
        Codigo VARCHAR(10) NOT NULL UNIQUE,
        Texto VARCHAR(50) NOT NULL,
        Vigencia BIT NOT NULL DEFAULT 1,
        [CreatedBy] [VARCHAR](10) CONSTRAINT FK_FHIR_USODOMICILIOPERSONA_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
        [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
    );

    INSERT INTO [dbo].[TAB_FHIR_UsoDomicilioPersona] (Id, [Codigo], [Texto]) VALUES
        (1, 'home', 'Casa'),
        (2, 'work', 'Trabajo'),
        (3, 'temp', 'Temporal'),
        (4, 'old', 'Antiguo'),
        (5, 'billing', 'Facturación');
END