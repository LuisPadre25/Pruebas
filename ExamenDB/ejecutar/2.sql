-- 2. crear  tabla pagos
create table pagos
(
    id int identity primary key,
    fecha_hora datetime default getdate(),
    monto decimal,
    idgastos int,
    foreign key (idgastos) references gastos(idgastos)
);
go
