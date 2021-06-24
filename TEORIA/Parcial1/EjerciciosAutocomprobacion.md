# EJERCICIOS DE AUTOCOMPROBACIÓN

## Tema 1

### ¿Cuáles son las principales diferencias entre un sistema de procesamiento de archivos y un sistema de bases de datos?

Un sistema de base de datos está especialmente diseñado para almacenar datos sin redundancia de forma que puedan ser útiles para diferentes aplicaciones. Es un fondo común de información almacenada en una computadora para que cualquier persona o programa autorizado pueda acceder a ella, independientemente del lugar de procedencia y del uso que haga de la misma solucionando de esta forma los principales problemas de los sistemas de archivos: **Redundancia, Inconsistencia, No reutilizables.**

### Describe las características más importantes en un sistema de base de datos y también las propiedades más deseables. Explica a tu juicio cuál es la propiedad más importante.

* No redundancia e inconsistencia (más importante)

* Definir estructuras de almacenamiento.

* Acceder a los datos de forma eficiente y segura.

*  Organizar la actualización de los datos y el acceso multiusuario.

  

### Hemos conocido las ventajas de utilizar un sistema de bases de datos, ¿podrías comentar también algunos inconvenientes?

- **Alta complejidad**

Los SGBD son conjuntos de programas muy complejos con una gran funcionalidad. Es preciso comprender muy bien esta funcionalidad para poder sacar un buen partido de ellos.

- **Gran tamaño**

Los SGBD son programas complejos y muy extensos que requieren una gran cantidad de espacio en disco y de memoria para trabajar de forma eﬁciente.

**Coste económico del SGBD** 

El coste de un SGBD varía dependiendo del entorno y de la funcionalidad que ofrece.

- **Coste del equipamiento adicional**

Tanto el SGBD, como la propia base de datos, pueden hacer que sea necesario adquirir más espacio de almacenamiento. Además, para alcanzar las prestaciones deseadas, es posible que sea necesario adquirir una máquina más grande o una máquina que se dedique solamente al SGBD. Todo esto hará que la implantación de un sistema de bases de datos sea más cara.

- **Coste de la conversión**

En algunas ocasiones, el coste del SGBD y el coste del equipo informático que sea necesario adquirir para su buen funcionamiento es insigniﬁcante comparado al coste de convertir la aplicación actual en un sistema de bases de datos

- **Prestaciones**

Un sistema de ﬁcheros está escrito para una aplicación especíﬁca, por lo que sus prestaciones suelen ser muy buenas. Sin embargo, los SGBD están escritos para ser más generales y ser útiles en muchas aplicaciones, lo que puede hacer que algunas de ellas no sean tan rápidas como antes.

- **Vulnerable a los fallos**

El hecho de que todo esté centralizado en el SGBD hace que el sistema sea más vulnerable ante los fallos que puedan producirse.

### Explica la diferencia entre independencia física e independencia lógica.

**Independencia física:** diseño lógico de la BD, a todos los niveles, debe ser independiente del almacenamiento físico de los datos permitiendo realizar cambios en la estructura física sin alterar la lógica de la aplicación y liberarando a las aplicaciones de gestionar los aspectos relativos al almacenamiento.

**Independencia lógica: **Cada aplicación debe poder organizar los datos según sus propios esquemas y acceder a los datos que le son necesarios y le conciernen (vistas de usuario). Persigue que los cambios en el esquema lógico general no afecten a las vistas de usuario de manera que las aplicaciones no necesiten ser modificadas. No siempre se puede conseguir, pues determinados cambios requieren cambios en las vistas de usuario.

### Definir brevemente los siguientes conceptos:

