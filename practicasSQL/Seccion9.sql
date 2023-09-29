--       SECCION 9
/* Visualizar los siguientes datos con CASE.
o Si el departamento es 50 ponemos Transporte
o Si el departamento es 90 ponemos Dirección
o Cualquier otro número ponemos “Otro departamento”*/
SELECT department_id,
DECODE(department_id,50,'TRANSPORTE',90,'DIRECCION','OTRO DEPARTAMENTO')
FROM departments;

/*Mostrar de la tabla LOCATIONS, la ciudad y el país. Ponemos los 
siguientes datos dependiendo de COUNTRY_ID.
*/

SELECT city,country_id,
CASE 
WHEN COUNTRY_ID IN('US','CA') THEN 'AMERICA DEL NORTE'
WHEN country_id IN('CH','UK','DE','IT') THEN 'EUROPA'
WHEN country_id = 'BR' THEN 'AMERICA DEL SUR'
ELSE 'OTRA ZONA'
END
FROM locations;