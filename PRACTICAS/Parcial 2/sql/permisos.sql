CREATE TABLE acceso (testigo NUMBER);

          INSERT INTO acceso VALUES(1);
          INSERT INTO acceso VALUES(462);
          
          GRANT SELECT ON acceso TO x6066049;
          
          SELECT * FROM x2081180.acceso;
          
          SELECT * FROM x4370025.acceso;
          
          REVOKE SELECT ON acceso FROM x6066049;
          
          GRANT SELECT ON acceso TO x6066049 WITH GRANT OPTION;
          
          GRANT SELECT ON x4370025.acceso TO x6066049;
          
          SELECT * FROM x6050580.acceso;
          
          SELECT * FROM x6066049.acceso;
          
          REVOKE SELECT ON acceso FROM x6066049;
          
          drop table acceso;