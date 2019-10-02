
CREATE TABLE departamento
(
  id serial NOT NULL,
  nombre character varying(100) NOT NULL,
  CONSTRAINT pk_departamento PRIMARY KEY (id)
);

CREATE TABLE puesto
(
  id serial NOT NULL,
  nombre character varying(100) NOT NULL,
  admin boolean NOT NULL DEFAULT false,
  CONSTRAINT pk_puesto PRIMARY KEY (id)
);


CREATE TABLE empleado
(
  id serial NOT NULL,
  nombre character varying(25) NOT NULL,
  apellido character varying(50) NOT NULL,
  fecha_nacimiento timestamp without time zone NOT NULL,
  precio_hora numeric(10,2) NOT NULL,
  id_departamento integer NOT NULL,
  id_puesto integer NOT NULL,
  CONSTRAINT pk_empleado PRIMARY KEY (id),
  CONSTRAINT fk_empleado_departamento FOREIGN KEY (id_departamento)
      REFERENCES departamento (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_empleado_puesto FOREIGN KEY (id_puesto)
      REFERENCES puesto (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

