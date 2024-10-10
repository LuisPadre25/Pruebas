/*
 3.	Escribir un trigger que nos permita llevar un control de los pagos que van realizando los clientes. Los detalles de implementación son los siguientes: (5a)
•	Nombre: trigger_pago
•	Se ejecuta sobre la tabla gastos.
•	Se ejecuta después de hacer la inserción de un gasto.
•	Cada vez que un cliente contrate un servicio (es decir, se hace una inserción en la tabla gastos), el trigger deberá insertar un nuevo registro en una tabla llamada pagos, para esto se debe multiplicar el precio por la cantidad del gasto y ese será el monto del pago
•	Probarlo con los siguientes Insert y tomar captura de lo que contiene después de los insert la tabla pagos

 */

create trigger trigger_pago
    on gastos
    after insert
    as
begin
    set nocount on;

    insert into pagos (monto, idgastos)
    select (i.cantidad * i.precio) as monto, i.idgastos
    from inserted i;
end
go


