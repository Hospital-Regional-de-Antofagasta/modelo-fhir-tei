/* 200 */
IF OBJECT_ID('dbo.Segu_Usuarios', 'U') IS NULL BEGIN
	CREATE TABLE [dbo].[Segu_Usuarios](
		[Segu_Usr_Cuenta] [varchar](10) PRIMARY KEY
	);

	DECLARE @user VARCHAR(10) = SUSER_NAME();
	INSERT INTO [dbo].[Segu_Usuarios] VALUES (@user);

END