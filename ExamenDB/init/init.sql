--drop database padre;
--use master
create database padre;
go


use padre;
go

create table paises
(
    pais char(20) primary key
);

create table clientes
(
    identificacion char(12) primary key,
    pais           char(20),
    nombre         char(12),
    apellido1      char(12),
    apellido2      char(12),
    direccion      char(30),
    telefono       char(12),
    observaciones  char(50),
    foreign key (pais) references paises (pais)
);

create table tipo_habitacion
(
    categoria int identity primary key,
    camas     int,
    exterior  char(2),
    salon     char(2),
    terraza   char(2)
);

create table habitaciones
(
    numhabitacion int  primary key,
    categoria     int,
    foreign key (categoria) references tipo_habitacion (categoria)
);

create table temporada
(
    temporada   int identity primary key,
    fechainicio date,
    fechafinal  date,
    tipo        char
);

create table precio_habitacion
(
    idprecio  int identity primary key,
    categoria int,
    temporada int,
    precio    decimal,
    foreign key (categoria) references tipo_habitacion (categoria),
    foreign key (temporada) references temporada (temporada)
);

create table reserva_habitac
(
    idreserva      int primary key,
    identificacion char(12),
    numhabitacion  int,
    fechaentrada   date,
    fechasalida    date,
    iva            decimal,
    foreign key (identificacion) references clientes (identificacion),
    foreign key (numhabitacion) references habitaciones (numhabitacion)
);

create table tipo_servicio
(
    nombreservicio char(10) primary key
);

create table servicios
(
    idservicios    int identity primary key,
    nombreservicio char(10),
    descripcion    char(30),
    precio         decimal,
    fecha          date,
    foreign key (nombreservicio) references tipo_servicio (nombreservicio)
);

create table gastos
(
    idgastos    int primary key,
    idservicios int,
    idreserva   int,
    fecha       date,
    cantidad    int,
    precio      decimal,
    foreign key (idservicios) references servicios (idservicios),
    foreign key (idreserva) references reserva_habitac (idreserva)
);

