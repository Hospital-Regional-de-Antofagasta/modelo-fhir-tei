/* 200 */
IF OBJECT_ID('dbo.SER_Servicios', 'U') IS NULL BEGIN
    CREATE TABLE [dbo].[SER_Servicios] (
        [SER_SER_Codigo] [CHAR](8) NOT NULL PRIMARY KEY
    );

    INSERT INTO [dbo].[SER_Servicios] (SER_SER_Codigo) values
    ('01-001'), ('01-103'), ('03-092')
END