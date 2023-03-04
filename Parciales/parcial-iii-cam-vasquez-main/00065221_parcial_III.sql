USE DB_00065221;
GO

------- EJERCICIO 1 -----------

---* Parte 1

/* Crear una función que reciba como parámetro el id de una factura la función retornará el subtotal calculado a
partir de los platillos consumidos en el servicio. El tipo de dato que retornará la función será DECIMAL. */

/* SELECT F.id, F.fecha, F.id_cliente, F.id_restaurante, SUM(P.precio)
'subtotal plato'
FROM FACTURA F
LEFT JOIN DETALLE_PLATO DP
ON F.id = DP.id_factura
LEFT JOIN PLATO P
ON P.id = DP.id_plato
GROUP BY F.id, F.fecha, F.id_cliente, F.id_restaurante;
GO */

CREATE FUNCTION GET_RECEIPT_PLATES(@id_factura INT)
    RETURNS FLOAT
AS BEGIN 
        DECLARE @subtotal_plates FLOAT;

        SELECT @subtotal_plates = SUM(P.precio)
        FROM FACTURA F
        LEFT JOIN DETALLE_PLATO DP
            ON F.id = DP.id_factura
        LEFT JOIN PLATO P
            ON P.id = DP.id_plato
        WHERE @id_factura = F.id
        GROUP BY F.id, F.fecha, F.id_cliente, F.id_restaurante;

		RETURN @subtotal_plates;
END;
GO

SELECT dbo.GET_RECEIPT_PLATES(1);
GO


---* Parte 2

/* Crear una función que reciba como parámetro el id de una factura la función retornará el subtotal calculado a
partir de los postres consumidos en el servicio. El tipo de dato que retornará la función será DECIMAL. */

/* SELECT F.id, F.fecha, F.id_cliente, F.id_restaurante, SUM(P.precio)
'subtotal postre'
FROM FACTURA F
LEFT JOIN DETALLE_POSTRE DP
ON F.id = DP.id_factura
LEFT JOIN POSTRE P
ON P.id = DP.id_postre
GROUP BY F.id, F.fecha, F.id_cliente, F.id_restaurante;
GO
 */

CREATE FUNCTION GET_RECEIPT_DESSERTS(@id_factura INT)
    RETURNS FLOAT
AS BEGIN 
        DECLARE @subtotal_desserts FLOAT;

        SELECT @subtotal_desserts = SUM(P.precio) 
        FROM FACTURA F
        LEFT JOIN DETALLE_PLATO DP
            ON F.id = DP.id_factura
        LEFT JOIN POSTRE P
            ON P.id = DP.id_plato
        WHERE @id_factura = F.id
        GROUP BY F.id, F.fecha, F.id_cliente, F.id_restaurante;

		RETURN @subtotal_desserts;
END;
GO


--SELECT dbo.GET_RECEIPT_DESSERTS(7);
--GO

DROP FUNCTION GET_RECEIPT_DESSERTS;
GO

------- EJERCICIO 2 -----------

/* Crear una función que reciba como parámetros valores que representan dos fechas, el tipo de dato debe ser
DATE. La función retornará la lista de facturas registradas en la base de datos en el rango de fechas definidas
como parámetros. El resultado debe incluir el subtotal de platos, el subtotal de postres y el total (suma del
subtotal de platos + subtotal de postres). Para calcular los subtotales, la función debe hacer uso de las dos
funciones creadas en el ejercicio 1.
 */


SELECT * FROM FACTURA;
GO


CREATE FUNCTION GET_RECEIPTS(@initial_date DATE, @final_date DATE)
RETURNS TABLE
AS
    RETURN
    SELECT  f.id, f.fecha, f.id_cliente, f.id_restaurante, SUM(p.precio) 'Subtotal Platos', SUM(pt.precio) 'Subtotal Postres', ISNULL(SUM(p.precio) + SUM(pt.precio),0) 'Total'
    FROM FACTURA f
    LEFT JOIN DETALLE_PLATO dp
        ON f.id = DP.id_factura
    LEFT JOIN PLATO p
        ON p.id = DP.id_plato
    LEFT JOIN POSTRE pt
        ON P.id = DP.id_plato
    WHERE f.fecha BETWEEN @initial_date AND @final_date
    GROUP BY f.id, f.fecha, f.id_cliente, f.id_restaurante;
