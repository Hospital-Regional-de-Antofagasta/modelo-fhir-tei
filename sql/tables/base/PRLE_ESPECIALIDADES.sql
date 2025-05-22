/* 200 */
CREATE TABLE [dbo].[PRLE_ESPECIALIDADES](
	[COD_DEIS_ESPECIALIDAD] [varchar](15) NOT NULL,
	[DESCRIPCION_DEIS_ESPECIALIDAD] [varchar](50) NOT NULL,
	[vigencia] [bit] NOT NULL,
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[EdadMinAnios] [int] NULL,
	[EdadMaxAnios] [int] NULL,
	[EdadMinDias] [int] NULL,
	[EdadMaxDias] [int] NULL,
	[VigenciaEntrada] [datetime] NULL,
	[VigenciaSalida] [datetime] NULL,
	[CodigoNorma820] [varchar](20) NULL,
	[IdTipoEspecialidad] [int] NULL,
	[CodigoFHIR] [varchar](10) NULL,
	[HospitalResuelve] [bit] NOT NULL,
    CONSTRAINT [PK_PRLE_ESPECIALIDADES] PRIMARY KEY ([Id])
);

ALTER TABLE [dbo].[PRLE_ESPECIALIDADES] ADD  CONSTRAINT [DF__PRLE_ESPE__vigen__27B0D017]  DEFAULT ((1)) FOR [vigencia]

ALTER TABLE [dbo].[PRLE_ESPECIALIDADES] ADD  DEFAULT ((1)) FOR [HospitalResuelve]

ALTER TABLE [dbo].[PRLE_ESPECIALIDADES]  WITH CHECK ADD  CONSTRAINT [FK_PRLE_ESPECIALIDADES_TIPO] FOREIGN KEY([IdTipoEspecialidad])
REFERENCES [dbo].[TAB_TipoEspecialidad] ([ID_TipoEsp])

ALTER TABLE [dbo].[PRLE_ESPECIALIDADES] CHECK CONSTRAINT [FK_PRLE_ESPECIALIDADES_TIPO]

