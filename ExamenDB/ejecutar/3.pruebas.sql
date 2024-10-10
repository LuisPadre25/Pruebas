-- insercion 1
insert into gastos(idgastos, idservicios, fecha, cantidad, precio)
values (5, 2, '2022-08-11 11:30', 3, 25);

-- insercion 2
insert into gastos(idgastos, idservicios, fecha, cantidad, precio)
values (7, 3, '2022-08-08 11:30', 10, 12);

-- verificar pagos
select *
from pagos;

