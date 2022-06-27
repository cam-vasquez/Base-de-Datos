USE Airport_Management; 				

    ---* EJERCICIO 1

/* Crear una función que reciba como parámetros 2 fechas y que retorne una tabla. La función deberá retornar el detalle de los vuelos en ese rango de fechas, incluyendo el nombre de los aeropuertos de destino y origen, así como el avión que se utilizará para realizar el vuelo.*/

    ---* EJERCICIO 2

/* Los clientes VIP tienen acceso a una serie de servicios adicionales en los distintos aeropuertos que visitan, por lo que se solicita que defina la lista de clientes VIP. El criterio de evaluación consiste en verificar que el promedio de las reservas realizadas por un cliente sea mayor a 1799.00. En la evaluación se debe tener en cuenta todos los servicios extra que incluyan los clientes en las reservas.

Actualizar la tabla PASAJERO incluyendo una columna con el nombre VIP de tipo entero, actualizar con "0" a la columna VIP de todos los pasajeros. Crear un procedimiento almacenado que calcule la lista de pasajeros VIP que almacenará en un cursor (Se sugiere realizar este paso basándose en el criterio y solución del ejercicio 1 del laboratorio 4), luego, el procedimiento almacenado recorrerá el cursor y actualizará la columna VIP de todos los pasajeros en la tabla PASAJERO con el valor de "1". */

/* 
SELECT  PASAJEROS_COMPRAS.id_pasajero 'Id_Pasajero', PASAJEROS_COMPRAS.pasajero_nombre 'Nombre', 
    AVG(PASAJEROS_COMPRAS.costo + subtotal_servicios) 'Promedio Reservas'
FROM(
SELECT ps.id 'id_pasajero', ps.nombre 'pasajero_nombre', r.costo,
    ISNULL(SUM(S.precio),0) AS subtotal_servicios
FROM RESERVA r
INNER JOIN PASAJERO ps
    ON ps.id = r.id_pasajero 
LEFT JOIN EXTRA x
    ON x.id_reserva = r.id
LEFT JOIN SERVICIO s
    ON  s.id = x.id_servicio
GROUP BY ps.nombre, ps.id, r.costo)
PASAJEROS_COMPRAS
GROUP BY PASAJEROS_COMPRAS.pasajero_nombre, PASAJEROS_COMPRAS.id_pasajero
HAVING (AVG(PASAJEROS_COMPRAS.costo + subtotal_servicios)) >= 1799.00
;
*/

ALTER TABLE PASAJERO ADD vip TINYINT NOT NULL DEFAULT 0;

UPDATE PASAJERO SET vip = 1 
WHERE id IN (
	SELECT PASAJEROS_COMPRAS.id_pasajero 
FROM(
    SELECT psj.id 'id_pasajero', psj.nombre 'pasajero_nombre', rsv.costo 'costo', ISNULL(SUM(srv.precio), 0) AS subtotal_servicios
    FROM RESERVA rsv
    INNER JOIN PASAJERO psj
        ON psj.id = rsv.id_pasajero
    LEFT JOIN EXTRA x 
        ON x.id_reserva = rsv.id
    LEFT JOIN SERVICIO srv 
        ON srv.id = x.id_servicio
    GROUP BY psj.nombre, psj.id, rsv.costo
)
PASAJEROS_COMPRAS
GROUP BY PASAJEROS_COMPRAS.pasajero_nombre, PASAJEROS_COMPRAS.id_pasajero
HAVING (AVG(PASAJEROS_COMPRAS.costo + subtotal_servicios)) >= 1799.00
);

SELECT * FROM PASAJERO;
