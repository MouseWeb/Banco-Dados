
--
DECLARE
  HORA VARCHAR2(2);
  H NUMBER;
BEGIN
  H := TO_NUMBER(To_Char(SYSDATE,'HH24'));
  Dbms_Output.Put_Line(H||' - '||TO_CHAR(SYSDATE, 'DAY'));
END;

BEGIN
  IF(TO_CHAR(SYSDATE, 'DAY') IN ('DOMINGO') OR
    TO_NUMBER(To_Char(SYSDATE,'HH24'))
        NOT BETWEEN 8 AND 18)THEN
    Raise_Application_Error
        ( -20001,'Fora do horário comercial');
  END IF;
END;

SELECT TO_CHAR(SYSDATE, 'D') FROM DUAL;
SELECT To_Number(To_Char(SYSDATE,'HH24')) FROM DUAL;

--
CREATE OR REPLACE TRIGGER VALIDA_HORARIO_CURSO
BEFORE INSERT OR DELETE ON TContrato
BEGIN
  IF(TO_CHAR(SYSDATE, 'D') IN (1) OR
     To_Number(To_Char(SYSDATE,'HH24'))
     NOT BETWEEN 8 AND 18) THEN
   Raise_Application_Error(-20001,'Fora horário comercial');
  END IF;
END;
--

--
INSERT INTO TCONTRATO
VALUES (7665, SYSDATE, 10, 1500, NULL);


--
SELECT * FROM TCONTRATO;


CREATE TABLE LOG
( USUARIO VARCHAR2(30),
  DATA DATE,
  VALOR_ANTIGO VARCHAR2(10),
  VALOR_NOVO VARCHAR2(10)
);

CREATE OR REPLACE TRIGGER gera_log_alt
AFTER UPDATE OF TOTAL ON TContrato
DECLARE
BEGIN
  INSERT INTO LOG(Usuario, DATA) VALUES (USER, SYSDATE);
END;

SELECT * FROM TCONTRATO;
UPDATE TCONTRATO SET TOTAL = 5000 WHERE COD_CONTRATO = 1;

SELECT * FROM LOG;


CREATE OR REPLACE TRIGGER valida_horario_curso2
BEFORE INSERT OR UPDATE OR DELETE ON TCONTRATO
BEGIN
  IF(TO_CHAR(SYSDATE,'D') IN (1, 7) OR
  TO_NUMBER(To_Char(SYSDATE,'HH24'))NOT BETWEEN 8 AND 18)THEN
    IF( INSERTING ) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Não pode inserir');
    ELSIF( DELETING ) THEN
      RAISE_APPLICATION_ERROR(-20002, 'Não pode remover');
    ELSIF( UPDATING('TOTAL') ) THEN
      RAISE_APPLICATION_ERROR(-20003, 'Não pode alterar total');
    ELSE
      RAISE_APPLICATION_ERROR(-20004, 'Não pode alterar');
    END IF;
  END IF;
END;

--Testes
ALTER TRIGGER valida_horario_curso DISABLE;
DELETE FROM TCONTRATO;
UPDATE TCONTRATO SET TOTAL = 5000 WHERE COD_CONTRATO = 1;
INSERT INTO TCONTRATO VALUES (90, SYSDATE, 10, 1500, NULL);

ALTER TRIGGER valida_horario_curso2 DISABLE;





ALTER TABLE Log ADD OBS VARCHAR(80);



CREATE OR REPLACE TRIGGER audita_aluno
AFTER INSERT OR DELETE OR UPDATE ON TALUNO
FOR EACH ROW --Executa para cada linha afetada
             --Sem o FOR EACH ROW executa uma vez só
BEGIN
  IF( DELETING )THEN
    INSERT INTO log( usuario, data, OBS )
    VALUES ( USER, SYSDATE,'Linhas deletadas.');
  ELSIF( INSERTING )THEN
    INSERT INTO log( usuario, data, OBS )
    VALUES ( USER, SYSDATE, 'Linhas inseridas.' );
  ELSIF( UPDATING('SALARIO') )THEN
    INSERT INTO log
    VALUES ( USER, SYSDATE,:OLD.SALARIO,:NEW.SALARIO,
    'Alterado Salario');
  ELSE
    INSERT INTO log( usuario, data, OBS )
    VALUES ( USER, SYSDATE, 'Atualização Aluno.' );
  END IF;
END;

SELECT * FROM Log;
UPDATE TALUNO SET SALARIO = 2500;





CREATE OR REPLACE TRIGGER gera_Log_CURSO
BEFORE UPDATE OF VALOR ON TCURSO
FOR EACH ROW
BEGIN
  INSERT INTO Log( Usuario, data, obs,
                   Valor_antigo, Valor_novo)
  VALUES ( USER, SYSDATE,'Curso Alterado: '||:OLD.NOME,
           :OLD.VALOR, :NEW.VALOR );