- Base de datos: Conjunto de datos relacionados (comunes a un “proyecto”) almacenados sin redundancia para ser útiles a diferentes aplicaciones. Resumiendo y simplificando, es un fondo común de información almacenada en una computadora para que cualquier persona o programa autorizado pueda acceder a ella, independientemente del lugar de procedencia y del uso que haga de la misma.
- DBMS (DataBase Management System): Programas para describir las estructuras y gestionar la información de la BD.
- DBA (DataBase Administrator): Administrador de la base de datos
- Acceso concurrente: acceder a la vez a algo, en este caso a la base de datos. Dos personas no pueden modificar una BD a la vez
- Vista de usuario: parte de la base de datos utilizada por el usuario.

### Explicar brevemente los conceptos de: Integridad, fiabilidad y seguridad en una base de de datos.

**Integridad**:

Los datos almacenados en una BD deben corresponderse con la realidad que representan.
 El diseño de la BD y el SGBD deben procurar acercarse lo máximo posible a ese objetivo.

**Fiabilidad**:

Los datos deben estar protegidos contra fallos.
 Mecanismos de mantenimiento de recuperación y relanzamiento de transacciones (o se realiza o no se realiza pero no se puede dividir (ver en Tema 2) o se completa y funciona o falla y se empieza desde el principio) -> *redundancia controlada* (en el diseño no tengo redundancia pero a la hora de implantar la base de datos, si hay que tener algunos datos duplicados y si hay que tener copias de seguridad necesitamos la redundancia).

**Seguridad**:
No todos los datos deben ser accesibles a todos los usuarios.

- Ordenarlos por importancia, explicando los criterios utilizados para elaborar el orden. 
- ¿En qué etapa de la vida de una base de datos se deben tener en cuenta unos y otros?
- ¿Cómo se mantienen en una base de datos?



## Tema 2

### Explicar la relación existente entre los niveles de una base de datos y el concepto de independencia.

Interno: independencia física

Conceptual: independencia lógica

Externo: vista del usuario

### Explicar la diferencia entre esquema externo y aplicaciones de usuario.

Una misma aplicación puede presentar información a diferentes usuarios.

### Explica el motivo por el que, a tu juicio, no se han desarrollado DDLs a nivel interno.

Para mantener la independencia física.

### Explica el motivo por el que, a tu juicio, no se han desarrollado DMLs a nivel externo.

Porque la lectura y escritura de los datos deben hacerse a un nivel físico.

### Buscar tres ejemplos de lenguajes de cuarta generación. Indicar sus objetivos o funciones. (NO)

### ¿Cuál es el enfoque actual del concepto de lenguaje anfitrión? Dar ejemplos de lenguajes anfitrión.

El lenguaje anfitrión es en el que se va a programar la aplicación que utiliza la base de datos, ya que el sistema de gestión de bases de datos, ya que el sistema de gestión de bases de datos no es suficiente de por sí para esta función. Los lenguajes anfitrión pueden ser C++, Java o Python.

### ¿Qué elementos conciernen al nivel interno de una base de datos?

Representación física de la BD en el ordenador --> cómo están almacenados los datos. Busca el rendimiento óptimo del sistema.

Representa:

- Estructuras de datos.
- Organizaciones en ficheros.
- Comunicación con el SO para gestionar el uso de unidades de almacenamiento.
- Compresión de datos, cifrado ...

Parte de las responsabilidades de este nivel las realiza el SO:

* Nivel físico.
* No existe una división clara, depende de cada SGBD y de cada SO.

### ¿Qué cuestiones debe cubrir a tu juicio una buena herramienta de gestión privilegios de usuarios?

Debe permitir que entre los usuarios no se pueda acceder a los datos de otros. También debbe tener una forma de cambiar la contraseña de cada usuario.

### Explicar las ventajas de la arquitectura cliente/servidor a tres niveles.

Reducción significativa de costes en cuanto al mantenimiento de los clientes: instalación, configuración y actualización de las aplicaciones realizada en el servidor, no en cada cliente.
 Mayor facilidad y flexibilidad para el usuario. Puede acceder desde casi cualquier puesto y a veces desde distintos dispositivos: móviles, tablets, portátil, PC, etc.



### Tema 3

