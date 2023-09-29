--    PRACTICA SESSION 6


/* En la tabla LOCATIONS, averiguar las ciudades que son de Canada o 
Estados unidos (Country_id=CA o US) y que la longitud del nombre de la 
calle sea superior a 15*/

SELECT city,street_address FROM locations WHERE
country_id IN('CA','US') AND LENGTH(STREET_ADDRESS)> 15; 

/* Muestra la longitud del nombre y el salario anual (por 14) para los 
empleados cuyo apellido contenga el carácter 'b' después de la 3ª 
posición.
*/

SELECT FIRST_NAME ,LENGTH(FIRST_NAME) AS "X CADA LETRA", LAST_NAME, 
SALARY*14 AS "SALARIO ANUAL" FROM employees WHERE 
 INSTR(LAST_NAME,'b')>3;
 
 /* Averiguar los empleados que ganan entre 4000 y 7000 euros y que 
tienen alguna 'a' en el nombre. (Debemos usar INSTR y da igual que sea 
mayúscula que minúsculas) y que tengan comisión*/

SELECT FIRST_NAME,SALARY FROM employees WHERE SALARY BETWEEN 4000 AND 7000 AND
INSTR(LOWER(FIRST_NAME),'a')<>0 AND commission_pct IS NOT NULL;

-- Visualizar las iniciales de nombre y apellidos separados por puntos
SELECT FIRST_NAME,LAST_NAME,SUBSTR(FIRST_NAME,1,1)||'.'||SUBSTR(LAST_NAME,1,1)||'.'
AS "INICIALES" FROM employees; 


--Mostrar empleados donde el nombre o apellido comienza con S..
 SELECT FIRST_NAME,LAST_NAME FROM employees WHERE
 SUBSTR(FIRST_NAME,1,1)='S' OR SUBSTR(LAST_NAME,1,1)='S'; 
 
 /* Visualizar el nombre del empleado, su salario, y con asteriscos, el 
número miles de dólares que gana. Se asocia ejemplo. (PISTA: se 
puede usar RPAD. Ordenado por salario*/

SELECT FIRST_NAME , SALARY,RPAD('*',SALARY/1000,'*') AS RANKING FROM employees
ORDER BY salary DESC;

/*Visualizar el nombre y salario de los empleados de los que el número de 
empleado es impar (PISTA: MOD)*/

SELECT FIRST_NAME,SALARY,EMPLOYEE_ID FROM EMPLOYEES WHERE 
MOD(EMPLOYEE_ID,2)<>0;

/* Prueba con los siguientes valores aplicando las funciones TRUNC y 
ROUND, con 1 y 2 decimales.*/

SELECT ROUND(25.67,0),TRUNC(25.67,0) FROM DUAL;
SELECT ROUND(25.67,1),TRUNC(25.67,1) FROM DUAL;
SELECT  ROUND(25.34,1),TRUNC(25.34,1) FROM DUAL;
SELECT  ROUND(25.34,2),TRUNC(25.34,2) FROM DUAL;
SELECT ROUND(25.67,-1),TRUNC(25.67,-1) FROM DUAL;

-- Indicar el número de días que los empleados llevan en la empresa

SELECT FIRST_NAME,HIRE_DATE,SYSDATE-HIRE_DATE AS "DIAS DE EMPLEADOS" 
FROM EMPLOYEES;

-- Indicar la fecha que será dentro de 15 días

SELECT SYSDATE,SYSDATE + 15 AS "DENTRO DE 15 DIAS" FROM DUAL;

/*¿Cuántos MESES faltan para la navidad? La cifra debe salir 
redondeada, con 1 decimal*/

SELECT ROUND( MONTHS_BETWEEN('25-12-2023',SYSDATE)) FROM DUAL;

/* Indicar la fecha de entrada de un empleado y el último día del mes que 
entró*/

SELECT FIRST_NAME,HIRE_DATE,LAST_DAY(HIRE_DATE) FROM EMPLOYEES;

/* Utilizando la función ROUND, indicar los empleados que entraron en los 
últimos 15 días de cada mes
*/

SELECT FIRST_NAME, HIRE_DATE,ROUND(HIRE_DATE,'MONTH') FROM EMPLOYEES
WHERE ROUND(HIRE_DATE,'MONTH')> HIRE_DATE;


























