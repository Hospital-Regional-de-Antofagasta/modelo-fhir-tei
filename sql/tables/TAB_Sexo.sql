
/****** Object:  Table [dbo].[TAB_Sexo]    Script Date: 05-05-2025 13:30:57 ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF OBJECT_ID(N'dbo.TAB_Sexo', N'U') IS NULL BEGIN
  CREATE TABLE [dbo].[TAB_Sexo](
    [TAB_Codigo] [varchar](1) NOT NULL,
    [TAB_Text] [varchar](20) NOT NULL,
    [TAB_Nro] [int] NULL,
    [TAB_Vigencia] [varchar](1) NULL,
    [CodDeis] [int] NULL
  ) ON [PRIMARY]


  INSERT INTO [dbo].[TAB_Sexo] ([TAB_Codigo], [TAB_Text], [TAB_Nro], [TAB_Vigencia], [CodDeis]) VALUES 
  ('A', 'AMBOS', NULL, 'N', NULL),
  ('B', 'AMBIGUO', NULL, 'N', NULL),
  ('D', 'DESCONOCIDO', 9, 'S', 99),
  ('E', 'INTERSEXUAL', 3, 'S', 3),
  ('F', 'MUJER', 2, 'S', 2),
  ('I', 'INDIFERENC', NULL, 'N', NULL),
  ('M', 'HOMBRE', 1, 'S', 1),
  ('N', 'NO INFORMADO', NULL, 'S', 93);
END
GO

