 --    SECCION 16
 
 --Crear la siguiente tabla usando el comando CREATE TABLE
 -- Comprobar con el comando DESC que existe y que tiene esa estructura

CREATE TABLE SECCION16(
COD_MATRICULA NUMBER ,
NOMBRE VARCHAR2(20 BYTE),
APELLIDO1 VARCHAR2(20 BYTE),
APELLIDO2 VARCHAR2(20 BYTE),
EDADI NUMBER,
FECHA_MATRICULA DATE
);

DESC SECCION16;

--Crear una tabla denominada CENTROS, con la siguiente estructura.

CREATE TABLE CENTROS(
CODIGO_CENTRO NUMBER,
NOMBRE VARCHAR2(100),
PROVINCIA VARCHAR2(100) DEFAULT 'MADRID',
FECHA_ALTA DATE DEFAULT SYSDATE,
NUM_ALUMNOS NUMBER DEFAULT 0
);

/* Insertar una fila que no tengo los tres últimos campos y comprobar que 
lo genera de forma automática*/

INSERT INTO CENTROS (CODIGO_CENTRO,NOMBRE) VALUES(1,'NACHO');

SELECT * FROM CENTROS;

/* Crear la siguiente tabla con las características indicadas
o Tabla CURSOS
▪ COD_CURSO NUMBER Y CLAVE PRIMARIA
▪ NOMBRE VARCHAR2(100) NO PUEDE SER NULO Y 
DEBE SER ÚNICO
▪ RESPONSABLE VARCHAR2(100)*/

CREATE TABLE CURSOS(
COD_CURSO NUMBER PRIMARY KEY,
NOMBRE VARCHAR(100) NOT NULL UNIQUE,
RESPONSABLE VARCHAR2(100)
);

DESC CURSOS;

/* Insertar algunas filas y comprobar que funciona la calve primaria y 
la clave única/not null*/
INSERT INTO CURSOS (COD_CURSO,NOMBRE) VALUES(1,'NACHO');
--INCORRECTOS
INSERT INTO CURSOS (COD_CURSO,NOMBRE) VALUES(1,'RAFA');
INSERT INTO CURSOS (COD_CURSO,NOMBRE) VALUES(2,'NACHO');
--CORRECTOS
INSERT INTO CURSOS (COD_CURSO,NOMBRE) VALUES(2,'RAFA');
INSERT INTO CURSOS (COD_CURSO,NOMBRE) VALUES(3,'LEO');


-- Otras constraints, crear tablas de otras, borrar tablas

-- Crear la siguiente tabla PAISES
CREATE TABLE PAISES(
COD_PAIS NUMBER PRIMARY KEY,
NOMBRE VARCHAR(100) NOT NULL CHECK(NOMBRE=UPPER(NOMBRE))
);


-- Crear la siguiente tabla CIUDADES con las siguientes características
CREATE TABLE CIUDADES(
COD_CIUDAD NUMBER PRIMARY KEY,
NOMBRE VARCHAR(100) NOT NULL CHECK(NOMBRE=UPPER(NOMBRE)),
POBLACION NUMBER NOT NULL CHECK(POBLACION > 0),
COD_PAIS NUMBER REFERENCES PAISES(COD_PAIS)
);
/*
Insertar una fila en PAISES, por ejemplo 28, ESTADOS UNIDOS
Insertar otra fila con el nombre en minúsculas, por ejemplo 29, Francia. 
Debe generar un error de CHEK. */
INSERT INTO PAISES VALUES(28,'ESTADOS UNIDOS');

INSERT INTO PAISES VALUES(29,'Francia');

INSERT INTO PAISES VALUES(29,'FRANCIA');

INSERT INTO PAISES VALUES(10,'ARGENTINA');

/*Insertar alguna fila en la tabla CIUDADES, por ejemplo (1,NUEVA 
YORK,4000000,28) Debe funcionar correctamente porque cumple todas 
las constraints
*/
INSERT INTO CIUDADES VALUES(1,'NUEVA YORK',400000,28);

/*Intentar insertar una fila de algún país que no exista. Por ejemplo 
(2,ROMA,3000000,40). Debe generar un error ya que el país 40 no 
existe en la tabla PAISES
*/

INSERT INTO CIUDADES VALUES(2,'ROMA',300000,40);

