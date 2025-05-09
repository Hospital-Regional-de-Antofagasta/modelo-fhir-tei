CREATE TABLE [dbo].[TituloProfesionalPrestador]
(
    IdPrestador UNIQUEIDENTIFIER NOT NULL,
    IdTituloProfesional SMALLINT NOT NULL,

    MencionEn VARCHAR(100) NULL,

    FechaEmision DATETIME NULL,
    FechaCaducidad DATETIME NULL,
    EmitidoPorEntidad VARCHAR(100) NULL,

    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy UNIQUEIDENTIFIER NOT NULL,
    
    DeletedAt DATETIME NULL,
    DeletedBy UNIQUEIDENTIFIER NULL
)