# Aplicación  

Una aplicación basada en React que permite a los usuarios realizar operaciones de Crear, Leer, Actualizar y Eliminar (CRUD). La aplicación se comunica con la API de [JSONPlaceholder](https://jsonplaceholder.typicode.com/) para la obtención y manipulación de datos. Además, está containerizada usando Docker y servida a través de Nginx para entornos de producción.

## Funcionalidades

- **Crear Publicaciones:** Añade nuevas publicaciones de blog con un título y contenido.
- **Leer Publicaciones:** Visualiza una lista de todas las publicaciones de blog.
- **Actualizar Publicaciones:** Edita publicaciones de blog existentes.
- **Eliminar Publicaciones:** Elimina publicaciones de blog.
- **Búsqueda:** Busca publicaciones por título.
- **Paginación:** Navega a través de las publicaciones con controles de paginación.
- **Diseño Responsivo:** Optimizado para diferentes tamaños de pantalla utilizando Ant Design.
- **Manejo de Errores:** Maneja errores de la API de manera eficiente actualizando el estado local.
- **Dockerizada:** Fácilmente desplegable usando Docker y Nginx.

## Instalación

### Usando npm



1. **Instalar Dependencias:**

   ```bash
   npm install
   ```

2. **Ejecutar la Aplicación en Modo Desarrollo:**

   ```bash
   npm run start
   ```

   La aplicación estará disponible en http://localhost:3000.

### Usando Docker

1. **Asegurarse de Tener Docker y Docker Compose Instalados:**

    - Instalar Docker
    - Instalar Docker Compose

2. **Construir y Ejecutar el Contenedor con Docker Compose:**

   Asegúrate de estar en el directorio raíz del proyecto donde se encuentra el archivo `docker-compose.yml`.

   ```bash
   docker-compose up --build -d
   ```

3. **Acceder a la Aplicación:**

   Abre tu navegador y navega a http://localhost.

4. **Detener el Contenedor Docker:**

   ```bash
   docker-compose down
   ```



## Tecnologías Utilizadas

- **React:** Biblioteca de javascript para construir interfaces de usuario.
- **Ant Design:** Librería de componentes UI para React.
- **Axios:** Cliente para solicitudes al servicio de jsonplaceholder.typicode.com.
- **Context API:** Para la gestión del estado global de la aplicación.
- **Docker:** Plataforma de containerización para empaquetar la aplicación.
- **Nginx:** Servidor web de alto rendimiento utilizado para servir la aplicación construida.
- **JSONPlaceholder API:** API REST falsa para pruebas y prototipos.

