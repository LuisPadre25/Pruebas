


declare @correo_generado varchar(50);

exec crear_correo
     @nombre = 'luis',
     @apellido1 = 'padre',
     @apellido2 = 'garcia',
     @correo = @correo_generado output;
print @correo_generado

