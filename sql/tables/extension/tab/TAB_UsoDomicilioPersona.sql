SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON

IF OBJECT_ID(N'dbo.TAB_UsoDomicilioPersona', N'U') IS NULL BEGIN  
    CREATE TABLE [dbo].[TAB_UsoDomicilioPersona] (
        Codigo VARCHAR(10) CONSTRAINT PK_USODOMICILIOPERSONA PRIMARY KEY,
        Texto VARCHAR(50) NOT NULL,
        Vigencia BIT NOT NULL DEFAULT 1,
        [CreatedBy] [VARCHAR](10) CONSTRAINT FK_USODOMICILIOPERSONA_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
        [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
    );

    INSERT INTO [dbo].[TAB_UsoDomicilioPersona] ([Codigo], [Texto]) VALUES
        ('home', 'Casa'),
        ('work', 'Trabajo'),
        ('temp', 'Temporal'),
        ('old', 'Antiguo'),
        ('billing', 'Facturación');
END