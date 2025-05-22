/* 50 */
CREATE TABLE [dbo].[ListaEspera_TAB_ModalidadAtencion](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Codigo] [int] NOT NULL,
	[Texto] [varchar](100) NOT NULL,
	[Vigencia] [bit] NOT NULL,
	[CreatedBy] [varchar](10) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[CodigoFHIR] [varchar](10) NULL,
    CONSTRAINT [PK_LE_MODALIDADATENCION] PRIMARY KEY ([Id])
);

ALTER TABLE [dbo].[ListaEspera_TAB_ModalidadAtencion] ADD DEFAULT ((1)) FOR [Vigencia]

ALTER TABLE [dbo].[ListaEspera_TAB_ModalidadAtencion] ADD DEFAULT (suser_name()) FOR [CreatedBy]

ALTER TABLE [dbo].[ListaEspera_TAB_ModalidadAtencion] ADD DEFAULT (getdate()) FOR [CreatedAt]

ALTER TABLE [dbo].[ListaEspera_TAB_ModalidadAtencion] WITH CHECK ADD  CONSTRAINT [FK_LE_MODALIDADATENCION_USUARIO] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Segu_Usuarios] ([Segu_Usr_Cuenta])

ALTER TABLE [dbo].[ListaEspera_TAB_ModalidadAtencion] CHECK CONSTRAINT [FK_LE_MODALIDADATENCION_USUARIO]

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código de la modalidad de atención.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_ModalidadAtencion', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre de la modaldiad de atención.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_ModalidadAtencion', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'ListaEspera_TAB_ModalidadAtencion', @value=N'Esta tabla almacena las modalidades de atención por las cuales se resolvió un caso de lista de espera.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_ModalidadAtencion'



INSERT INTO [dbo].[ListaEspera_TAB_ModalidadAtencion]
    (Codigo, Texto, CodigoFHIR)
VALUES
('1', 'Presencial (institucional)', '1'),
('2', 'Telemedicina', '3'),
('3', 'Salud digital', NULL),
('4', 'PRAPS', NULL),
('5', 'Convenio FONASA, GORE', NULL),
('6', 'MLE', NULL),
('20', 'Remota', '2');