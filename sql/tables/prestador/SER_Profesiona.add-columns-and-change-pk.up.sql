/* 199 */

IF (dbo._ExisteColumnaEnTabla('dbo.SER_Profesiona', 'IdIdentidadGenero') = 0)
    ALTER TABLE [dbo].[SER_Profesiona] ADD IdIdentidadGenero TINYINT NULL

IF (dbo._ExisteColumnaEnTabla('dbo.SER_Profesiona', 'IdNacionalidad') = 0)
    ALTER TABLE [dbo].[SER_Profesiona] ADD IdNacionalidad SMALLINT NULL

IF (dbo._ExisteColumnaEnTabla('dbo.SER_Profesiona', 'NumeroRPNI') = 0)
    ALTER TABLE [dbo].[SER_Profesiona] ADD NumeroRPNI BIGINT NULL

IF (dbo._ExisteColumnaEnTabla('dbo.SER_Profesiona', 'FechaNacimiento') = 0)
    ALTER TABLE [dbo].[SER_Profesiona] ADD FechaNacimiento DATETIME NULL

IF (dbo._ExisteColumnaEnTabla('dbo.SER_Profesiona', 'IdSexoBiologico') = 0)
    ALTER TABLE [dbo].[SER_Profesiona] ADD IdSexoBiologico TINYINT NULL

IF (dbo._ExisteColumnaEnTabla('dbo.SER_Profesiona', 'Id') = 0)
    ALTER TABLE [dbo].[SER_Profesiona] ADD Id UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_SER_PROFESIONA_ID DEFAULT NEWID()

IF (OBJECT_ID('dbo.UQ_SER_PROFESIONA', 'UQ') IS NULL) BEGIN
    ALTER TABLE [dbo].[SER_Profesiona] ADD CONSTRAINT UQ_SER_PROFESIONA
    UNIQUE ([SER_PRO_Rut] ASC, [SER_PRO_Tipo] ASC, [SER_PRO_Procedencia] ASC)
END

IF (
    OBJECT_ID('dbo.PK_SER_PROFESIONA', 'PK') IS NOT NULL
    AND (SELECT COUNT(1) FROM dbo._ObtenerColumnasPK('dbo.SER_Profesiona')) = 3
) BEGIN
    ALTER TABLE [dbo].[SER_Profesiona] DROP CONSTRAINT PK_SER_PROFESIONA
    ALTER TABLE [dbo].[SER_Profesiona] ADD CONSTRAINT PK_SER_PROFESIONA
    PRIMARY KEY (Id)
END