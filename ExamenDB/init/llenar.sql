
INSERT INTO paises (pais)
VALUES ('México'),
       ('Perú'),
       ('Chile');


INSERT INTO clientes (identificacion, pais, nombre, apellido1, apellido2, direccion, telefono, observaciones)
VALUES ('ID001', 'México', 'Jose', 'Padre', 'Garcia', 'Calle 1', '5551234', ''),
       ('ID003', 'Chile', 'Juan', 'Padre', 'Garcia', 'Calle 13', '5559012', ''),
       ('ID004', 'Chile', 'Felipe', 'Ramírez', 'Lopez', 'Calle 4', '5553456', '');



--SET IDENTITY_INSERT habitaciones ON;
--SET IDENTITY_INSERT gastos ON;

INSERT INTO tipo_habitacion (camas, exterior, salon, terraza)
VALUES (1, 'No', 'No', 'No'),
       (2, 'No', 'Sí', 'No'),
       (3, 'Sí', 'Sí', 'Sí');


INSERT INTO habitaciones (numhabitacion, categoria)
VALUES (101, 1),
       (106, 2);


INSERT INTO tipo_servicio (nombreservicio)
VALUES ('COMEDOR'),
       ('SPA'),
       ('GIMNASIO');


INSERT INTO servicios (nombreservicio, descripcion, precio, fecha)
VALUES ('COMEDOR', 'Servicio de comedor', 50.00, '2024-07-01'),
       ('SPA', 'Acceso al spa', 30.00, '2024-07-01'),
       ('GIMNASIO', 'Acceso al gimnasio', 20.00, '2024-07-01');
