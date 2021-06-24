# TEMA 4 - Nivel Interno

## Índice

1. **Conceptos básicos**
2. **Dispositivos de almacenamiento**
3. **Métodos de acceso a la BD almacenada**
4. **Representación de la BD en el nivel interno**
5. **Organización y métodos de acceso**
6. **Organización secuencial**
7. **Indexación**
8. **Índices no densos**
9. **Índices jerárquicos**
10. **Árboles B+**
11. **Árboles B**
12. **Uso de Árbole sB+ en BD**
13. **Índices BITMAP**
14. **Acceso directo**
15. **Hashing**
16. **Hashing**
17. **Uso del Hash en SGBD**

## 1. Conceptos básicos

**Base de datos**

- Sirven para almacenar de forma permanente grandes cantidades de datos.
- Propósito principal: gestionar de forma eficiente los datos y su almacenamiento.
- Implica consecuencias tanto en la organización lógica de los datos, como en su organización física.

**Nivel interno**

- Expresa en última instancia, las operaciones sobre los datos (creación, alteración y recuperación) en términos de actuación sobre unidades mínimas de almacenamiento denominadas páginas o bloques de base de datos.
- Provee al administrador de mecanismos para optimizar el almacenamiento y el acceso a los datos.
- Se encuentra implementado en el SGBD.

**Nivel físico**

- Se encuentra implementado en el sistema operativo.

- Proporciona al SGBD una capa de abstracción sobre el

  hardware.

- Realiza el acceso a los medios de almacenamiento mediante llamadas a los servicios del sistema de archivos proporcionado por el SO.

## 2. Dispositivos de almacenamiento

**Características**

![Captura de pantalla 2021-04-29 a las 15.23.29](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-04-29 a las 15.23.29.png)

**Jerarquía**

![Captura de pantalla 2021-04-29 a las 15.23.48](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-04-29 a las 15.23.48.png)

**Memoria principal**

- Es el dispositivo de almacenamiento primario de los ordenadores. 
  - Hace trabajos de caché de la porción de la BD de uso más reciente.
  - Elemento de almacenamiento intermedio que ubica de forma temporal los datos afectados por las operaciones.
- Como es rápida y cara (preciada), el nivel interno debe optimizar su uso para acelerar el procesamiento de los datos.
- Es volátil (su información se pierde con las caídas del sistema): El nivel interno debe garantizar que dicha información tenga un respaldo en almacenamiento secundario para evitarlo.
- Tanto el disco duro como la memoria principal utilizan distintos niveles de caché para acelerar el acceso a los datos.

**Discos duros**

- Dispositivo de almacenamiento más usado en BD.
- Constituidos por un conjunto de discos magnéticos con dos caras.
- Cada cara tiene un conjunto de pistas concéntricas (cilindro: la misma pista de todas las caras).
- Cada pista se divide en sectores con la misma capacidad de almacenamiento (bloque).
- Localización de un bloque:
  - Cilindro.
  - Superficie de disco.
  - Sector.
- Parámetros:
  - Capacidad.
  - Tiempo medio de acceso.
  - RPM.
  - Velocidad sostenida de lectura/escritura

**Discos duros: Medidas de rendimiento**

- **Tiempo medio de acceso** (ta): tiempo medio transcurrido entre una instrucción y la obtención de la información.

- **Tiempo medio de búsqueda** (tb): tiempo medio de posicionamiento en pista.

- **Tiempo de latencia rotacional** (tl): tiempo medio de posicionamiento en sector.

  *ta=tb+tl*

- **Tiempo medio entre fallos** (MTBF).

## 3. Métodos de acceso a la BD almacenada

![Captura de pantalla 2021-04-29 a las 15.26.38](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-04-29 a las 15.26.38.png)

¿Cómo se transforma un registro almacenado en una representación física en el almacenamiento secundario? (mediante acceso directo)

![Captura de pantalla 2021-04-29 a las 15.27.04](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-04-29 a las 15.27.04.png)

Para que el gestor de almacenamiento pueda localizar un registro almacenado, se utiliza el RID (Record IDentifier):

* Almacena el número de página y un puntero a la posición de comienzo del registro en la página.