END;

//
ALTER TRIGGER VALIDA_HORARIO_CURSO DISABLE;

UPDATE TCURSO SET
VALOR = 3000
WHERE valor > 1000

SELECT * FROM Log;




ALTER TABLE tcontrato ADD valor_comissao NUMERIC(8,2);

CREATE OR REPLACE TRIGGER calc_comissao
BEFORE INSERT OR UPDATE OF total ON TContrato
REFERENCING OLD AS antigo
            NEW AS novo
FOR EACH ROW
WHEN(Novo.Total >= 5000)
DECLARE
  vComissao NUMERIC(6,2) := 0.15;
BEGIN
  IF(:novo.Total <= 10000) THEN
    :novo.valor_comissao := :novo.Total*(vComissao);
  ELSE
    :novo.valor_comissao := :novo.Total*(vComissao+0.01);
  END IF;
END;
--
INSERT INTO TCONTRATO(COD_CONTRATO, TOTAL)VALUES(666,6000);
INSERT INTO TCONTRATO(COD_CONTRATO, TOTAL)VALUES(667,12000);
SELECT * FROM tcontrato

--ALTER TABLE tcontrato MODIFY desconto NUMERIC(12,2);

--INSERT INTO TCONTRATO VALUES (18, SYSDATE, 5, 7500 , NULL);
SELECT * FROM TCONTRATO;


--Exemplo de view com trigger e dml
CREATE OR REPLACE VIEW vcontratos_pares
AS SELECT COD_CONTRATO, DATA, COD_ALUNO, DESCONTO, TOTAL
   FROM   tcontrato
   WHERE  MOD( COD_CONTRATO, 2 ) = 0;
----------------
SELECT * FROM vcontratos_pares;
----------------
CREATE OR REPLACE TRIGGER tri_contratos_pares
INSTEAD OF INSERT OR DELETE OR UPDATE ON vcontratos_pares
DECLARE
BEGIN
  INSERT INTO Log( usuario, data, obs )
  VALUES (USER, SYSDATE, 'DML da view VCONTRATOS_PARES.' );
END;
----------------
INSERT INTO vContratos_pares VALUES(90,SYSDATE,10, NULL, 5000);

SELECT * FROM Log;


--trigger mutante
--ALTER TABLE tcurso ADD pre_req INTEGER;

CREATE OR REPLACE TRIGGER tri_atual_prereq
AFTER UPDATE ON tcurso FOR EACH ROW
BEGIN
  UPDATE tcurso
  SET    pre_req = :new.cod_curso
  WHERE  pre_req = :old.cod_curso;
END;


UPDATE TCurso SET Cod_Curso = 100 WHERE Cod_Curso = 3;



CREATE OR REPLACE TRIGGER verifica_total
BEFORE INSERT OR UPDATE OF total ON TCONTRATO
FOR EACH ROW
DECLARE
  vMin_total   tcontrato.total%TYPE;
  vMax_total   tcontrato.total%TYPE;
BEGIN
  SELECT Min(total), Max(total)
  INTO vMin_total, vMax_total FROM TCONTRATO;
  IF( :new.total < vMin_total OR   -- Novo valor deve estar entre o valor
      :new.total > vMax_total )THEN  -- Mínimo e Máximo
    RAISE_APPLICATION_ERROR(-20505, 'Valor Inválido');
  END IF;
END;

UPDATE TCONTRATO SET total = 10 WHERE COD_CONTRATO = 1;

SELECT * FROM TCONTRATO;


--Resolvendo Erros de Mutante tables (Solução)
CREATE OR REPLACE PACKAGE pkg_Contrato
AS
 vValor1 NUMERIC(12,2);
 vValor2 NUMERIC(12,2);
END;
/
CREATE OR REPLACE TRIGGER tri_verifica_total_1
BEFORE INSERT OR UPDATE OF total ON tcontrato
BEGIN
  SELECT MIN(total), MAX(total)
  INTO pkg_Contrato.vValor1, pkg_Contrato.vValor2
  FROM   tcontrato;
END;
/
CREATE OR REPLACE TRIGGER tri_verifica_total_2
BEFORE INSERT OR UPDATE OF total ON tcontrato
FOR EACH ROW
BEGIN
   IF(:new.Total < pkg_Contrato.vValor1 OR
      :new.Total > pkg_Contrato.vValor2 ) THEN
    RAISE_APPLICATION_ERROR(-20001,'Valor Inválido');
  END IF;
END;
/
UPDATE tcontrato SET total = 12 WHERE COD_CONTRATO = 1;


ALTER TRIGGER verifica_total DISABLE; --Desativa
ALTER TRIGGER verifica_total ENABLE;  --Ativa


ALTER TABLE TCONTRATO DISABLE ALL TRIGGERS;
ALTER TABLE TCONTRATO ENABLE ALL TRIGGERS;


DROP TRIGGER verifica_total;
