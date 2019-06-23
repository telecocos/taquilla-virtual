-- Fichero de inicialización de la base de datos del Sistema de Taquilla Virtual
-- (C) Andrés Álvarez López, Diego Araújo Novoa, Guillermo Barreiro Fernández, Shaila Calvo Almeida

-- 1º, crea la Base de Datos y sus tablas
-- 2º, crea los procedimientos almacenados
-- 3º, crea los disparadores (triggers)

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX Creación de la Base de Datos XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

CREATE DATABASE IF NOT EXISTS TaquillaVirtual; 
USE TaquillaVirtual; 
DROP TABLE IF EXISTS Compras;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Localidades;
DROP TABLE IF EXISTS Gradas;
DROP TABLE IF EXISTS Eventos;
DROP TABLE IF EXISTS Participantes;
DROP TABLE IF EXISTS Espectaculos;
DROP TABLE IF EXISTS Recintos;

-- ***************************************** TABLAS *********************************************************

CREATE TABLE Recintos (id_recinto INT PRIMARY KEY AUTO_INCREMENT, 
                       tipo VARCHAR(30),
                       nombre VARCHAR(50),
                       direccion VARCHAR(70),
                       ciudad VARCHAR(30)
);

CREATE TABLE Espectaculos(id_espectaculo INT PRIMARY KEY AUTO_INCREMENT, 
                          nombre VARCHAR(30) NOT NULL, 
                          descripcion VARCHAR(500)
);

CREATE TABLE Participantes (id_participante INT AUTO_INCREMENT, 
                            id_espectaculo INT NOT NULL, 
                            nombre VARCHAR(30) NOT NULL, 
                            primer_apellido VARCHAR(30), 
                            segundo_apellido VARCHAR(30),
                            PRIMARY KEY (id_participante,id_espectaculo),
                            FOREIGN KEY (id_espectaculo) REFERENCES Espectaculos(id_espectaculo));

CREATE TABLE Eventos (id_evento INT PRIMARY KEY AUTO_INCREMENT, 
                      id_recinto INT NOT NULL, 
                      id_espectaculo INT NOT NULL,
                      fecha date NOT NULL, 
                      estado INT NOT NULL, 
                      t1 INT NOT NULL, 
                      t2 DATE NOT NULL, 
                      t3 DATE NOT NULL,
                      aforo_bebe INT NOT NULL,
                      aforo_parado INT NOT NULL,
                      aforo_jubilado INT NOT NULL,
                      aforo_adulto INT NOT NULL,
                      aforo_infantil INT NOT NULL, 
                      max_pre_cliente INT NOT NULL, 
                      max_compra_cliente INT NOT NULL, 
                      FOREIGN KEY (id_recinto) REFERENCES Recintos(id_recinto), 
                      FOREIGN KEY (id_espectaculo) REFERENCES Espectaculos(id_espectaculo) 
                      );

CREATE TABLE Gradas (id_grada INT auto_increment, 
                     id_evento INT NOT NULL, 
                     nombre varchar(20) NOT NULL,
                     precio_bebe INT NOT NULL,
                     precio_parado INT NOT NULL,
                     precio_jubilado INT NOT NULL,
                     precio_infantil INT NOT NULL,
                     precio_adulto INT NOT NULL,
                     PRIMARY KEY (id_grada,id_evento),                 
                     FOREIGN KEY (id_evento) REFERENCES Eventos(id_evento));

CREATE TABLE Localidades (id_localidad INT AUTO_INCREMENT, 
                          id_evento INT,
                          id_grada INT, 
                          estado INT NOT NULL, 
                          PRIMARY KEY (id_localidad, id_grada, id_evento), 
                          FOREIGN KEY (id_evento) REFERENCES Eventos(id_evento),
                          FOREIGN KEY (id_grada) REFERENCES Gradas(id_grada)
                            ON DELETE CASCADE
                          );

CREATE TABLE Clientes (id_cliente INT PRIMARY KEY auto_increment, 
                       dni varchar(30) NOT NULL, 
                       nombre VARCHAR(20) NOT NULL, 
                       primer_apellido VARCHAR(20) NOT NULL, 
                       segundo_apellido VARCHAR(20), 
                       cuenta_bancaria VARCHAR(40) NOT NULL);

CREATE TABLE Compras (id_compra INT PRIMARY KEY auto_increment, 
                      id_localidad INT, 
                      id_cliente INT NOT NULL,
		              fecha_compra DATETIME, 
                      id_evento INT NOT NULL, 
                      id_tipousuario INT NOT NULL,
                      id_grada INT,
                      FOREIGN KEY (id_localidad,id_grada) REFERENCES Localidades(id_localidad,id_grada) ON DELETE SET NULL, 
                      FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
                      FOREIGN KEY (id_evento) REFERENCES Eventos(id_evento));



