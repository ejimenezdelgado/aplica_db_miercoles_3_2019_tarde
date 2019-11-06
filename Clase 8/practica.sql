CREATE TABLE marca_articulo 
  ( 
     cod_marca   VARCHAR(20) NOT NULL, 
     descripcion VARCHAR(50) NOT NULL, 
     activo      VARCHAR(1), 
     CONSTRAINT pk_marca PRIMARY KEY (cod_marca), 
     CONSTRAINT marca_articulo_activo_check CHECK (activo = 's' OR activo = 'n') 
  ); 

CREATE TABLE articulo 
  ( 
     cod_articulo        VARCHAR(20) NOT NULL, 
     cod_marca           VARCHAR(20), 
     descripcion         VARCHAR(100) NOT NULL, 
     precio_default      NUMERIC(10, 2), 
     costo_proveedor     NUMERIC(10, 2), 
     cantidad_max        NUMERIC(10, 2), 
     cantidad_min        NUMERIC(10, 2), 
     activo              VARCHAR(1), 
     porcentaje_utilidad NUMERIC(10, 2), 
     existencia          NUMERIC(10, 2), 
     ubicacion           VARCHAR(100), 
     CONSTRAINT pk_articulo PRIMARY KEY (cod_articulo), 
     CONSTRAINT fk_marca_articulo FOREIGN KEY (cod_marca) REFERENCES 
     marca_articulo (cod_marca), 
     CONSTRAINT articulo_activo_check CHECK (activo = 's' OR activo = 'n') 
  ); 