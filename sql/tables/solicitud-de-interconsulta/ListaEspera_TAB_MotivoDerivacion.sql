/* 200 */
CREATE TABLE [dbo].[ListaEspera_TAB_MotivoDerivacion](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Codigo] [int] NOT NULL,
	[Texto] [varchar](100) NOT NULL,
	[Vigencia] [bit] NOT NULL,
	[CreatedBy] [varchar](10) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[CodigoFHIR] [varchar](10) NULL,
    CONSTRAINT [PK_MOTIVODERIVACION] PRIMARY KEY ([Id])
);

ALTER TABLE [dbo].[ListaEspera_TAB_MotivoDerivacion] ADD  DEFAULT ((1)) FOR [Vigencia]

ALTER TABLE [dbo].[ListaEspera_TAB_MotivoDerivacion] ADD  DEFAULT (suser_name()) FOR [CreatedBy]

ALTER TABLE [dbo].[ListaEspera_TAB_MotivoDerivacion] ADD  DEFAULT (getdate()) FOR [CreatedAt]

ALTER TABLE [dbo].[ListaEspera_TAB_MotivoDerivacion]  WITH CHECK ADD  CONSTRAINT [FK_MOTIVODERIVACION_USUARIO] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Segu_Usuarios] ([Segu_Usr_Cuenta])

ALTER TABLE [dbo].[ListaEspera_TAB_MotivoDerivacion] CHECK CONSTRAINT [FK_MOTIVODERIVACION_USUARIO]

EXEC sys.sp_addextendedproperty @name=N'Codigo', @value=N'Código del estado del motivo.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_MotivoDerivacion', @level2type=N'COLUMN',@level2name=N'Codigo'

EXEC sys.sp_addextendedproperty @name=N'Texto', @value=N'Nombre del motivo de derivación.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_MotivoDerivacion', @level2type=N'COLUMN',@level2name=N'Texto'

EXEC sys.sp_addextendedproperty @name=N'ListaEspera_TAB_MotivoDerivacion', @value=N'Esta tabla almacena los motivos de derivación de una Interconsulta.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ListaEspera_TAB_MotivoDerivacion'


INSERT INTO [dbo].[ListaEspera_TAB_MotivoDerivacion] ([Codigo], [Texto], [CodigoFHIR]) VALUES
('1', 'Confirmación Diagnóstica', '1'),
('2', 'Control Especialista', '2'),
('3', 'Realizar Tratamiento', '3'),
('4', 'Seguimiento', '4'),
('5', 'Otro', '5');