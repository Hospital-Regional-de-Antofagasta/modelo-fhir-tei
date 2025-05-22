/* 200 */
IF OBJECT_ID('dbo.SER_Profesiona', 'U') IS NULL BEGIN
	CREATE TABLE [dbo].[SER_Profesiona](
		[SER_PRO_Rut] [varchar](10) NOT NULL,
		[SER_PRO_Tipo] [char](4) NOT NULL,
		[SER_PRO_ApellPater] [varchar](20) NOT NULL,
		[SER_PRO_ApellMater] [varchar](20) NOT NULL,
		[SER_PRO_Nombres] [varchar](40) NOT NULL,
		[SER_PRO_Estado] [char](4) NOT NULL,
		[SER_PRO_Direccion] [varchar](40) NOT NULL,
		[SER_PRO_Telefono] [varchar](20) NOT NULL,
		[SER_PRO_Observacio] [varchar](40) NOT NULL,
		[SER_PRO_TimeStamp] [varbinary](8) NULL,
		[SER_PRO_Soundex] [varchar](8) NOT NULL,
		[SER_PRO_TipoReceta] [tinyint] NULL,
		[SER_PRO_Procedencia] [varchar](10) NOT NULL,
		[Farmacia] [varchar](2) NULL,
		[SER_PRO_Agenda] [varchar](1) NULL,
		[SER_PRO_NomSocial] [varchar](40) NULL,
		[SER_PRO_EsSocial] [char](1) NULL,

		CONSTRAINT [PK_SER_PROFESIONA] PRIMARY KEY ([SER_PRO_Rut] ASC, [SER_PRO_Tipo] ASC, [SER_PRO_Procedencia] ASC)
	)

	ALTER TABLE [dbo].[SER_Profesiona] ADD  DEFAULT ('1-9') FOR [SER_PRO_Rut]

	ALTER TABLE [dbo].[SER_Profesiona] ADD  DEFAULT ('') FOR [SER_PRO_Tipo]

	ALTER TABLE [dbo].[SER_Profesiona] ADD  DEFAULT ('') FOR [SER_PRO_ApellPater]

	ALTER TABLE [dbo].[SER_Profesiona] ADD  DEFAULT ('') FOR [SER_PRO_ApellMater]

	ALTER TABLE [dbo].[SER_Profesiona] ADD  DEFAULT ('') FOR [SER_PRO_Nombres]

	ALTER TABLE [dbo].[SER_Profesiona] ADD  DEFAULT ('') FOR [SER_PRO_Estado]

	ALTER TABLE [dbo].[SER_Profesiona] ADD  DEFAULT ('') FOR [SER_PRO_Direccion]

	ALTER TABLE [dbo].[SER_Profesiona] ADD  DEFAULT ('') FOR [SER_PRO_Telefono]

	ALTER TABLE [dbo].[SER_Profesiona] ADD  DEFAULT ('') FOR [SER_PRO_Observacio]

	ALTER TABLE [dbo].[SER_Profesiona] ADD  DEFAULT ('') FOR [SER_PRO_Soundex]

	ALTER TABLE [dbo].[SER_Profesiona] ADD  DEFAULT ((0)) FOR [SER_PRO_TipoReceta]
END