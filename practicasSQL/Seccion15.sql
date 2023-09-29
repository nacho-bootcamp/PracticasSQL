/*               SECCION 15

• Abrir otro SqlDeveloper y entrar también como el usuario HR
• Entrar en el primer SqlDeveloper
• Realizar un insert en la tabla productos
*/
select * from productos2;

insert into productos2 (code,name) VALUES (12,'Clavos');

COMMIT;

DELETE productos2 where code = 12;

ROLLBACK;

INSERT INTO productos2 ( code,name ) VALUES (2,'ARANDELAS' );
INSERT INTO productos2 ( code,name ) VALUES (3,'ESCARPIAS' );

SAVEPOINT A;

UPDATE PRODUCTOS2 SET NAME='TORNILLOS' WHERE CODE=3;

ROLLBACK TO SAVEPOINT A;

SELECT * FROM productos2;

COMMIT;