/* Insertar ITALIA con el código 40 en la tabla PAISES*/

INSERT INTO PAISES VALUES(40,'ITALIA');

-- Volver a insertar la fila con ROMA. Debería funcionar.

INSERT INTO CIUDADES VALUES(2,'ROMA',300000,40);

/* Intentar grabar una ciudad con el nombre en minúsculas. Debe generar 
un error*/

INSERT INTO CIUDADES VALUES(1,'Toronto',400000,28);

/*Intentar grabar una ciudad con una población de 0. Debe generar un 
error*/

INSERT INTO CIUDADES VALUES(1,'TORONTO',0,28);

/* Insertamos varias ciudades con poblaciones entre 1.000.000 y 5.000.000
*/

INSERT INTO CIUDADES VALUES(3,'JUJUY',4000000,28);

INSERT INTO CIUDADES VALUES(4,'MEDELLIN',2000000,28);

INSERT INTO CIUDADES VALUES(5,'LA UNION',1000000,28);

/* Creamos una tabla denominada CIUDADES_PEQUE, basada en 
CIUDADES, pero solo con las que tengan una población inferior a 
2.000.000. Lo hacemos mediante la opción de crear una tabla basada en 
otra*/

CREATE TABLE CIUDADES_PEQUES
AS SELECT * FROM CIUDADES WHERE POBLACION < 2000000;

/* Añadimos la clave primaria a CIUDADES_PEQUE sobre la columna 
CODIGO*/

ALTER TABLE CIUDADES_PEQUES
MODIFY (COD_CIUDAD NUMBER NOT NULL PRIMARY KEY);

/* Añadimos una nueva columna a la tabla llamada BANDERA de tipo 
VARCHAR2(100)*/

ALTER TABLE CIUDADES_PEQUES 
ADD (BANDERA VARCHAR2(100));

/* Añadimos alguna fila y comprobamos el resultado*/

INSERT INTO  CIUDADES_PEQUES VALUES(6,'CORDOBA',10000,10,'ARGENTINA');

/* Eliminamos la columna BANDERA*/

 ALTER TABLE CIUDADES_PEQUES DROP(BANDERA);
 DESC CIUDADES_PEQUES;
 
/* Borramos la tabla CIUDADES_PEQUE*/

DROP TABLE CIUDADES_PEQUES;


/*                             Índices, secuencias y Vistas                  */
 
 /* Crear una vista llamada CIUDADES_GRANDES con las ciudades que 
tengan más de 3.000.000 de habitantes*/

CREATE VIEW CIUDADES_GRANDES
AS SELECT * FROM CIUDADES WHERE poblacion > 3000000;
  
/* Comprobar que funciona*/ 

SELECT * FROM CIUDADES_GRANDES;
  
/* Crear una vista llamada CIUDADES_USA con las ciudades de Estados 
Unidos (código 18 según la práctica anterior)
*/ 
 CREATE VIEW CIUDADES_USA 
 AS SELECT * FROM CIUDADES WHERE cod_pais=28;
 
 /* Comprobar que funciona*/ 

SELECT * FROM CIUDADES_GRANDES;
 
/* Borrar las dos vistas*/ 
DROP VIEW CIUDADES_GRANDES;
DROP VIEW CIUDADES_USA;
 
 
-- Crear un índice en la tabla ciudades sobre el nombre de la ciudad

CREATE INDEX INDEX1 ON CIUDADES(NOMBRE); 
 
/* Crear una secuencia denominada SEQ1, que comience por 1 y que 
devuelve números de 5 en cinco.*/ 

CREATE SEQUENCE SEQ1 INCREMENT BY 5
MAXVALUE 50 MINVALUE 1 CACHE 20;
 
/* Insertar un par de países usando la secuencia como clave primaria, en 
vez de poner un número directamente
*/

 INSERT INTO PAISES (cod_pais,nombre) VALUES(SEQ1.NEXTVAL,'MARRUECO');
 INSERT INTO PAISES (cod_pais,nombre) VALUES(SEQ1.NEXTVAL,'URUGUAY');
 INSERT INTO PAISES (cod_pais,nombre) VALUES(SEQ1.NEXTVAL,'COLOMBIA');
 -- Comprobar el resultado

 SELECT * FROM PAISES;