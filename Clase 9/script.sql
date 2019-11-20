CREATE TABLE pruebasql
(
	id INT,
	valor VARCHAR(30),
	fecha DATETIME
);

GO

--DROP PROCEDURE InsertaPruebaSQL;
CREATE PROCEDURE InsertaPruebaSQL
AS
DECLARE @maxValor int
BEGIN
	SELECT @maxValor = ISNULL(MAX(id),0)
	FROM pruebasql;
	INSERT INTO pruebasql (id,valor,fecha)
	VALUES (@maxValor+1,'Valor de prueba',
	        GETDATE());
END

GO

--DELETE FROM pruebasql;
SELECT *
FROM pruebasql;

GO

EXEC InsertaPruebaSQL;

GO
-- Procedimiento que devuelve los valores de las 
-- variables de error de SQL Server
CREATE PROCEDURE ObtenerInfoErrores
AS
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage;
	GO
	-- Bloque para probar el procedimiento
	BEGIN
		BEGIN TRY
			-- Generar un error de división por cero
			SELECT 1/0;
		END TRY
	BEGIN CATCH
		-- Ejecutar el procedimiento que obtiene los errores
		EXECUTE ObtenerInfoErrores;
	END CATCH;
END;


----------------------------------------------------------------------------
CREATE TABLE CUENTAS (
	numCuenta VARCHAR(20),
	saldo DECIMAL(10,2)
);

GO;

INSERT INTO CUENTAS (numCuenta,saldo)
VALUES ('A1',-100);
INSERT INTO CUENTAS (numCuenta,saldo)
VALUES ('A2',200);
INSERT INTO CUENTAS (numCuenta,saldo)
VALUES ('A3',300);

GO;

CREATE PROCEDURE ObtenerSaldoCuenta
	@numCuenta varchar(20),
	@saldo decimal(10,2) OUTPUT
AS
BEGIN
	SELECT @saldo as valor_entrada_saldo
	SELECT @saldo = saldo
	FROM cuentas
	WHERE numcuenta = @numCuenta
END

--Prueba de procedimiento con parámetros de salida.

--Declarar una variable
declare @saldoPrueba decimal(10,2);

--iniciar el bloque
Begin
	--Establecer un valor inicial a la variable
	set @saldoPrueba =25;
	select @saldoPrueba as ValorOriginalSaldo;

	--Ejecuta el procedimiento llevándose la variable
	execute ObtenerSaldoCuenta 'A2',
	@saldoPrueba output;

	--Mostrar la variable después de ejecutar el SP.
	select @saldoPrueba as ValorSalidaSaldo;
END

GO
--------------------------------------------------------------------
CREATE PROCEDURE CuentaConSaldoNegativo @numCuenta
varchar(20)
AS
BEGIN
	IF (SELECT SALDO FROM CUENTAS WHERE NUMCUENTA =
	@numCuenta) < 0
	BEGIN
		RETURN 1
	END
ELSE
	RETURN 0
END
--Prueba de procedimiento que devuelve valores
DECLARE @rv INT
EXEC @rv = CuentaConSaldoNegativo   'A2'
SELECT CASE @rv WHEN 0 THEN 'Si' ELSE 'No' END AS EsNegativo;

GO

USE AdventureWorks2008R2; --Se debe usar la base de datos AdventureWorks2008R2 facilitada en clase
GO
-------------------------Creación de la función-----------------
CREATE FUNCTION dbo.ufnGetInventoryStock(@ProductID int)
RETURNS int   -- Se establece que la función devolverá un dato de tipo entero
AS
-- Devuelve el nivel de inventario disponible para un producto dado.
BEGIN
	DECLARE @ret int; -- Se declara una variable del mismo tipo del retorno de 
	--la función
	-----Se obtiene la cantidad de elementos en el inventario y se asigna a la 
	--variable @ret
	SELECT @ret = SUM(p.Quantity)
	FROM Production.ProductInventory p
	WHERE p.ProductID = @ProductID
	AND p.LocationID = '6';
	-----
	IF (@ret IS NULL) -- Si @ret terminó siendo NULL se le pone un cero
	SET @ret = 0;
	-----
	RETURN @ret; --Devolver el valor de @ret como valor de retorno de la función
END;
GO
---------------------------Prueba de la función -----------------
SELECT ProductModelID, Name, dbo.ufnGetInventoryStock(ProductID)AS CurrentSupply
FROM Production.Product
WHERE ProductModelID BETWEEN 75 and 80;

GO

---------------------------------------------------------------------------
CREATE FUNCTION Sales.ufn_SalesByStore (@storeid int)
RETURNS TABLE
AS
RETURN
(
	SELECT P.ProductID, P.Name, SUM(SD.LineTotal) AS 'Total'
	FROM Production.Product AS P
	JOIN Sales.SalesOrderDetail AS SD ON SD.ProductID = P.ProductID
	JOIN Sales.SalesOrderHeader AS SH ON SH.SalesOrderID = SD.SalesOrderID
	JOIN Sales.Customer AS C ON SH.CustomerID = C.CustomerID
	WHERE C.StoreID = @storeid
	GROUP BY P.ProductID, P.Name
); 
GO
SELECT * FROM Sales.ufn_SalesByStore (602);
	
-----------------------------------------------------------------------------------------
GO

--Usar la base de datos AdventureWorks2008R2
--Creación de la función
CREATE FUNCTION 
dbo.OBTENER_PERSONAS_CON_CONSONANTES_INICIALES(@LetraInicio CHAR(1) -- Parámetro de la funcion
)
RETURNS @PERSONAS TABLE -- declaración de la tabla temporal que se devolverá
(ID INT,NOMBRE VARCHAR(50)
)
AS
BEGIN
	--Inserta en la "tabla temporal" @Personas a todas las personas que tengan su 
	--inicial del nombre mayor a la letra dada como parámetro
	INSERT INTO @PERSONAS (ID,NOMBRE)
	SELECT BusinessEntityID as ID,isnull(FirstName,'')+' '+isnull(MiddleName,'')+' '+
	isnull(LastName,'') as Nombre
	FROM Person.Person
	WHERE upper(SUBSTRING(FirstName,1,1))>upper(@LetraInicio)
	--Elimina de la "tabla temporal" todas las personas que tenga un nombre que empiece en vocal.
	DELETE FROM @PERSONAS WHERE upper(SUBSTRING(Nombre,1,1)) in ('A','E','I','O','U');
	RETURN; --Devolver los resultados
END;

GO

--Prueba de la función (solo trae personas que el nombre empiece con una letra superior a H pero que no sea vocal
select * from OBTENER_PERSONAS_CON_CONSONANTES_INICIALES('H');



