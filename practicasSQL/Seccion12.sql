--                            SECCION 12

/* Mostrar los compañeros que trabajan en el mismo departamento que 
John Chen*/

SELECT  FIRST_NAME,LAST_NAME FROM EMPLOYEES WHERE DEPARTMENT_ID =(
SELECT employees.department_id FROM EMPLOYEES WHERE first_name='John' 
AND LAST_NAME='Chen');


-- ¿Qué departamentos tienen su sede en Toronto?

SELECT DEPARTMENT_NAME,DEPARTMENT_ID FROM departments WHERE location_id=(
SELECT location_id FROM locations WHERE CITY='Toronto');


-- Visualizar los empleados que tengan más de 5 empleados a su cargo.

SELECT FIRST_NAME FROM  employees 
WHERE employee_id IN (SELECT MANAGER_ID FROM EMPLOYEES 
GROUP BY MANAGER_ID HAVING COUNT(*)>5);

-- ¿En qué ciudad trabajar Guy Himuro?

SELECT CITY FROM locations WHERE location_id =( 
SELECT LOCATION_ID FROM departments WHERE department_id=(
SELECT DEPARTMENT_ID FROM employees 
WHERE FIRST_NAME='Guy' AND LAST_NAME='Himuro'
));

--¿Qué empleados tienen el salario mínimo?

SELECT FIRST_NAME,LAST_NAME, SALARY,JOB_ID FROM EMPLOYEES
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES );

/* Mostrar los detalles de los departamentos en los cuales el salario 
máximo sea mayor a 10000*/

SELECT department_id,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID FROM departments
WHERE department_id IN (
SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE salary > 10000);

/* Indicar los tipos de trabajo de los empleados que entraron en la empresa 
entre 2002 y 2003*/

SELECT JOB_ID ,JOB_TITLE,MIN_SALARY,MAX_SALARY FROM jobs WHERE job_id IN (
SELECT JOB_ID 
FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'YYYY') BETWEEN '2002' AND '2003');

/*Seleccionar el nombre, salario y departamento de los empleados que 
ganen mas que cualquiera de los salarios máximos de los 
departamentos 50, 60 y 70. Usar el operador ANY*/

SELECT FIRST_NAME,SALARY,DEPARTMENT_ID FROM EMPLOYEES
WHERE SALARY > ANY (SELECT MAX(SALARY) FROM EMPLOYEES  GROUP BY
employees.department_id HAVING employees.department_id IN('50','60','70'));


/*Indicar el nombre de los departamentos cuyo salario medio sea superior 
a 9000. Usar el operador IN
*/

SELECT DEPARTMENT_NAME FROM departments 
WHERE department_id IN(
SELECT  DEPARTMENT_ID FROM EMPLOYEES
GROUP BY department_id HAVING AVG(SALARY) > 9000 );


/* Indicar el nombre del empleado, el nombre del departamento, el salario 
de los empleados que tengan el salario máximo de su departamento. 
Ordenado por salario descendentemente. Usar el operador IN*/

SELECT E.FIRST_NAME, D.DEPARTMENT_NAME, E.SALARY
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE (E.DEPARTMENT_ID, E.SALARY) IN (
  SELECT DEPARTMENT_ID, MAX(SALARY)
  FROM EMPLOYEES
  GROUP BY DEPARTMENT_ID
)
ORDER BY E.SALARY DESC;

/* Realizar la misma consulta anterior pero usando una subconsulta 
sincronizada*/

SELECT DEPARTMENT_NAME,FIRST_NAME,SALARY 
FROM EMPLOYEES EMP  JOIN departments D ON emp.department_id = d.department_id 
WHERE SALARY=(SELECT MAX(SALARY)FROM EMPLOYEES
WHERE employees.department_id=emp.department_id);

/*Indicar los datos de los empleados que ganen más que todos los 
empleados del departamento 100. Usar el operador ALL*/

SELECT * FROM EMPLOYEES WHERE SALARY > ALL(
SELECT MAX(SALARY) FROM employees WHERE employees.department_id = 100);


/* Mostrar los empleados que tienen el mayor salario de su departamento. 
Usar subconsultas sincronizadas*/

SELECT DEPARTMENT_ID ,FIRST_NAME,SALARY FROM EMPLOYEES EMP
WHERE SALARY=(SELECT MAX(SALARY) FROM EMPLOYEES 
WHERE employee_id = emp.employee_id);

/* Visualizar las ciudades en las que haya algún departamento. Debemos 
usar consultas sincronizadas y el operador EXISTS*/

SELECT CITY FROM LOCATIONS LO WHERE EXISTS (
SELECT * FROM departments D WHERE d.location_id = lo.location_id);

/*Visualizar el nombre de las regiones donde no hay departamentos. Usar 
subconsultas sincronizadas y el operador NOT EXISTS*/

SELECT REGION_NAME
FROM REGIONS R
WHERE NOT EXISTS (
  SELECT * FROM COUNTRIES CO
  JOIN LOCATIONS LO ON CO.country_id = LO.country_id
  JOIN DEPARTMENTS DEP ON LO.location_id = DEP.location_id
  WHERE CO.region_id = R.region_id
);




