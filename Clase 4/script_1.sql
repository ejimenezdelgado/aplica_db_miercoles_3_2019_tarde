CREATE TABLE usuario
(
  id serial NOT NULL,
  nombre character varying(50) NOT NULL,
  clave character varying(100),
  fecha_creacion timestamp without time zone NOT NULL,
  activo boolean NOT NULL DEFAULT false
);