;
GO

SELECT * FROM dbo.GET_RECEIPTS('2022-01-01', '2022-01-30');
GO



------- EJERCICIO 3 -----------

/* Crear un procedimiento almacenado que reciba como parámetros el id de un restaurante (INT), y dos fechas
(VARCHAR). El procedimiento deberá hacer uso de la función creada en el ejercicio 2 para poder obtener las
ganancias de un restaurante específico en un rango de fechas.

 */

SELECT r.nombre, r.id, COUNT(f.id_restaurante) 'num Facturas'
FROM FACTURA f
LEFT JOIN RESTAURANTE r 
ON f.id_restaurante = r.id
GROUP BY r.nombre, r.id
ORDER BY  r.id
;
GO

SELECT * FROM FACTURA;
GO

CREATE OR ALTER PROCEDURE PROFITS_RESTAURANT
    @id_restaurante INT,
    @id_cliente INT,
    @initial_date VARCHAR,
    @final_date VARCHAR
AS 

BEGIN 
	---* Validación de el num de facruras registradas de restaurante
    DECLARE @num_facturas INT;
    SELECT @num_facturas = COUNT(id_restaurante) FROM FACTURA f;

    BEGIN TRY
	PRINT 'La factura registrada del restaurante' + f.id_restaurante + 'son';
        INSERT INTO FACTURA(id, id_cliente, id_restaurante, fecha) VALUES(@num_facturas +1, @id_cliente, @id_restaurante, CONVERT(DATETIME, @initial_date, 103), CONVERT(DATETIME, @final_date, 103))
    END TRY
    BEGIN CATCH
		PRINT ERROR_MESSAGE();
	END CATCH;
END;
GO

---------------------
INSERT INTO FACTURA VALUES(31, CONVERT(DATE,'05/07/2022',103), 10, 1);
INSERT INTO FACTURA VALUES(32, CONVERT(DATE,'05/07/2022',103), 10, 2);
INSERT INTO FACTURA VALUES(33, CONVERT(DATE,'05/07/2022',103), 10, 5);
INSERT INTO FACTURA VALUES(34, CONVERT(DATE,'05/07/2022',103), 10, 4);
INSERT INTO FACTURA VALUES(35, CONVERT(DATE,'05/07/2022',103), 10, 2);
INSERT INTO FACTURA VALUES(36, CONVERT(DATE,'05/07/2022',103), 10, 1);
GO
---------------------
------------ Ejercicio 5 -------

/* Crear un TRIGGER que permita cumplir con la siguiente disposición de la cadena de restaurantes: cada cliente
solo puede generar 5 facturas en un día específico. Si un cliente desea generar una sexta factura en un mismo
día la instrucción fallará.
 */

CREATE OR ALTER TRIGGER CHECK_RECEIPT_BY_CLIENT ON FACTURA AFTER INSERT
AS BEGIN
-- DECLARANDO VARIABLES
	DECLARE @id_cliente INT;
    DECLARE @id_restaurante INT;
    DECLARE @initial_date VARCHAR;
    DECLARE @final_date VARCHAR;


SELECT  f.id, f.fecha, f.id_cliente, f.id_restaurante, SUM(p.precio) 'Subtotal Platos', SUM(pt.precio) 'Subtotal Postres', ISNULL(SUM(p.precio) + SUM(pt.precio),0) 'Total'
    FROM FACTURA f
    LEFT JOIN DETALLE_PLATO dp
        ON f.id = DP.id_factura
    LEFT JOIN PLATO p
        ON p.id = DP.id_plato
    LEFT JOIN POSTRE pt
        ON P.id = DP.id_plato
    WHERE f.fecha BETWEEN @initial_date AND @final_date
    GROUP BY f.id, f.fecha, f.id_cliente, f.id_restaurante;

    DECLARE @num_facturas INT;
    SELECT @num_facturas = COUNT(id_restaurante) FROM FACTURA f;


		IF(@num_facturas <= 5)
			BEGIN
				PRINT 'La factura ha sido almacendad exitosamente';	
			END;
            ELSE
            BEGIN
				PRINT 'ERROR: No es posible registrar otra factura porque ha exidido el maximo de 6 por día';
       			ROLLBACK TRANSACTION;
            END;
    
END;
GO

