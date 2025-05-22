/* 21 */
CREATE TABLE [dbo].[TAB_FHIR_MotivoCierreInterconsulta] (
    Id TINYINT NOT NULL CONSTRAINT PK_FHIR_MOTIVOCIERREINTERCONSULTA PRIMARY KEY,
    Codigo VARCHAR(2) NOT NULL UNIQUE,
    Texto VARCHAR(100) NOT NULL,
    Vigencia BIT NOT NULL DEFAULT 1,
    [CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
);

ALTER TABLE [dbo].[TAB_FHIR_MotivoCierreInterconsulta] ADD
CONSTRAINT FK_FHIR_MOTIVOCIERREINTERCONSULTA_USUARIO FOREIGN KEY (CreatedBy) REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]);

INSERT INTO [dbo].[TAB_FHIR_MotivoCierreInterconsulta] (Id, Codigo, Texto) VALUES
(1, '1', 'GES (0)'),
(2, '2', 'Atención Realizada (1)'),
(3, '3', 'Corresponde a la realización del examen procedimiento ejecutado (2)'),
(4, '4', 'Atención Otorgada en el Extra sistema (4)'),
(5, '5', 'No beneficiario (5)'),
(6, '6', 'Renuncia o rechazo voluntario (6)'),
(7, '7', 'Recuperación espontánea (7)'),
(8, '8', 'Inasistencia (2 NSP) (8)'),
(9, '9', 'Fallecimiento (9)'),
(10, '10', 'Solicitud de indicación duplicada (10)'),
(11, '11', 'Contacto no corresponde (11)'),
(12, '12', 'Traslado coordinado (12)'),
(13, '13', 'No pertinencia (13)'),
(14, '14', 'Error de digitación(15)'),
(15, '15', 'Atención por resolutividad (16)'),
(16, '16', 'Atención por telemedicina (17)'),
(17, '17', 'Modificación de condicion clínica del paciente (18)'),
(18, '18', 'Atención hospital digital (19)');