![Captura de pantalla 2021-04-29 a las 15.27.31](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-04-29 a las 15.27.31.png)

- Cada registro almacenado se compone de:
  - Cabecera: Número y tipo de columnas que lo integran.
  - Datos: Contenido de las columnas.
- Las páginas o bloques de la BD deben tener un tamaño múltiplo de las páginas del sistema operativo (mínima unidad de E/S).
- Para recuperar un registro almacenado hay que determinar la página de BD que lo contiene y entonces recuperar los bloques de disco que la integran.
- Hay que organizar la estructura de almacenamiento y los métodos de acceso, de forma que se optimice la interacción con los dispositivos de almacenamiento secundario.
- Deben minimizarse las operaciones de E/S al almacenamiento secundario.

**Gestor de disco del SO**

- Normalmente el SGBD interactúa con la BD almacenada en el sistema de almacenamiento secundario a través del gestor de disco del SO.
- El gestor de disco organiza los datos en conjuntos de bloques o archivos de SO.
- Una BD puede valerse de uno o varios de estos archivos para almacenar su contenido.
- También se encarga de gestionar el espacio libre en el disco.

**Funciones del gestor de disco del SO**

- Crear un nuevo archivo de sistema operativo.
- Eliminar un archivo de sistema operativo existente.
- Añadir un bloque nuevo al conjunto de bloques c.
- Eliminar el bloque b del conjunto de bloques c.
- Devolver el bloque b del conjunto de bloques c.
- Reemplazar el bloque b dentro del conjunto de bloques c.

**El gestor de archivos del SGBD**

* Componente del SGBD que se encarga de: 
  * Hacer la transformación entre:
    * Campos, registros y archivos almacenados y bloques y conjuntos de bloques que pueda entender el gestor de disco.
  * Organizar los datos de manera que se minimice el tiempo de recuperación. Minimizar las E/S a disco.

**Funciones del gestor de archivos del SGBD (I)**

* Crear un nuevo archivo almacenado:
  * Asociar al archivo un conjunto de páginas o bloques de la BD.

- Eliminar un archivo almacenado.
- Recuperar el registro almacenado r del archivo almacenado a:
  - Normalmente, el SGBD proporciona el RID.
  - Sólo hay que obtener en memoria la página que contiene el registro para extraerlo.
- Añadir un nuevo registro almacenado al archivo almacenado a. Hay que localizar la página de BD más apropiada de las pertenecientes al archivo almacenado:
  - Si no se pudiera, se solicita una nueva página.
  - Se devuelve al SGBD el RID nuevo.

* Eliminar el registro r del archivo almacenado a:
  * Hay que recuperar la página de BD que contiene dicho registro y marcar el espacio ocupado por el registro en dicha página como disponible.
* Actualizar el registro r en el archivo almacenado a:
  * Recupera la página de la BD que contiene el registro que se desea actualizar.
  * Trata de sustituir la información. Si no puede, se intenta ubicar en otra página.

## 4. Representación de la BD en el nivel interno

**La BD se representa de diferentes formas en los diferentes niveles de la arquitectura del SGBD**

- Su representación en el nivel interno no tiene porqué coincidir con su representación en el nivel conceptual.
- Cada conjunto de registros del mismo tipo no tiene porqué ser un mismo archivo.
- El nivel interno debe traducir las estructuras del nivel conceptual a otras estructuras intermedias más cercanas al almacenamiento real de los datos (nivel físico).



**Agrupamiento**

* La BD en el nivel interno:
  * Conjunto de páginas en las que se van ubicando los registros.

- Agrupamiento intra-archivo:
  - Ubicar en una página registros del mismo tipo.
  - Es el más frecuente.
- Agrupamiento inter-archivo:
  - Ubicar en una página registros de distinto tipo.
  - Ha de existir relación (por ejemplo entidades fuerte- débil).

**Ejemplo**

![Captura de pantalla 2021-05-13 a las 17.17.06](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-13 a las 17.17.06.png)

![Captura de pantalla 2021-05-13 a las 17.17.32](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-13 a las 17.17.32.png)

![Captura de pantalla 2021-05-13 a las 17.17.40](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-13 a las 17.17.40.png)

![Captura de pantalla 2021-05-13 a las 17.17.48](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-13 a las 17.17.48.png)

