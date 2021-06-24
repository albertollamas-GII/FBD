CREATE TABLE ObjetoAstronomico (
    codigoO CHAR(3) PRIMARY KEY,
    fecha DATE DEFAULT SYSDATE,
    observatorio VARCHAR2(30)
);

CREATE TABLE Estrella (
    codigoE REFERENCES ObjetoAstronomico(codigoO) PRIMARY KEY,
    tipo VARCHAR2(15) NOT NULL,
    subtipo VARCHAR2(15)
);

CREATE TABLE BajaEmision (
    codigoBE REFERENCES ObjetoAstronomico(codigoO) PRIMARY KEY
);

CREATE TABLE Planeta (
    codigoP,
    tipo VARCHAR2(10),
    FOREIGN KEY (codigoP) REFERENCES BajaEmision(codigoBE),
    PRIMARY KEY (codigoP)
);
CREATE TABLE Satelite (
    codigoS,
    tipo VARCHAR2(10),
    FOREIGN KEY (codigoS) REFERENCES BajaEmision(codigoBE), -- cuando tenemos mas de una clave externa
    PRIMARY KEY (codigoS)
);
CREATE TABLE Constelacion (
    codigoC INT PRIMARY KEY,
    nombre VARCHAR2(25) DEFAULT 'desconocido' NOT NULL
);

CREATE TABLE Forma (
    codigoC REFERENCES  Constelacion(codigoC),
    codigoE REFERENCES Estrella(codigoE),
    PRIMARY KEY (codigoC, codigoE) --Clave primaria compuesta
);

CREATE TABLE  Gira (
    codigoS REFERENCES Satelite(codigoS) PRIMARY KEY,
    codigoP REFERENCES Planeta(codigoP),
    distancia INT CHECK(distancia > 0)
);

CREATE TABLE  Orbita (
    codigoP REFERENCES Planeta(codigoP) PRIMARY KEY,
    codigoE REFERENCES Estrella(codigoE),
    distancia INT CHECK(distancia > 0)
);

COMMIT;

ALTER TABLE Satelite ADD (
    codigoP REFERENCES Planeta(codigoP),
    distancia INT CHECK(distancia > 0));
    
drop table Gira;

ALTER TABLE Planeta ADD (
codigoE REFERENCES Estrella(codigoE),
    distancia INT CHECK(distancia > 0)
);

drop table Orbita;

INSERT INTO ObjetoAstronomico VALUES ('ABC',SYSDATE,'Observatorio de Granada');

SELECT * FROM ObjetoAstronomico;
DESCRIBE objetoastronomico;

INSERT INTO objetoastronomico (codigoO) VALUES ('ABZ');
SELECT * FROM ObjetoAstronomico;

UPDATE objetoastronomico SET fecha=fecha+1;
SELECT * FROM ObjetoAstronomico;

UPDATE objetoastronomico SET observatorio='Real Observatorio de Granada' WHERE (codigoO='ABC');
SELECT * FROM ObjetoAstronomico;

DELETE FROM objetoastronomico WHERE (codigoO='ABC');


