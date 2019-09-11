CREATE DATABASE hotel; 

CREATE TABLE tipo_servicio 
  ( 
     id SERIAL NOT NULL PRIMARY KEY,
     nombre_servicio CHAR(10) NOT NULL
  ); 

INSERT INTO tipo_servicio(nombre_servicio) 
VALUES      ('Comedor'); 

INSERT INTO tipo_servicio(nombre_servicio)  
VALUES      ('Lavanderia'); 

CREATE TABLE pais 
  ( 
     id SERIAL NOT NULL PRIMARY KEY,
     pais CHAR(20) NOT NULL
  ); 

INSERT INTO pais(pais)  
VALUES      ('Alemania'); 

INSERT INTO pais(pais) 
VALUES      ('España'); 

INSERT INTO pais(pais)
VALUES      ('Francia'); 

INSERT INTO pais(pais) 
VALUES      ('Portugal'); 

CREATE TABLE cliente
  ( 
     id SERIAL NOT NULL PRIMARY KEY,
     identificacion CHAR(12) NOT NULL, 
     id_pais        INTEGER NOT NULL, 
     nombre         CHAR(12) NOT NULL, 
     apellido1      CHAR(12) NOT NULL, 
     apellido2      CHAR(12), 
     direccion      CHAR(30) NOT NULL, 
     telefono       CHAR(12) NOT NULL, 
     observaciones  CHAR(50),
     FOREIGN KEY (id_pais) REFERENCES pais (id) 
  ); 

INSERT INTO cliente(identificacion,id_pais,
		    nombre,apellido1,apellido2,
		    direccion,telefono,
		    observaciones) 
VALUES      ('12345', 
             2, 
             'Felipe', 
             'Iglesias', 
             'López', 
             'Avda los castros, 44', 
             '942344444', 
             'Buen cliente'); 

INSERT INTO cliente(identificacion,id_pais,
		    nombre,apellido1,apellido2,
		    direccion,telefono,
		    observaciones)
VALUES      ('44444', 
             2, 
             'Luis', 
             'García', 
             'García', 
             'Calle mayor, 67 ', 
             '942456444', 
             NULL); 

INSERT INTO cliente(identificacion,id_pais,
		    nombre,apellido1,apellido2,
		    direccion,telefono,
		    observaciones)
VALUES      ('456789', 
             3, 
             'Ludovic', 
             'Giuly', 
             'Bourquin', 
             '18 avenue alsacen cour', 
             '37890194', 
             NULL); 

CREATE TABLE tipo_habitacion 
  ( 
     id SERIAL NOT NULL PRIMARY KEY,
     categoria INT NOT NULL, 
     camas     INT NOT NULL, 
     exterior  INTEGER NOT NULL CHECK (exterior IN (1, 0)), 
     salon     INTEGER NOT NULL CHECK (salon IN (1, 0)), 
     terraza   INTEGER NOT NULL CHECK (terraza IN (1, 0))
  ); 
COMMENT ON COLUMN tipo_habitacion.exterior 
IS '1 es si y 0 es no';
COMMENT ON COLUMN tipo_habitacion.salon 
IS '1 es si y 0 es no';
COMMENT ON COLUMN tipo_habitacion.terraza 
IS '1 es si y 0 es no';

INSERT INTO tipo_habitacion(categoria,camas,
			    exterior,salon,terraza) 
VALUES      (1, 
             1, 
             1, 
             0, 
             0); 

INSERT INTO tipo_habitacion(categoria,camas,
			    exterior,salon,terraza) 
VALUES      (2, 
             2, 
             1, 
             0, 
             0); 
             
INSERT INTO tipo_habitacion(categoria,camas,
			    exterior,salon,terraza)
VALUES      (3, 
             3, 
             1, 
             0, 
             0); 

INSERT INTO tipo_habitacion(categoria,camas,
			    exterior,salon,terraza)
VALUES      (4, 
             1, 
             1, 
             1, 
             0); 

CREATE TABLE habitacion
  ( 
     id SERIAL NOT NULL PRIMARY KEY,
     num_habitacion   INT NOT NULL, 
     id_tipo_habitacion INT NOT NULL, 
     FOREIGN KEY (id_tipo_habitacion)
      REFERENCES tipo_habitacion (id) 
  ); 

INSERT INTO habitacion(num_habitacion,
                       id_tipo_habitacion)
VALUES      (101, 
             1); 

INSERT INTO habitacion(num_habitacion,
                       id_tipo_habitacion)