![Captura de pantalla 2021-05-13 a las 17.18.02](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-13 a las 17.18.02.png)

![Captura de pantalla 2021-05-13 a las 17.18.11](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-13 a las 17.18.11.png)

![Captura de pantalla 2021-05-13 a las 17.18.25](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-13 a las 17.18.25.png)

![Captura de pantalla 2021-05-13 a las 17.18.33](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-13 a las 17.18.33.png)

**Consideraciones finales**

- La organización descrita es un ejemplo general.

- Cada SGBD comercial utiliza su variante concreta,

  aunque la idea subyacente es la misma.

- No existe una relación directa fichero almacenado con fichero físico, ya que todos los conjuntos de páginas irán almacenados, con toda probabilidad, en uno o varios ficheros físicos.

## 5. Organización y métodos de acceso

**Objetivo**:

Minimizar el número de accesos a disco ® minimizar la cantidad de páginas de BD involucradas en una operación de BD.

- Ninguna de las organizaciones presentadas es mejor en términos absolutos.
- Criterios básicos para medir la “calidad” de una organización son:
  - Tiempo de acceso a los datos requeridos.
  - Porcentaje de memoria ocupada por los datos requeridos con respecto a las páginas de BD que los contienen.
- Trabajaremos a dos niveles:
  - Organización de registros de datos a nivel de almacenamiento.
  - Adición de estructuras complementarias para acelerar el acceso a dichos registros.

## 6. Organización secuencial

**Fichero de acceso secuencial:**

- Los registros están almacenados consecutivamente.

- Para acceder a un registro determinado debemos pasar

  obligatoriamente por los registros que le preceden.

- Los registros suelen estar ordenados por una clave (clave física).

![Captura de pantalla 2021-05-13 a las 17.27.35](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-13 a las 17.27.35.png)

**Ejemplo**:

- Mostrar la relación completa de departamentos.
- La consulta se resolvería rápidamente si los departamentos están almacenados conjuntamente en bloques contiguos de un fichero.
- Sin embargo: 
  - ¿Qué pasa si queremos plantear consultas por valor de clave o por rango de valores?

* El primer caso implica:
  * Recorrer uno tras otro cada uno de los registros.
  * En el peor caso (no encontrarse dicho departamento o ser el último de la lista) supone recorrer de forma completa el fichero.
  * Esta búsqueda es O(N).
* El segundo caso tiene un tratamiento muy parecido:
  - Se realiza la búsqueda por valor de clave de la cota inferior del intervalo.
  - Se continúa hasta alcanzar la cota superior. Si están ordenados por el valor de la clave.

**Inserción de un nuevo registro:**

* Buscar el bloque que le corresponde.
  * Si hay sitio, se inserta el nuevo registro.
  * En caso contrario, o bien se opta por crear un nuevo bloque o bien se crea un bloque de desbordamiento.
* Es recomendable dejar espacio vacío en los bloques para evitar los problemas de reorganización.

**Borrado de un registro:**

- Buscar el registro.
- Puede implicar una reorganización local de los registros de un bloque.

**En resumen, las dos operaciones suponen:**

- Escritura del bloque del registro que se inserta o borra.

- Creación o liberación de bloques de datos en el fichero

  secuencial.

- Creación o liberación de bloques de desbordamiento.

- Reorganización de registros entre bloques contiguos, lo que implica la escritura de los bloques implicados en el desplazamiento.

- Como puede verse, esta forma de organizar los registros no está exenta de grandes inconvenientes.
- Pueden subsanarse, al menos en parte, mediante el uso de estructuras adicionales que nos permitan:
  - Acelerar la localización de los datos.
  - Disminuir el número de bloques de disco transferidos.
- Entre las técnicas más populares se encuentran:
  - Índices.
  - Acceso directo

## 7. Indexación

Tiene por objeto disminuir el tiempo de acceso a los datos por una clave de búsqueda. Es similar a la idea de un índice en un libro. Además, existen muchas formas de llevar a cabo esta idea.

**Ficheros indexados:**

- Partimos de un fichero secuencial sobre el que disponemos una estructura adicional: fichero índice.
- Sus registros poseen:
  - Campo clave (la clave de búsqueda).
  - Campo de referencia que contiene RIDs de registros.
