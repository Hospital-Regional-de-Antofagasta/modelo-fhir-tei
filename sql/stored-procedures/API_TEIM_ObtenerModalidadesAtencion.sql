CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerModalidadesAtencion]
AS
BEGIN
    SELECT
        Id AS 'id',
        Codigo AS 'codigo',
        Texto AS 'texto'
    FROM [dbo].[ListaEspera_TAB_ModalidadAtencion]
    WHERE Vigencia = 1
END