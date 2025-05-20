CREATE OR ALTER PROCEDURE API_TEIM_ObtenerIdentificadoresPacienteDadoNumeroPaciente
    @NumeroPaciente FLOAT
AS
BEGIN
    SELECT
        idp.[Id] AS 'id',
        tipo.[Texto] AS 'texto_tipo',
        tipo.[Id] AS 'id_tipo',

        uso.[Texto] AS 'texto_uso',
        uso.[Id] AS 'id_uso',
        idp.[Valor] AS 'valor',
        
        pais.[Id] AS 'id_pais_emisor_documento',
        pais.[Texto] AS 'texto_pais_emisor_documento'
    FROM
        [dbo].[IdentificadorPaciente] idp
        LEFT JOIN [dbo].[TAB_FHIR_UsoIdentificadorPersona] uso
            ON idp.[IdUso] = uso.[Id]
        LEFT JOIN [dbo].[TAB_FHIR_TipoIdentificadorPersona] tipo
            ON idp.[IdTipo] = tipo.[Id]
        LEFT JOIN [dbo].[TAB_DEIS_Pais] pais
            ON idp.[IdPaisEmisorDocumento] = pais.[Id]
    WHERE NumeroPaciente = @NumeroPaciente;
END