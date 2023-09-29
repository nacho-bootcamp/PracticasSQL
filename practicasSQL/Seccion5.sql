--        PRACTICA  DE LA CLAUSULA "BETWEEN" Y LA CLAUSULA "IN"
 
-- Averiguar los empleados que están entre el departamento 40 y el 60
SELECT * FROM employees WHERE department_id BETWEEN 40 AND 60;

--Visualizar los empleados que entraron entre 2002 y 2004
SELECT * FROM employees WHERE hire_date BETWEEN '01-01-2002' AND '01-01-2004';

-- Indica los apellidos de los empleados que empiezan desde ‘D’ hasta ‘G’;
SELECT * FROM employees WHERE last_name BETWEEN 'D' AND 'G';


/*Averiguar los empleados de los departamentos 30,60 y 90. Hay que usar la 
cláusula IN*/
SELECT * FROM employees WHERE department_id IN(30,60,90);


-- Averiguar los empleados que tienen el tipo de trabajo IT_PROG y PU_CLERK.
SELECT * FROM employees WHERE job_id IN('IT_PROG','PU_CLERK');

/* Indica las ciudades que están en Inglaterra (UK) y Japón (JP).. Tabla 
LOCATIONS*/

SELECT city , country_id FROM locations WHERE country_id IN('UK','JP');

--                   PRACTICA DE LA CLAUSULA "LIKE"

-- el _ representa un solo caracter, el % representa mas de un caracter

-- Indicar los datos de los empleados cuyo FIRST_NAME empieza por ‘J’
SELECT * FROM employees WHERE first_name LIKE 'J%';

--Averiguar los empleados que comienzan por ‘S’ y terminan en ‘n’
SELECT * FROM employees WHERE first_name LIKE 'S%n';

-- Indicar los países que tienen una “r” en la segunda letra (Tabla COUNTRIES)
SELECT * FROM countries WHERE country_name LIKE '_r%';

--                   PRACTICA DE LA CLAUSULA "IS NULL"

 --Listar las ciudades de la tabla LOCATIONS no tienen STATE_PROVINCE
SELECT CITY , state_province FROM locations WHERE state_province IS NULL;

/* Averiguar el nombre, salario y comisión de aquellos empleados que tienen 
comisión. También debemos visualizar una columna calculada denominada 
“Sueldo Total”, que sea el sueldo más la comisión*/

SELECT FIRST_NAME,SALARY,COMMISSION_PCT,SALARY+(SALARY*commission_pct) 
AS "SALARIO TOTAL"  FROM employees WHERE  
commission_pct IS NOT NULL ;

--     PRACTICAS AND-OR-NOT

/* Obtener el nombre y la fecha de la entrada y el tipo de trabajo de los 
empleados que sean IT_PROG y que ganen menos de 6000 dólares*/

SELECT FIRST_NAME,HIRE_DATE,JOB_ID FROM employees
WHERE job_id='IT_PROG' AND SALARY < 6000;

/* Seleccionar los empleados que trabajen en el departamento 50 o 80, 
cuyo nombre comience por S y que ganen más de 3000 dólares.
*/

SELECT * FROM employees WHERE department_id IN(50,80) AND 
FIRST_NAME LIKE'S%' AND salary > 3000;

/* ¿Qué empleados de job_id IT_PROG tienen un prefijo 5 en el teléfono 
y entraron en la empresa en el año 2007?*/

SELECT * FROM employees WHERE
job_id ='IT_PROG' AND phone_number LIKE'%5%' AND hire_date >= '01-01-07'

--                             CLAUSULA FETCH

SELECT FIRST_NAME,SALARY FROM EMPLOYEES ORDER BY SALARY DESC 
FETCH FIRST 7 ROW ONLY;

/*TRAE LOS 7 MEJORES SUELDOS SI ES QUE HAY DOS PERSONAS QUE TIENEN 
EL MISMO SUELDO TRAE A LAS DOS 
*/
SELECT FIRST_NAME,SALARY FROM EMPLOYEES ORDER BY SALARY DESC 
FETCH FIRST 7 ROW WITH TIES;

-- EL OFFSET SIRVE PARA SALTARSE LAS PRIMERAS FILAS
SELECT FIRST_NAME,SALARY FROM EMPLOYEES ORDER BY SALARY DESC 
OFFSET 5 ROWS FETCH FIRST 7 ROW WITH TIES;

-- PERCENT SIRVE PARA TRAER EL PORCENTAJE DE LA TABLA 

SELECT * FROM EMPLOYEES FETCH FIRST 20 PERCENT ROWS ONLY