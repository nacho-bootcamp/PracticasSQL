--                        SESSION 7

/*Indicar los empleados que entraron en Mayo en la empresa. Debemos 
buscar por la abreviatura del mes*/
SELECT * FROM EMPLOYEES WHERE
TO_CHAR(HIRE_DATE,'MM')='05';


/* Indicar los empleados que entraron en el año 2007 usando la función 
to_char*/
SELECT FIRST_NAME,HIRE_DATE FROM EMPLOYEES WHERE
TO_CHAR(HIRE_DATE,'YYYY')= 2007;

-- ¿Qué día de la semana (en letra) era el día que naciste?
SELECT TO_CHAR(TO_DATE('30-04-2001'),'DAY') FROM DUAL;

/* Averiguar los empleados que entraron en el mes de Junio. Debemos 
preguntar por el mes en letra. Nota: La función TO_CHAR puede 
devolver espacios a la derecha)*/

SELECT FIRST_NAME,HIRE_DATE FROM EMPLOYEES WHERE 
RTRIM(TO_CHAR(HIRE_DATE,'MON'))='JUN';

/*Visualizar el salario de los empleados con dos decimales y en dólares y 
también en la moneda local (el ejemplo es con euros, suponiendo que el 
cambio esté en 0,79$)
*/
SELECT SALARY,TO_CHAR(SALARY,'$99,999.99')AS"DOLAR",
'€'||TO_CHAR(SALARY * 0.79,'99,999.99')AS "EURO" FROM EMPLOYEES;

--Convertir las siguientes cadenas a números:
SELECT TO_NUMBER('1210.73','9999.99') FROM DUAL;
SELECT TO_NUMBER('$127.2','L999.9') FROM DUAL;


/* Convertir los 3 primeros caracteres del número de teléfono en números y 
multiplicarlos por 2.*/

SELECT PHONE_NUMBER,TO_NUMBER(SUBSTR(PHONE_NUMBER,1,3))*2 AS MODIFICADO FROM 
EMPLOYEES;

/* Convertir las siguientes cadenas en fecha (NOTA: el mes lo debemos 
poner en el idioma que tengamos en el SqlDeveloper.*/

SELECT TO_DATE('10 DE FEBRERO DE 2018','dd "DE" MONTH "DE" YYYY')
FROM DUAL;

SELECT TO_DATE('FACTURA: MARZO0806','"FACTURA:" MONTHDDRR') FROM DUAL;
