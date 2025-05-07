SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

DROP TABLE IF EXISTS [dbo].[SER_Profesiona];

CREATE TABLE [dbo].[SER_Profesiona](
    [SER_PRO_Rut] [varchar](10) NOT NULL,
    [SER_PRO_Tipo] [char](4) NOT NULL,
    [SER_PRO_ApellPater] [varchar](20) NOT NULL,
    [SER_PRO_ApellMater] [varchar](20) NOT NULL,
    [SER_PRO_Nombres] [varchar](40) NOT NULL,
    [SER_PRO_Estado] [char](4) NOT NULL,
    [SER_PRO_Procedencia] [varchar](10) NOT NULL,
    [SER_PRO_NomSocial] [varchar](40) NULL,
CONSTRAINT [PK_SER_PROFESIONA] PRIMARY KEY CLUSTERED 
(
    [SER_PRO_Rut] ASC,
    [SER_PRO_Tipo] ASC,
    [SER_PRO_Procedencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