- Son más pequeños que los del fichero de datos, aunque el número de ellos es el mismo en ambos ficheros.

![Captura de pantalla 2021-05-13 a las 17.31.10](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-13 a las 17.31.10.png)

* **Índice primario:**
  * La clave de búsqueda es el mismo campo clave (clave física) por el que está ordenado el fichero secuencial de datos.

* **Índices secundarios:**
  * Construidos sobre otros campos que no sean la clave física del fichero de datos.

![Captura de pantalla 2021-05-13 a las 17.32.02](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-13 a las 17.32.02.png)

**Ficheros indexados:**

* Proceso de consulta:
  * Consulta por un valor de la clave:
    * Sobre el índice localizamos la clave (recorrido secuencial).
    * Obtenemos el RID del registro requerido.
    * Vamos a disco para recuperar el bloque de datos donde se encuentra el registro señalado por el RID.
    * La búsqueda en el índice es más rápida.
  * Consulta por rango de valores:
    * Búsqueda en el índice por valor de clave de la cota inferior.
    * Recorrido de las entradas del índice que están en el intervalo, recuperando los registros correspondientes gracias a su RID.
* Inserción de un nuevo registro:
  * Las mismas operaciones que en el fichero secuencial.
  * Hay que actualizar también el índice (inserción en un fichero secuencial).
* Borrado de un registro:
  * Borrado de un registro en el fichero de datos.
  * Borrado de una entrada en el índice.

![Captura de pantalla 2021-05-13 a las 17.33.31](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-13 a las 17.33.31.png)

**Ficheros indexados:**

- Se puede montar un índice sobre más de un campo de un registro.
  - Clave: concatenación de los campos indicados.
- Hay que tener cuidado con el orden de los campos indexados.
- Por ejemplo, un índice sobre nombre-alumno y DNI. 
  - Es útil para consultas que involucran:
    - Nombre
    - Nombre y DNI.
  - No es útil para consultas sobre el DNI.

**Conclusiones**: 

* Los índices:
  * Aceleran el acceso a los datos.
  * Ralentizan las otras operaciones. 
  * Hay que mantener el índice.
* Por tanto:
  * Hay que considerar la conveniencia de crear cada índice.
  * Frecuencia de las consultas.
  * Frecuencia de las operaciones de mantenimiento de los datos.

## 8. Índices no densos

- Lo ideal: Mantener el índice en memoria principal.

- La realidad: los índices siguen siendo muy grandes, porque

  contienen todos los registros del fichero que indexan:  Son densos.

- Para reducir el tamaño aparecen los índices no densos: 

  - Registros compuestos por:
    - La clave de búsqueda.
    - La dirección de comienzo del bloque donde puede encontrarse el registro deseado.
  - El número de registros se reduce al número de bloques del fichero de datos.
    - El acceso secuencial al índice no denso se acelera.

![Captura de pantalla 2021-05-13 a las 17.36.43](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-13 a las 17.36.43.png)

**Diferencias en el proceso de búsqueda:**

- Una vez encontrado el bloque donde podría encontrarse el registro:
  - Hay que cargarlo en memoria.
  - Hay que hacer una búsqueda secuencial.
  - No tiene costes en términos de acceso a disco.
- No se tiene garantía alguna de encontrar el registro deseado hasta consultar el bloque de datos leído.

**Los índices no densos sólo se pueden definir sobre la clave física**

* El mantenimiento de un índice no denso es menos costoso:
  * Inserción y borrado menos frecuentes
  * Sólo ocurren cuando la operación afecta al valor representativo del bloque.

![Captura de pantalla 2021-05-13 a las 17.38.32](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-13 a las 17.38.32.png)

## 9. Índices jerárquicos

- Volvemos al objetivo de disminuir el tiempo necesario para recorrer el índice en busca de un registro:
  - **Idea: crear índices sobre índices.**
  - Varios niveles en el acceso a los datos.
- Un índice multinivel está formado:
  - Un índice de primer nivel sobre el fichero de datos.
  - Puede ser denso o no dependiendo de la clave.
  - Otros índices, no densos, construidos sucesivamente unos sobre otros.
