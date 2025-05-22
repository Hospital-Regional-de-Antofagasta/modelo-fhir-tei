/* 50 */
CREATE TABLE [dbo].[ListaEspera_TAB_Establecimiento]
(
    [Id] [bigint] NOT NULL PRIMARY KEY IDENTITY(1, 1),
    Codigo varchar(10) NOT NULL,
    Texto VARCHAR(200),
    Vigencia BIT NOT NULL DEFAULT 1,
);

    INSERT INTO [dbo].[ListaEspera_TAB_Establecimiento]
        (Codigo, Texto)
    values
        ('10401', 'Hospital regional de Calama'),
        ('103200', 'Hospital regional de Iquique'),
        ('103100', 'Hospital regional de Antofagasta')
