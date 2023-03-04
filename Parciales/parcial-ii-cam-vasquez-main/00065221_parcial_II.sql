

USE BD_PARCIAL_II;

-- Ejercicio 1

SELECT * FROM PLATO;

SELECT * FROM PLATO p
    ORDER BY p.precio DESC;
;

-- Ejercicio 2

SELECT * FROM RESTAURANTE;

SELECT * FROM RESTAURANTE
    WHERE direccion LIKE '[1|9]%';

-- Ejercicio 3

SELECT * FROM CLIENTE;

SELECT * FROM CLIENTE
    WHERE correo LIKE '%@%.org';

-- Ejercicio 4

SELECT * FROM FACTURA;

SELECT * FROM FACTURA
    WHERE fecha BETWEEN '2022-02-01' AND '2022-02-28'
;

SELECT * FROM FACTURA
    WHERE fecha BETWEEN '2022-03-01' AND '2022-03-31'
;

-- RESPUESTA

SELECT * FROM FACTURA
        WHERE fecha BETWEEN '2022-02-01' AND '2022-02-28' OR fecha BETWEEN '2022-03-01' AND '2022-03-31'

;

-- Ejercicio 5

SELECT * FROM PLATO;

SELECT * FROM PLATO p
    WHERE p.precio > 5
    ORDER BY p.precio ASC 
;

-- Ejercicio 6

SELECT * FROM POSTRE, DETALLE_POSTRE;

SELECT pt.nombre, pt.precio, dPt.id_factura FROM POSTRE pt, DETALLE_POSTRE dPt
    ORDER BY dPt.id_factura, pt.precio DESC 
    ;

-- Ejercicio 7


SELECT * FROM PLATO;

SELECT * FROM MENU;

SELECT p.nombre AS PLATO, p.precio AS Precio, mPlato.estacion AS Estacion
    FROM PLATO p, MENU mPlato
    WHERE mPlato.estacion = 'invierno'
    ORDER BY p.precio DESC
;

-- Ejercicio 8

SELECT * FROM POSTRE;

SELECT fac.id AS "Fact. #", fac.fecha, C.nombre, pt.nombre AS Postre
    FROM CLIENTE c, POSTRE pt, FACTURA fac
    WHERE c.nombre = 'Clementine Clarke'
    ORDER BY fac.fecha DESC
;

-- Ejercicio 9

SELECT * FROM PLATO;

SELECT * FROM MENU;

SELECT mPlato.nombre AS Menu, mPlato.estacion AS Estacion, p.precio
FROM PLATO p, MENU mPlato
    WHERE mPlato.id = p.id_menu 
    ORDER BY p.precio DESC  
;

-- Ejercicio 10

SELECT * FROM POSTRE;

SELECT * FROM FACTURA;

SELECT * FROM RESTAURANTE;

SELECT * FROM CLIENTE;

SELECT  fac.id AS "Fact. #", rest.nombre Restaurante, c.nombre Cliente, post.precio Precio
FROM FACTURA fac, RESTAURANTE rest, CLIENTE c, POSTRE post
    WHERE fac.id_cliente = c.id
    ORDER BY C.nombre, rest. nombre, post.precio ASC
;


-- Ejercicios

