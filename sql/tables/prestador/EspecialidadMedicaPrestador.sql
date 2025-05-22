-- /* 20 */
-- CREATE TABLE [dbo].[EspecialidadMedicaPrestador]
-- (
--     IdPrestador UNIQUEIDENTIFIER NOT NULL,
--     IdEspecialidadMedica SMALLINT NOT NULL,
--     CONSTRAINT PK_ESPECIALIDADMEDICAPRESTADOR PRIMARY KEY (IdPrestador, IdEspecialidadMedica),

--     FechaEmision DATETIME NULL,
--     FechaCaducidad DATETIME NULL,
--     EmitidoPorEntidad VARCHAR(100) NULL,

--     CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
--     CreatedBy VARCHAR(10) NOT NULL,
    
--     DeletedAt DATETIME NULL,
--     DeletedBy VARCHAR(10) NULL
-- )


-- ALTER TABLE [dbo].[EspecialidadMedicaPrestador] ADD
-- CONSTRAINT FK_ESPECIALIDADMEDICAPRESTADOR_PRESTADOR FOREIGN KEY (IdPrestador) REFERENCES [dbo].[SER_Profesiona]([Id]),
-- -- CONSTRAINT FK_ESPECIALIDADMEDICAPRESTADOR_ESPECIALIDAD FOREIGN KEY (IdEspecialidadMedica) REFERENCES [dbo].[TAB_DEIS_EspecialidadMedica]([Id]),
-- CONSTRAINT FK_ESPECIALIDADMEDICAPRESTADOR_CREATEDBY FOREIGN KEY (CreatedBy) REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]),
-- CONSTRAINT FK_ESPECIALIDADMEDICAPRESTADOR_DELETEDBY FOREIGN KEY (DeletedBy) REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]);
