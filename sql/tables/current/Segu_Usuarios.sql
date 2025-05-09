
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON



CREATE TABLE [dbo].[Segu_Usuarios](
	[Segu_Usr_Cuenta] [varchar](10) PRIMARY KEY
);


DECLARE @user VARCHAR(10) = SUSER_NAME();

INSERT INTO [dbo].[Segu_Usuarios] VALUES (@user);

