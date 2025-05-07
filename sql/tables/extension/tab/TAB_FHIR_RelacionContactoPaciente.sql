IF OBJECT_ID(N'dbo.TAB_FHIR_RelacionContactoPaciente', N'U') IS NULL BEGIN
  CREATE TABLE [dbo].[TAB_FHIR_RelacionContactoPaciente]
  (
    Codigo CHAR(1) PRIMARY KEY,
    Nombre VARCHAR(30) NOT NULL,
    Vigente BIT DEFAULT 1 NOT NULL
  );
  EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'https://hl7.org/fhir/R4/valueset-patient-contactrelationship.html' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAB_FHIR_RelacionContactoPaciente', @level2type=N'COLUMN',@level2name=N'Codigo'

  INSERT INTO [dbo].[TAB_FHIR_RelacionContactoPaciente]
    (Codigo, Nombre)
  VALUES
    ('C', 'Contacto de emergencia'),
    ('E', 'Empleador'),
    ('F', 'Entidad federal'),
    ('I', 'Compañia de seguros'),
    ('N', 'Pariente más cercano'),
    ('S', 'Entidad estatal'),
    ('U', 'Desconocido');
END

