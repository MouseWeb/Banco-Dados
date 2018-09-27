INSERT ALL
  INTO tcurso (cod_curso,nome, valor)
  INTO taluno (cod_aluno,nome, salario)
      SELECT cod_contrato+50,'INSERT ALL', 1013
      FROM TCONTRATO
      WHERE COD_CONTRATO=1;

      --  ALTER TABLE TALUNO ADD SALARIO NUMERIC;

SELECT * FROM TCURSO;
SELECT * FROM TALUNO;

-----**************


CREATE SEQUENCE seq_curso START WITH 100;

--
INSERT ALL
   WHEN TOTAL>=1000  THEN
        INTO TCURSO (COD_CURSO, NOME, VALOR)
        VALUES (seq_curso.NEXTVAL, 'CURSO>1000', TOTAL)
   WHEN DESCONTO IS NULL THEN
        INTO TCURSO (COD_CURSO, NOME, VALOR)
        VALUES (seq_curso.NEXTVAL, 'DESCONTO IS NULL', TOTAL)
   SELECT COD_CONTRATO, TOTAL, DESCONTO
   FROM TCONTRATO WHERE COD_CONTRATO = 1;


SELECT * FROM TCURSO;


--Merge
CREATE SEQUENCE seq_con START WITH 500;

MERGE INTO TCONTRATO tcn
    USING (SELECT COD_ALUNO AS ALUNO
           FROM   TALUNO
           WHERE  estado = 'RS')
    ON    (tcn.COD_ALUNO = ALUNO)
       WHEN MATCHED THEN --Encontrou o registro
            UPDATE SET desconto = 22
       WHEN NOT MATCHED THEN --nao encontrou o registro
            INSERT(tcn.COD_CONTRATO, tcn.DATA, tcn.COD_ALUNO,
                   tcn.desconto, tcn.total)
           VALUES( Seq_Con.NextVal, SYSDATE, ALUNO, 0, 666);

SELECT * FROM TCONTRATO

--ALTER TABLE TALUNO ADD ESTADO VARCHAR(2) DEFAULT  'RS';

