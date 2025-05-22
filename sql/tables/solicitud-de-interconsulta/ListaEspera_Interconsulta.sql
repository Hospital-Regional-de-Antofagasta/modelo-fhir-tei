/* 20 */
CREATE TABLE [dbo].[ListaEspera_Interconsulta](
	[Id] BIGINT IDENTITY(1,1) CONSTRAINT PK_LE_INTERCONSULTA PRIMARY KEY NOT NULL,
	[NumeroPaciente] [float] CONSTRAINT FK_LE_INTERCONSULTA_PACIENTE FOREIGN KEY REFERENCES [dbo].[PAC_Paciente]([PAC_PAC_Numero]) NULL,--PCA_AGE_NumerPacie
	[IdSistemaOrigen] [BIGINT] CONSTRAINT FK_LE_INTERCONSULTA_SISTEMAORIGEN FOREIGN KEY REFERENCES [dbo].[ListaEspera_TAB_SistemaOrigen](Id) NOT NULL,
	[IdentificadorOrigen] [VARCHAR](100) NULL,
	[IdEspecialidadOrigen] [BIGINT] CONSTRAINT FK_LE_INTERCONSULTA_ESPECIALIDADORIGEN FOREIGN KEY REFERENCES [dbo].[PRLE_ESPECIALIDADES](Id) NULL,
	[CodigoPoliclinicoOrigen] [CHAR](8) CONSTRAINT FK_LE_INTERCONSULTA_POLICLINICOORIGEN FOREIGN KEY REFERENCES [dbo].[SER_Servicios]([SER_SER_Codigo]) NULL,
	[NumeroFolioNominaOrigen] [int] CONSTRAINT FK_LE_INTERCONSULTA_NOMINA FOREIGN KEY REFERENCES [dbo].[AFC_Nomina]([NOM_Folio]) NULL,--NOM_Folio
	[IdEstablecimientoOrigen] [BIGINT] CONSTRAINT FK_LE_INTERCONSULTA_ESTABLECIMIENTOORIGEN FOREIGN KEY REFERENCES [dbo].[ListaEspera_TAB_Establecimiento](Id) NOT NULL,
	[IdReferenciaOrigen] [TINYINT] CONSTRAINT FK_LE_INTERCONSULTA_REFERENCIAORIGEN FOREIGN KEY REFERENCES [dbo].[ListaEspera_TAB_ReferenciaOrigen]([Id]) NULL,
	[RutProfesionalOrigen] [varchar](10) NULL,
	[CodigoTipoProfesionalOrigen] [char](4) NULL,
	[ProcedenciaProfesionalOrigen] [varchar](10) NULL,
	CONSTRAINT FK_LE_INTERCONSULTA_PROFESIONALORIGEN FOREIGN KEY ([RutProfesionalOrigen],[CodigoTipoProfesionalOrigen],[ProcedenciaProfesionalOrigen]) REFERENCES [dbo].[SER_Profesiona]([SER_PRO_Rut],[SER_PRO_Tipo],[SER_PRO_Procedencia]),
	[IdEstablecimientoDestino] [BIGINT] CONSTRAINT FK_LE_INTERCONSULTA_ESTABLEDESTINO FOREIGN KEY REFERENCES [dbo].[ListaEspera_TAB_Establecimiento](Id) NOT NULL,
	[IdReferenciaDestino] [TINYINT] CONSTRAINT FK_LE_INTERCONSULTA_REFERENCIADESTINO FOREIGN KEY REFERENCES [dbo].[ListaEspera_TAB_ReferenciaDestino]([Id]) NULL, 
	[IdEspecialidadDestino] [BIGINT] CONSTRAINT FK_LE_INTERCONSULTA_ESPECIALIDADDESTINO FOREIGN KEY REFERENCES [dbo].[PRLE_ESPECIALIDADES](Id) NULL,--PARA CNE y CCE
	[IdSubespecialidadDestino] [BIGINT] CONSTRAINT FK_LE_INTERCONSULTA_SUBESPECIALIDADDESTINO FOREIGN KEY REFERENCES [dbo].[PRLE_ESPECIALIDADES](Id) NULL,
	[IdProcedimientoIntervencionDestino] [BIGINT] NULL,--PARA IQE y PDT
	CONSTRAINT LE_INTERCONSULTA_ESP_O_PROC CHECK (([IdEspecialidadDestino] IS NULL AND [IdProcedimientoIntervencionDestino] IS NOT NULL) OR (([IdEspecialidadDestino] IS NOT NULL AND [IdProcedimientoIntervencionDestino] IS NULL))),
	[IdDiagnostico] [BIGINT] CONSTRAINT FK_LE_INTERCONSULTA_DIAGNOSTICO FOREIGN KEY REFERENCES [dbo].[ListaEspera_TAB_Diagnostico]([Id])NOT NULL,
	[IdEstadoDiagnostico] [BIGINT] CONSTRAINT FK_LE_INTERCONSULTA_ESTADODIAGNOSTICO FOREIGN KEY REFERENCES [dbo].[ListaEspera_TAB_EstadoDiagnostico](Id) NOT NULL,
	[FundamentosDiagnostico] [VARCHAR](256) NULL,
	[IdMotivoDerivacion] [BIGINT] CONSTRAINT FK_LE_INTERCONSULTA_MOTIVODERIVACION FOREIGN KEY REFERENCES [dbo].[ListaEspera_TAB_MotivoDerivacion](Id) NOT NULL,
	[MotivoEspecifico] [VARCHAR](3000) NULL,	
	[RequiereExamen] [BIT] NULL,
	[ExamenesRealizados] [VARCHAR](256) NULL,
	[EsAtencionPreferente] [BIT] NULL,
    [TieneResolutividadAPS] [BIT] NULL,
	[FechaSolicitud] [DATETIME] NOT NULL,	
	[IdTipoPrestacion] [BIGINT] CONSTRAINT FK_LE_INTERCONSULTA_TIPOPRESTACION FOREIGN KEY REFERENCES [dbo].[ListaEspera_TAB_TipoPrestacion](Id) NOT NULL,
	[IdentificadorFHIR] [VARCHAR](64) NULL,
	[IdentificadorMINSAL] [VARCHAR](100) NULL,
	[IdentificadorSIGTE] [VARCHAR](100) NULL,
	[CodigoProblemaSaludAuge] [int]  NULL,--PCA_AGE_ProblemasSalud --CONSTRAINT FK_LE_INTERCONSULTA_PROBLEMASSALUD FOREIGN KEY REFERENCES [BD_HCE].[dbo].[HCE_GESProblemaSalud]([GES_Codigo])	
	[IdPrioridad] [TINYINT] CONSTRAINT FK_LE_INTERCONSULTA_PRIORIDAD FOREIGN KEY REFERENCES [dbo].[TAB_FHIR_PrioridadSolicitud]([Id]) NULL,
	[FundamentoPriorizacion] [VARCHAR](256) NULL,	
	[PrioritizedBy] [varchar](10) CONSTRAINT FK_LE_INTERCONSULTA_USUARIO_PRIORIZADOR FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NULL,
	[PrioritizedAt] DATETIME NULL,
	[IdCausalSalida] [TINYINT] CONSTRAINT FK_LE_INTERCONSULTA_CAUSASALIDA FOREIGN KEY REFERENCES [dbo].[TAB_FHIR_MotivoCierreInterconsulta]([Id]) NULL,
	[FechaSalida] DATETIME NULL,
	[MotivoNoPertinencia] [VARCHAR](256) NULL,	
	[IdModalidadAtencion] [BIGINT] CONSTRAINT FK_LE_INTERCONSULTA_MODALIDADATENCION FOREIGN KEY REFERENCES [dbo].[ListaEspera_TAB_ModalidadAtencion]([Id]) NULL,
	[CreatedBy] [VARCHAR](10) CONSTRAINT FK_LE_INTERCONSULTA_USUARIO FOREIGN KEY REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE()
);


