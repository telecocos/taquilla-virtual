# API REST
La API REST permite interactuar con la base de datos mediante peticiones HTTP. Está implementada en Node, usando el framework Express.

## Estructura del proyecto Node:
* `package.json`: información sobre el proyecto Node
* `api.json`: Punto de entrada del proyecto. Referencia a las dependencias (express, body-parser), el archivo en el que definimos los endpoints (`routes/routes.js`) y el puerto local dentro del contenedor (el 80).
* `data/config.json`: configura la conexión con la BD MySQL
* `routes/routes.js`: define los endpoints de la API mediante un Router

## Endpoints:
Los endpoints de la API están definidos en `taquilla-virtual-api/routes/routes.js`, y se corresponden con un procedimiento almacenado de la BD (consultar su README para más información).

### Añadir:
* `POST /recintos`: añade un nuevo Recinto (`add_recinto()`). 
    - BODY: `nombre`,`tipo`,`direccion`,`ciudad`.
* `POST /espectaculos`: añade un nuevo Espectáculo (`add_espectaculo()`). 
    - BODY: `nombre`, `descripcion`.
* `POST /eventos`: añade un nuevo Evento (`add_evento()`). 
    - BODY: `id_espectaculo`,`id_recinto`,`fecha`,`estado`, `t1`,`t2`,`t3`,`aforo_bebe`, `aforo_parado`,`aforo_jubilado`,`aforo_adulto`,`aforo_infantil`,`max_pre_cliente`,`max_compra_cliente`.
* `POST /espectaculos/:espectaculo/participantes`: añade un nuevo Participante al Espectáculo `:espectaculo` (`add_participante()`). 
    - BODY: `nombre`,`primer_apellido`,`segundo_apellido`.
* `POST /eventos/:evento/gradas`: añade una nueva Grada al Evento `:evento` (`add_grada()`). 
    - BODY: `nombre`,`precio_bebe`,`precio_parado`,`precio_jubilado`,`precio_adulto`,`precio_infantil`.
* `POST /eventos/:evento/gradas/:grada/localidades/:localidad`: añade una Localidad a la Grada `:grada`del Evento `:evento` (`add_localidad()`). 
    - BODY: `estado`.   

### Consultar:
* `GET /eventos`: devuelve todos los Eventos (`consultar_eventos()`). Se puede filtrar la búsqueda con las siguientes query strings: `fecha_inicio`, `fecha_final`, `id_recinto`, `ciudad`, `tipo_usuario`.
* `GET /eventos/:evento`: devuelve la información sobre el Evento `:evento` (`consultar_evento()`).
* `GET /eventos/:evento/gradas`: devuelve las Gradas disponibles para el Evento `:evento`. (`consultar_gradas()`).
* `GET /eventos/:evento/gradas/:grada/localidades`: devuelve las Localidades disponibles para la Grada `:grada` del Evento `:evento` (`consultar_localidades()`).
* `GET /eventos/:evento/gradas/:grada/precios`: devuelve los precios para los 5 Tipos de Usuario del Evento `:evento` en la Grada `:grada` (`consultar_precios()`)
* `GET /eventos/:evento/gradas/:grada/precios/:usuario`: devuelve el precio que pagaría el Tipo de Usuario `:usuario` por asistir al Evento `:evento` en la Grada `:grada` (`consultar_precio()`).
* `GET /eventos/:evento/asistencia`: devuelve los Tipos de Usuario que pueden asistir al Evento `:evento` y el aforo para cada Tipo de Usuario (`consultar_asistencia()`).
* `GET /eventos/:evento/asistencia/:usuario`: para el Evento `:evento` y el Tipo de Usuario `:usuario`, devuelve -1 si dicho Tipo de Usuario no puede asistir al Evento, o el aforo disponible si su asistencia sí que está permitida.

### Operaciones de compra:
* `POST /clientes`: registra a un Cliente (`registrar_cliente()`):
    - BODY: `dni`,`nombre`,`primer_apellido`,`segundo_apellido`, `cuenta_bancaria`.
* `POST /clientes/:cliente/compras/comprar`: registra la Compra del Cliente `:cliente` de una Localidad de un Evento para un Tipo de Usuario (`comprar()`):
    - BODY: `id_evento`,`id_grada`,`id_localidad`, `tipo_usuario`.
* `POST /clientes/:cliente/compras/prerreservar`: registra la Prerreserva del Cliente `:cliente` de una Localidad de un Evento para un Tipo de Usuario (`prerreservar()`):
    - BODY: `id_evento`,`id_grada`,`id_localidad`, `tipo_usuario`.
* `DELETE /clientes/:cliente/compras/:compra`: anula la Compra o Prerreserva del Cliente `:cliente` con ID `:compra` (`anular()`)