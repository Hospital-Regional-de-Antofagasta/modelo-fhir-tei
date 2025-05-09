CREATE TABLE [dbo].[TituloProfesionalPrestador]
(
    IdPrestador UNIQUEIDENTIFIER NOT NULL,
    IdTituloProfesional SMALLINT NOT NULL,

    MencionEn VARCHAR(100) NULL,

    FechaEmision DATETIME NULL,
    FechaCaducidad DATETIME NULL,
    EmitidoPorEntidad VARCHAR(100) NULL,

    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy VARCHAR(10) NOT NULL,
    
    DeletedAt DATETIME NULL,
    DeletedBy VARCHAR(10) NULL
)