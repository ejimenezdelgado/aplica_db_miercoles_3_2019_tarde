--Cursores en SQL Server 

CREATE TABLE categoria (
  idCategoria int PRIMARY KEY NOT NULL,
  nombreCategoria varchar(50) NOT NULL,
)
GO
INSERT INTO categoria
  VALUES (1, 'Computadoras')
INSERT INTO categoria
  VALUES (2, 'Accesorios')
GO
CREATE TABLE productos (
  codigo int PRIMARY KEY NOT NULL,
  producto varchar(50) NOT NULL,
  precio money NOT NULL,
  idCategoria int NOT NULL
  FOREIGN KEY (idCategoria) REFERENCES categoria,
)
GO
INSERT INTO productos
  VALUES (1, 'Laptop', 2500.00, 1)
INSERT INTO productos
  VALUES (2, 'Mouse', 50.00, 2)
INSERT INTO productos
  VALUES (3, 'Parlantes', 80.00, 2)
INSERT INTO productos
  VALUES (4, 'Audifonos', 20.00, 2)
GO

-- Crear un cursor que permita listar los productos
DECLARE cursorP CURSOR FOR
SELECT
  codigo,
  producto,
  precio
FROM productos
OPEN cursorP
DECLARE @cod int,
        @pro varchar(50),
        @pre money
FETCH NEXT FROM cursorP INTO @cod, @pro, @pre
WHILE @@fetch_status = 0
BEGIN
  PRINT 'Codigo :' + CAST(@cod AS varchar(10))
  PRINT 'producto :' + @pro
  PRINT 'Precio :' + CAST(@pre AS varchar(10))
  FETCH NEXT FROM cursorP INTO @cod, @pro, @pre
END
CLOSE cursorP
DEALLOCATE cursorP

-- Crear un cursor que permita mostrar los productos de cada categoría.
--Primera Opción
DECLARE cursorCP CURSOR FOR
SELECT
  idCategoria,
  nombreCategoria
FROM categoria
OPEN cursorCP
DECLARE @cat int,
        @nom varchar(50)
FETCH NEXT FROM cursorCP INTO @cat, @nom
WHILE @@fetch_status = 0
BEGIN
  PRINT 'Categoria : ' + @nom
  PRINT '=================================='
  DECLARE cursorCP1 CURSOR FOR
  SELECT
    codigo,
    producto,
    precio
  FROM productos
  WHERE idCategoria = @cat
  OPEN cursorCP1
  DECLARE @codpro int,
          @prod varchar(50),
          @prec money
  FETCH NEXT FROM cursorCP1 INTO @codpro, @prod, @prec
  WHILE @@fetch_status = 0
  BEGIN
    PRINT 'Codigo : ' + CAST(@codpro AS varchar(10))
    PRINT 'Producto : ' + @prod
    PRINT 'Precio : ' + CAST(@prec AS varchar(10))
    FETCH NEXT FROM cursorCP1 INTO @codpro, @prod, @prec
  END
  CLOSE cursorCP1
  DEALLOCATE cursorCP1
  FETCH NEXT FROM cursorCP INTO @cat, @nom
END
CLOSE cursorCP
DEALLOCATE cursorCP
GO

--Segunda Opción
DECLARE cursorCate CURSOR FOR
SELECT
  nombreCategoria,
  idCategoria
FROM categoria
DECLARE cursorProd CURSOR FOR
SELECT
  codigo,
  producto,
  precio,
  idCategoria
FROM productos
DECLARE @codcat int,
        @categoria varchar(50)
DECLARE @codprod int,
        @producto varchar(50),
        @precio decimal,
        @cate int
OPEN cursorCate
FETCH NEXT FROM cursorCate INTO @categoria, @codcat
WHILE @@FETCH_STATUS = 0
BEGIN
  PRINT '=================================='
  PRINT 'Categoria=' + UPPER(@categoria)
  PRINT '=================================='
  OPEN cursorProd
  FETCH NEXT FROM cursorProd INTO @codprod, @producto, @precio, @cate
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @cate = @codcat
    BEGIN
      PRINT 'Codigo=' + CAST(@codprod AS varchar(5))
      PRINT 'Producto=' + @producto
      PRINT 'Precio=' + CAST(@precio AS varchar(10))
    END
    ELSE
      SET @cate = 0
    FETCH NEXT FROM cursorProd INTO @codprod, @producto, @precio, @cate
  END
  CLOSE cursorProd
  FETCH NEXT FROM cursorCate INTO @categoria, @codcat
