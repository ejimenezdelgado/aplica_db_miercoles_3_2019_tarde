-- Crear base de datos y tablas

CREATE TABLE tipo_cambio (
    id serial NOT NULL,
    nombre CHARACTER VARYING (100) NOT NULL,
    tipo_moneda CHARACTER VARYING (10) NOT NULL,
    url CHARACTER VARYING (250),
    CONSTRAINT pk_tipo_cambio PRIMARY KEY (id)
);

CREATE TABLE tipo_cambio_historico (
    id serial NOT NULL,
    monto numeric(10,4) NOT NULL,
    id_tipo_cambio INTEGER NOT NULL,
    fecha TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    CONSTRAINT pk_tipo_cambio_historico PRIMARY KEY (id),
    CONSTRAINT fk_tipo_cambio_tipo_cambio_historico FOREIGN KEY (id_tipo_cambio) REFERENCES tipo_cambio (id)
);