VALUES      (102, 
             1); 

INSERT INTO habitacion(num_habitacion,
                       id_tipo_habitacion)
VALUES      (103, 
             1); 

INSERT INTO habitacion(num_habitacion,
                       id_tipo_habitacion)
VALUES      (104, 
             2); 

INSERT INTO habitacion(num_habitacion,
                       id_tipo_habitacion)
VALUES      (105, 
             2); 

INSERT INTO habitacion(num_habitacion,
                       id_tipo_habitacion)
VALUES      (106, 
             3); 

INSERT INTO habitacion(num_habitacion,
                       id_tipo_habitacion)
VALUES      (107, 
             4); 

CREATE TABLE servicio
  ( 
     id SERIAL           NOT NULL PRIMARY KEY,
     id_tipo_servicio    INTEGER NOT NULL, 
     descripcion         CHAR(30) NOT NULL, 
     precio              NUMERIC(10,2) NOT NULL, 
     iva                 NUMERIC (5, 2) NOT NULL, 
     fecha               TIMESTAMP WITHOUT TIME ZONE NOT NULL,
     FOREIGN KEY (id_tipo_servicio) 
     REFERENCES tipo_servicio ( id ) 
  ); 

INSERT INTO servicio(id_tipo_servicio,descripcion,
		     precio,iva,fecha)
VALUES      (1,
             '1 menu del dia', 
             10, 
             7, 
             '2009-01-01'); 

INSERT INTO servicio(id_tipo_servicio,descripcion,
		     precio,iva,fecha) 
VALUES      (2, 
             'lavado de camisa', 
             2, 
             7, 
             '2009-01-01'); 

INSERT INTO servicio(id_tipo_servicio,descripcion,
		     precio,iva,fecha)  
VALUES      (2,
             'lavado de pantalon', 
             1, 
             7, 
             '2009-01-01'); 

CREATE TABLE temporada   
( 
  id           SERIAL NOT NULL PRIMARY KEY,
  temporada    INT NOT NULL, 
  fecha_inicio TIMESTAMP WITHOUT TIME ZONE NOT NULL, 
  fecha_final  TIMESTAMP WITHOUT TIME ZONE NOT NULL, 
  tipo         INTEGER NOT NULL CHECK (tipo IN (1,2,3))
); 
COMMENT ON COLUMN temporada.tipo 
IS '1 es alta, 2 es media y 3 es baja';

INSERT INTO temporada(temporada,fecha_inicio,fecha_final,tipo) 
VALUES      (1, 
             '2009-01-01', 
             '2009-03-31', 
             1); 

INSERT INTO temporada(temporada,fecha_inicio,fecha_final,tipo) 
VALUES      (2, 
             '2009-04-01', 
             '2009-05-31', 
             2); 

INSERT INTO temporada(temporada,fecha_inicio,fecha_final,tipo) 
VALUES      (3, 
             '2009-06-01', 
             '2009-08-31', 
             3); 

INSERT INTO temporada(temporada,fecha_inicio,fecha_final,tipo) 
VALUES      (4, 
             '2009-09-01', 
             '2009-10-31', 
             2); 

INSERT INTO temporada(temporada,fecha_inicio,fecha_final,tipo) 
VALUES      (5, 
             '2009-11-01', 
             '2009-12-31', 
             1); 

CREATE TABLE precio_habitacion 
  ( 
     id               SERIAL NOT NULL PRIMARY KEY,
     precio          NUMERIC(10,2) NOT NULL, 
     id_temporada       INT NOT NULL, 
     id_tipo_habitacion INT NOT NULL, 
     FOREIGN KEY (id_temporada) REFERENCES temporada(id), 
     FOREIGN KEY (id_tipo_habitacion) REFERENCES tipo_habitacion(id) 
  ); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion)
VALUES      (30, 
             1, 
             1); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion)
VALUES      (35, 
             2, 
             1); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion)
VALUES      (40, 
             3, 
             1); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion)
VALUES      (35, 
             4, 
             1); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion)
VALUES      (30, 
             5, 
             1); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion)
VALUES      (35, 
             1, 
             2); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion)
VALUES      (40, 
             2, 
             2); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion)
VALUES      (45, 
             3, 
             2); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion)
VALUES      (40, 
             4, 
             2); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion)
VALUES      (35, 
             5, 
             2); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion)
VALUES      (40, 
             1, 
             3); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion)
