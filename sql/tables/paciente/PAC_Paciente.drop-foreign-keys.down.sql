/* 10 */
IF (OBJECT_ID('dbo.FK_PAC_PACIENTE_SEXOBILOGICO', 'F') IS NOT NULL)
ALTER TABLE [dbo].[PAC_Paciente] DROP CONSTRAINT FK_PAC_PACIENTE_SEXOBILOGICO

IF (OBJECT_ID('dbo.FK_PAC_PACIENTE_IDENTIDADGENERO', 'F') IS NOT NULL)
ALTER TABLE [dbo].[PAC_Paciente] DROP CONSTRAINT
FK_PAC_PACIENTE_IDENTIDADGENERO

IF (OBJECT_ID('dbo.FK_PAC_PACIENTE_NACIONALIDAD', 'F') IS NOT NULL)
ALTER TABLE [dbo].[PAC_Paciente] DROP CONSTRAINT
FK_PAC_PACIENTE_NACIONALIDAD

IF (OBJECT_ID('dbo.FK_PAC_PACIENTE_PAISORIGEN', 'F') IS NOT NULL)
ALTER TABLE [dbo].[PAC_Paciente] DROP CONSTRAINT
FK_PAC_PACIENTE_PAISORIGEN

IF (OBJECT_ID('dbo.FK_PAC_PACIENTE_ESTADOCIVIL', 'F') IS NOT NULL)
ALTER TABLE [dbo].[PAC_Paciente] DROP CONSTRAINT
FK_PAC_PACIENTE_ESTADOCIVIL

IF (OBJECT_ID('dbo.FK_PAC_PACIENTE_PUEBLOORIGINARIO', 'F') IS NOT NULL)
ALTER TABLE [dbo].[PAC_Paciente] DROP CONSTRAINT
FK_PAC_PACIENTE_PUEBLOORIGINARIO

IF (OBJECT_ID('dbo.FK_PAC_PACIENTE_RELIGION', 'F') IS NOT NULL)
ALTER TABLE [dbo].[PAC_Paciente] DROP CONSTRAINT
FK_PAC_PACIENTE_RELIGION


