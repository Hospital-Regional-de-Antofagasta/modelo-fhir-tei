/* 50 */
CREATE TABLE [dbo].[TAB_DEIS_IdentidadGenero](
    [Id] [TINYINT] CONSTRAINT PK_DEIS_IDENTIDADGENERO PRIMARY KEY (Id),
    [Codigo] [VARCHAR](10) NOT NULL UNIQUE,
    [Texto] [VARCHAR](25) NOT NULL,
    [Descripcion] [VARCHAR](200) NOT NULL,
    [Vigencia] BIT NOT NULL DEFAULT 1,
    CodigoFHIR VARCHAR(10),
    [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);
ALTER TABLE [dbo].[TAB_DEIS_IdentidadGenero] ADD
CONSTRAINT FK_DEIS_IDENTIDADGENERO_USUARIO FOREIGN KEY (CreatedBy) REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]);


INSERT INTO [dbo].[TAB_DEIS_IdentidadGenero] ([Id], [Codigo], CodigoFHIR, [Texto], [Descripcion])
VALUES
    (1, '1', '1', 'Masculino', 'La persona de sexo "Hombre" asignado al nacer, que se identifica a si misma como de género masculino. También se le conoco como "cisgénero masculino".'),
    (2, '2', '2', 'Femenina', 'La persona de sexo "Mujer" asignado al nacer, que se identifica a sí misma como de género femenino. También se le conoce como "cisgénero femenino".'),
    (3, '4', '3', 'Transgénero Masculino', 'La persona de sexo "Mujer" asignado al nacer, que se identifica a si misma como de género masculino.'),
    (4, '5', '4', 'Transgénero Femenina', 'La persona de sexo "Hombre" asignado al nacer, que se identifica a asi misma como de género femenino.'),
    (5, '6', '5', 'No Binarie', 'La persona que no se identifica con ninguno de los géneros convencionales (femenino o masculino).'),
    (6, '7', '6', 'Otra', 'Otra identidad de género no descrita previamente.'),
    (7, '8', '7', 'No Revelado', 'La persona no desea revelar su identidad de género.');