-- ********************************* VALORES POR DEFECTO *********************************

-- RECINTOS
-- Recintos (id_recinto,tipo,nombre,direccion);
INSERT Recintos values(NULL, "multifuncional", "Palau Sant Jordi", "Passeig Olímpic, 5-7, 08038", "Barcelona");
INSERT Recintos values(NULL, "musical", "Palacio de la Ópera", "Glorieta de América, s/n, 15004", "A Coruña");
INSERT Recintos values(NULL, "deportivo", "Estadio de Balaídos", "Av. de Balaídos, 13, 36210 Vigo", "Vigo");
INSERT Recintos values(NULL, "deportivo", "Estadio de Riazor", "Rúa Manuel Murguía, S/N, 15011" ,"A Coruña");


-- ESPECTÁCULOS
-- Espectaculos(id_espectaculo,nombre,descripcion);
INSERT Espectaculos values(NULL, "Partido Celta - Depor", "El derbi gallego se juega en Balaídos");
INSERT Espectaculos values(NULL, "Concierto de Beret", "El sevillano estrena su nuevo álbum");
INSERT Espectaculos values(NULL, "Marisquiño", "Festival urbano con música y deportes");
INSERT Espectaculos values(NULL, "Concierto Beyoncé ", "La cantante mostrará los temas de su nuevo disco");

-- PARTICIPANTES
-- Participantes (id_participante, id_espectaculo, nombre, primer_apellido, segundo_apellido)
INSERT Participantes values(NULL, 1, "Iago", "Aspas", "Juncal");
INSERT Participantes values(NULL, 1, "Rubén", "Blanco", "Veiga");
INSERT Participantes values(NULL, 2, "Francisco Javier", "Álvarez", "Beret");
INSERT Participantes values(NULL, 3, "Daniel", "Vidal", "RelsB");
INSERT Participantes values(NULL, 3, "Antón", "Álvarez", "Alfaro");
INSERT Participantes values(NULL, 4, "Beyoncé", "Giselle", "Knowles-Carter");

-- EVENTOS
-- Eventos (id_evento, id_recinto, id_espectaculo,fecha, estado, t1, t2, t3,
-- aforo_bebe,aforo_parado,aforo_jubilado,aforo_adulto,aforo_infantil, max_pre_cliente, max_compra_cliente)
INSERT Eventos values(NULL, 1, 4, '2020-07-04', 1, 10, '2020-07-01', '2019-01-15', 2, 3, 2, 3, 2, 4, 4);
INSERT Eventos values(NULL, 2, 2, '2019-01-23', 1, 10, '2019-01-15', '2019-01-20', -1, 2, 2, 3, -1, 4, 4);
INSERT Eventos values(NULL, 3, 3, '2020-01-23', 1, 10, '2019-01-15', '2020-01-20', -1, 2, 2, 3, -1, 3, 3);
INSERT Eventos values(NULL, 4, 1, '2021-08-23', 1, 10, '2021-08-15', '2021-08-20', -1, -1, -1, 1, 1, 1, 1);
     
-- GRADAS
-- Gradas (id_grada, id_evento, nombre,precio_bebe,precio_parado,precio_jubilado,precio_infantil,precio_adulto);
INSERT Gradas values(NULL, 1, "A1", 25,10,39,29,40);
INSERT Gradas values(NULL, 1, "A2", 25,10,39,29,40); 
INSERT Gradas values(NULL, 3, "B1", 0,11,37,25,0); 
INSERT Gradas values(NULL, 3, "B2", 0,10,39,29,0); 
INSERT Gradas values(NULL, 4, "C1", 12,10,29,19,20); 
INSERT Gradas values(NULL, 4, "C2", 18,15,39,24,40);  
INSERT Gradas values(NULL, 2, "D1", 0,11,37,25,0); 
INSERT Gradas values(NULL, 2, "D2", 0,10,39,29,0); 

-- LOCALIDADES
-- Localidades (id_localidad, id_evento,id_grada, estado);
INSERT Localidades values(NULL, 1, 1, 4);
INSERT Localidades values(NULL, 1, 1, 1);
INSERT Localidades values(NULL, 1, 1, 1);
INSERT Localidades values(NULL, 3, 3, 1);
INSERT Localidades values(NULL, 3, 3, 2);
INSERT Localidades values(NULL, 3, 3, 3);
INSERT Localidades values(NULL, 4, 5, 1);
INSERT Localidades values(NULL, 4, 5, 1);
INSERT Localidades values(NULL, 4, 5, 3);
INSERT Localidades values(NULL, 2, 8, 3);

