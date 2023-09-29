--                   SECCION 8

/*
De la tabla LOCATIONS visualizar el nombre de la ciudad y el estadoprovincia. 
En el caso de que no tenga que aparezca el texto “No tiene”
*/

SELECT CITY,NVL(STATE_PROVINCE,'No Tiene') FROM locations;

/* Visualizar el salario de los empleados incrementado en la comisión 
(PCT_COMMISSION). Si no tiene comisión solo debe salir el salario*/

SELECT first_name, salary,commission_pct,NVL2(COMMISSION_PCT,
SALARY+SALARY*COMMISSION_PCT/100,SALARY)FROM EMPLOYEES;

/* Seleccionar el nombre del departamento y el manager_id. Si no tiene, 
debe salir un -1
*/

SELECT DEPARTMENT_NAME,NVL(MANAGER_ID,-1) FROM departments;

/* De la tabla LOCATIONS, devolver NULL si la ciudad y la provincia son 
iguales. Si no son iguales devolver la CITY.*/

SELECT CITY,STATE_PROVINCE, NULLIF(CITY,STATE_PROVINCE) FROM locations;