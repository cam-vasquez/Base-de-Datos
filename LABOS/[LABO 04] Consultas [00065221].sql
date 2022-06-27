
USE Airport_Management; 				

--- Ejercicio 1

/* Los clientes VIP tienen acceso a una serie de servicios adicionales en los distintos aeropuertos que visitan, por lo que se solicita que defina la lista de clientes VIP. El criterio de evaluación consiste en verificar que el promedio de las reservas realizadas por un cliente sea mayor a 1799.00. En la evaluación se debe tener en cuenta todos los servicios extra que incluyan los clientes en las reservas. */

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

/* Ejercicio 2. Cada reserva tiene una fecha en la que fue realizada, una solicitud del departamento de finanzas del consorcio requiere la ganancia del mes de abril de 2021, pero los datos deben estar organizados por días. Como parte de la solicitud, se requiere que la fecha sea mostrada en un formato especial (ver imagen de vista esperada). Para calcular el valor de una reserva se debe tomar en cuenta tanto el precio de la reserva como la suma de todos los servicios extras incluidos. Restricción : El ejercicio debe realizarse en una consulta SELECT, sin utilizar la sentencia INTO, tablas temporales o bloques de programación (bloques anónimos, funciones o procedimientos almacenados). Sugerencia : Investigar sobre la instrucción CONVERT y su utilización en la instrucción SELECT. Sección del resultado esperado (El resultado contiene más filas) */

SELECT 
    CONVERT(VARCHAR, TOTAL_RESERVAXDIA.fecha, 106) 'Fecha Reserva', 
    SUM(TOTAL_RESERVAXDIA.costo) + SUM(subtotal_servicios) 'Ganancia del dia' 
FROM( 
SELECT r.fecha, r.costo, ISNULL(SUM(S.precio),0) AS subtotal_servicios
FROM RESERVA r
LEFT JOIN EXTRA x
    ON x.id_reserva = R.id
LEFT JOIN SERVICIO S
    ON x.id_servicio = S.id
GROUP BY R.fecha, R.costo) 
TOTAL_RESERVAXDIA
GROUP BY TOTAL_RESERVAXDIA.fecha
;

/* Ejercicio 3. La legislación internacional exige incluir un impuesto que depende de la clase seleccionada para cada reserva, la distribución actual impone los siguientes porcentajes: 

        Econommica              - 7% sobre el total de  la reserva 
        Ejecutivo               - 11% sobre el total de la reserva 
        Primera Clase           - 15% sobre el total de la reserva 

Por lo que se requiere mostrar las reservas realizadas, pero incluyendo el precio de cada reserva más el impuesto aplicado según la clase. Se deben mostrar los siguientes campos: el id de la reserva, la fecha, el id de la clase, el nombre de la clase, el total de la reserva sin impuesto aplicado y el total con el impuesto aplicado. Debe recordar que el total de la reserva se define a partir del precio de la reserva más la suma de todos los servicios extras incluidos. Restricciones : El ejercicio debe realizarse en una consulta SELECT, sin utilizar la sentencia INTO, tablas temporales o bloques de programación (bloques anónimos, funciones o procedimientos almacenados). Sugerencia : Investigar sobre la instrucción CASE y su utilización en la instrucción SELECT. Nota : El total de cada reserva se calcula de la siguiente forma: costo de la reserva + (suma de todos los servicios extra contratados). Tener en cuenta que no todas las reservas incluyen servicios extras. Sección del resultado esperado (el resultado contiene más filas): */

-- el id de la reserva, la fecha, el id de la clase, el nombre de la clase, el total de la reserva sin impuesto aplicado y el total con el impuesto aplicado.

SELECT r.id 'Reserva_ ID', r.fecha 'Fecha Reserva', c.id 'Clase_ID', c.clase 'Clase',
    CASE 
        WHEN r.id = c.id THEN ISNULL(SUM(s.precio),0) + r.costo
        ELSE ISNULL(SUM(S.precio),0) + r.costo 
        END 'Total libre de impuesto',
    CASE  
        WHEN c.id = 1 THEN ((ISNULL(SUM(s.precio),0) + r.costo) * 0.07) + ISNULL(SUM(s.precio), 0) + r.costo
        WHEN c.id = 2 THEN ((ISNULL(SUM(s.precio),0) + r.costo) * 0.11)+ ISNULL(SUM(s.precio), 0) + r.costo  
        ELSE ((ISNULL(SUM(S.precio),0) + r.costo)*0.15)+ ISNULL(SUM(s.precio),0) + r.costo 
        END 'Total aplicado el impuesto'
FROM EXTRA x
LEFT JOIN SERVICIO s
    ON x.id_servicio = s.id
RIGHT JOIN RESERVA r
    ON x.id_reserva = r.id
INNER JOIN CLASE c
    ON r.id_clase = c.id
GROUP BY r.id, c.id,R.costo, r.fecha, c.id, c.clase
ORDER BY r.id ASC
;