-- CLIENTES
-- Clientes (id_cliente, dni, nombre, primer_apellido, segundo_apellido, cuenta_bancaria);
INSERT Clientes values(NULL, "55669158Z", "Julio Ricardo", "Pérez","López","ES24123456789"); 
INSERT Clientes values(NULL, "65485618D", "Shaila", "Calvo","Almeida","ES2354135351"); 
INSERT Clientes values(NULL, "64514832F", "Andres", "Álvarez","López","ES24154154155"); 
INSERT Clientes values(NULL, "87834354R", "Guillermo", "Barreiro","Fernández","ES26541658851"); 
INSERT Clientes values(NULL, "85338345G", "Diego", "Araújo","Novoa","ES24454158418"); 


-- COMPRAS
-- Compras (id_compra,id_localidad,id_cliente,fecha_compra,id_evento,id_tipousuario, id_grada)
INSERT Compras values(NULL, 5, 1,now(), 3, 5, 3);
INSERT Compras values(NULL, 10, 5,now(), 2, 4, 8);


-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX PROCEDIMIENTOS ALMACENADOS XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

delimiter //
drop procedure if EXISTS add_recinto//
drop procedure if EXISTS add_espectaculo//
drop procedure if EXISTS add_evento//
drop procedure if EXISTS add_participantes//
drop procedure if EXISTS add_grada//
drop procedure if EXISTS add_localidad//

-- Procedimiento que AÑADE UN NUEVO RECINTO a la Base de Datos
CREATE PROCEDURE  add_recinto(IN nombre VARCHAR(50), IN tipo VARCHAR(30), IN direccion VARCHAR(70), IN ciudad VARCHAR(30))
    BEGIN
        INSERT Recintos values(NULL,tipo,nombre,direccion,ciudad);
    END //

-- Procedimiento que AÑADE UN NUEVO ESPECTÁCULO a la Base de Datos
CREATE PROCEDURE  add_espectaculo(IN nombre VARCHAR(30), IN descripcion VARCHAR(500))
    BEGIN
        INSERT Espectaculos values(NULL,nombre,descripcion);
    END //

-- Procedimiento que AÑADE UN NUEVO EVENTO a la Base de Datos
CREATE PROCEDURE add_evento(IN id_espectaculo INT, IN id_recinto INT, IN fecha DATETIME, IN estado INT, IN t1 INT, IN t2 DATE, IN t3 DATE, IN aforo_bebe INT, IN aforo_parado INT, IN aforo_jubilado INT, IN aforo_adulto INT, IN aforo_infantil INT, IN max_pre_cliente INT, IN max_compra_cliente INT)
    BEGIN
        IF t1<0 THEN SELECT 'ERROR AL INTRODUCIR t1';
        
        ELSEIF estado<1 or estado>3 THEN SELECT 'ERROR AL INTRODUCIR estado';
        
        ELSEIF aforo_bebe<-1 THEN SELECT 'ERROR AL INTRODUCIR aforo_bebe';
        
        ELSEIF aforo_parado<-1 THEN SELECT 'ERROR AL INTRODUCIR aforo_parado';
        
        ELSEIF aforo_jubilado<-1 THEN SELECT 'ERROR AL INTRODUCIR aforo_jubilado';
        
        ELSEIF aforo_infantil<-1 THEN SELECT 'ERROR AL INTRODUCIR aforo_infantil';
        
        ELSEIF aforo_adulto<-1 THEN SELECT 'ERROR AL INTRODUCIR aforo_adulto';
        
        ELSE  INSERT Eventos values(NULL,id_recinto,id_espectaculo,fecha,estado,t1,t2,t3,
                      aforo_bebe,aforo_parado,aforo_jubilado,aforo_adulto,aforo_infantil,max_pre_cliente,max_compra_cliente);
        
        END IF;
    END //

-- Procedimiento que AÑADE UN NUEVO PARTICIPANTE A UN ESPECTÁCULO de la Base de Datos
CREATE PROCEDURE add_participantes(IN id_espectaculo INT, IN nombre VARCHAR(30), IN primer_apellido  VARCHAR(30),  IN segundo_apellido  VARCHAR(30))
    BEGIN
        INSERT Participantes values(NULL,id_espectaculo,nombre,primer_apellido,segundo_apellido);
    END //

-- Procedimiento que AÑADE UNA NUEVA GRADA A UN EVENTO de la Base de Datos
CREATE PROCEDURE add_grada(IN id_evento INT, IN nombre VARCHAR(30) ,IN precio_bebe INT, IN precio_parado INT, IN precio_jubilado INT, IN precio_adulto INT, IN precio_infantil INT)
    BEGIN
        IF precio_bebe<0 THEN SELECT 'ERROR AL INTRODUCIR precio_bebe';
        
        ELSEIF precio_parado<0 THEN SELECT 'ERROR AL INTRODUCIR precio_parado';
        
        ELSEIF precio_jubilado<0 THEN SELECT 'ERROR AL INTRODUCIR precio_jubilado';
        
        ELSEIF precio_infantil<0 THEN SELECT 'ERROR AL INTRODUCIR precio_infantil';
      
        ELSEIF precio_adulto<0 THEN SELECT 'ERROR AL INTRODUCIR precio_adulto';
    
        ELSE INSERT Gradas values(NULL,id_evento,nombre,precio_bebe,precio_parado,precio_jubilado,precio_infantil,precio_adulto);
         
        END IF;
    END //

