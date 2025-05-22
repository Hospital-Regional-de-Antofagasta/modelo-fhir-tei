/* 199 */
IF NOT EXISTS (SELECT TOP (1) 1 FROM [dbo].[Segu_Usuarios] WHERE Segu_Usr_Cuenta = 'jmery')
INSERT INTO [dbo].[Segu_Usuarios] VALUES ('jmery')

IF NOT EXISTS (SELECT TOP (1) 1 FROM [dbo].[Segu_Usuarios] WHERE Segu_Usr_Cuenta = 'cagonzalez')
INSERT INTO [dbo].[Segu_Usuarios] VALUES ('cagonzalez')

IF NOT EXISTS (SELECT TOP (1) 1 FROM [dbo].[Segu_Usuarios] WHERE Segu_Usr_Cuenta = 'cfarias')
INSERT INTO [dbo].[Segu_Usuarios] VALUES ('cfarias')