- El tamaño de los bloques se establece con la idea de optimizar cada una de las operaciones de acceso al disco físico.
- Se reduce el número de accesos a disco para localizar un registro:
  - En el peor caso: tantos como niveles.
-  Se **complica el mantenimiento** del índice.

![Captura de pantalla 2021-05-28 a las 0.47.14](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 0.47.14.png)

## 10. Árboles B+

- Propuestos en 1972 por Bayer y McCreight son una generalización de los árboles binarios balanceados en la que **los nodos pueden tener más de dos hijos.**
- Creación de árboles B+: https://www.cs.usfca.edu/~galles/visualization/BPlusTree.html
- Todos los valores de la clave se encuentran almacenados en los nodos hoja.
- Un Árbol B+ de orden M (el máximo número de hijos que puede tener cada nodo) es un árbol con la siguiente **estructura**:
  -   Nodo de nivel superior: raíz del árbol.
  -   Nodos del nivel inferior: hojas.
  -   Cada nodo distinto de las hojas tiene como máximo M hijos.
  -   Cada nodo (excepto raíz y hojas) tiene como mínimo (M+1)/2 hijos.
  -   La raíz tiene al menos 2 hijos si no es un nodo hoja.
  -   Todos los nodos hoja aparecen al mismo nivel.
  -   Las claves contenidas en cada nodo nos guiarán hasta el siguiente nodo del nivel inmediatamente inferior.
  -   Un nodo no hoja con **n** hijos contiene:
    - n-1 valores de clave almacenados.
    - *n* punteros *P**i* que apuntan a un nodo hijo.

![Captura de pantalla 2021-05-28 a las 0.49.40](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 0.49.40.png)

**Restricciones dentro de los nodos:**

* Los valores de clave Ci están ordenados dentro del nodo.
* Los valores x del subárbol apuntado por Pi cumplen:
  * Ci−1 ≤ x < Ci
* Excepto para:
  * *i* = 1, donde *x < C*1
  * *i* = *m*, donde *x ≤ C*m

**Nodos hoja:**

* Tienen una estructura diferente:
  * Parejas clave - RID.
  * Punteros al siguiente nodo hoja.
  * Algunas variantes también tienen punteros al nodo hoja anterior.
* La lista concatenada de nodos hoja (conjunto secuencia), tiene gran utilidad a la hora de hacer consultas por intervalos.

**Restricciones en nodos hoja:**

- Las claves aparecen ordenadas en cada nodo.
- Todas las claves han de ser menores que las del siguiente nodo en el conjunto secuencia.
- Los nodos han de estar como mínimo rellenos hasta la mitad.
- Todos los nodos hoja se encuentran en el mismo nivel.
  - Árbol equilibrado.
  - Todos los caminos desde la raíz a un nodo hoja tienen la misma longitud.
- **Proceso de consulta**
  - Localización de un registro:
    - Navegamos desde la raíz, bajando niveles.
    - Buscamos el registro en el nodo hoja y, en su caso, recuperamos el registro del fichero de datos gracias al RID.
  - Consultas por rango:
    - Se localiza el nodo hoja que contiene el valor inferior.
    - Se recorren los nodos hoja hasta alcanzar el superior, recuperando los registros pertinentes del fichero de datos.
- **Inserción y borrado** 
  - Se utilizan algoritmos que garantizan que el árbol resultante sea equilibrado.

## 11. Árboles B

Los árboles-B (B-Tree) son una variante de B+Tree en la que no almacenan todos los valores de la clave en los nodos hoja: algunos valores se van almacenando en los nodos intermedios conforme se crea el árbol.

Creador de árboles B: https://www.cs.usfca.edu/~galles/visualization/BTree.html

## 12. Uso de Árboles B+ en BD

- **Variación del árbol B+**, de orden elevado, en la que se procura que cada nodo tenga una capacidad de almacenamiento similar al tamaño de un bloque de datos.
- Esto **reduce los accesos a disco** que suelen ser los que determinan el rendimiento de las búsquedas en BD.
- En los nodos intermedios sólo están los rangos de los valores de la clave y los punteros a los nodos hijo correspondientes.
- En los nodos hoja se encuentran todos los valores de la clave ordenados junto con los RIDs (rowid) que apuntan a las tuplas que contienen ese valor de la clave.
- Los nodos hoja, que forman el conjunto secuencia, se encuentran enlazados para poder recuperar por búsquedas secuenciales.
- A veces se encuentran doblemente enlazados, para facilitar búsquedas ascendentes y descendentes por el valor de la clave.

