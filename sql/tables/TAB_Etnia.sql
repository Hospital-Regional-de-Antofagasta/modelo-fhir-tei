
SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON

IF OBJECT_ID(N'dbo.TAB_Etnia', N'U') IS NULL BEGIN
  CREATE TABLE [dbo].[TAB_Etnia](
    [TAB_Codigo] [char](4) NOT NULL,
    [TAB_Text] [varchar](30) NOT NULL,
    [TAB_Vigencia] [char](1) NULL,
  CONSTRAINT [PK_ETNIA] PRIMARY KEY CLUSTERED 
  (
    [TAB_Codigo] ASC
  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
  ) ON [PRIMARY]


  INSERT INTO [TAB_Etnia] ([TAB_Codigo], [TAB_Text], [TAB_Vigencia]) VALUES
  ('00', 'Ninguna de las Anteriores', 'N'),
  ('01', 'MAPUCHE', 'S'),
  ('02', 'AYMARA', 'S'),
  ('03', 'RAPA NUI (PASCUENSE)', 'S'),
  ('04', 'LICAN ANTAI (ATACAMEÑO)', 'S'),
  ('05', 'QUECHUA', 'S'),
  ('06', 'COLLA', 'S'),
  ('07', 'DIAGUITA', 'S'),
  ('08', 'KAWESQAR (Alacalufe)', 'S'),
  ('09', 'YAMANA(YAGAN)', 'S'),
  ('1', 'Alacalufe', 'N'),
  ('10', 'OTRO', 'S'),
  ('11', 'CHANGO', 'S'),
  ('12', 'SELK''NAM', 'S'),
  ('2', 'Atacameño', 'N'),
  ('3', 'Aimara', 'N'),
  ('4', 'Colla', 'N'),
  ('5', 'Diaguita', 'N'),
  ('6', 'Mapuche', 'N'),
  ('7', 'Quechua', 'N'),
  ('8', 'Rapa Nui', 'N'),
  ('9', 'Yamana(Yagan)', 'N'),
  ('96', 'NINGUNO', 'S'),
  ('A10', 'No Sabe (Hasta 2020)', 'N'),
  ('A11', 'No Responde (Hasta 2020)', 'N');
END