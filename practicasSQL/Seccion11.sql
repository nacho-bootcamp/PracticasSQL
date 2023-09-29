--                   Seccion 11

/* Visualizar el nombre del país y el nombre de la región. (tablas COUNTRIES 
y REGIONS). Usar un natural join*/

SELECT C.COUNTRY_NAME,R.REGION_NAME FROM countries C 
NATURAL JOIN regions R;

/* Usando el ejemplo anterior visualizar también el nombre de la ciudad 
añadiendo una nueva tabla (LOCATIONS)*/
SELECT C.COUNTRY_NAME,R.REGION_NAME,L.CITY FROM countries C 
 JOIN regions R ON(c.region_id=r.region_id)
 JOIN locations L ON(c.country_id=l.country_id);
 
 
--Indicar el nombre del departamento y la media de sus salarios 

SELECT d.department_name,ROUND(AVG(e.salary),2) FROM departments D JOIN
employees E USING(department_id) GROUP BY department_name;


/*Mostrar el nombre del departamento, el del manager a cargo y la ciudad a la 
que pertenece. Debemos usar la cláusula ON y/o la cláusula USING para 
realizar la operación */

SELECT D.DEPARTMENT_NAME,E.FIRST_NAME,L.CITY FROM departments D JOIN employees E
ON(e.manager_id=d.manager_id) JOIN locations L ON(d.location_id=l.location_id)
ORDER BY d.department_name;

/* Mostrar job_title, el department_name, el last_name de empleado y 
hire_date de todos los empleados que entraron entre el 2000 y el 2004.
Usar cláusulas using
*/

SELECT J.JOB_TITLE,D.DEPARTMENT_NAME,E.LAST_NAME,HIRE_DATE FROM jobs J JOIN
employees E USING(JOB_ID) JOIN departments D USING(department_id)
WHERE TO_CHAR(HIRE_DATE,'YYYY')BETWEEN 2002 AND 2004;

/* Mostrar el job_title y la media de los salarios de cada uno, siempre que la 
media supere los 7000*/

SELECT J.JOB_TITLE ,AVG(E.SALARY) FROM jobs J JOIN employees E USING(job_id) 
 GROUP BY job_title HAVING AVG(SALARY) > 7000;
 
/*Mostrar el nombre de la región y el número de departamentos en cada una 
de las regiones*/

SELECT REGION_NAME,COUNT(*) AS "NUM DEPAR"FROM REGIONS NATURAL JOIN COUNTRIES 
NATURAL JOIN LOCATIONS NATURAL JOIN DEPARTMENTS GROUP BY REGION_NAME;

/* Mostrar el nombre del empleado, el departamento y el país donde trabaja 
(debemos usar la cláusual using)*/

SELECT FIRST_NAME,DEPARTMENT_NAME,COUNTRY_NAME FROM employees JOIN departments
USING(department_id) JOIN locations USING(location_id) 
JOIN countries USING(country_id);

/*Indicar el nombre del empleado y el de su jefe (SELF_JOIN de la tabla 
EMPLOYEES)*/

SELECT E.FIRST_NAME AS EMPLEADO , J.FIRST_NAME AS JEFE 
FROM employees E JOIN employees J ON(e.employee_id=j.manager_id);

/*Indica el DEPARTMENT_NAME y la suma de salarios de ese departamento 
ordenados ascendentemente y que aparezcan también los 
DEPARTMENT_NAME que no tengan empleados.*/

SELECT DEPARTMENT_NAME,SUM(SALARY) FROM departments D FULL
OUTER  JOIN employees E ON(e.department_id=d.department_id)GROUP BY department_name
ORDER BY SUM(salary) ;


/* Visualizar la ciudad y el nombre del departamento, incluidas aquellas 
ciudades que no tengan departamentos*/

SELECT CITY,DEPARTMENT_NAME FROM departments FULL OUTER JOIN locations 
USING(location_id);







