
CREATE DATABASE LINK filial
CONNECT TO douglas     --usuario
IDENTIFIED BY "123"   --senha do usuario
USING 'xe'            --tns (sid)
;
--TNS

CREATE TABLE TCONTRATO
(  COD_CONTRATO INTEGER NOT NULL PRIMARY KEY,
   DATA DATE,
   COD_ALUNO INTEGER,
   TOTAL NUMBER(8,2),
   DESCONTO NUMBER(5,2)
);

select * from TALUNO;

select * from TCONTRATO;

CREATE SEQUENCE seq_con START WITH 500;

MERGE INTO TCONTRATO tcn
    USING (SELECT COD_ALUNO AS ALUNO
           FROM   TALUNO@FILIAL
           WHERE  estado = 'RS')
    ON    (tcn.COD_ALUNO = ALUNO)
       WHEN MATCHED THEN --Encontrou o registro
            UPDATE SET desconto = 28
       WHEN NOT MATCHED THEN --nao encontrou o registro
            INSERT(tcn.COD_CONTRATO, tcn.DATA, tcn.COD_ALUNO,
                   tcn.desconto, tcn.total)
            VALUES( Seq_Con.NextVal, SYSDATE, ALUNO, 0, 666);
           
CREATE TABLE TALUNO
(
  COD_ALUNO INTEGER NOT NULL,
  NOME VARCHAR(30),
  CIDADE VARCHAR2(30),
  CEP VARCHAR(10),
  PRIMARY KEY (COD_ALUNO)
);

------------------------------------------------

SELECT * FROM taluno
ORDER BY cod_aluno;

SELECT * FROM tcontrato; 

CREATE SEQUENCE seq_con START WITH 50;
--

MERGE INTO tcontrato tcn
    USING (SELECT cod_aluno AS aluno
              FROM taluno)
    ON ( tcn.cod_aluno = aluno )
    WHEN MATCHED THEN --Encontrou o registro
         UPDATE
            SET desconto = 44
    WHEN NOT MATCHED THEN --nao encontrou o registro
        INSERT ( tcn.cod_contrato, tcn.data, tcn.cod_aluno, tcn.desconto, tcn.total )
         VALUES( seq_con.NEXTVAL, sysdate, aluno, 0, 666 );
           