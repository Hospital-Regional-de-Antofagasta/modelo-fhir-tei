/* 199 */

IF (dbo._ExisteColumnaEnTabla('dbo.PAC_Paciente', 'IdSexoBiologico') = 0)
    ALTER TABLE [dbo].[PAC_Paciente] ADD IdSexoBiologico TINYINT NULL

IF (dbo._ExisteColumnaEnTabla('dbo.PAC_Paciente', 'IdIdentidadGenero') = 0)
    ALTER TABLE [dbo].[PAC_Paciente] ADD IdIdentidadGenero TINYINT NULL

IF (dbo._ExisteColumnaEnTabla('dbo.PAC_Paciente', 'IdNacionalidad') = 0)
    ALTER TABLE [dbo].[PAC_Paciente] ADD IdNacionalidad SMALLINT NULL

IF (dbo._ExisteColumnaEnTabla('dbo.PAC_Paciente', 'IdPaisOrigen') = 0)
    ALTER TABLE [dbo].[PAC_Paciente] ADD IdPaisOrigen SMALLINT NULL

IF (dbo._ExisteColumnaEnTabla('dbo.PAC_Paciente', 'IdEstadoCivil') = 0)
    ALTER TABLE [dbo].[PAC_Paciente] ADD IdEstadoCivil TINYINT NULL

IF (dbo._ExisteColumnaEnTabla('dbo.PAC_Paciente', 'PerteneceAPuebloOriginario') = 0)
    ALTER TABLE [dbo].[PAC_Paciente] ADD PerteneceAPuebloOriginario BIT NULL

IF (dbo._ExisteColumnaEnTabla('dbo.PAC_Paciente', 'IdPuebloOriginario') = 0)
    ALTER TABLE [dbo].[PAC_Paciente] ADD IdPuebloOriginario TINYINT NULL

IF (dbo._ExisteColumnaEnTabla('dbo.PAC_Paciente', 'NombreOtroPuebloOriginario') = 0)
    ALTER TABLE [dbo].[PAC_Paciente] ADD NombreOtroPuebloOriginario VARCHAR(25) NULL

IF (dbo._ExisteColumnaEnTabla('dbo.PAC_Paciente', 'PerteneceAPuebloAfrodescendiente') = 0)
    ALTER TABLE [dbo].[PAC_Paciente] ADD PerteneceAPuebloAfrodescendiente BIT NULL

IF (dbo._ExisteColumnaEnTabla('dbo.PAC_Paciente', 'IdReligion') = 0)
    ALTER TABLE [dbo].[PAC_Paciente] ADD IdReligion TINYINT NULL
