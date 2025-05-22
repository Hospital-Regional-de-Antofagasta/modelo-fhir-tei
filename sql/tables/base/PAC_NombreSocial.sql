/* 200 */
IF OBJECT_ID('dbo.PAC_NombreSocial', 'U') IS NULL BEGIN
	CREATE TABLE [dbo].[PAC_NombreSocial](
		[PAC_PAC_Numero] [real] NOT NULL,
		[PAC_PAC_NombreSocial] [varchar](100) NOT NULL
	);
END