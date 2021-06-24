CREATE TABLE plantilla(
  dni varchar2(9),
  nombre varchar2(15),
  estadocivil varchar2(10)
    CHECK (estadocivil IN ('soltero', 'casado', 'divorciado', 'viudo')),
  fechaalta date,
  PRIMARY KEY (dni));
  
CREATE TABLE serjefe(
             dnijefe REFERENCES plantilla(dni),
             dnitrabajador REFERENCES plantilla(dni),
             PRIMARY KEY (dnitrabajador)
             );
            
drop table prueba1;

  