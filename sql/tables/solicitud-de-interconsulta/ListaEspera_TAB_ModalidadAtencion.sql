/* 50 */
CREATE TABLE [dbo].[ListaEspera_TAB_ModalidadAtencion]
(
    [Id] [bigint] NOT NULL PRIMARY KEY IDENTITY,
    CodigoFHIR varchar(10) NOT NULL,
    Texto varchar(100),
    Vigencia BIT NOT NULL DEFAULT 1
);


INSERT INTO [dbo].[ListaEspera_TAB_ModalidadAtencion]
    (CodigoFHIR, Texto)
VALUES
('11', 'Presencial'),
('22', 'Virtual'),
('33', 'Ambos');