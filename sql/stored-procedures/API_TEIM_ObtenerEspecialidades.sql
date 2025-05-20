CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerEspecialidades]
AS
BEGIN
    SELECT
        Id AS 'id',
        CodigoFHIR AS 'codigo_fhir',
        CASE IdTipoEspecialidad
            WHEN 1 THEN 'https://interoperabilidad.minsal.cl/fhir/ig/tei/CodeSystem/CSEspecialidadMed'
            WHEN 2 THEN 'https://interoperabilidad.minsal.cl/fhir/ig/tei/CodeSystem/CSEspecialidadOdont'
        END AS 'sistema_fhir',
        DESCRIPCION_DEIS_ESPECIALIDAD AS 'texto'
    FROM [dbo].PRLE_ESPECIALIDADES
    WHERE vigencia = 1 AND CodigoFHIR IS NOT NULL
	order by CAST(IdTipoEspecialidad AS INTEGER) asc, CAST(CodigoFHIR AS INTEGER) asc
END