EXEC sys.sp_addextendedproperty @name=N'NumeroPaciente', @value=N'Número que identifica al paciente de la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'NumeroPaciente'

EXEC sys.sp_addextendedproperty @name=N'IdSistemaOrigen', @value=N'Id del sistema en el que se originó/digitó la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdSistemaOrigen'

EXEC sys.sp_addextendedproperty @name=N'IdentificadorOrigen', @value=N'Id del caso en el origen.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdentificadorOrigen'

EXEC sys.sp_addextendedproperty @name=N'IdEspecialidadOrigen', @value=N'Id de la especialidad que originó la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdEspecialidadOrigen'

EXEC sys.sp_addextendedproperty @name=N'CodigoPoliclinicoOrigen', @value=N'Codigo del policlinico que originó la interconsulta (para interconsultas originadas en el hospital HRA).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'CodigoPoliclinicoOrigen'

EXEC sys.sp_addextendedproperty @name=N'NumeroFolioNominaOrigen', @value=N'Número del folio de la nómina de la atención que originió la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'NumeroFolioNominaOrigen'

EXEC sys.sp_addextendedproperty @name=N'IdEstablecimientoOrigen', @value=N'Id del establecimiento de salud que emitió la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdEstablecimientoOrigen'

EXEC sys.sp_addextendedproperty @name=N'IdReferenciaOrigen', @value=N'Id del tipo de establecimiento de salud que emitió la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdReferenciaOrigen'

