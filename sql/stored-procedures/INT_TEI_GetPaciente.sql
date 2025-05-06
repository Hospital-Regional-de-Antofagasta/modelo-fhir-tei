CREATE OR ALTER PROCEDURE INT_TEI_GetPaciente
  @numeroPaciente FLOAT
AS
BEGIN
  IF NOT EXISTS (SELECT TOP (1) 1 FROM dbo.PAC_PacienteExtendido pe WHERE pe.NumeroPaciente = @numeroPaciente) BEGIN
    THROW 50001, 'Paciente no encontrado', 1
  END

  DECLARE @resultado TABLE (
    id UNIQUEIDENTIFIER,
    numero_paciente FLOAT NOT NULL,
    esta_activo BIT NOT NULL,
    codigo_estado_civil CHAR(2) NULL,
    codigo_genero_administrativo VARCHAR(10) NOT NULL,
    codigo_sexo_biologico VARCHAR(10) NULL,
    codigo_nacionalidad CHAR(3) NOT NULL,
    codigo_pais_origen CHAR(3) NOT NULL,
    codigo_religion VARCHAR(2) NULL,
    pertenece_a_pueblo_originario_chile BIT NOT NULL,
    pertenece_a_pueblo_afrodescendiente BIT NULL,

    _id VARCHAR(64) NULL,
    _link VARCHAR(MAX) NULL,
    _general_practitioner VARCHAR(MAX) NULL
  );

  INSERT INTO @resultado
  SELECT
    pe.Id,
    pe.NumeroPaciente,
    pe.EstaActivo,
    pe.CodigoEstadoCivil,
    pe.CodigoGeneroAdministrativo,
    pe.CodigoSexoBiologico,
    pe.CodigoNacionalidad,
    pe.CodigoPaisOrigen,
    pe.CodigoReligion,
    pe.PerteneceAPuebloOriginarioChile,
    pe.PerteneceAPuebloAfrodescendiente,
    pe._id,
    pe._link,
    pe._general_practitioner
  FROM dbo.PAC_PacienteExtendido pe
    JOIN dbo.PAC_Paciente pa ON pe.NumeroPaciente = pa.PAC_PAC_Numero
  WHERE pe.NumeroPaciente = @numeroPaciente;

END