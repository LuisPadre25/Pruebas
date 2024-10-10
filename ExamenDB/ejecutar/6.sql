/*
 6.	Escriba un procedimiento llamado actualizar_correos que permita crear un email para todos los clientes que ya existen en la tabla. (12a)
Procedimiento: actualizar_correos
Entrada: no hay
Proceso: Usar un cursor para que por cada registro de la tabla clientes se envíen los datos requeridos al procedimiento crear_correo, Posteriormente se debe actualizar el correo en la tabla clientes.
Manejo de errores: usarlo para controlar el cursor

•	Llamar el procedimiento, y tomar captura de lo que contiene la tabla clientes después
 */
create or alter procedure actualizar_correos
as
begin
    set nocount on;

    declare @identificacion char(12);
    declare @nombre varchar(50);
    declare @apellido1 varchar(50);
    declare @apellido2 varchar(50);
    declare @correo varchar(50);

    declare cliente_cursor cursor for
        select identificacion, nombre, apellido1, apellido2
        from clientes;

    begin try
        open cliente_cursor;

        fetch next from cliente_cursor into @identificacion, @nombre, @apellido1, @apellido2;

        while @@fetch_status = 0
            begin

                set @correo = null;

                exec crear_correo
                     @nombre = @nombre,
                     @apellido1 = @apellido1,
                     @apellido2 = @apellido2,
                     @correo = @correo output;


                update clientes
                set correo = @correo
                where identificacion = @identificacion;


                fetch next from cliente_cursor into @identificacion, @nombre, @apellido1, @apellido2;
            end

        close cliente_cursor;

        deallocate cliente_cursor;

        print 'actualizacion de correos completada exitosamente.';
    end try
    begin catch


        declare @errormessage nvarchar(4000);
        declare @errorseverity int;
        declare @errorstate int;

        select @errormessage = error_message(),
               @errorseverity = error_severity(),
               @errorstate = error_state();

        raiserror (@errormessage, @errorseverity, @errorstate);
    end catch
end
go