EXEC sys.sp_addextendedproperty @name=N'RutProfesionalOrigen', @value=N'Rut del profesional que emitió la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'RutProfesionalOrigen'

EXEC sys.sp_addextendedproperty @name=N'CodigoTipoProfesionalOrigen', @value=N'Codigo del tipo de profesional que emitió la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'CodigoTipoProfesionalOrigen'

EXEC sys.sp_addextendedproperty @name=N'ProcedenciaProfesionalOrigen', @value=N'Procedencia del profesional que emitió la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'ProcedenciaProfesionalOrigen'

EXEC sys.sp_addextendedproperty @name=N'IdEstablecimientoDestino', @value=N'Id del establecimiento de salud al que se derivó a través de la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdEstablecimientoDestino'

EXEC sys.sp_addextendedproperty @name=N'IdReferenciaDestino', @value=N'Id del tipo de establecimiento de salud al que se derivó a través de la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdReferenciaDestino'

EXEC sys.sp_addextendedproperty @name=N'IdEspecialidadDestino', @value=N'Id de la especialidad a la que se está derivando a través de la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdEspecialidadDestino'

EXEC sys.sp_addextendedproperty @name=N'IdSubespecialidadDestino', @value=N'Id de la subespecialidad a la que se está derivando a través de la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdSubespecialidadDestino'

EXEC sys.sp_addextendedproperty @name=N'IdProcedimientoIntervencionDestino', @value=N'Id del procedimiento o intervención quirúrgica a la que se está derivando a través de la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdProcedimientoIntervencionDestino'

EXEC sys.sp_addextendedproperty @name=N'IdDiagnostico', @value=N'Id del diagnóstico de la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdDiagnostico'

EXEC sys.sp_addextendedproperty @name=N'IdEstadoDiagnostico', @value=N'Id del tipo de diagnóstico que tiene la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdEstadoDiagnostico'

EXEC sys.sp_addextendedproperty @name=N'FundamentosDiagnostico', @value=N'Texto libre para detallar razones del diagnóstico.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'FundamentosDiagnostico'

EXEC sys.sp_addextendedproperty @name=N'IdMotivoDerivacion', @value=N'Id del motivo de derivación que tiene la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdMotivoDerivacion'

EXEC sys.sp_addextendedproperty @name=N'MotivoEspecifico', @value=N'Texto libre sobre el motivo de la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'MotivoEspecifico'

EXEC sys.sp_addextendedproperty @name=N'RequiereExamen', @value=N'Indica si el paciente requiere exámenes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'RequiereExamen'

