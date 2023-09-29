-- datos JSON

CREATE TABLE PRODUCTOS1(
CODIGO INT,
NOMBRE VARCHAR2(200),
DAOS JSON
);

DESC PRODUCTOS1;


INSERT INTO PRODUCTOS1 VALUES(1,'CAMISA DE MESSI','
{
"PAIS":"ARG",
"CIUDAD":"ROSARIOS",
"POBLACION":1000000
}
');

--ACCEDER AL CONTENIDO CON NOTACION POR PUNTO

select datos from productos1;

select prod1.datos.pais from productos1 prod1;


insert into productos1
values ( 2,'ejemplo1',
'
  {
    "pais": "Argentina",
    "ciudad": "Buenos aires",
    "poblacion": 1000000,
    "direccion":{
             "calle": "xcxxxxx",
             "piso": 5,
             "puerta": "c"
             }
  }
');

select prod1.datos.direccion from productos1 prod1;

select prod1.datos.direccion.puerta from productos1 prod1;


insert into productos1
values ( 3,'ejemplo3',
'
  {
    "pais": "Francia",
    "ciudad": "Paris",
    "poblacion": 1500000,
    "direccion":{
             "calle": "xcxxxxx",
             "piso": 5,
             "puerta": "c"
             },
    "telefonos": [
        "111-111111",
        "222-222222"
    ]
  }
');

select datos from productos1;

select prod1.datos.telefonos from productos1 prod1;
select prod1.datos.telefonos[0] from productos1 prod1;

/*
IS JSON
IS NOT JSON
*/

CREATE TABLE EJEMPLO(
CODIGO INT,
FICHERO CLOB
);

INSERT INTO EJEMPLO VALUES(1,'{"COL1":"PRUEBA"}');
INSERT INTO EJEMPLO VALUES(2,'ESTO ES UNA PRUEBA');
INSERT INTO EJEMPLO VALUES(3,'<DOC><COL1>PRUEBA</COL1></DOC>');

SELECT * FROM EJEMPLO WHERE FICHERO IS JSON;
SELECT * FROM EJEMPLO WHERE FICHERO IS NOT JSON;



/*

   JSON_EXISTS(campo_json,expresion_json,on_error);
   */

drop table productos1;

CREATE TABLE productos1 (
  codigo INT,
  nombre VARCHAR2(200),
  datos json
);

insert into productos1
values ( 1,'ejemplo1',
'
  {
    "pais": "Argentina",
    "ciudad": "Buenos aires",
    "poblacion": 1000000
  }
');



insert into productos1
values ( 2,'ejemplo1',
'
  {
    "pais": "Argentina",
    "ciudad": "Buenos aires",
    "poblacion": 1000000,
    "direccion":{
             "calle": "xcxxxxx",
             "piso": 5,
             "puerta": "c"
             }
  }
');


insert into productos1
values ( 3,'ejemplo3',
'
  {
    "pais": "Francia",
    "ciudad": "Paris",
    "poblacion": 1500000,
    "direccion":{
             "calle": "xcxxxxx",
             "piso": 5,
             "puerta": "c"
             },
    "telefonos": [
        "111-111111",
        "222-222222"
    ]
  }
');


insert into productos1
values ( 4,'ejemplo4',
'
  {
    "pais": "Italia",
    "ciudad": "Roma",
    "poblacion": 1400000,
    "direccion":{
             "calle": "xcxxxxx",
             "piso": 4,
             "puerta": ""
             },
    "telefonos": [
        "111-111111AA",
        "222-222222BB"
    ]
  }
');


insert into productos1
values ( 5,'ejemplo5',
'
  {
    "pais": "Inglaterra",
    "ciudad": "Londres",
    "poblacion": 10009000
  }
');


select json_value(prod1.datos,'$.pais') from productos1 prod1;
select json_value(prod1.datos,'$.pais' returning varchar(100)) from productos1 prod1;
-- Si no son escalare no funciona
select json_value(prod1.datos,'$.direccion') from productos1 prod1;
select json_value(prod1.datos,'$.telefonos') from productos1 prod1;
select json_value(prod1.datos,'$.telefonos[0]') from productos1 prod1;

select json_query(prod1.datos,'$.pais') from productos1 prod1;
select json_query(prod1.datos,'$.direccion') from productos1 prod1;
select json_query(prod1.datos,'$.direccion.calle') from productos1 prod1;
select json_query(prod1.datos,'$.telefonos') from productos1 prod1;
select json_query(prod1.datos,'$.telefonos[0]') from productos1 prod1;


select prod1.datos.pais from productos1 prod1;

/*
JSON_VALUE(CAMPO_JSON,EXPRESION_JSON) no podemos recuperar subdocumentos 
*/
SELECT DATOS FROM PRODUCTOS1;
SELECT JSON_VALUE(PROD1.DATOS,'$.pais') FROM PRODUCTOS1 PROD1;
SELECT JSON_VALUE(PROD1.DATOS,'$.direccion.calle') FROM PRODUCTOS1 PROD1;
SELECT JSON_VALUE(PROD1.DATOS,'$.telefonos[0]') FROM PRODUCTOS1 PROD1;
/*

JSON QUERY si recuperamos subdocumentos y array
*/
SELECT DATOS FROM PRODUCTOS1;
SELECT JSON_query(PROD1.DATOS,'$.pais') FROM PRODUCTOS1 PROD1;
SELECT JSON_query(PROD1.DATOS,'$.direccion') FROM PRODUCTOS1 PROD1;
SELECT JSON_query(PROD1.DATOS,'$.direccion.calle') FROM PRODUCTOS1 PROD1;
SELECT JSON_query(PROD1.DATOS,'$.telefonos[0]') FROM PRODUCTOS1 PROD1;
SELECT JSON_query(PROD1.DATOS,'$.telefonos') FROM PRODUCTOS1 PROD1;

/*
JSON_TABLE
*/

SELECT J_PAIS FROM PRODUCTOS1 PROD1,JSON_TABLE(PROD1.DATOS,'$' COLUMNS(J_PAIS PATH '$.pais'));
SELECT J_PAIS,J_CIUDAD FROM PRODUCTOS1 PROD1,
JSON_TABLE(PROD1.DATOS, '$' COLUMNS(J_PAIS PATH '$.pais',J_CIUDAD PATH '$.ciudad'));

create view datos_json as SELECT J_PAIS,J_CIUDAD,J_direc FROM PRODUCTOS1 PROD1,
JSON_TABLE(PROD1.DATOS, '$' COLUMNS(J_PAIS PATH '$.pais',J_CIUDAD PATH '$.ciudad',j_direc PATH '$.direccion.calle'));


select * from datos_json;

/*

   MODIFICAR JSON
   
   - Antes de la 19c- Había que modificar todo el campo completo
   - En la 19c aparece JSON_MERGEPATCH para actualizar trozos
   - En la 21c aparece JSON_TRANSFORM que es un poco más potente
   
   */
   
   
   select datos from productos1;
   
   -- Modificar uno existente
   update productos1 set datos='
  {
    "pais": "Argentina",
    "ciudad": "Buenos aires",
    "poblacion": 2000000
  }' 
  where codigo=1;
  
  
  -- Añadir un elemento
     update productos1 set datos='
  {
    "pais": "Argentina",
    "ciudad": "Buenos aires",
    "poblacion": 2100000,
    "estado": true
  }' 
  where codigo=1;
  
  -- JSON_MERGEPATCH
      update productos1 set datos=JSON_MERGEPATCH(
      datos,
      '{
            "estado": false
      }' 
      )
  where codigo=1;
  
  
     update productos1 set datos=JSON_MERGEPATCH(
      datos,
      '{
            "estado": true,
            "c1": 10
      }' 
      )
  where codigo=1;

/*
OPERACIONES CON JSON_TRANSFORM

SET ==> ACTUALIZA UN ELEMENETO, SI EL ELEMENTO NO EXISTE ,LO CREA
INSERT ==> INSERTA UN ELEMENTO QUE NO EXISTE 
APPEND ==> AÑADE UN ELEMENTO AL FINAL DE UN ARRAY
REMOVE ==> BORRAR UN ELEMENTO , INCLUIDO DENTRO DE UN ARRAY
RENAME  ==> RENOMBRAR UN ELEMENTO
REPLACE ==> COMO EL SET PERO SI EL ELEMENTO NO EXISTE,NO LO CREA
KEEP ==> ELIMINA TODO LOS ELEMENTOS SALVO LOS QUE ESTAN EN LA LISTA
*/

UPDATE PRODUCTOS1 SET DATOS = JSON_TRANSFORM(DATOS,SET'$.POBLACION'=190000) WHERE CODIGO=1;

select datos from productos1;

select json_transform(datos,set'$.poblacion1'=1000) from productos1 where codigo=1;
--da error por que solo sirve para insertar si no exite no lo crea
select json_transform(datos,insert '$.tipo'='tipo1') from productos1 where codigo=1;
select json_transform(datos,append'$.telefono'='999999') from productos1 where codigo=3;
select json_transform(datos,insert'$.telefono[0]'='21999999') from productos1 where codigo=3;
select json_transform(datos,rename'$.poblacion'='pob') from productos1 where codigo=1;
select json_transform(datos, replace'$.poblacion1'=1000) from productos1 where codigo=1;
select json_transform(datos, remove'$.poblacion') from productos1 where codigo=3;
select json_transform(datos, keep'$.direccion.calle'=1000) from productos1 where codigo=3;
select json_transform(datos,set'$.poblacion'=1000,
                      insert'$.direccion.codigo'=90901,
                      rename'$.direccion.calle'='via'
)from productos1 where codigo=3;