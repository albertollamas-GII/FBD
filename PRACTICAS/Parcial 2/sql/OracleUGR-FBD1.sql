CREATE TABLE Responde (
  ID NOT NULL REFERENCES USUARIO(ID),
  REF NOT NULL,
  NRO NOT NULL,
  rta_usuario char(1) NOT NULL
    CHECK (rta_usuario IN ('V','F')),
  tiempo INT NOT NULL 
    CHECK (tiempo >= 0 and tiempo <= 300),
  fecha DATE DEFAULT SYSDATE,
  FOREIGN KEY (REF, NRO) REFERENCES PREGUNTA(REF, NRO)
);