CREATE OR ALTER PROCEDURE [dbo].[API_TEIM_RegistrarErrorMensajeSalidaInterconsulta]
    @IdMensajeSalidaInterconsulta UNIQUEIDENTIFIER,
    @ErrorJSON VARCHAR(MAX)
AS
BEGIN
    IF NOT EXISTS (SELECT TOP(1) 1 FROM [dbo].[FHIR_MensajeSalidaInterconsulta] WHERE Id = @IdMensajeSalidaInterconsulta) BEGIN
        RAISERROR('El mensaje de salida de interconsulta no existe', 16, 1)
        RETURN 1;
    END


    DECLARE @idEstadoActual TINYINT = (
        SELECT TOP (1) IdEstadoMensajeSalida FROM [dbo].[FHIR_MensajeSalidaInterconsulta] WHERE Id = @IdMensajeSalidaInterconsulta
    );

    IF @idEstadoActual = 4 BEGIN
        RAISERROR('El mensaje de salida de interconsulta ya fue marcado como no enviado.', 16, 1)
        RETURN 1;
    END

    IF @idEstadoActual = 3 BEGIN
        RAISERROR('El mensaje de salida de interconsulta ya fue enviado.', 16, 1)
        RETURN 1;
    END

    IF @idEstadoActual = 1 BEGIN
        RAISERROR('El mensaje de salida de interconsulta no está siendo procesado.', 16, 1)
        RETURN 1;
    END

    DECLARE @cantidadErrores int = (
        SELECT COUNT(1) FROM FHIR_ErrorMensajeSalidaInterconsulta WHERE IdMensajeSalida = @IdMensajeSalidaInterconsulta
    );

    IF @cantidadErrores >= 3 BEGIN
        UPDATE TOP(1) [dbo].[FHIR_MensajeSalidaInterconsulta]
        SET
            IdEstadoMensajeSalida = 4
        WHERE Id = @IdMensajeSalidaInterconsulta
    END
    ELSE
    BEGIN
        UPDATE TOP(1) [dbo].[FHIR_MensajeSalidaInterconsulta]
        SET
            IdEstadoMensajeSalida = 1
        WHERE Id = @IdMensajeSalidaInterconsulta
    END

    INSERT INTO [dbo].[FHIR_ErrorMensajeSalidaInterconsulta] (IdMensajeSalida, ErrorJSON)
    VALUES (@IdMensajeSalidaInterconsulta, @ErrorJSON)
END