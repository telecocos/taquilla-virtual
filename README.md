# Servicio de Taquilla Virtual
Proyecto de la asignatura Sistemas de Información de Teleco en la Universidade de Vigo.

Base de datos para gestionar la venta de entradas para eventos de todo tipo. El proyecto está compuesto por una base de datos MySQL que almacena toda la información relativa a los eventos, los clientes y sus compras, y una API REST implementada con NodeJS. El despliegue del servicio se realiza mediante Docker Compose, creando de esta manera un contenedor para la BD y otro para la API.

## Base de datos
La base de datos está definida en el archivo `mysql/BDTaquillaVirtual.sql`, el cual crea la estructura de la BD y la inicializa con datos de ejemplo. En el <a href="mysql/README.md" README de la BD> hay más información sobre su funcionamiento.

## API REST:

La API REST permite interactuar con la base de datos mediante peticiones HTTP. Su código fuente está en la carpeta `node/taquillavirutal-api`. En el <a href="node/README.md" README del Node> hay más información sobre su funcionamiento.

## Despliegue:
Ejecutar `$ docker-compose build` y después `$docker-compose up`. Una vez inicializados los contenedores, se puede acceder a la API en el puerto 2080.

## Mejoras pendientes:
<ul>
<li>Mecanismo de autenticación para las compras, altas de clientes y tareas administrativas
<li>Guardar las credenciales de acceso a la BD de forma segura (ahora mismo están en texto plano en el código)
<li>Conexión HTTPS con la API
<li>Cliente en Angular o PHP
</ul>

## Autores:
<ul>
<li>Andrés Álvarez López: <a href="https://github.com/andresallo">@andresallo</a>
<li>Diego Araújo Novoa: <a href="https://github.com/diegoara96">@diegoara96</a>
<li>Guillermo Barreiro Fernández: <a href="https://github.com/gbarreiro">@gbarreiro</a>
<li>Shaila Calvo Almeida: <a href="https://github.com/shaic98">@shaic98</a>
</ul>
