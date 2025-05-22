/* 30 */
CREATE TABLE [dbo].[ListaEspera_Interconsulta]
(
	[Id] BIGINT NOT NULL IDENTITY(1, 1) CONSTRAINT PK_LE_INTERCONSULTA PRIMARY KEY,
	[NumeroPaciente] [float] NULL,
	[IdSistemaOrigen] BIGINT NOT NULL,

	-- Inicio nuevos campos
	RequiereExamen BIT NULL,
	EsAtencionPreferente BIT NULL,
	TieneResolutividadAPS BIT NULL,

	IdReferenciaOrigen TINYINT NULL,
	-- FK ListaEspera_TAB_ReferenciaOrigen
	IdReferenciaDestino TINYINT NULL,
	-- FK ListaEspera_TAB_ReferenciaDestino


	[IdentificadorFHIR] [VARCHAR](64) NULL,
	[IdentificadorMINSAL] [VARCHAR](100) NULL,
	[IdentificadorOrigen] [VARCHAR](100) NULL,
	[IdentificadorSIGTE] [VARCHAR](100) NULL,

	-- Fin nuevos campos

	[IdEspecialidadOrigen] [BIGINT] NULL,

	[CodigoPoliclinicoOrigen] CHAR(8) NULL,
	[NumeroFolioNominaOrigen] [int] NULL,
	[IdEstablecimientoOrigen] [BIGINT] NOT NULL,
	[RutProfesionalOrigen] [varchar](10) NULL,
	[CodigoTipoProfesionalOrigen] [char](4) NULL,
	[ProcedenciaProfesionalOrigen] [varchar](10) NULL,
	[IdEstablecimientoDestino] [BIGINT] NOT NULL,
	[IdEspecialidadDestino] [BIGINT] NULL,
	[IdSubespecialidadDestino] [BIGINT] NULL,
	-- FK PRLE_ESPECIALIDADES
	[IdProcedimientoIntervencionDestino] [BIGINT] NULL,

	[IdDiagnostico] [BIGINT] NOT NULL,
	[IdEstadoDiagnostico] [BIGINT] NOT NULL,
	[FundamentosDiagnostico] [VARCHAR](256) NOT NULL,
	[IdMotivoDerivacion] [BIGINT] NOT NULL,
	[MotivoEspecifico] [VARCHAR](256) NULL,
	[ExamenesRealizados] [VARCHAR](256) NULL,
	[FechaSolicitud] [DATETIME] NOT NULL,
	[IdTipoPrestacion] [BIGINT] NOT NULL,
	[CodigoProblemaSaludAuge] [int] NULL,
	[IdPrioridad] [tinyint] NULL,
	[FundamentoPriorizacion] [VARCHAR](256) NULL,
	[PrioritizedBy] [varchar](10) NULL,
	[PrioritizedAt] DATETIME NULL,
	[IdCausalSalida] [TINYINT] NULL,
	[FechaSalida] DATETIME NULL,
	[MotivoNoPertinencia] [VARCHAR](256) NULL,
	[IdModalidadAtencion] [BIGINT] NULL,
	[CreatedBy] [VARCHAR](10) NOT NULL DEFAULT SUSER_NAME(),
	[CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),

	CONSTRAINT LE_INTERCONSULTA_ESP_O_PROC CHECK (
        ([IdEspecialidadDestino] IS NULL AND [IdProcedimientoIntervencionDestino] IS NOT NULL)
		OR (([IdEspecialidadDestino] IS NOT NULL AND [IdProcedimientoIntervencionDestino] IS NULL))
    )
);


ALTER TABLE [dbo].[ListaEspera_Interconsulta] ADD
CONSTRAINT FK_LE_INTERCONSULTA_PACIENTE FOREIGN KEY (NumeroPaciente)
REFERENCES [dbo].[PAC_Paciente]([PAC_PAC_Numero])

-- CONSTRAINT FK_LE_INTERCONSULTA_SISTEMAORIGEN FOREIGN KEY (IdSistemaOrigen)
-- REFERENCES [dbo].[ListaEspera_TAB_SistemaOrigen](Id)

