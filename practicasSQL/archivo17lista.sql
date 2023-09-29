--                       PARTICION POR LISTA

CREATE TABLE LISTA(
CODIGO NUMBER NOT NULL,
PAIS VARCHAR2(100),
CLIENTE VARCHAR2(100)
)
PARTITION BY LIST (PAIS)(
PARTITION EUROPA VALUES ('ESPAÑA','FRANCIA','ALEMANIA'),
PARTITION LATINOAMERIA VALUES('ARGENTINA','CHILE'),
PARTITION ASIA VALUES('MALASIA','CHINA','INDONESIA')
);

SELECT * FROM user_tab_partitions WHERE TABLE_NAME = 'LISTA';

INSERT INTO LISTA VALUES(SEQ1.NEXTVAL,'ARGENTINA','MESSI');

-- SI QUIERO VER LA PARTICION NO VA ENTRE COMILLAS PORQUE 
--ES COMO LLAMAR A UNA TABLA

SELECT * FROM LISTA;
SELECT * FROM LISTA PARTITION (LATINOAMERIA);

--añadir particiones y soble la particion default

ALTER TABLE LISTA ADD PARTITION AMERICA_NORTE VALUES ('USA','CANADA');

INSERT INTO LISTA VALUES (SEQ1.NEXTVAL,'USA','OBAMA');

--PARA QUE SE PUEDE HACER CAMBIOS DE FILAS Y SE PUEDAN CAMBIAR DE PARTICION

ALTER TABLE LISTAS ENABLE ROW MOVEMENT;

--PARTICION DEFAULT

ALTER TABLE LISTA ADD PARTITION OTROS VALUES(DEFAULT);

INSERT INTO LISTA VALUES (SEQ1.NEXTVAL,'PORTUGAL','CR7');

SELECT * FROM LISTA;

--FUSION DE LISTAS 

ALTER TABLE LISTA MERGE PARTITIONS LATINOAMERIA,AMERICA_NORTE INTO PARTITION AMERICA; 


SELECT * FROM user_tab_partitions WHERE table_name = 'LISTA';

--                      PARTICIONES HASH
-- LA VENTAJA DE LA PARTICION HASH ES QUE LAS PARTICIONES SON HOMOGENIAS 
--TIENEN LA  MISMA CANTIDAD DE FILAS Y ORACLE LAS PONE DE FORMA ATUOMATICA A CADA FILA

CREATE TABLE TABLA_HASH(
CODIGO NUMBER NOT NULL,
DATOS VARCHAR2(50)
)
PARTITION BY HASH(CODIGO)
PARTITIONS 3;


SELECT * FROM user_tab_partitions WHERE TABLE_NAME = 'TABLA_HASH';


--NO SE PUEDE HACER FUCION DE PARTICIONES EN EL HASH

--ELIMINAR PARTICIONES 
--CUANDO ELIMINAMOS PARTICIONES TAMBIEN SE ELIMINAN LAS FILAS QUE CONTIENE

ALTER TABLE RANGO DROP PARTITION P3_4;

SELECT * FROM RANGO;

-- SUBPARTICIONES
-- LAS LISTA SE ENCONTRA EN LAS SUBPARTICIONES YA QUE LA PARTICION ES LOGICO
CREATE TABLE RANGO_SUB(
COD NUMBER NOT NULL,
DATOS VARCHAR2(50),
FECHA DATE,
COD_CLIENTE NUMBER
)
PARTITION BY RANGE(FECHA)
 SUBPARTITION BY HASH(COD_CLIENTE) SUBPARTITIONS 3
(PARTITION TIMESTRE1 VALUES LESS THAN (TO_DATE('01-04-2023','DD-MM-YYYY')),
 PARTITION TIMESTRE2 VALUES LESS THAN (TO_DATE('01-07-2023','DD-MM-YYYY')),
 PARTITION TIMESTRE3 VALUES LESS THAN (TO_DATE('01-10-2023','DD-MM-YYYY')),
 PARTITION TIMESTRE4 VALUES LESS THAN (TO_DATE('01-01-2024','DD-MM-YYYY'))
 );
 
 SELECT * FROM user_tab_subpartitions WHERE table_name='RANGO_SUB';
 
