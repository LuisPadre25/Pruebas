/*
 5.	Escribir un procedimiento llamado crear_correo que dados los parámetros de entrada: nombre, apellido1, apellido2, cree una dirección de correo y la devuelva como salida. (3a)
•	Procedimiento: crear_correo
•	Entrada:
o	nombre (cadena de caracteres)
o	apellido1 (cadena de caracteres)
o	apellido2 (cadena de caracteres)
•	Salida:
o	correo (cadena de caracteres)
La dirección de correo electrónico devuelta tendrá el siguiente formato:
•	El primer carácter del parámetro nombre.
•	Los tres primeros caracteres del parámetro apellido1.
•	Los tres primeros caracteres del parámetro apellido2.
•	El carácter @.
•	El dominio: gmail.com pasado como parámetro.

TIP: usar las funciones de SQL: CONCAT (cadenas separadas por comas de lo que se quiere concatenar) y
LEFT (cadena, num caracteres a extraer)

 */
create procedure crear_correo @nombre varchar(50),
                              @apellido1 varchar(50),
                              @apellido2 varchar(50),
                              @dominio varchar(50) = 'gmail.com',
                              @correo varchar(50) output
as
begin
    set nocount on;

    set @correo = concat(
            left(@nombre, 1),
            left(@apellido1, 3),
            left(@apellido2, 3),
            '@',
            @dominio
                  );
    print @correo
    if @correo is null
        begin
            set @correo = concat(
                    left(isnull(@nombre, ''), 1),
                    left(isnull(@apellido1, ''), 3),
                    left(isnull(@apellido2, ''), 3),
                    '@',
                    @dominio
                          );
        end
end
go
