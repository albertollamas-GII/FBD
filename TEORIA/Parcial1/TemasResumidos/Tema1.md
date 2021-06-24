# TEMA 1 : INTRODUCCIÓN Y DEFINICIONES INICIALES

## ÍNDICE

*  Concepto intuitivo de Base de Datos
* Bases de Datos y Sistemas de Gestión de Bases de Datos.
* Concepto de independencia.
* Objetivos de un SGBD.

### 1. Concepto Intuitivo de Base de Datos

Prácticamente todas las empresas requieren de aplicaciones que gestionen información, accesible desde diferentes puntos de acceso.

Pueden aparecer tres problemas:

- [x] **Redundancia** : cuando la información está duplicada en distintas zonas de la Base de Datos.
- [x] **Inconsistencia**: datos no correctamente actualizados.
- [x] **No hay reutilización**: se introduce un datos desde 0 sin utilizar la entrada ya creada en otra Base.

Por ahora para "solapar" la información en las aplicaciones que usan los datos utilizamos los ficheros. Este sistema de archivos presenta cierta complejidad:

- [x] Crear un archivo con una estructura determinada.
- [x] Consultar o actualizar un archivo imponiendo diferentes condiciones.
- [x] Modificar dinámicamente la estructura de un archivo.
- [x] Proteger ciertos datos de usuarios no autorizados.
- [x] Permitir el acceso desde distintas aplicaciones, con distintos lenguajes y sistemas operativos.

Para solucionar estos problemas, o al menos evitarlos, utilizamos un Sistema de Gestión de Bases de Datos (SGBD)





**Definiciones**

***Base de Datos (BD)***: Conjunto de datos relacionados (comunes a un “proyecto”) almacenados sin redundancia para ser útiles a diferentes aplicaciones. Resumiendo y simplificando, es un fondo común de información almacenada en una computadora para que cualquier persona o programa autorizado pueda acceder a ella, independientemente del lugar de procedencia y del uso que haga de la misma.

***Sistema Gestor de Bases de Datos (SGBD)***: Conjunto de elementos software con capacidad para definir, mantener y utilizar una base de datos.

Debe permitir (entre otros):

- [x] Definir estructuras de almacenamiento.
- [x] Acceder a los datos de forma eficiente y segura.
- [x] Organizar la actualización de los datos y el acceso multiusuario.

Se pueden realizar varias **operaciones** con un SGBD: 

- [x] Gestionar datos y una estructura de datos de forma transparente (sin necesidad de que se necesite programar código para “toquetear” ficheros):
  - [x] INSERTAR datos (**C**reate).
  - [x] OBTENER datos previamente insertados en la BD (**R**ead).
  - [x] MODIFICAR datos existentes (**U**pdate).
  - [x] BORRAR datos existentes (**D**elete).
- [x] Normalmente nos referimos a estas operaciones como:
  - [x] \- CRUD(**C**reate,**R**ead,**U**pdate,**D**elete).

### 2. Bases de Datos y Sistema de Gestión de Bases de Datos

Elementos involucrados en una BD:

* Datos:
  * Integrados según las distintas necesidades (sin redundancia). 
  * Compartidos(útiles a varias aplicaciones).
* Hardware:
  * Soporte necesario.
  * BD centralizada, federada o distribuida.
* Software SGBD o DBMS (DataBase Management System):
  * Programas para describir las estructuras y gestionar la información de la BD.
  * Programas de aplicación.
* Usuarios:
  * Usuario final.
  * Programador de aplicaciones.
  * Administrador (DBA ó DBM).

***Dato Operativo***: Pieza de información básica que necesita una empresa (o proyecto, o aplicación, etc.) para su funcionamiento. Puede ser:

* **Ítem básico**: Elementos acerca de los que se puede pedir infomación (sustantivos). [Estudiante, Asignatura, Paciente, Médico...].
* **Atributos**: Características de los ítems básicos (adjetivos o propiedades de los ítems). [Nombre, DNI, Apellidos, etc].
* **Relaciones**: Conexiones lógicas entre ítems (verbos o acciones). [Estudiante está matriculado en Asignatura].

Cuando se determinan y clasifican de esta forma todos los datos operativos, se obtiene el **esquema lógico** de la BD. En el día a día, usaremos el término **campo** para referirnos a la representación de un dato o de atributos de la BD.

<img src="/Users/albertollamasgonzalez/Library/Application Support/typora-user-images/Captura de pantalla 2021-03-11 a las 13.06.31.png" alt="Captura de pantalla 2021-03-11 a las 13.06.31" style="zoom: 150%;" />

  ### 3. Concepto de Independencia

