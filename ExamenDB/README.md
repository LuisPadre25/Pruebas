# Proyecto ExamenGS

Este proyecto utiliza una base de datos SQL Server que debe ser inicializada y poblada utilizando Docker y una serie de scripts SQL. A continuación, se describen los pasos para ejecutar el entorno y los scripts necesarios para completar las tareas del examen.

## Requisitos

- Docker
- Docker Compose
- Un gestor de bases de datos compatible con SQL Server, como Azure Data Studio o SQL Server Management Studio (SSMS).

## Instrucciones

### 1. Configuración y Ejecución del Docker Compose

El proyecto incluye un archivo `docker-compose.yml` que define un servicio para SQL Server. Este archivo utiliza la versión más reciente de SQL Server 2019 con las siguientes credenciales de acceso:

- **Usuario**: `sa`
- **Contraseña**: `10Universe10==`

Para poner en marcha el entorno de base de datos, sigue estos pasos:

1. Abre una terminal y navega al directorio donde se encuentra el archivo `docker-compose.yml`.

2. Ejecuta el siguiente comando:

   ```bash
   docker-compose up -d
   ```

Este comando hará lo siguiente:

- Levantará un contenedor con SQL Server.
- Expondrá el puerto `1433` para conectarte al servidor desde el host.
- Ejecutará los scripts iniciales definidos en el volumen `./init` dentro del contenedor.

### 2. Conexión a un Gestor de Base de Datos

Una vez que el contenedor esté en funcionamiento, deberás conectarte a la base de datos utilizando un gestor de base de datos como Azure Data Studio o SQL Server Management Studio (SSMS).

Para conectarte, usa las siguientes credenciales:

- **Servidor**: `localhost,1433`
- **Usuario**: `sa`
- **Contraseña**: `10Universe10==`

### 3. Ejecución de los Scripts

Conéctate al servidor utilizando el gestor de base de datos, y luego procede a ejecutar los scripts SQL para inicializar y llenar la base de datos.

1. En la carpeta `ExamenDB/init` encontrarás los siguientes scripts:
    - **`init.sql`**: Este script configura la estructura inicial de la base de datos.
    - **`llenar.sql`**: Este script inserta los datos iniciales necesarios para realizar las pruebas.

Ejecuta estos scripts en el siguiente orden:

**Inicializar la Base de Datos**
Ejecuta el script `init.sql` que configura la estructura inicial de la base de datos:

**Llenado de Datos**
Una vez que la base de datos esté inicializada, procede con la inserción de datos utilizando el script `llenar.sql`:



### 4. Ejecución de Scripts de Pruebas

En la carpeta `ExamenDB/ejecutar` encontrarás los scripts de pruebas que deben ejecutarse en orden para verificar la funcionalidad.

1. **Ejecutar el script principal (`1.sql`)**
2. **Ejecutar las pruebas correspondientes (`1.pruebas.sql`)**:

1. **Ejecutar las pruebas correspondientes (`1.pruebas.sql`)**:


#### Ejecución Secuencial:

Sigue este mismo proceso con los demás scripts secuenciales (2.sql, 2.pruebas.sql, 3.sql, etc.). Cada script debe ejecutarse en el siguiente orden:

- `1.sql` y `1.pruebas.sql`
- `2.sql` y `2.pruebas.sql`
- Y así sucesivamente hasta `6.sql` y `6.pruebas.sql`

### 5. Resultados

Una vez ejecutados todos los scripts, podrás verificar que las pruebas han pasado correctamente utilizando el gestor de base de datos para inspeccionar los resultados

## Notas Adicionales

- Recuerda que debes estar conectado al contenedor de Docker para ejecutar estos comandos
- Recuerda usar la base de datos padre