SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON

IF OBJECT_ID(N'dbo.TAB_FHIR_UsoMedioContacto', N'U') IS NULL BEGIN  
  CREATE TABLE [dbo].[TAB_FHIR_UsoMedioContacto] (
    Codigo VARCHAR(10) CONSTRAINT PK_USOMEDIOCONTACTO PRIMARY KEY,
    Texto VARCHAR(50) NOT NULL,
    Vigencia BIT NOT NULL DEFAULT 1,
    [CreatedBy] [VARCHAR](10) CONSTRAINT FK_USOMEDIOCONTACTO_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
	  [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
  );

  INSERT INTO [dbo].[TAB_FHIR_UsoMedioContacto] ([Codigo], [Texto]) VALUES
    ('home', 'Casa'),
    ('work', 'Trabajo'),
    ('temp', 'Temporal'),
    ('old', 'Antiguo'),
    ('mobile', 'Móvil');
END