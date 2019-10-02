
CREATE INDEX nombre_index
  ON usuario
  USING btree
  (nombre COLLATE pg_catalog."default");
