SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON

DROP TABLE IF EXISTS [dbo].[PAC_NombreSocial];

CREATE TABLE [dbo].[PAC_NombreSocial](
	[PAC_PAC_Numero] [real] NOT NULL,
	[PAC_PAC_NombreSocial] [varchar](100) NOT NULL
) ON [PRIMARY]