![Captura de pantalla 2021-05-28 a las 0.57.41](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 0.57.41.png)

**Tablas Organizadas por Índice (IOT).** Las hojas contienen las tuplas en lugar del RID. Una IOT sólo puede estar organizada de esta forma mediante una clave (normalmente la clave primaria), aunque se pueden definir índices adicionales basados en otras claves.

![Captura de pantalla 2021-05-28 a las 0.58.04](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 0.58.04.png)

Estructura comparada con la de los índices normales.

![Captura de pantalla 2021-05-28 a las 0.58.30](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 0.58.30.png)

Comparativa con índices normales.

![Captura de pantalla 2021-05-28 a las 0.58.46](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 0.58.46.png)

**Índice por clave invertida (reverse index)**

- Invierte los datos del valor de la clave.
- Ejemplo (página siguiente): 
  - Para el empleado 7698 almacena 8967.

- Este índice es adecuado para búsquedas basadas en

  predicados =.

- Se reducen los embotellamientos (retención de bloques de BD) en el índice cuando se están introduciendo los datos de forma ascendente para los valores de la clave, puesto que todos irían a la misma entrada de índice.

  **CREATE INDEX pie_codpie_rv_idx ON pieza(codpie)** **REVERSE**

  **![Captura de pantalla 2021-05-28 a las 0.59.21](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 0.59.21.png)**

## 13. Índices BITMAP

Para cada valor que toma la clave, almacena una secuencia de bits (tantos como tuplas contenga la tabla): el bit 1 indica que ese valor está presente en la tupla y el 0 que no lo está.

![Captura de pantalla 2021-05-28 a las 10.07.56](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.07.56.png)

**Índices Bitmap.** Comparativa con índices basados en B-tree.

![Captura de pantalla 2021-05-28 a las 10.08.16](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.08.16.png)

## 14. Acceso directo

- Otra forma de acceder a un registro almacenado: 
  - No hay una estructura adicional.
  - Se usa un algoritmo que nos indique directamente la posición del registro deseado.
- **Acceso directo:**
  - Calcular directamente la dirección de un registro mediante la aplicación de un algoritmo o función sobre un campo determinado del mismo.
  - El campo debe identificar unívocamente al registro.
- Funcionamiento:
  * Normalmente no es posible establecer una clave física que sea totalmente correlativa y única para cada registro.
  * Hay que buscar un **algoritmo que transforme los valores de un cierto campo en una dirección**:
    * Entrada: campo clave.
    * Salida: valor entero positivo fácilmente transformable en RID.

![Captura de pantalla 2021-05-28 a las 10.11.08](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.11.08.png)

* Los algoritmos de direccionamiento **no suelen mantener el orden de la clave:**
  * Los registros no están almacenados según el orden de su clave física.
  * Problemas con la recuperación por intervalos.

* Hay una gran variedad de algoritmos: 
  * Dependen del tipo de clave:
  * Si la clave es alfanumérica, hay que transformarla a un valor numérico.
* Suelen estar basados en un mecanismo de generación de números pseudoaletorios:
  * *Cuadrados centrales*: Se eleva la clave al cuadrado y se eligen tantos dígitos centrales como sea necesario: http://research.cs.vt.edu/AVresearch/hashing/midsquare.php
  * *Congruencias**:* Se divide la clave por M y se toma el resto (M suele ser primo) http://research.cs.vt.edu/AVresearch/hashing/modfunc.php
  * *Desplazamiento**:* Se superponen adecuadamente los dígitos binarios de la clave y luego se suman.
  * *Conversión de base**:* Se cambia la base de numeración y se suprimen algunos dígitos resultantes.

