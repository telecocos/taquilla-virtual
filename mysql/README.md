# Base de datos MySQL
La base de datos almacena la siguiente información:

* <b>Eventos: </b>Un <b>Evento</b> es un <b>Espectáculo</b> celebrado en un <b>Recinto</b>. Cada <b>Evento</b> divide el <b>Recinto</b> en una o varias <b>Gradas</b>, las cuales están compuestas por <b>Localidades</b>. Un <b>Espectáculo</b> puede tener 1 o varios <b>Participantes</b>. Cada <b>Evento</b> fija un precio y un aforo para cada <b>Tipo de usuario:</b> Bebé, Infantil, Adulto, Parado y Jubilado.
* <b>Clientes: </b>Realizan <b>Compras</b> de entradas para <b>Eventos</b>.

## Modelo Entidad-Asociación:
<img src="doc/modelo-ea.jpg"/>

## Modelo Lógico-Relacional:
<img src="doc/modelo-relacional.jpg"/>

## Procedimientos almacenados (procedures):
Toda la funcionalidad de la base de datos se implementa a través de una serie de procedimientos almacenados (stored procedures), definidos todos en `BDTaquillaVirtual.sql`:

### Añadir:
* `add_recinto(IN nombre VARCHAR(50), IN tipo VARCHAR(30), IN direccion VARCHAR(70), IN ciudad VARCHAR(30))`: añade un nuevo Recinto a la BD.
* `add_espectaculo(IN nombre VARCHAR(30), IN descripcion VARCHAR(500))`: añade un nuevo Espectáculo a la BD.
* `add_evento(IN id_espectaculo INT, IN id_recinto INT, IN fecha DATETIME, IN estado INT, IN t1 INT, IN t2 DATE, IN t3 DATE, IN aforo_bebe INT, IN aforo_parado INT, IN aforo_jubilado INT, IN aforo_adulto INT, IN aforo_infantil INT, IN max_pre_cliente INT, IN max_compra_cliente INT)`: añade un nuevo Evento (Espectáculo celebrado en un Recinto) a la BD.
* `add_participantes(IN id_espectaculo INT, IN nombre VARCHAR(30), IN primer_apellido  VARCHAR(30),  IN segundo_apellido  VARCHAR(30))`: añade un nuevo Participante a un Evento.
* `add_grada(IN id_evento INT, IN nombre VARCHAR(30) ,IN precio_bebe INT, IN precio_parado INT, IN precio_jubilado INT, IN precio_adulto INT, IN precio_infantil INT)`: añade una nueva Grada a un Evento.
* `add_localidad(IN id_localidad INT,IN id_evento INT, IN id_grada INT, IN estado INT)`: añade una nueva Localidad a la Grada de un Evento.
    
### Consultar:
* `consultar_eventos(IN fecha_inicio DATE, IN fecha_final DATE, IN id_recinto INT, IN ciudad VARCHAR(70), IN tipo_usuario INT)`: devuelve todos los Eventos almacenados en la BD. Los parámetros son opcionales, y sirven para filtrar la búsqueda.
* `consultar_evento(IN id_evento INT)`: devuelve la información sobre un Evento en concreto.
* `consultar_gradas(IN id_evento INT)`: devuelve las Gradas disponibles para un Evento.
* `consultar_localidades(IN id_evento INT, IN id_grada INT)`: devuelve las Localidades disponibles para una determinada Grada de un Evento.
* `consultar_precios(IN id_evento INT, IN id_grada INT)`: devuelve los precios para los 5 Tipos de Usuario de un Evento en una Grada concreta.
* `consultar_precio(IN id_evento INT, IN id_grada INT, IN tipo_usuario INT)`: devuelve el precio que pagaría un Tipo de Usuario por asistir a un Evento en una Grada concreta.
* `consultar_asistencia(IN id_evento INT)`: devuelve los Tipos de Usuario que pueden asistir a un Evento y el aforo para cada Tipo de Usuario.
* `comprobar_asistencia(IN id_evento INT, IN tipo_usuario INT)`: para un Evento y Tipo de Usuario determinados, devuelve -1 si dicho Tipo de Usuario no puede asistir al Evento, o el aforo disponible si su asistencia sí que está permitida.

### Operaciones de compra:
* `registrar_cliente(IN dni VARCHAR(30), IN nombre VARCHAR(20), IN primer_apellido VARCHAR(20), IN segundo_apellido VARCHAR(20), IN cuenta_bancaria VARCHAR(40), OUT id_cliente_insertado INT)`: registra a un Cliente en la Base de Datos.
* `comprar(IN id_localidad INT, IN id_cliente INT, IN id_evento INT, IN tipo_usuarios INT,IN id_grada INT)`: registra la Compra de un Cliente de una Localidad de un Evento para un Tipo de Usuario.
* `prereservar( IN id_localidad INT, IN id_cliente INT, IN id_evento INT,IN tipo_usuarios INT,IN id_grada INT)`: registra la Prerreserva de un Cliente de una Localidad de un Evento para un Tipo de Usuario.
* `anular(IN id_compra INT, IN id_cliente INT)`: anula la Compra o Prerreserva de un Cliente de una Localidad para un Evento.