-- CONSTRAINT FK_LE_INTERCONSULTA_ESPECIALIDADORIGEN FOREIGN KEY (IdEspecialidadOrigen)
-- REFERENCES [dbo].[PRLE_ESPECIALIDADES](Id),

-- CONSTRAINT FK_LE_INTERCONSULTA_POLICLINICOORIGEN FOREIGN KEY (CodigoPoliclinicoOrigen)
-- REFERENCES [dbo].[SER_Servicios]([SER_SER_Codigo]),

-- CONSTRAINT FK_LE_INTERCONSULTA_NOMINA FOREIGN KEY (NumeroFolioNominaOrigen)
-- REFERENCES [dbo].[AFC_Nomina]([NOM_Folio]),

-- CONSTRAINT FK_LE_INTERCONSULTA_ESTABLECIMIENTOORIGEN FOREIGN KEY (IdEstablecimientoOrigen)
-- REFERENCES [dbo].[ListaEspera_TAB_Establecimiento](Id),

-- CONSTRAINT FK_LE_INTERCONSULTA_ESTABLEDESTINO FOREIGN KEY (IdEstablecimientoDestino)
-- REFERENCES [dbo].[ListaEspera_TAB_Establecimiento](Id),

-- CONSTRAINT FK_LE_INTERCONSULTA_ESPECIALIDADDESTINO FOREIGN KEY (IdEspecialidadDestino)
-- REFERENCES [dbo].[PRLE_ESPECIALIDADES](Id),

-- CONSTRAINT FK_LE_INTERCONSULTA_DIAGNOSTICO FOREIGN KEY (IdDiagnostico)
-- REFERENCES [dbo].[ListaEspera_TAB_Diagnostico]([Id]),

-- CONSTRAINT FK_LE_INTERCONSULTA_ESTADODIAGNOSTICO FOREIGN KEY (IdEstadoDiagnostico)
-- REFERENCES [dbo].[ListaEspera_TAB_EstadoDiagnostico](Id)

-- CONSTRAINT FK_LE_INTERCONSULTA_MOTIVODERIVACION FOREIGN KEY (IdMotivoDerivacion)
-- REFERENCES [dbo].[ListaEspera_TAB_MotivoDerivacion](Id),

-- CONSTRAINT FK_LE_INTERCONSULTA_TIPOPRESTACION FOREIGN KEY (IdTipoPrestacion)
-- REFERENCES [dbo].[ListaEspera_TAB_TipoPrestacion](Id),

-- CONSTRAINT FK_LE_INTERCONSULTA_PRIORIDAD FOREIGN KEY (IdPrioridad)
-- -- REFERENCES [dbo].[ListaEspera_TAB_PrioridadCaso]([Id]),
-- REFERENCES [dbo].[TAB_FHIR_PrioridadSolicitud](Id),

-- CONSTRAINT FK_LE_INTERCONSULTA_USUARIO_PRIORIZADOR FOREIGN KEY (PrioritizedBy)
-- REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]),

-- CONSTRAINT FK_LE_INTERCONSULTA_CAUSASALIDA FOREIGN KEY (IdCausalSalida)
-- REFERENCES [dbo].[TAB_FHIR_MotivoCierreInterconsulta]([Id]),

-- CONSTRAINT FK_LE_INTERCONSULTA_MODALIDADATENCION FOREIGN KEY (IdModalidadAtencion)
-- REFERENCES [dbo].[ListaEspera_TAB_ModalidadAtencion]([Id]),

-- CONSTRAINT FK_LE_INTERCONSULTA_USUARIO FOREIGN KEY (CreatedBy)
-- REFERENCES [dbo].[Segu_Usuarios]([Segu_Usr_Cuenta]),

-- CONSTRAINT FK_LE_INTERCONSULTA_PROFESIONALORIGEN FOREIGN KEY ([RutProfesionalOrigen], [CodigoTipoProfesionalOrigen], [ProcedenciaProfesionalOrigen])
-- REFERENCES [dbo].[SER_Profesiona]([SER_PRO_Rut],[SER_PRO_Tipo],[SER_PRO_Procedencia])