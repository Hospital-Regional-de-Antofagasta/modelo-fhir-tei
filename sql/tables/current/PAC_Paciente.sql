
SET ANSI_NULLS OFF

SET QUOTED_IDENTIFIER ON


CREATE TABLE [dbo].[PAC_Paciente](
  [PAC_PAC_Numero] [float] PRIMARY KEY,
  [PAC_PAC_Rut] [varchar](10) NOT NULL,
  [PAC_PAC_ApellPater] [varchar](20) NOT NULL,
  [PAC_PAC_ApellMater] [varchar](20) NOT NULL,
  [PAC_PAC_Nombre] [varchar](40) NOT NULL,
  [PAC_PAC_FechaNacim] [datetime] NOT NULL,
  [PAC_PAC_CalleHabit] [varchar](20) NULL,
  [PAC_PAC_NumerHabit] [varchar](8) NULL,
  [PAC_PAC_DeparHabit] [varchar](8) NULL,
  [PAC_PAC_PoblaHabit] [varchar](30) NULL,
  [PAC_PAC_ComunHabit] [varchar](20) NULL,
  [PAC_PAC_CiudaHabit] [varchar](30) NULL,
  [PAC_PAC_RegioHabit] [varchar](20) NULL,
  [PAC_PAC_CalleTempo] [varchar](20) NULL,
  [PAC_PAC_NumerTempo] [varchar](8) NULL,
  [PAC_PAC_DeparTempo] [varchar](8) NULL,
  [PAC_PAC_PoblaTempo] [varchar](30) NULL,
  [PAC_PAC_ComunTempo] [varchar](20) NULL,
  [PAC_PAC_CiudaTempo] [varchar](30) NULL,
  [PAC_PAC_RegioTempo] [varchar](20) NULL,
  [PAC_PAC_Fono] [varchar](20) NULL,
  [PAC_PAC_Sexo] [char](1) NOT NULL,
  [PAC_PAC_Profesion] [char](8) NULL,
  [PAC_PAC_Religion] [varchar](20) NULL,
  [PAC_PAC_Ocupacion] [varchar](30) NULL,
  [PAC_PAC_EstadCivil] [varchar](10) NOT NULL,
  [PAC_PAC_FechaIngre] [datetime] NOT NULL,
  [PAC_PAC_Origen] [varchar](15) NOT NULL,
  [PAC_PAC_FechaModif] [datetime] NULL,
  [PAC_PAC_FechaFallec] [datetime] NOT NULL,
  [PAC_PAC_Prevision] [char](8) NOT NULL,
  [PAC_PAC_Codigo] [char](8) NOT NULL,
  [PAC_PAC_TimeStamp] [varbinary](8) NULL,
  [PAC_PAC_Soundex] [varchar](8) NOT NULL,
  [PAC_PAC_TipoBenef] [char](1) NULL,
  [PAC_PAC_FechaUaten] [datetime] NULL,
  [PAC_PAC_Clasificado] [tinyint] NULL,
  [PAC_PAC_ClaseCodigo] [char](8) NULL,
  [PAC_PAC_Cotizante] [tinyint] NULL,
  [PAC_PAC_FonoTempo] [char](20) NULL,
  [PAC_PAC_DireccionGralHabit] [varchar](100) NULL,
  [PAC_PAC_CodigUsuar] [varchar](10) NULL,
  [PAC_PAC_CodigInsti] [char](8) NULL,
  [PAC_PAC_NumeroRayos] [varchar](8) NULL,
  [PAC_PAC_FechaVenci] [datetime] NULL,
  [PAC_PAC_CorrAutori] [varchar](10) NULL,
  [PAC_PAC_NroPasaporte] [varchar](20) NULL,
  [PAC_PAC_TelefonoMovil] [varchar](20) NULL,
  [PAC_PAC_Sector] [varchar](8) NULL,
  [PAC_PAC_Etnia] [varchar](2) NULL,
  [PAC_PAC_FonoNumerico] [numeric](8, 0) NULL,
  [PAC_PAC_TelefonoMovilNumerico] [numeric](8, 0) NULL,
  [PAC_PAC_Prais] [int] NULL,
  [PAC_PAC_Ruralidad] [int] NULL,
  [PAC_PAC_ClaseVia] [int] NULL,
  [PAC_PAC_CIUCodigo] [varchar](8) NULL,
  [PAC_PAC_CorreoCuerpo] [varchar](35) NULL,
  [PAC_PAC_CorreoExtension] [varchar](25) NULL,
  [PAC_PAC_Nacionalidad] [varchar](1) NULL,
  [PAC_PAC_MotPacSinRut] [varchar](4) NULL,
  [NAC_Ide] [bigint] NULL,
  [PAC_PAC_NivelInstruccion] [varchar](2) NULL,
  [PAC_PAC_ActivoInactivo] [varchar](2) NULL,
  [PAC_PAC_FichaPasiva] [bit] NULL,
  [PAC_PAC_PacTrans] [bit] NULL,
  [PAC_RutProvisorio] [bit] NULL,
  [PAC_PAC_IdentidadGenero] [int] NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ((0)) FOR [PAC_PAC_Numero]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('1-9') FOR [PAC_PAC_Rut]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_ApellPater]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_ApellMater]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_Nombre]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('1/1/1900') FOR [PAC_PAC_FechaNacim]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_CalleHabit]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_NumerHabit]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_DeparHabit]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_PoblaHabit]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_ComunHabit]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_CiudaHabit]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_RegioHabit]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_CalleTempo]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_NumerTempo]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_DeparTempo]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_PoblaTempo]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_ComunTempo]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_CiudaTempo]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_RegioTempo]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_Fono]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_Sexo]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_Profesion]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_Religion]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_Ocupacion]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_EstadCivil]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('1/1/1900') FOR [PAC_PAC_FechaIngre]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_Origen]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('1/1/1900') FOR [PAC_PAC_FechaModif]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('1/1/1900') FOR [PAC_PAC_FechaFallec]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_Prevision]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_Codigo]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_Soundex]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_TipoBenef]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('1/1/1900') FOR [PAC_PAC_FechaUaten]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ((0)) FOR [PAC_PAC_Clasificado]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_ClaseCodigo]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_CodigInsti]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ('') FOR [PAC_PAC_CorrAutori]

ALTER TABLE [dbo].[PAC_Paciente] ADD  DEFAULT ((0)) FOR [PAC_PAC_FichaPasiva]