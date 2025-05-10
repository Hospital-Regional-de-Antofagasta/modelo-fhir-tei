CREATE TABLE [dbo].[EspecialidadMedicaPrestador]
(
    IdPrestador UNIQUEIDENTIFIER NOT NULL,
    IdEspecialidadMedica SMALLINT NOT NULL,
    CONSTRAINT PK_ESPECIALIDADMEDICAPRESTADOR PRIMARY KEY (IdPrestador, IdEspecialidadMedica),

    FechaEmision DATETIME NULL,
    FechaCaducidad DATETIME NULL,
    EmitidoPorEntidad VARCHAR(100) NULL,

    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy VARCHAR(10) NOT NULL,
    
    DeletedAt DATETIME NULL,
    DeletedBy VARCHAR(10) NULL
)