VALUES      (45, 
             2, 
             3); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion)
VALUES      (50, 
             3, 
             3); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion) 
VALUES      (45, 
             4, 
             3); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion) 
VALUES      (40, 
             5, 
             3); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion) 
VALUES      (50, 
             1, 
             4); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion) 
VALUES      (55, 
             2, 
             4); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion) 
VALUES      (60, 
             3, 
             4); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion) 
VALUES      (55, 
             4, 
             4); 

INSERT INTO precio_habitacion(precio,id_temporada,id_tipo_habitacion) 
VALUES      (50, 
             5, 
             4); 

CREATE TABLE reserva_habitacion 
  ( 
     id            SERIAL NOT NULL PRIMARY KEY,
     fecha_entrada TIMESTAMP WITHOUT TIME ZONE NOT NULL, 
     fecha_salida  TIMESTAMP WITHOUT TIME ZONE NOT NULL, 
     iva           NUMERIC(5, 2) NOT NULL, 
     id_habitacion INT NOT NULL, 
     id_cliente      INT NOT NULL,
     FOREIGN KEY (id_cliente) REFERENCES cliente (id), 
     FOREIGN KEY (id_habitacion) REFERENCES habitacion (id) 
  ); 

INSERT INTO reserva_habitacion 
            (fecha_entrada, 
             fecha_salida, 
             iva, 
             id_habitacion, 
             id_cliente) 
VALUES      ( '2009-03-15', 
              '2009-03-25', 
              0.07, 
              1, 
              1); 

INSERT INTO reserva_habitacion 
            (fecha_entrada, 
             fecha_salida, 
             iva, 
             id_habitacion, 
             id_cliente)  
VALUES      ( '2009-03-15', 
              '2009-03-25', 
              0.07, 
              2, 
              1); 

INSERT INTO reserva_habitacion 
            (fecha_entrada, 
             fecha_salida, 
             iva, 
             id_habitacion, 
             id_cliente)
VALUES      ( '2009-02-16', 
              '2009-02-21', 
              0.07, 
              3, 
              1); 


INSERT INTO reserva_habitacion 
            (fecha_entrada, 
             fecha_salida, 
             iva, 
             id_habitacion, 
             id_cliente) 
VALUES      ( '2009-03-16', 
              '2009-03-21', 
              0.07, 
              4, 
              2); 

INSERT INTO reserva_habitacion 
            (fecha_entrada, 
             fecha_salida, 
             iva, 
             id_habitacion, 
             id_cliente) 
VALUES      ( '2009-03-16', 
              '2009-03-21', 
              0.07, 
              5, 
              2);
               
INSERT INTO reserva_habitacion 
            (fecha_entrada, 
             fecha_salida, 
             iva, 
             id_habitacion, 
             id_cliente) 
VALUES      ( '2009-03-16', 
              '2009-03-21', 
              0.07, 
              6, 
              2); 

INSERT INTO reserva_habitacion 
            (fecha_entrada, 
             fecha_salida, 
             iva, 
             id_habitacion, 
             id_cliente) 
VALUES      ( '2009-03-16', 
              '2009-03-21', 
              0.07, 
              7, 
              2); 

CREATE TABLE gastos 
  ( 
     id    SERIAL NOT NULL PRIMARY KEY, 
     id_reserva   INT NOT NULL, 
     id_servicio INT NOT NULL, 
     fecha       TIMESTAMP WITHOUT TIME ZONE NOT NULL, 
     cantidad    INT NOT NULL, 
     precio      NUMERIC(10,2) NOT NULL,
     FOREIGN KEY (id_reserva) REFERENCES reserva_habitacion (id), 
     FOREIGN KEY (id_servicio ) REFERENCES servicio (id) 
  ); 

INSERT INTO gastos 
            (id_reserva, 
             id_servicio, 
             fecha, 
             cantidad, 
             precio) 
VALUES      ( 1, 
              1, 
              '2009-03-15 12:00', 
              1, 
              10); 

INSERT INTO gastos 
            (id_reserva, 
             id_servicio, 
             fecha, 
             cantidad, 
             precio) 
VALUES      (1, 
             1, 
             '2009-03-15 11:00', 
             1, 
             10); 

INSERT INTO gastos 
            (id_reserva, 
             id_servicio, 
             fecha, 
             cantidad, 
             precio)
VALUES      (4, 
             2, 
             '2009-03-15 09:30', 
             1, 
             2); 
