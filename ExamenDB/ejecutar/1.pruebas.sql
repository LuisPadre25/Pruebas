-- Prueba 1: reserva realizada exitosamente
exec reserva @idreserva = 1, @nombre_cliente = 'Felipe', @numhabitacion = 106, @fechaentrada = '2022-07-15';

-- Prueba 2: cliente existente, reserva con id duplicado
exec reserva @idreserva = 10, @nombre_cliente = 'Felipe', @numhabitacion = 106, @fechaentrada = '2022-07-15';

-- Prueba 3: reserva realizada exitosamente
exec reserva @idreserva = 12, @nombre_cliente = 'Juan', @numhabitacion = 106, @fechaentrada = '2022-07-15';

-- prueba 4: Cliente inexistente
exec reserva @idreserva = 15, @nombre_cliente = 'Luis', @numhabitacion = 101, @fechaentrada = '2022-07-10';
