CREATE TABLE Linea(
    nombreLin varchar2(20) PRIMARY KEY);
    
CREATE TABLE Modelo(
    nombreModelo varchar2(30) PRIMARY KEY,
    capacidadModelo int,
    consumoModelo float);
    
CREATE TABLE Incidencia(
    refInci int NOT NULL, 
    descrInci varchar2(100), 
    costInci float, 
    tipoInci varchar2(20),
    CONSTRAINT clave_primaria_incidencia PRIMARY KEY(refInci));
    
CREATE TABLE Parada(
    nombreLin CONSTRAINT nombreLin_clave_externa_Linea REFERENCES Linea(nombreLin),
    ordeParada NUMBER, 
    direcParada varchar2(50),
    nombreParada char(20), 
    tiempoParada NUMBER,
    CONSTRAINT clave_primariaParada PRIMARY KEY (nombreLin, ordeParada));
    
CREATE TABLE AutobusTiene(
    numMat NUMBER NOT NULL PRIMARY KEY,
    nombreModelo NOT NULL CONSTRAINT nombreModelo_clave_externa_Modelo REFERENCES Modelo(nombreModelo));

CREATE TABLE Registra(
    numMat CONSTRAINT clave_externa_AutobusTiene REFERENCES AutobusTiene(numMat),
    refInci CONSTRAINT clave_externaIncidencia REFERENCES Incidencia(refInci),
    fechaIncidencia DATE,
    CONSTRAINT clavePrimariaRegistra PRIMARY KEY (numMat, refInci, fechaIncidencia));
    
CREATE TABLE Llega(
    numMat CONSTRAINT clave_externa_AutobusTienee REFERENCES AutobusTiene(numMat),
    cuando TIME,
    nomLin CONSTRAINT REFERENCES Parada(clave_primariaa),
    ordenParada CONSTRAINT REFERENCES Parada(clave_primariaa),
    numUsuario NUMBER,
    CONSTRAINT clave_primaria_Registra PRIMARY KEY (numMat, cuando));

