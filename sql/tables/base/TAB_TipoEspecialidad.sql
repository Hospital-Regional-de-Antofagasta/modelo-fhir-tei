/* 201 */
CREATE TABLE [dbo].[TAB_TipoEspecialidad](
	[ID_TipoEsp] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[Vigente] [bit] NOT NULL,
    CONSTRAINT [PK_TipoEspec] PRIMARY KEY (ID_TipoEsp)
)

ALTER TABLE [dbo].[TAB_TipoEspecialidad] ADD  DEFAULT ((1)) FOR [Vigente]

INSERT INTO [dbo].[TAB_TipoEspecialidad] (Descripcion) VALUES
('Especialidades Médicas'),
('Especialidades Odontológicas');
