--conectado com usuario system

DROP DATABASE LINK filial;

CREATE DATABASE LINK filial
CONNECT TO marcio     --usuario
IDENTIFIED BY "123"   --senha do usuario
USING 'xe'            --tns (sid)

--TNS


SELECT * FROM TALUNO@FILIAL