- Comparación del rendimiento de diversas funciones Hash:  http://research.cs.vt.edu/AVresearch/hashing/hashfuncsum.php
- **Problemas**:
  - Salvo que el campo clave se diseñe para ello, es prácticamente imposible encontrar una transformación que dé un valor entero positivo en un rango de valores limitado tal que:
    - No haya dos valores distintos de clave que den lugar al mismo número.
    - Por ello se **producen colisiones**.
  - Los algoritmos **producen huecos:**
    - Zonas vacías del rango de salida, no asignadas por el algoritmo.
    - Se traducen en huecos en el fichero de datos.

* **Para gestionar colisiones y huecos**:

  * Combinar el acceso directo con una gestión mediante listas de colisión:**Zona de desbordamiento**. 
  * Colisión:
    * El registro problemático se almacena en la zona de desbordamiento.
    * Los sinónimos (registros con claves que producen colisión) se conectan mediante una lista.

  ![Captura de pantalla 2021-05-28 a las 10.19.53](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.19.53.png)

***Para realizar ejecuciones con applet mirar pdf de la asignatura***

* Si crecen las listas de sinónimos:
  * El acceso directo puro no resulta óptimo por:
    * Mantener listas.
    * Zona de desbordamiento casi como el fichero original.
* Han aparecido técnicas más sofisticadas:
  * Hashing.

## 15. Hashing básico

Si el problema principal es que los valores de las claves no están uniformemente distribuidos en el intervalo [0,M]:

* Se acumulan en una parte de este intervalo. 
* Solución:
  * Asignar más espacio a esa parte del intervalo.

**Técnica**:

- Se divide el espacio del fichero en “cubos” (buckets).

- El algoritmo de direccionamiento asigna cubos, no direcciones

  concretas.

- En cada “cubo” puede haber más de un registro.

- Ciertos rangos de valores tienen asignados más cubos que otros.

- Se complementa con el uso de “cubos de desbordamiento”.

**Parámetros**:

* Número de cubos.
* Tamaño de los cubos (relación con bloques físicos): slots.
* La transformada clave/dirección debe tener en cuenta la distribución de la clave según rangos, para que unos cubos no se llenen mucho y otros se queden muy vacíos.
* ***Hay ejecucion en applet***

**Para insertar un registro:**

- Transformar la clave.
- Localizar el cubo correspondiente.
- Si hay sitio, se inserta el registro y hemos terminado.
- Si no hay sitio, se sitúa el registro en un cubo de desbordamiento conectándolo con el cubo que realmente le corresponde mediante punteros.

* El proceso de búsqueda:
  * Transformar la clave.
  * Localizar el cubo correspondiente.
  * Realizar una búsqueda secuencial dentro del cubo:
    * Si hemos encontrado el registro, el proceso termina.
    * En caso contrario, se impone “un barrido por punteros” a través de los cubos de desbordamiento.

![Captura de pantalla 2021-05-28 a las 10.24.05](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.24.05.png)



## 16. Hashing dinámico

**El hashing básico sigue teniendo problemas:**

- Es necesario conocer la distribución previa de las claves para

  asignar adecuadamente los cubos.

- En otro caso siguen apareciendo huecos/colisiones.

- Al aumentar el número de registros, aumentan los registros en páginas de desbordamiento.

- Se hacen necesarias las reorganizaciones.

**Solución:**

* Trabajar de forma dinámica.
* Esta técnica se denomina: Hashing dinámico o extensible.
* Se parte de una configuración uniforme y de pocos cubos.
* Los restantes, se van generando conforme se necesiten.
* Se asignan a los rangos conforme la afluencia de registros lo demanda.

**Técnica**:

- El valor transformado del campo clave nos lleva a la entrada de

  una tabla índice que se almacena en memoria.

-  Allí está la dirección del cubo donde se encuentran los registros que tienen asociado este valor transformado.

- Puede ocurrir que varias entradas de la tabla conduzcan al mismo cubo.

- Proceso:

  - Inicialmente, todas las entradas apuntan al mismo cubo.
  - A medida que vamos insertando registros, se van generando nuevos cubos y cambiando las salidas de la tabla índice.

**Algoritmo de Hashing dinámico**