EXEC sys.sp_addextendedproperty @name=N'ExamenesRealizados', @value=N'Texto libre sobre los exámenes realizados al paciente de la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'ExamenesRealizados'

EXEC sys.sp_addextendedproperty @name=N'EsAtencionPreferente', @value=N'Indica si el paciente requiere atención preferencial.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'EsAtencionPreferente'

EXEC sys.sp_addextendedproperty @name=N'TieneResolutividadAPS', @value=N'Indica si el caso puede resolverse en APS.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'TieneResolutividadAPS'

EXEC sys.sp_addextendedproperty @name=N'FechaSolicitud', @value=N'Fecha en la que se emitió la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'FechaSolicitud'

EXEC sys.sp_addextendedproperty @name=N'IdTipoPrestacion', @value=N'Id del tipo de prestación que se solicita en la interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdTipoPrestacion'

EXEC sys.sp_addextendedproperty @name=N'IdentificadorFHIR', @value=N'Identificador de la solicitud en la integración FHIR.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdentificadorFHIR'

EXEC sys.sp_addextendedproperty @name=N'IdentificadorMINSAL', @value=N'Identificador de la solicitud en el sistema de Minsal.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdentificadorMINSAL'

EXEC sys.sp_addextendedproperty @name=N'IdentificadorSIGTE', @value=N'Identificador de la solicitud en el sistema SIGTE.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdentificadorSIGTE'

EXEC sys.sp_addextendedproperty @name=N'CodigoProblemaSaludAuge', @value=N'Codigo del problema de salud que presenta el paciente GES.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'CodigoProblemaSaludAuge'

EXEC sys.sp_addextendedproperty @name=N'IdPrioridad', @value=N'Identificador de la prioridad del caso de lista de espera.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdPrioridad'

EXEC sys.sp_addextendedproperty @name=N'FundamentoPriorizacion', @value=N'Texto libre de fundamentos de la prioridad.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'FundamentoPriorizacion'

EXEC sys.sp_addextendedproperty @name=N'PrioritizedBy', @value=N'Cuenta de usuario que prioriza el caso.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'PrioritizedBy'

EXEC sys.sp_addextendedproperty @name=N'IdCausalSalida', @value=N'Identificador de la causa de salida de lista de espera.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdCausalSalida'

EXEC sys.sp_addextendedproperty @name=N'FechaSalida', @value=N'Fecha de salida de lista de espera.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'FechaSalida'

EXEC sys.sp_addextendedproperty @name=N'MotivoNoPertinencia', @value=N'Texto libre sobre el motivo por el cual la interconsulta no es pertinente.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'MotivoNoPertinencia'

EXEC sys.sp_addextendedproperty @name=N'IdModalidadAtencion', @value=N'Identificador de la modalidad en la que se atendió al paciente.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta', @level2type=N'COLUMN',@level2name=N'IdModalidadAtencion'

EXEC sys.sp_addextendedproperty @name=N'ListaEspera_Interconsulta', @value=N'Esta tabla almacena los diagnósticos que pueden tener las interconsultas de lista de espera.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_Interconsulta'


-- UPDATE [dbo].[API_AGENDA_Cita] SET IdInterconsulta = NULL
-- -- ALTER TABLE [dbo].[API_AGENDA_Cita]  ADD  CONSTRAINT [FK_CITA_INTERCONSULTA] FOREIGN KEY([IdInterconsulta])
-- REFERENCES [dbo].[ListaEspera_Interconsulta] ([Id])
-- 
-- TRUNCATE TABLE [dbo].[ListaEspera_EstadoInterconsulta]
-- -- ALTER TABLE [dbo].[ListaEspera_EstadoInterconsulta]  WITH CHECK ADD  CONSTRAINT [FK_LE_ESTADOINTERCONSULTA_INTERCONSULTA] FOREIGN KEY([IdInterconsulta])
-- REFERENCES [dbo].[ListaEspera_Interconsulta] ([Id])
-- GO