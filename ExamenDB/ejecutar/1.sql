/* 1. 1.	Crear un procedimiento llamado reserva con las siguientes características.

a)	El procedimiento recibe como parámetros de entrada: idreserva, nombre de cliente, numhabitacion, fechaentrada
b)	Mostrará un mensaje con el tipo de error que detecte, o un mensaje de éxito en otro caso ( 3 aciertos)

El procedimiento realiza los siguientes pasos:

a)	Inicia una transacción. (1 acierto)
b)	Busca la clave del cliente de acuerdo con el nombre recibido como entrada (1 acierto)
c)	Calcula la fecha de salida, la cual serán 3 días después de la fecha de entrada, usando la función de SQL:
DATE_ADD(fecha ,INTERVAL numdias DAY); (1 acierto)
d)	Inserta un registro en la tabla reserva_habitac poniendo como IVA el valor: 0.16 ( 2 aciertos)
e)	Inserta un registro también en gastos con los valores: (3 aciertos)
o	Calcula a través de una función el número de gasto que sigue (3 aciertos – 1 acierto de llamada)
o Con el servicio “COMEDOR”, para esto con otro procedimiento recupera el idservicio y el precio (3 aciertos– 1 acierto de llamada)
o	La fecha del gasto corresponde a un día después de que se hace la reservación
o	La cantidad será 2
o	El id de reserva se toma del recibido como parámetro inicialmente
f)	Comprueba si ha ocurrido algún error en las operaciones anteriores. Si no ocurre ningún error entonces aplica un COMMIT a la transacción y si ha ocurrido algún error aplica un ROLLBACK.

Deberá manejar los siguientes errores que puedan ocurrir durante el proceso.

•	ERROR 1048 (El cliente no existe)
•	ERROR 1062 (Llave primaria duplicada)

Probar con los siguientes valores e indicar al lado el resultado mostrado en tu procedimiento: (4 aciertos)

call reserva(1,”Felipe”, 106, ‘2022/07/15’); call reserva(10,”Felipe”, 106, ‘2022/07/15’); call reserva(12,"Juan", 106, ‘2022/07/15’); call reserva(15,"Luis", 101, ‘2022/07/10’);

   */

create or alter procedure reserva @idreserva int,
                                  @nombre_cliente char(12),
                                  @numhabitacion int,
                                  @fechaentrada date
as
begin
    set nocount on;
    begin try
        -- a) Inicia una transacción
        begin transaction;

        -- b) Busca la clave del cliente de acuerdo con el nombre recibido como entrada
        declare @identificacion char(12);
        select @identificacion = identificacion
        from clientes
        where nombre = @nombre_cliente;

        -- Si el cliente no existe, lanza el error 1048
        if @identificacion is null
            begin
                raiserror ('error 1048: El cliente "%s" no existe.', 16, 1, @nombre_cliente);
                rollback transaction;
                return;
            end

        -- c) Calcula la fecha de salida, 3 días después de la fecha de entrada
        declare @fechasalida date;
        set @fechasalida = dateadd(day, 3, @fechaentrada);

        -- d) Inserta en la tabla reserva_habitac
        insert into reserva_habitac (idreserva, identificacion, numhabitacion, fechaentrada, fechasalida, iva)
        values (@idreserva, @identificacion, @numhabitacion, @fechaentrada, @fechasalida, 0.16);

        -- e) Inserta en la tabla gastos
        declare @idservicio int;
        declare @precio decimal(18, 2);
        declare @idgasto int;

        -- Obtener el siguiente número de gasto a través de la función
        set @idgasto = dbo.obtener_siguiente_gasto();

        -- Recuperar el id del servicio y el precio del servicio 'COMEDOR'
        exec obtener_servicio 'COMEDOR', @idservicio output, @precio output;

        -- Verifica si obtener_servicio lanzó un error
        if @idservicio is null
            begin
                raiserror ('error: El servicio "COMEDOR" no se encontró.', 16, 1);
                rollback transaction;
                return;
            end

        -- Fecha del gasto: un día después de la reservación
        declare @fechagasto date;
        set @fechagasto = dateadd(day, 1, @fechaentrada);

        -- Insertar en la tabla gastos
        insert into gastos (idgastos, idservicios, idreserva, fecha, cantidad, precio)
        values (@idgasto, @idservicio, @idreserva, @fechagasto, 2, @precio);

        -- f) Si todo está bien, hacer commit
        commit transaction;
        print 'reserva realizada exitosamente. id de reserva: ' + cast(@idreserva as varchar);

    end try
    begin catch
        -- Manejo de errores y rollback
        if xact_state() <> 0
            begin
                rollback transaction;
            end

        -- Obtener el error y mostrar mensaje adecuado
        declare @errormessage nvarchar(4000) = error_message();
        declare @errornumber int = error_number();

        if @errornumber = 2627 -- Llave primaria duplicada
            begin
                raiserror ('error 1062: La reserva con id "%d" ya existe.', 16, 1, @idreserva);
            end
        else
            begin
                raiserror (@errormessage, 16, 1);
            end
    end catch
end
go



--sp para calcular el siguiente id de gastos
create or alter function obtener_siguiente_gasto()
    returns int
as
begin
    declare @siguiente_id int;
    select @siguiente_id = isnull(max(idgastos), 0) + 1
    from gastos;
    return @siguiente_id;
end
go


--sp para recuperar el idservicio y el precio
create or alter procedure obtener_servicio @servicio varchar(50),
                                           @idservicio int output,
                                           @precio decimal(18, 2) output
as
begin
    set nocount on;

    select @idservicio = idservicios,
           @precio = precio
    from servicios
    where nombreservicio = @servicio;

    if @idservicio is null
        begin
            raiserror ('error: servicio "%s" no encontrado.', 16, 1, @servicio);
        end
end
go

----
EXEC reserva @idreserva = 10, @nombre_cliente = 'Felipe', @numhabitacion = 106, @fechaentrada = '2022-07-15';
-----------------