* Datos de partida:
  * k= clave física para direccionar
  * k’= h(k) valor entero entre 0 y M
  * n= número de bits que tiene k’ en binario
  * d <= n, los d primeros dígitos de k’ seleccionan el cubo donde está el registro y se llaman pseudollave.
  * b<d<=n, inicialmente el archivo tiene 2b cubos distintos, como máximo tendrá 2d

**Algoritmo**:

- Se considera una tabla índice en memoria con 2d filas.

- En la primera columna de esta tabla (valores de campo clave) se sitúan todas las posibles sucesiones de d dígitos binarios:

  - d es la “profundidad global” de la tabla.

- En principio, todas las entradas cuyos b primeros dígitos son

  iguales apuntan al mismo cubo:

  * Allí se almacenan los registros cuyo valor de k’ tiene esos b primeros dígitos.

- Todos los cubos tienen en principio “profundidad local” igual a b.

- Cuando se llena un cubo se divide en 2, poniendo en uno de ellos los registros con el dígito b+1 de k’ a 0 y en el otro los que lo tienen igual a 1. La profundidad local de estos cubos aumenta una unidad.

![Captura de pantalla 2021-05-28 a las 10.28.06](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.28.06.png)

**Video de hashing extensible: **https://www.youtube.com/watch?v=8bj3wg-9E_w

**Ejemplo:**

![Captura de pantalla 2021-05-28 a las 10.29.00](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.29.00.png)

![Captura de pantalla 2021-05-28 a las 10.29.11](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.29.11.png)

![Captura de pantalla 2021-05-28 a las 10.29.20](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.29.20.png)

**Otro ejemplo:**

![Captura de pantalla 2021-05-28 a las 10.29.39](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.29.39.png)

![Captura de pantalla 2021-05-28 a las 10.29.47](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.29.47.png)

![Captura de pantalla 2021-05-28 a las 10.29.55](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.29.55.png)

![Captura de pantalla 2021-05-28 a las 10.30.02](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.30.02.png)

![Captura de pantalla 2021-05-28 a las 10.30.10](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.30.10.png)

![Captura de pantalla 2021-05-28 a las 10.30.19](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.30.19.png)

- El hashing dinámico **supera los problemas clásicos del acceso directo.**

- También tiene sus **inconvenientes**:

  - Utilizar una tabla índice adicional (nuevos accesos a disco si

    no cabe en memoria).

  - El tamaño máximo de la tabla depende de “n” y, por tanto, de la función de dispersión que se elija: número de valores distintos M que pueda devolver.

## 17. Uso del Hash en SGDB

- Para usar acceso mediante hash en un SGBD (p.e. Oracle), es preciso crear un “*cluster hash*” y asociar una o dos tablas a ese clúster.

- Ejemplo: “*Cluster Hash*” con una única tabla:
  ![Captura de pantalla 2021-05-28 a las 10.31.28](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.31.28.png)

- La cláusula HASHKEYS indica que se trata de un clúster accedido

  mediante hash:

  - El valor proporcionado (1000) indica la cantidad de valores hash que

    se van a generar (unos 1000 códigos de empleado).

  - Oracle busca el número primo superior a éste (1007 en este

    ejemplo) y esa será la cantidad de valores distintos que va generar.

- Mediante la **cláusula SIZE** debemos estimar el tamaño que van a ocupar todas las tuplas (empleados) que tomen un mismo valor para la clave hash (empno).
  - En este caso hay una tupla por cada valor de la clave y su tamaño, teniendo en cuenta el de sus atributos, es de 37 bytes.
- La **cláusula HASH IS** se puede usar si se cumple que la clave del clúster está compuesta por un único atributo de tipo NUMBER y contiene enteros uniformemente distribuidos.
  - Esas premisas se dan en el ejemplo, por lo que se podría incluir la cláusula HASH IS empno en la sentencia.
  - Esto además implicaría que no se usaría la función “hash” implementada por defecto en Oracle.

* El **acceso** a un empleado mediante hash a través de su código de departamento, sería:

![Captura de pantalla 2021-05-28 a las 10.32.25](/Users/albertollamasgonzalez/Desktop/Captura de pantalla 2021-05-28 a las 10.32.25.png)

* Comparativa de **uso de índice normal frente a hash:**

![Captura de pantalla 2021-05-28 a las 10.33.15](/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-05-28 a las 10.33.15.png)
