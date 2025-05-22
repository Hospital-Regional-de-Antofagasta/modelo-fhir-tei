CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_ObtenerMensajeSalidaInterconsultaPendientes]
    @IdTipoEvento TINYINT,
    @CantidadMaximaMensajes INT = 100
AS
BEGIN
    IF NOT EXISTS (SELECT TOP (1) 1 FROM [dbo].[TAB_FHIR_TipoEventoInterconsulta] WHERE Id = @IdTipoEvento) BEGIN
        RAISERROR('El tipo de evento no existe.', 16, 1)
        RETURN 1
    END

    IF (@CantidadMaximaMensajes IS NULL) BEGIN
        SET @CantidadMaximaMensajes = 100
    END

    IF (@CantidadMaximaMensajes <= 0) BEGIN
        RAISERROR('La cantidad de mensajes a obtener debe ser mayor a 0.', 16, 1)
        RETURN 1
    END

    IF (@CantidadMaximaMensajes > 100) BEGIN
        RAISERROR('La cantidad de mensajes a obtener debe ser menor o igual a 100.', 16, 1)
        RETURN 1
    END

    SELECT TOP(@CantidadMaximaMensajes)
        ms.[Id] AS 'id',
        ms.[IdEventoTributacion] AS 'id_evento_tributacion',
        ms.[IdEstadoMensajeSalida] AS 'id_estado_mensaje_salida',
        ms.[IdDestinoMensajeSalida] AS 'id_destino_mensaje_salida',
        ms.[MensajeJSON] AS 'mensaje_json',
        ms.[CreatedAt] AS 'created_at'
    FROM [dbo].[FHIR_MensajeSalidaInterconsulta] ms
        JOIN [dbo].[TAB_FHIR_DestinoMensajeSalidaInterconsulta] dms
            ON ms.[IdDestinoMensajeSalida] = dms.[Id]
        JOIN [dbo].[TAB_FHIR_EstadoMensajeSalidaInterconsulta] ems
            ON ms.[IdEstadoMensajeSalida] = ems.[Id]
        JOIN [dbo].[FHIR_EventoTributacionInterconsulta] et
            ON ms.[IdEventoTributacion] = et.[Id]
    WHERE 
        et.[IdTipoEvento] = @IdTipoEvento
        AND (NOT EXISTS (
            SELECT 1
            FROM [dbo].[FHIR_EventoTributacionInterconsulta] anterior
                JOIN [dbo].[FHIR_MensajeSalidaInterconsulta] ms_anterior
                    ON ms_anterior.[IdEventoTributacion] = anterior.[Id]
                    AND ms_anterior.[Id] <> ms.[Id]
            WHERE
                anterior.[IdInterconsulta] = et.[IdInterconsulta]
                AND anterior.[OrdenEnvio] < et.[OrdenEnvio]
                AND ms_anterior.[IdEstadoMensajeSalida] <> 3
            )
        );        
END