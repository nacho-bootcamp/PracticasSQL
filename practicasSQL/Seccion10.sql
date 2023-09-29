--           SECCION 10

--Indicar el número de empleados del departamento 50

SELECT COUNT(*) FROM employees WHERE department_id = 50;

/* Indicar el número de empleados que entraron en el año 2007 a trabajar*/

SELECT COUNT(*) FROM employees WHERE HIRE_DATE BETWEEN '01-01-2007' 
AND '31-12-2007';

--Indicar la diferencia entre el sueldo más alto y al mínimo

SELECT MAX(SALARY)- MIN(SALARY) AS "DIREFENCIA DE SUELDO" FROM EMPLOYEES;

--Visualizar la suma del salario del departamento 100

SELECT SUM(SALARY) FROM employees WHERE department_id=100;

--Mostrar el salario medio por departamento, con dos decimales

SELECT  ROUND(AVG(SALARY),2) FROM employees GROUP BY department_id;

--Mostrar el country_id y el número de ciudades que hay en ese país.

SELECT COUNTRY_ID,COUNT(CITY) FROM locations GROUP BY(country_id) 
ORDER BY COUNT(CITY); 

/*Mostrar el promedio de salario de los empleados por departamento que 
tengan comisión*/

SELECT ROUND(AVG(SALARY)) FROM EMPLOYEES WHERE commission_pct IS NOT NULL
GROUP BY(department_id);

/* Mostrar los años en que ingresaron más de 10 empleados*/

SELECT TO_CHAR(hire_date,'YYYY'),COUNT(*) FROM 
EMPLOYEES GROUP BY(TO_CHAR(hire_date,'YYYY')) HAVING COUNT(*)>10;

/* Mostrar por departamento y año el número de empleados que 
ingresaron*/

SELECT  department_id,COUNT(*),TO_CHAR(HIRE_DATE,'YYYY') FROM EMPLOYEES
GROUP BY department_id,TO_CHAR(HIRE_DATE,'YYYY') 
ORDER BY (TO_CHAR(HIRE_DATE,'YYYY'));

/* Mostrar los departament_id de los departamentos que tienen managers 
que tienen a cargo más de 5 empleados*/     

SELECT DEPARTMENT_IDFROM EMPLOYEES GROUP BY DEPARTMENT_ID 
HAVING COUNT(DISTINCT MANAGER_ID) > 5;