***Independencia***: Los datos se organizan independientemente de las aplicaciones que los vayan a usar y de los archivos en los que vayan a almacenarse.

***Independencia física***: El diseño lógico de la BD, a todos los niveles, debe ser independiente del almacenamiento físico de los datos. **Esto permite**:

* Realizar cambios en la estructura física sin alterar la lógica de la aplicación.
  * Representación de campos 
  * Organización en registros 
  * Organización en archivos 
  * Mecanismos de acceso 
  * Distribución física
* Liberar a las aplicaciones de gestionar los aspectos relativos al almacenamiento.
  * Optimizar recursos 
  * Cambios hardware
  * Optimización accesos



***Independencia lógica***: Existen dos tipos de estructuras lógicas:

* **Esquema lógico general** (o visión global de la BD) : Permite organizar la información global de toda la organización para optimizar accesos, evitar redundancia, etc.
* **Vistas de usuario** (o los datos a los que se permite acceso a un usuario, aplicación, etc.): Permite "dar permiso" a los programadores de las aplicaciones para accerder a los datos que pueden "ver" del esquema general, ocultando los datos a los que no se debe tener acceso.

Cada aplicación debe poder organizar los datos según sus propios esquemas y acceder a los datos que le son necesarios y le conciernen (vistas de usuario). Persigue que los cambios en el esquema lógico general no afecten a las vistas de usuario de manera que las aplicaciones no necesiten ser modificadas. No siempre se puede conseguir, pues determinados cambios requieren cambios en las vistas de usuari. Con ello se produce:

* Aumento de seguridad y fiabilidad.
* Menos problemas para las aplicaciones. 
* Posibilidad de cambios en los esquemas por parte de desarrolladores de las aplicaciones y por parte de los administradores.

### 4. Objetivos de un SGBD

Los objetivos de un SGBD son:

* **Independencia de los datos**. Poder realizar cambios que no afecten al resto de etapas a la hora de implementar las BD. Intentar que el diseño se quede lo más estable posible 
* **Diseño y utilización orientada al usuario**: Los datos y aplicaciones deben ser accesibles a los usuarios de la manera más amigable posible para:
  * Soportar un modelo de datos teórico.
  * Soportar facilidades de definición.
  * Soportar lenguajes de acceso y modificación.
* **Centralización**: Los datos deben gestionarse de forma centralizada (se encarga una única persona) e independiente de las aplicaciones apareciendo la figura del Administrador de la BD y las Utilidades de la Gestión que permiten controlar las aplicaciones y sus permisos junto con las prestaciones del sistema.
* **No redundancia**: 
  * Los datos no deben estar duplicados. 
  * Gestión de accesos concurrentes.
* **Consistencia**:
  - Si una BD contiene varias copias de la información del mismo objeto, éstas deben ser idénticas. Copias para mantener la seguridad con copias idénticas, actualizadas en todo momento.
* **Integridad**:
  - Los datos almacenados en una BD deben corresponderse con la realidad que representan.
  - El diseño de la BD y el SGBD deben procurar acercarse lo máximo posible a ese objetivo.
* **Fiabilidad**:
  - Los datos deben estar protegidos contra fallos.
  - Mecanismos de mantenimiento de recuperación y relanzamiento de transacciones (o se realiza o no se realiza pero no se puede dividir (ver en Tema 2) o se completa y funciona o falla y se empieza desde el principio) -> *redundancia controlada* (en el diseño no tengo redundancia pero a la hora de implantar la base de datos, si hay que tener algunos datos duplicados y si hay que tener copias de seguridad necesitamos la redundancia).
* **Seguridad**:
  - No todos los datos deben ser accesibles a todos los usuarios:
    * Mecanismos de gestión de usuarios y privilegios.
    * Mecanismos de protección de información.

***Para el usuario:***

- **Usuario final**: Puede acceder a los datos.
- **Programador de aplicaciones**, elimina problemas de:
  - Diseño lógico y físico -> reduce necesidad de reescribir programas. 
  - Depuración de errores.
  - Mantenimiento en general (copias de seguridad, recuperación de
  fallos, etc.).
- **Administrador de BD**: esta figura y su cometido surge con la aparición
de las BDs.

***Para el sistema:***

- **Control centralizado**: fiabilidad, consistencia, seguridad, etc. 
- **Criterios de uniformización**.
- **Generación de nuevas aplicaciones**.
- **Equilibrio entre requerimientos conflictivos**.
- **Escalabilidad**: incrementar capacidad y procesamiento.