END
CLOSE cursorCate
DEALLOCATE cursorCate
DEALLOCATE cursorProd
GO

-- Crear un cursor que permita mostrar los libros publicados por autores peruanos

CREATE TABLE titulos (
  codigoTitulo int PRIMARY KEY NOT NULL,
  Titulo varchar(20) NOT NULL
)
CREATE TABLE autores (
  codigoAutor int PRIMARY KEY NOT NULL,
  nombres varchar(20) NOT NULL,
  apellidos varchar(40) NOT NULL,
  origen varchar(10) NOT NULL
)
CREATE TABLE titulos_autores (
  codigoTitulo int FOREIGN KEY (codigoTitulo) REFERENCES titulos NOT NULL,
  codigoAutor int FOREIGN KEY (codigoAutor) REFERENCES autores NOT NULL
)
GO
--Registros de prueba
INSERT INTO titulos
  VALUES (1, 'Prog. PHP')
INSERT INTO titulos
  VALUES (2, 'Prog. Visual Studio')
INSERT INTO titulos
  VALUES (3, 'Prog. Java')
INSERT INTO titulos
  VALUES (4, 'BD My SQL')
INSERT INTO titulos
  VALUES (5, 'BD SQL Server')
INSERT INTO titulos
  VALUES (6, 'BD Oracle')
GO
INSERT INTO autores
  VALUES (1, 'Riachard', 'Ortiz', 'Perú')
INSERT INTO autores
  VALUES (2, 'Darwin', 'Durand', 'Perú')
INSERT INTO autores
  VALUES (3, 'Nilton', 'Tataje', 'Perú')
GO
INSERT INTO titulos_autores
  VALUES (1, 1)
INSERT INTO titulos_autores
  VALUES (2, 2)
INSERT INTO titulos_autores
  VALUES (3, 3)
INSERT INTO titulos_autores
  VALUES (4, 1)
INSERT INTO titulos_autores
  VALUES (5, 2)
INSERT INTO titulos_autores
  VALUES (6, 3)
GO

CREATE PROCEDURE prod_Autores_Libros as

--Ahora creamos el cursor y ejecumatos
SET NOCOUNT ON
DECLARE @codigo varchar(11),
        @nombres varchar(20),
        @apellidos varchar(40),
        @mensaje varchar(80),
        @titulo varchar(80)
PRINT '*** Reporte de Libros y Autores ***'
DECLARE authors_cursor CURSOR FOR
SELECT
  codigoAutor,
  nombres,
  apellidos
FROM autores
WHERE origen = 'Perú'
ORDER BY codigoAutor
OPEN authors_cursor
FETCH NEXT FROM authors_cursor
INTO @codigo, @nombres, @apellidos
WHILE @@FETCH_STATUS = 0
BEGIN
  PRINT ''
  SELECT
    @mensaje = '* Libros del Autor: ' +
    @nombres + ' ' + @apellidos
  PRINT @mensaje
  DECLARE titles_cursor CURSOR FOR
  SELECT
    ti.Titulo
  FROM autores AS au
  INNER JOIN titulos_autores AS ta
    ON au.codigoAutor = ta.codigoAutor
  INNER JOIN titulos AS ti
    ON ta.codigoTitulo = ti.codigoTitulo
  WHERE au.codigoAutor = @codigo
  OPEN titles_cursor
  FETCH NEXT FROM titles_cursor INTO @titulo
  IF @@FETCH_STATUS <> 0
    PRINT 'No hay Libros'
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SELECT
      @mensaje = ' ' + @titulo
    PRINT @mensaje
    FETCH NEXT FROM titles_cursor INTO @titulo
  END
  CLOSE titles_cursor
  DEALLOCATE titles_cursor
  FETCH NEXT FROM authors_cursor
  INTO @codigo, @nombres, @apellidos
END
CLOSE authors_cursor
DEALLOCATE authors_cursor

EXEC prod_Autores_Libros
