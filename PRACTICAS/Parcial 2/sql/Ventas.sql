CREATE TABLE proveedor(
             codpro VARCHAR2(3) CONSTRAINT codpro_no_nulo NOT NULL
               CONSTRAINT codpro_clave_primaria PRIMARY KEY,
             nompro VARCHAR2(30) CONSTRAINT nompro_no_nulo NOT NULL,
             status NUMBER CONSTRAINT status_entre_1_y_10
               CHECK (status>=1 and status<=10),
             ciudad VARCHAR2(15));
             
CREATE TABLE pieza (
       codpie VARCHAR2(3) CONSTRAINT codpie_clave_primaria PRIMARY KEY,
       nompie VARCHAR2(10) CONSTRAINT nompie_no_nulo NOT NULL,
       color VARCHAR2(10),
       peso NUMBER(5,2)
         CONSTRAINT peso_entre_0_y_100 CHECK (peso>0 and peso<=100),
       ciudad VARCHAR2(15));
       
CREATE TABLE proyecto(
             codpj VARCHAR2(3) CONSTRAINT codpj_clave_primaria PRIMARY KEY,
             nompj VARCHAR2(20) CONSTRAINT nompj_no_nulo NOT NULL,
             ciudad VARCHAR2(15));
             
CREATE TABLE ventas  (
             codpro CONSTRAINT codpro_clave_externa_proveedor
               REFERENCES  proveedor(codpro),
             codpie CONSTRAINT codpie_clave_externa_pieza
               REFERENCES  pieza(codpie),
             codpj CONSTRAINT codpj_clave_externa_proyecto
               REFERENCES proyecto(codpj),
             cantidad NUMBER(4),
             CONSTRAINT clave_primaria PRIMARY KEY (codpro,codpie,codpj)
);

ALTER TABLE ventas ADD(Fecha  date  DEFAULT sysdate);

INSERT INTO proveedor SELECT * FROM opc.proveedor;
INSERT INTO proyecto SELECT * FROM opc.proyecto;
INSERT INTO pieza SELECT * FROM opc.pieza;
INSERT INTO ventas SELECT * FROM opc.ventas;

COMMIT;
DESCRIBE opc.ventas;
describe ventas;
INSERT INTO ventas SELECT * FROM opc.ventas;

UPDATE proveedor SET codpro='S1' WHERE (nompro='pepe');

UPDATE proveedor SET codpro='S4' WHERE (nompro='olga pons');

INSERT INTO ventas SELECT * FROM opc.ventas;


SELECT ciudad FROM proyecto;

SELECT DISTINCT ciudad FROM proyecto; -- para mostrar ciudades unicas (sin repetir)

SELECT codpro FROM ventas WHERE codpj='J1';

select table_name from all_tables where lower(table_name) like '%ventas'; -- lower hace que podamos poner %ventas en minusculas sino tenemos que ponerlo en mayusculas

select table_name from user_tables;

(SELECT DISTINCT ciudad FROM proveedor WHERE status>2)
                               MINUS
              (SELECT DISTINCT ciudad FROM pieza WHERE codpie='P1');
              
((SELECT DISTINCT ciudad FROM pieza)
UNION
(SELECT DISTINCT ciudad FROM proveedor))
UNION
(SELECT DISTINCT ciudad FROM proyecto);

--PRODUCTO CARTESIANO

--Ejemplo 3.9 Muestra las posibles ternas (codpro,codpie,codpj) tal que, todos los implicados sean de la misma ciudad.
SELECT codpro, codpie, codpj
FROM proveedor, proyecto, pieza
WHERE Proveedor.ciudad=Proyecto.ciudad
AND Proyecto.ciudad=Pieza.ciudad;
               
--Ejemplo 3.10 Mostrar las ternas (codpro,codpie,codpj) tal que todos los implicados son de Londres.
SELECT codpro,codpie,codpj
           FROM proveedor, proyecto, pieza
           WHERE Proveedor.ciudad='Londres' AND Proyecto.ciudad='Londres'
            AND Pieza.ciudad='Londres';
        
--Más eficiente
SELECT codpro,codpie,codpj
FROM(SELECT * FROM proveedor WHERE ciudad='Londres'),
 (SELECT * FROM pieza WHERE ciudad='Londres'),
 (SELECT * FROM proyecto WHERE ciudad='Londres');
 
 
SELECT TO_CHAR(fecha,'DD-MM-YYYY')
     FROM ventas;
     
SELECT TO_CHAR(fecha,'MM-YYYY')
     FROM ventas;
     
SELECT *  FROM ventas
     WHERE fecha BETWEEN TO_DATE('01/01/2018','DD/MM/YYYY') AND
                         TO_DATE('31/12/2020','DD/MM/YYYY');
SELECT *  FROM ventas
     WHERE fecha BETWEEN ('01/01/2018') AND
                         ('31/12/2020');
CREATE VIEW VentasParis (codpro,codpie,codpj,cantidad,fecha) AS
          SELECT codpro,codpie,codpj,cantidad,fecha
          FROM ventas
          WHERE (codpro,codpie,codpj) IN
              (SELECT codpro,codpie,codpj
               FROM proveedor,pieza,proyecto
               WHERE proveedor.ciudad='Paris' AND
                     pieza.ciudad='Paris' AND
                     proyecto.ciudad='Paris');
                     
                     
CREATE VIEW Projo (Nombre, Peso) AS
(SELECT nompie, peso FROM Pieza
WHERE color='Rojo');
