# Resumen SQL

## CREAR TABLAS

```sql
CREATE TABLE nombre-tabla(
  nombre-atributo1 tipo-atributo1 [NOT NULL] [DEFAULT expr],
  nombre-atributo2 tipo-atributo2 [NOT NULL] [DEFAULT expr],...
  [PRIMARY KEY(nombre-atributo1, nombre-atributo2...),]
  [UNIQUE (nombre-atributo1, nombre-atributo2...),]
  [FOREIGN KEY(nombre-atributo1, nombre-atributo2...)
    REFERENCES nombre-tabla(nombre-atributo, ...),]
  [CHECK(condicion)]
  );
```

destacar que cuando la clave primaria, la clave candidata o la clave externa está formada por un solo atributo, las palabras reservadas PRIMARY KEY, UNIQUE y REFERENCES, respectivamente, se podrán incluir a continuación de la definición del atributo correspondiente, tal y como se muestra a continuación:

```sql
CREATE TABLE nombre-tabla1(
  nombre-atributo1 tipo-atributo1 PRIMARY KEY,
  nombre-atributo2 tipo-atributo2 UNIQUE,
  nombre-atributo3 [tipo-atributo3]
  REFERENCES nombre-tabla2(nombre-atributo3));
```


 La cláusula tipo-atributo3 puede omitirse, en cuyo caso el atributo será del mismo tipo que el atributo al que hace referencia.

### TIPOS DE DATOS Y OPERADORES BÁSICOS

![Captura de pantalla 2021-06-13 a las 0.27.19](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-06-13 a las 0.27.19.png)

## ELIMINAR TABLA

~~~sql
DROP TABLE nombre-tabla
~~~



## INSERTAR TUPLAS

~~~SQL
INSERT INTO nombre_tabla [(column1, column2,...)]
        VALUES(valor1, valor2,...);
~~~

### EJEMPLO

~~~SQL
			INSERT INTO plantilla (dni,nombre,estadocivil,fechaalta)
             VALUES ('12345678','Pepe','soltero', SYSDATE);
      INSERT INTO plantilla (dni,nombre,estadocivil,fechaalta)
             VALUES ('87654321','Juan', 'casado', SYSDATE);
      INSERT INTO serjefe VALUES ('87654321','12345678');
      INSERT INTO plantilla (dni, estadocivil) VALUES ('11223344','soltero');
~~~



## MOSTRAR EL CONTENIDO DE UNA TABLA

```SQL
SELECT * FROM nombre-tabla;
```

La lista de atributos entre la cláusula SELECT y la cláusula FROM equivale en SQL a la operación de proyección de Álgebra Relacional. En este caso particular, el ∗ equivale a proyectar sobre todos los atributos de las tablas relacionadas en al cláusula FROM. Para proyectar campos individuales, se debe ejecutar la siguiente sentencia:

```sql
SELECT campo1, campo2, .... FROM nombre-tabla;
```

SINTÁXIS GENERAL:

~~~SQL
SELECT [ DISTINCT | ALL]
                 expresion [alias_columna_expresion]
                 {,expresion [alias_columna_expresion]}
          FROM [esquema.]tabla|vista [alias_tabla_vista]
          [WHERE <condicion>]
          [GROUP BY expresion {,expresion}]
          [HAVING <condicion>]
          [{UNION | UNION ALL | INTERSECT | MINUS}  <SELECT instruccion>]
          [ORDER BY {expresion} [ASC | DESC]]

~~~

## PROYECCIÓN AR EN SQL

~~~sql
SELECT DISTINCT ciudad FROM proyecto
--Muestra las distintas ciudades sin repetirlas
~~~

## SELECCION AR EN SQL

Para realizar la selección Algebráica σ en SQL se emplea la cláusula WHERE seguida de <condicion>, aunque siempre será necesario especificar la cláusula SELECT de la instrucción de consulta. <condicion> es una expresión booleana que implica cualquiera de los atributos de la tabla que figura en la cláusula FROM de la instrucción.