-- Procedimiento que AÑADE UNA NUEVA LOCALIDAD A UNA GRADA de un Evento de la Base de Datos
CREATE PROCEDURE add_localidad(IN id_localidad INT,IN id_evento INT, IN id_grada INT, IN estado INT)
    BEGIN 
        IF estado<1 or estado>4 THEN SELECT 'ERROR AL INTRODUCIR estado';
       
        ELSE INSERT Localidades values( id_localidad, id_evento, id_grada, estado);
        END IF;
    END //



-- ************************************** PROCEDURES *************************************
DROP PROCEDURE IF EXISTS consultar_eventos//
DROP PROCEDURE IF EXISTS consultar_evento//
DROP PROCEDURE IF EXISTS consultar_gradas//
DROP PROCEDURE IF EXISTS consultar_localidades//
DROP PROCEDURE IF EXISTS consultar_precio//
DROP PROCEDURE IF EXISTS consultar_asistencia//
DROP PROCEDURE IF EXISTS registrar_cliente//
DROP PROCEDURE IF EXISTS comprar//
DROP PROCEDURE IF EXISTS prereservar//
DROP PROCEDURE IF EXISTS anular//
DROP PROCEDURE IF EXISTS comprobar_asistencia//

-- Devuelve todos los eventos almacenados en el sistema. Los parámetros son opcionales.
CREATE PROCEDURE consultar_eventos(IN fecha_inicio DATE, IN fecha_final DATE, IN id_recinto INT, IN ciudad VARCHAR(70), IN tipo_usuario INT)
BEGIN

    DECLARE sentencia_where VARCHAR(1000);
    
    SET sentencia_where = " ";

    IF id_recinto IS NOT NULL THEN
        IF sentencia_where IS NOT NULL THEN SET sentencia_where = CONCAT(sentencia_where," AND "); END IF;
        SET sentencia_where = CONCAT(sentencia_where,"Eventos.id_recinto= ", id_recinto);
    END IF;

    IF fecha_inicio IS NOT NULL OR fecha_final IS NOT NULL THEN
        IF sentencia_where IS NOT NULL THEN SET sentencia_where = CONCAT(sentencia_where," AND "); END IF;
        IF fecha_inicio IS NULL THEN SET fecha_inicio=DATE_ADD(NOW(), INTERVAL -5 YEAR); END IF;
        IF fecha_final IS NULL THEN SET fecha_final=DATE_ADD(NOW(), INTERVAL 5 YEAR); END IF;
        SET sentencia_where = CONCAT(sentencia_where,"Eventos.fecha BETWEEN '", DATE_ADD(fecha_inicio,INTERVAL -1 DAY),"' AND '",DATE_ADD(fecha_final,INTERVAL 1 DAY),"'");
    END IF;

    IF id_recinto IS NOT NULL THEN
        IF sentencia_where IS NOT NULL THEN SET sentencia_where = CONCAT(sentencia_where," AND "); END IF; 
        SET sentencia_where = CONCAT(sentencia_where,"Eventos.id_recinto= ", id_recinto);
    END IF;


    IF ciudad IS NOT NULL THEN
        IF sentencia_where IS NOT NULL THEN SET sentencia_where = CONCAT(sentencia_where," AND "); END IF; 
        SET sentencia_where = CONCAT(sentencia_where," Recintos.ciudad= '",ciudad,"'");
    END IF;

    IF tipo_usuario IS NOT NULL THEN
        IF sentencia_where IS NOT NULL THEN SET sentencia_where = CONCAT(sentencia_where," AND "); END IF; 
        SET sentencia_where = CONCAT(sentencia_where," CASE ", tipo_usuario," WHEN 1 THEN Eventos.aforo_bebe>-1 WHEN 2 THEN Eventos.aforo_infantil>-1 WHEN 3 THEN Eventos.aforo_adulto>-1
        WHEN 4 THEN Eventos.aforo_parado>-1 WHEN 5 THEN Eventos.aforo_jubilado>-1 END");
    END IF;

    SET @sentencia = CONCAT("SELECT Eventos.id_evento, Espectaculos.nombre,Espectaculos.descripcion, Recintos.nombre as recinto,Eventos.fecha FROM Eventos,Recintos,Espectaculos 
    WHERE Eventos.id_recinto = Recintos.id_recinto AND Espectaculos.id_espectaculo = Eventos.id_espectaculo", sentencia_where,";");

    PREPARE ejecucion FROM @sentencia;
    EXECUTE ejecucion;
    DEALLOCATE PREPARE ejecucion;

END //

-- Devuelve la información sobre un evento en concreto dado su ID
CREATE PROCEDURE consultar_evento(IN id_evento INT)
BEGIN
    SELECT Eventos.id_evento, Espectaculos.nombre,Espectaculos.descripcion, Recintos.nombre as recinto,Eventos.fecha FROM Eventos,Recintos,Espectaculos 
    WHERE Eventos.id_recinto = Recintos.id_recinto AND Espectaculos.id_espectaculo = Eventos.id_espectaculo AND Eventos.id_evento = id_evento;
END //

-- Devuelve las Gradas disponibles para un determinado Evento
CREATE PROCEDURE consultar_gradas(IN id_evento INT)
BEGIN

    SELECT Gradas.id_grada, nombre FROM Localidades NATURAL JOIN Gradas WHERE Localidades.id_evento = id_evento AND Localidades.estado = 1 
    GROUP BY nombre, Gradas.id_grada;

END //

-- Devuelve las Localidades disponibles para una determinada Grada en un determinado Evento
CREATE PROCEDURE consultar_localidades(IN id_evento INT, IN id_grada INT)
BEGIN

    SELECT id_localidad FROM Localidades
    WHERE id_evento = Localidades.id_evento AND Localidades.id_grada = id_grada and Localidades.estado = 1;

END //

-- Devuelve los precios para todos los tipos de usuario para un Evento en una Grada concreta
CREATE PROCEDURE consultar_precios(IN id_evento INT, IN id_grada INT)
BEGIN
    SELECT precio_bebe, precio_infantil, precio_adulto, precio_parado, precio_jubilado FROM Gradas WHERE Gradas.id_evento = id_evento AND Gradas.id_grada = id_grada;
END //

-- Devuelve el precio que pagaría un Tipo de Usuario asistir a un Evento en una Grada concreta
CREATE PROCEDURE consultar_precio(IN id_evento INT, IN id_grada INT, IN tipo_usuario INT)
BEGIN
    SELECT CASE tipo_usuario WHEN 1 THEN precio_bebe WHEN 2 THEN precio_infantil WHEN 3 THEN precio_adulto
        WHEN 4 THEN precio_parado WHEN 5 THEN precio_jubilado END AS Precio FROM Gradas WHERE Gradas.id_evento = id_evento AND Gradas.id_grada = id_grada;
END //

-- Devuelve los Tipo de Usuario que pueden asistir a un Evento y el aforo de cada Tipo de Usuario
CREATE PROCEDURE consultar_asistencia(IN id_evento INT)
BEGIN

    SELECT aforo_bebe, aforo_infantil, aforo_adulto, aforo_parado, aforo_jubilado FROM Eventos WHERE Eventos.id_evento = id_evento;

END //

-- Registra a un Cliente en la Base de Datos
CREATE PROCEDURE registrar_cliente(IN dni VARCHAR(30), IN nombre VARCHAR(20), IN primer_apellido VARCHAR(20), 
                            IN segundo_apellido VARCHAR(20), IN cuenta_bancaria VARCHAR(40), OUT id_cliente_insertado INT)
BEGIN

    INSERT Clientes values(NULL,dni,nombre,primer_apellido,segundo_apellido,cuenta_bancaria);
    SET id_cliente_insertado = LAST_INSERT_ID();

END //

-- Registra la Compra de un Cliente de una o varias localidades para un Evento
CREATE PROCEDURE comprar(IN id_localidad INT, IN id_cliente INT, IN id_evento INT, IN tipo_usuarios INT,IN id_grada INT)

BEGIN
    DECLARE cliente_id_otros,cliente_id_yo,total,maximo,void ,estado_localidad, estado_localid_actual,estado_evento INT;
    DECLARE aforo_x INT;

    SELECT id_cliente into cliente_id_otros FROM Compras WHERE id_localidad = Compras.id_localidad AND id_cliente != Compras.id_cliente AND Compras.id_evento = id_evento AND Compras.id_grada = id_grada; 
    SELECT id_cliente , Localidades.estado INTO cliente_id_yo, estado_localidad FROM Compras
    INNER JOIN Localidades ON Localidades.id_localidad=Compras.id_localidad
        WHERE id_localidad = Compras.id_localidad AND id_cliente = Compras.id_cliente AND Compras.id_evento = id_evento AND Compras.id_grada = id_grada;
    SELECT estado into estado_localid_actual FROM Localidades WHERE id_grada = id_grada AND id_evento = id_evento AND id_localidad = id_localidad;
    SELECT max_compra_cliente ,CASE tipo_usuarios WHEN 1 THEN Eventos.aforo_bebe WHEN 2 THEN Eventos.aforo_infantil WHEN 3 THEN Eventos.aforo_adulto
        WHEN 4 THEN Eventos.aforo_parado WHEN 5 THEN Eventos.aforo_jubilado END, Eventos.estado  INTO maximo,aforo_x ,estado_evento FROM Eventos WHERE id_evento = Eventos.id_evento;



    IF cliente_id_otros IS NOT NULL THEN 
        SELECT "Esta localidad ya ha sido ocupada";
    ELSEIF estado_evento=3 THEN
        select "EL EVENTO ESTA CERRADO";
 
    ELSEIF estado_localid_actual = 4 THEN
        SELECT "Esta localidad esta deteriorada";

    ELSEIF cliente_id_yo IS NULL AND aforo_x>0 THEN
        SELECT Compras.id_evento, count(*) into void,total FROM Compras , Localidades Where Compras.id_cliente = id_cliente AND Localidades.estado = 3 AND Localidades.id_localidad = Compras.id_localidad GROUP BY Compras.id_evento;
        SET total = IFNULL(total,0);
            IF total < maximo THEN
                INSERT Compras values(NULL,id_localidad,id_cliente,NOW(),id_evento,tipo_usuarios,id_grada);
                UPDATE Localidades SET estado = 3 WHERE Localidades.id_evento = id_evento AND Localidades.id_localidad = id_localidad;
               
            ELSE SELECT "HAS SUPERADO EL MAXIMO DE COMPRAS";
            END IF;
    ELSEIF cliente_id_yo IS NULL AND NOT aforo_x>0 THEN SELECT "No hay aforo suficiente";
    ELSEIF cliente_id_yo IS NOT NULL AND estado_localidad != 3 THEN
        UPDATE Localidades SET estado = 3 WHERE Localidades.id_evento = id_evento AND Localidades.id_localidad = id_localidad;
        UPDATE Compras SET fecha_compra = now() WHERE Compras.id_evento = id_evento AND Compras.id_localidad = id_localidad and Compras.id_cliente = id_cliente and Compras.id_grada = id_grada;
    ELSE SELECT "Localidad ya comprada por usted";
    END IF;

END //

-- Registra la Pre-reserva de un Cliente de una o varias localidades para un Evento
CREATE PROCEDURE prereservar( IN id_localidad INT, IN id_cliente INT, IN id_evento INT,IN tipo_usuarios INT,IN id_grada INT)
BEGIN
    DECLARE cliente_id_yo,aforo_x,cliente_id_otros,total,maximo,void ,estado_localidad, estado_localid_actual,estado_evento INT;
    DECLARE tiempo_2 DATE;

    SELECT id_cliente INTO cliente_id_otros FROM Compras WHERE id_localidad = Compras.id_localidad AND id_cliente != Compras.id_cliente AND Compras.id_evento = id_evento AND Compras.id_grada = id_grada;
    SELECT id_cliente , Localidades.estado INTO cliente_id_yo, estado_localidad FROM Compras
    INNER JOIN Localidades ON Localidades.id_localidad=Compras.id_localidad
        WHERE id_localidad = Compras.id_localidad AND id_cliente = Compras.id_cliente AND Compras.id_evento = id_evento AND Compras.id_grada = id_grada;

    SELECT estado into estado_localid_actual FROM Localidades WHERE id_grada = id_grada AND id_evento = id_evento AND id_localidad = id_localidad;

    SELECT max_compra_cliente , CASE tipo_usuarios WHEN 1 THEN Eventos.aforo_bebe WHEN 2 THEN Eventos.aforo_infantil WHEN 3 THEN Eventos.aforo_adulto
        WHEN 4 THEN Eventos.aforo_parado WHEN 5 THEN Eventos.aforo_jubilado END, Eventos.estado  INTO maximo,aforo_x,estado_evento FROM Eventos WHERE id_evento = Eventos.id_evento;


    IF cliente_id_otros IS NOT NULL THEN 
        SELECT "Esta localidad ya ha sido ocupada";
    ELSEIF estado_localid_actual = 4 THEN
        SELECT "Esta localidad esta deteriorada";
    ELSEIF estado_evento=3 THEN
        select "EL EVENTO ESTA CERRADO";

    ELSEIF cliente_id_yo IS NULL AND aforo_x>0 THEN
        SELECT t2 into tiempo_2 FROM Eventos WHERE id_evento = id_evento;
        IF tiempo_2 > NOW() THEN
            SELECT Compras.id_evento, count(*) into void,total FROM Compras , Localidades Where Compras.id_cliente = id_cliente AND Localidades.estado = 2 AND Localidades.id_localidad = Compras.id_localidad GROUP BY Compras.id_evento;
            SET total = IFNULL(total,0);
            IF total < maximo THEN
                INSERT Compras values(NULL,id_localidad,id_cliente,now(),id_evento,tipo_usuarios,id_grada);
                UPDATE Localidades SET estado = 2 WHERE Localidades.id_evento = id_evento AND Localidades.id_localidad = id_localidad;
            ELSE SELECT "HAS SUPERADO EL MAXIMO DE PRERESERVAS";
            END IF;
        ELSE 
            SELECT "Tiempo de prereservar excedido";
        END IF;
    ELSE SELECT "No hay aforo suficiente";
    END IF;

END //

-- Anula la Compra/Pre-reserva de un Cliente de una localidad para un Evento
CREATE PROCEDURE anular(IN id_compra INT, IN id_cliente INT)
BEGIN

    DECLARE clien, even, grad, tipo, esta,localidades,esta_even INT;
    declare precio numeric(4,2);
    DECLARE tiempo_3 DATE;
    SELECT Compras.id_localidad,Compras.id_cliente,Compras.id_evento,Compras.id_grada,Compras.id_tipousuario,Localidades.estado INTO localidades, clien,even,grad,tipo,esta FROM Compras NATURAL JOIN Localidades WHERE Compras.id_compra = id_compra;
    SELECT Eventos.estado INTO esta_even FROM Eventos,Compras WHERE Eventos.id_evento = Compras.id_evento AND Compras.id_compra = id_compra;  

    IF esta_even = 3 THEN 
        SELECT "El evento ya ha finalizado";
    ELSEIF clien = id_cliente THEN     
        IF esta = 3 THEN
            SELECT t3 into tiempo_3 FROM Eventos WHERE id_evento = even;
            SELECT CASE tipo WHEN 1 THEN precio_bebe WHEN 2 THEN precio_infantil WHEN 3 THEN precio_adulto
            WHEN 4 THEN precio_parado WHEN 5 THEN precio_jubilado END INTO precio FROM Gradas WHERE Gradas.id_grada = grad;
            IF NOW() > tiempo_3 THEN
                SELECT CONCAT("Tiempo de Anulaciones excedido se te aplica penalizacion. Dinero a devolver: ",precio*0.5) AS Anulacion_Realizada;
                   
            ELSE 
                SELECT concat("Se te devuelve el dinero : ",precio) AS Anulacion_Realizada;
            END IF;       
        END IF;
        DELETE FROM Compras WHERE Compras.id_compra = id_compra;
        UPDATE Localidades SET estado = 1 WHERE Localidades.id_evento = even AND Localidades.id_localidad = localidades;
    ELSE SELECT "ERROR AL ANULAR UNA COMPRA";
    END IF;
    
END //

-- Devuelve -1 si ese Tipo de Usuario no puede asistir al Evento. Si puede asistir, devuelve el aforo disponible para ese Tipo de Usuario.
CREATE PROCEDURE comprobar_asistencia(IN id_evento INT, IN tipo_usuario INT)
BEGIN
    SELECT CASE tipo_usuario WHEN 1 THEN Eventos.aforo_bebe WHEN 2 THEN Eventos.aforo_infantil WHEN 3 THEN Eventos.aforo_adulto
        WHEN 4 THEN Eventos.aforo_parado WHEN 5 THEN Eventos.aforo_jubilado END AS aforo FROM Eventos WHERE Eventos.id_evento = id_evento;
END //

-- ************************************** TRIGGERS *************************************

DROP TRIGGER IF EXISTS eliminar_gradas_evento//
DROP TRIGGER IF EXISTS actualizar_aforo_reducir//
DROP TRIGGER IF EXISTS actualizar_aforo_aumentar//
DROP EVENT   IF EXISTS comprobar_t1//
DROP EVENT   IF EXISTS estado_evento//


-- Elimina las gradas y localidades asociadas a un Evento una vez que este finaliza
CREATE TRIGGER eliminar_gradas_evento AFTER UPDATE ON Eventos FOR EACH ROW
BEGIN
    
    -- Si el evento está finalizado (estado = 3)
    IF new.estado = 3 THEN    
        -- Se eliminan sus gradas
        DELETE FROM Gradas WHERE Gradas.id_evento = new.id_evento;
    END IF;
   
END //


-- Reduce o aumenta el aforo de un Evento cada vez que se realiza una compra/pre-reserva/anulacion, y actualiza su estado
CREATE TRIGGER actualizar_aforo_reducir AFTER INSERT ON Compras FOR EACH ROW
BEGIN

    DECLARE bebe,infantil,adulto,parado,jubilado INT;
    CASE 
        WHEN new.id_tipousuario = 1 THEN 
            UPDATE Eventos SET aforo_bebe = aforo_bebe-1  WHERE new.id_evento = id_evento;
        WHEN new.id_tipousuario = 2 THEN 
            UPDATE Eventos SET aforo_infantil = aforo_infantil-1  WHERE new.id_evento = id_evento;
        WHEN new.id_tipousuario = 3 THEN 
            UPDATE Eventos SET aforo_adulto = aforo_adulto-1 WHERE new.id_evento = id_evento;
        WHEN new.id_tipousuario = 4 THEN 
            UPDATE Eventos SET aforo_parado = aforo_parado-1  WHERE new.id_evento = id_evento;
        WHEN new.id_tipousuario = 5 THEN 
            UPDATE Eventos SET aforo_jubilado = aforo_jubilado-1 WHERE new.id_evento = id_evento;
           
    END CASE;

    SELECT  aforo_bebe,aforo_infantil,aforo_adulto,aforo_parado,aforo_jubilado into bebe,infantil,adulto,parado,jubilado FROM Eventos WHERE new.id_evento= id_evento;
        IF  bebe<1 
        AND infantil<1 
        AND adulto<1 
        AND parado<1 
        AND jubilado<1 THEN 
        UPDATE Eventos SET estado = 2 WHERE new.id_evento = id_evento;
    END IF;
  
END //

CREATE  TRIGGER actualizar_aforo_aumentar AFTER DELETE ON Compras FOR EACH ROW
BEGIN

    DECLARE bebe,infantil,adulto,parado,jubilado INT;
    CASE
        WHEN old.id_tipousuario = 1 THEN 
            UPDATE Eventos SET aforo_bebe = aforo_bebe+1  WHERE old.id_evento = id_evento;
        WHEN old.id_tipousuario = 2 THEN 
            UPDATE Eventos SET aforo_infantil = aforo_infantil+1  WHERE old.id_evento = id_evento;
        WHEN old.id_tipousuario = 3 THEN 
            UPDATE Eventos SET aforo_adulto = aforo_adulto+1 WHERE old.id_evento = id_evento;
        WHEN old.id_tipousuario = 4 THEN 
            UPDATE Eventos SET aforo_parado = aforo_parado+1  WHERE old.id_evento = id_evento;
        WHEN old.id_tipousuario = 5 THEN 
            UPDATE Eventos SET aforo_jubilado = aforo_jubilado+1 WHERE old.id_evento = id_evento;
           
    END CASE;

    SELECT  aforo_bebe,aforo_infantil,aforo_adulto,aforo_parado,aforo_jubilado into bebe,infantil,adulto,parado,jubilado FROM Eventos WHERE old.id_evento= id_evento;
        IF  bebe>0
        OR infantil>0
        OR adulto>0 
        OR parado>0
        OR jubilado>0 THEN 
        UPDATE Eventos SET estado = 1 WHERE old.id_evento = id_evento;
    END IF;

END //


-- Comprueba cada 2 minutos si alguna prerreserva ha excedido sus t1 minutos. En caso afirmativo, la elimina del sistema. 
CREATE EVENT comprobar_t1 ON SCHEDULE EVERY 5 MINUTE DO
BEGIN

     DECLARE id_compra INT;
    DECLARE fechas DATETIME;
    DECLARE t1 INT;
    DECLARE id_localidad INT;
    DECLARE id_evento INT;
    DECLARE id_grada INT;
    DECLARE fin_cursor BOOLEAN DEFAULT FALSE; -- valdrá TRUE cuando el cursor llegue a su fin
    DECLARE prerreservas CURSOR FOR SELECT Compras.id_compra, Compras.fecha_compra, Eventos.t1,Compras.id_localidad,Compras.id_evento, Compras.id_grada FROM (Compras NATURAL JOIN Localidades), Eventos 
        WHERE Localidades.estado = 2 AND Compras.id_evento = Eventos.id_evento;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;
  
    OPEN prerreservas;
    WHILE NOT fin_cursor DO
        FETCH prerreservas INTO id_compra, fechas, t1,id_localidad , id_evento, id_grada;
        
        -- comprobamos si la prerreserva está fuera de plazo
        IF DATE_ADD(fechas, INTERVAL t1 MINUTE) < NOW() THEN
            -- si es así, la borramos
            UPDATE Localidades SET estado = 1 WHERE Localidades.id_localidad = id_localidad AND Localidades.id_evento  = id_evento AND Localidades.id_grada = id_grada;
            DELETE FROM Compras WHERE Compras.id_compra = id_compra;
        END IF;
        
        
    END WHILE;
    CLOSE prerreservas;
END //

-- Comprueba cada 3 minutos si algún Evento ya ha finalizado
CREATE EVENT estado_evento ON SCHEDULE EVERY 5 MINUTE DO
BEGIN
    
    DECLARE id_evento INT;
    DECLARE fechas DATETIME;
    DECLARE fin_cursor BOOLEAN DEFAULT FALSE;
    DECLARE situacion CURSOR FOR SELECT id_evento, fecha FROM Eventos;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;

    OPEN situacion;
    WHILE NOT fin_cursor DO
        FETCH situacion INTO id_evento, fechas;

        IF fechas < NOW() THEN
            UPDATE Eventos SET estado = 3 WHERE Eventos.id_evento = id_evento;
        END IF;
    END WHILE;
    CLOSE situacion;

END //

    delimiter ;

