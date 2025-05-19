CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerEspecialidades]
AS
BEGIN
    SELECT
        Id AS 'id',
        CodigoFHIR AS 'codigo_fhir',
		IdTipoEspecialidad AS 'id_tipo_especialidad',
        DESCRIPCION_DEIS_ESPECIALIDAD AS 'texto'
    FROM [dbo].PRLE_ESPECIALIDADES
    WHERE vigencia = 1 AND CodigoFHIR IS NOT NULL
	order by CAST(IdTipoEspecialidad AS INTEGER) asc, CAST(CodigoFHIR AS INTEGER) asc
END