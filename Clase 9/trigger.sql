CREATE TABLE empleados 
  ( 
     documento CHAR(8) NOT NULL, 
     nombre    VARCHAR(30) NOT NULL, 
     domicilio VARCHAR(30), 
     seccion   VARCHAR(20), 
     CONSTRAINT pk_empleados PRIMARY KEY(documento), 
  ); 

INSERT INTO empleados 
VALUES     ('22222222', 
            'Ana Acosta', 
            'Bulnes 56', 
            'Secretaria'); 

INSERT INTO empleados 
VALUES     ('23333333', 
            'Bernardo Bustos', 
            'Bulnes 188', 
            'Contaduria'); 

INSERT INTO empleados 
VALUES     ('24444444', 
            'Carlos Caseres', 
            'Caseros 364', 
            'Sistemas'); 

INSERT INTO empleados 
VALUES     ('25555555', 
            'Diana Duarte', 
            'Colon 1234', 
            'Sistemas'); 

INSERT INTO empleados 
VALUES     ('26666666', 
            'Diana Duarte', 
            'Colon 897', 
            'Sistemas'); 

INSERT INTO empleados 
VALUES     ('27777777', 
            'Matilda Morales', 
            'Colon 542', 
            'Gerencia'); 

go 

; 
CREATE TRIGGER tr_empleados_borrar 
ON empleados 
FOR DELETE 
AS 
    IF (SELECT Count(*) 
        FROM   deleted) > 1 
      BEGIN 
          RAISERROR('No puede eliminar más de un 1 empleado',16,1) 

          ROLLBACK TRANSACTION 
      END; 

go 

; 
CREATE TRIGGER tr_empleados_validacion 
ON empleados 
FOR DELETE 
AS 
    IF ( Len(old.nombre) ) < 0 
      BEGIN 
          RAISERROR('No puede eliminar más de un 1 empleado',16,1) 

          ROLLBACK TRANSACTION 
      END; 

go 

; 
CREATE TRIGGER tr_empleados_actualizar 
ON empleados 
FOR UPDATE 
AS 
    IF UPDATE(documento) 
      BEGIN 
          RAISERROR('No puede modificar el documento de los empleados',16,1) 

          ROLLBACK TRANSACTION 
      END; 

go 

; 
CREATE TRIGGER tr_empleados_insertar 
ON empleados 
FOR INSERT 
AS 
    IF (SELECT seccion 
        FROM   inserted) = 'Gerencia' 
      BEGIN 
          RAISERROR('No puede ingresar empleados en la sección "Gerencia".',16, 
                    1) 

          ROLLBACK TRANSACTION 
      END; 

    DELETE FROM empleados 
    WHERE  domicilio LIKE 'Bulnes%'; 

    ALTER TABLE empleados 
      disable TRIGGER tr_empleados_borrar; 

    DELETE FROM empleados 
    WHERE  domicilio LIKE 'Bulnes%'; 

    SELECT * 
    FROM   empleados; 

    UPDATE empleados 
    SET    documento = '23030303' 
    WHERE  documento = '23333333'; 

    INSERT INTO empleados 
    VALUES     ('28888888', 
                'Juan Juarez', 
                'Jamaica 123', 
                'Gerencia'); 

    ALTER TABLE empleados 
      disable TRIGGER tr_empleados_actualizar, tr_empleados_insertar; 

    UPDATE empleados 
    SET    documento = '20000444' 
    WHERE  documento = '24444444'; 

    SELECT * 
    FROM   empleados; 

    INSERT INTO empleados 
    VALUES     ('28888888', 
                'Juan Juarez', 
                'Jamaica 123', 
                'Gerencia'); 

    SELECT * 
    FROM   empleados; 

    ALTER TABLE empleados 
      enable TRIGGER ALL; 

    UPDATE empleados 
    SET    documento = '30000000' 
    WHERE  documento = '28888888'; 