![Captura de pantalla 2021-06-13 a las 0.41.50](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-06-13 a las 0.41.50.png)

~~~SQL
SELECT codpro FROM ventas WHERE codpj='J1'
~~~

### OPERADORES ESPECIFICOS DE SQL

* **Like** y **caracteres comodín**. El operador like se emplea para comparar cadenas de caracteres mediante el uso de patrones. Cuando se emplea el carácter comodín %, éste se sustituye por cualquier cadena de 0 ó más caracteres
* ![Captura de pantalla 2021-06-13 a las 0.43.37](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-06-13 a las 0.43.37.png)

### Uso de operadores aritméticos y funciones numéricas.

Describe la cantidad de cada venta expresada en docenas, docenas redon- deadas y truncadas al tercer decimal y aproximadas por el entero inferior y por el entero superior, sólo de las ventas cuyo número de piezas es mayor de diez docenas.

~~~sql
SELECT cantidad/12, round(cantidad/12,3), trunc(cantidad/12,3),
            floor(cantidad/12), ceil(cantidad/12)
FROM ventas WHERE (cantidad/12)>10;
~~~

### Comparación con el valor nulo. El operador IS [NOT] NULL

Encontrar los proveedores que tienen su status registrado en la base de datos.

~~~SQL
SELECT codpro, nompro FROM proveedor WHERE status IS NOT NULL;
~~~



## OPERADORES AR SOBRE CONJUNTOS EN SQL

~~~SQL
<SELECT instruccion>
             UNION | UNION ALL | INTERSECT | MINUS
<SELECT instruccion>
~~~

Estos operadores tienen una restricción similar a sus correspondientes del AR, para poder llevarse a cabo: **los esquemas de las tablas resultantes de cada sentencia SELECT han de ser iguales en tipo, esto es, los atributos no tienen porqué llamarse igual, aunque sí han de coincidir en número, posición en el “select list” y tipo**. Trás la operación, el esquema del resultado coincide con el esquema del primer operando

## PRODUCTO CARTESIANO EN SQL

En la cláusula FROM de una sentencia de consulta puede aparecer una lista de tablas (o de subconsultas) en lugar de una sóla. En este caso, el sistema realiza el producto cartesiano de todas las tablas (o subconsultas) incluidas en dicha lista para, posteriormente, seleccionar aquellas tuplas que hacen verdad la condición de la cláusula WHERE (en el caso de que se haya establecido) mostrándolas como resultado de ese producto cartesiano.

**EJEMPLO**

Muestra las posibles ternas (codpro,codpie,codpj) tal que, todos los implicados sean de la misma ciudad.

![Captura de pantalla 2021-06-13 a las 0.55.23](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-06-13 a las 0.55.23.png)

~~~sql
SELECT codpro, codpie, codpj
               FROM proveedor, proyecto, pieza
               WHERE Proveedor.ciudad=Proyecto.ciudad
               AND Proyecto.ciudad=Pieza.ciudad;
~~~



## REUNIÓN NATURAL

Llegado este punto, disponemos de todos los elementos SQL para expresar el operador equi-reunión y la reunión natural . Para la reunión natural se usa la cláusula NATURAL JOIN dentro de la cláusula FROM entre las tablas o subconsultas participantes. EL SGBD aplica la reunión natural sobre aquellos campos que se llamen de igual forma en las tablas o subconsultas intervinientes, si no coincidieran en tipo, devolvería error.

**EJEMPLO**

Mostrar los nombres de proveedores y cantidad de aquellos que han realizado alguna venta en cantidad superior a 800 unidades.

![Captura de pantalla 2021-06-13 a las 0.57.28](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-06-13 a las 0.57.28.png)

```SQL
SELECT nompro, cantidad
           FROM proveedor NATURAL JOIN (SELECT * FROM ventas WHERE cantidad>800);
```

## ORDENACIÓN DE RESULTADOS

```sql
ORDER BY expresion [ASC | DESC]{,expresion [ASC | DESC]}
```

