--    SECCION 14
CREATE TABLE PRODUCTOS 
(
 CODIGO NUMBER NOT NULL 
, NOMBRE VARCHAR2(100) NOT NULL 
, PRECIO NUMBER NOT NULL 
, UNIDADES NUMBER 
, FECHA_ALTA DATE 
);

INSERT INTO productos VALUES(1,'TORNILLOS',100,10,'01-09-2017');

INSERT INTO productos VALUES(2,'TUERCA',50,5,'01-10-2009');


INSERT INTO productos (CODIGO,NOMBRE,PRECIO) VALUES(3,'MARTILLO',90);

/*¿Este INSERT funciona? 
INSERT INTO PRODUCTOS (CODIGO,NOMBRE,unidades)
VALUES (4,'Arandela',10);*/

INSERT INTO productos (CODIGO,NOMBRE,PRECIO)
VALUES (4,'Arandela',10);

--Crear la siguiente tabla

CREATE TABLE PRODUCTOS2
(CODE NUMBER,
NAME VARCHAR2(100));

/*Insertar en la tabla PRODUCTOS2 las filas de la tabla PRODUCTOS 
que tengan más de 8 unidades. Comprobar las filas
*/

INSERT INTO productos2 (CODE,NAME)
SELECT CODIGO,NOMBRE FROM productos WHERE productos.unidades > 8;

/*Modificar el campo NOMBRE de la tabla PRODUCTOS y poner en 
mayúsculas el nombre de aquellas filas que valgan más de 50.*/

UPDATE productos
SET NOMBRE =UPPER(NOMBRE) WHERE precio > 50;

/* Modificar el precio de la tabla productos de aquellas filas cuyo nombre 
comienza por ‘T’. Debemos incrementarlo en 5.*/

UPDATE productos 
SET PRECIO = PRECIO + 5
WHERE UPPER(NOMBRE) LIKE 'T%';


/* Borrar las filas de la tabla productos que tengan menos de 10 unidades 
o un valor nulo. Comprobar el resultado
*/
DELETE  productos
WHERE unidades < 10 OR unidades IS NULL;


/* Truncar la tabla PRODUCTOS2. Comprobar el resultado*/

TRUNCATE TABLE PRODUCTOS2;