--     PARTICION RANGO-LISTA
CREATE TABLE RANGO_LISTA
   (	
    CODIGO NUMBER NOT NULL , 
	DATOS VARCHAR2(100)	,
    FECHA date,
    PAIS VARCHAR2(50)
     ) 
  PARTITION BY RANGE (FECHA)
     SUBPARTITION BY LIST(PAIS) 
    (
    PARTITION TRIMESTRE1 VALUES LESS THAN (TO_DATE('01-04-2023','dd-mm-yyyy'))
      ( 
      SUBPARTITION T1_P1 VALUES('ESPAÑA','FRANCIA','ALEMANIA'),
      SUBPARTITION T1_P2 VALUES('ARGENTINA','CHILE'),
      SUBPARTITION T1_P3 VALUES('USA','CANADA'),
      SUBPARTITION T1_P4 VALUES(DEFAULT)
      ),
    PARTITION TRIMESTRE2 VALUES LESS THAN (TO_DATE('01-07-2023','dd-mm-yyyy'))
      ( SUBPARTITION T2_P1 VALUES('ESPAÑA','FRANCIA','ALEMANIA'),
      SUBPARTITION T2_P2 VALUES('ARGENTINA','CHILE'),
      SUBPARTITION T2_P3 VALUES('USA','CANADA'),
      SUBPARTITION T2_P4 VALUES(DEFAULT)
    ),
    PARTITION TRIMESTRE3 VALUES LESS THAN (TO_DATE('01-10-2023','dd-mm-yyyy'))
        ( SUBPARTITION T3_P1 VALUES('ESPAÑA','FRANCIA','ALEMANIA'),
      SUBPARTITION T3_P2 VALUES('ARGENTINA','CHILE'),
      SUBPARTITION T3_P3 VALUES('USA','CANADA'),
      SUBPARTITION T3_P4 VALUES(DEFAULT)
    ),
    PARTITION TRIMESTRE4 VALUES LESS THAN (TO_DATE('01-01-2024','dd-mm-yyyy'))
        ( SUBPARTITION T4_P1 VALUES('ESPAÑA','FRANCIA','ALEMANIA'),
      SUBPARTITION T4_P2 VALUES('ARGENTINA','CHILE'),
      SUBPARTITION T4_P3 VALUES('USA','CANADA'),
      SUBPARTITION T4_P4 VALUES(DEFAULT)
    )
    );
    
    
select * from user_tab_partitions where table_name='RANGO_LISTA';
select * from user_tab_subpartitions where table_name='RANGO_LISTA';


INSERT INTO RANGO_LISTA VALUES(1,'AAAA',SYSDATE,'USA');
INSERT INTO RANGO_LISTA VALUES(2,'BBBB',SYSDATE,'CHILE');
SELECT * FROM RANGO_LISTA;
SELECT * FROM RANGO_LISTA PARTITION(TRIMESTRE2);
SELECT * FROM RANGO_LISTA SUBPARTITION(T2_P2);
SELECT * FROM RANGO_LISTA SUBPARTITION(T2_P3);



--PARTICIONES DE INDICES  

/*
PODEMOS TENER DOS TIPOS DE INDICES PARTICIONADOS
GLOBALES : QUE SE PARTICIPAN DE FORMA INDEPENDIENTE A LA TABLA,ESTAS PARTICIONES 
VIENEN MUY BIEN PARA APP DE TIPO TRANSACCIONAL (OLTP)

LOCALES: QUE ESTAN ASOCIADOS A CADA UNA DE LAS PARTICIONES DE LA TABLA
SE UTILIZA PARA DATA WAREHOSE O DE INTELIGENCIA DE NEGOCIO
*/

-- Tabla normal e índice particionado

drop table t1;

create table t1
(codigo number,
datos varchar2(50));

create index g1_t1 on t1 (codigo) global partition by hash(codigo) partitions 4;

select * from user_ind_partitions where index_name='G1_T1';



-- Tabla particionada e índice normal

drop table t2;
create table t2
(codigo number,
datos varchar2(50))
PARTITION BY RANGE (codigo)
  (
      PARTITION P1 VALUES LESS THAN (10),
      PARTITION P2 VALUES LESS THAN (20),
      PARTITION P3 VALUES LESS THAN (30),
      PARTITION P4 VALUES LESS THAN (40)
     );
     
     create index t2_i1 on t2(datos);
     
     
-- Tabla particionada e índice global particionado

drop table t3;
create table t3
(codigo number,
datos varchar2(50))
PARTITION BY RANGE (codigo)
  (
      PARTITION P1 VALUES LESS THAN (10),
      PARTITION P2 VALUES LESS THAN (20),
      PARTITION P3 VALUES LESS THAN (30),
      PARTITION P4 VALUES LESS THAN (40)
     );
        
     create index g1_t3 on t3 (datos) global partition by hash(datos) partitions 4;
     
-- indices particionados locales

drop table t4;
create table t4
(codigo number,
datos varchar2(50))
PARTITION BY RANGE (codigo)
  (
      PARTITION P1 VALUES LESS THAN (10),
      PARTITION P2 VALUES LESS THAN (20),
      PARTITION P3 VALUES LESS THAN (30),
      PARTITION P4 VALUES LESS THAN (40)
     );
     create index t4_i1 on t4(codigo) local ;
     select * from user_ind_partitions where index_name='T4_I1';



















