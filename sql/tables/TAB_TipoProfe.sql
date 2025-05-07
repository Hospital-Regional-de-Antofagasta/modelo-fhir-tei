SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

DROP TABLE IF EXISTS [dbo].[TAB_TipoProfe];

CREATE TABLE [dbo].[TAB_TipoProfe](
    [TAB_Codigo] [char](4) NOT NULL,
    [TAB_Text] [varchar](30) NOT NULL,
    [TAB_Clasificacion] [varchar](3) NOT NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[TAB_TipoProfe] ADD  DEFAULT ('') FOR [TAB_Text]

ALTER TABLE [dbo].[TAB_TipoProfe] ADD  DEFAULT ('CIR') FOR [TAB_Clasificacion]