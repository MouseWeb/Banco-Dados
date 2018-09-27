DECLARE
  vCod   taluno.cod_aluno%TYPE := 566;
  vCidade taluno.cidade%TYPE;    x NUMBER;
BEGIN
  SELECT Cidade INTO vCidade
  FROM TAluno
  WHERE nome LIKE '%';
  --WHERE  cod_aluno = vCod;
  X := 0 / 0;
  Dbms_Output.Put_Line('Cidade: '||vCidade);
EXCEPTION
  WHEN no_data_found THEN
    RAISE_APPLICATION_ERROR(-20001,
           'Aluno Inexistente! '||SQLCODE||' '||SQLERRM);
  WHEN too_many_rows THEN
    RAISE_APPLICATION_ERROR(-20002,
           'Registro Duplicado! '||SQLCODE||' '||SQLERRM);
  WHEN others THEN
    RAISE_APPLICATION_ERROR(-20003,
           'Exceção Desconhecida! '||SQLCODE||' '||SQLERRM);
END;


--SELECT * FROM taluno

CREATE TABLE CONTAS
(
  Codigo     INTEGER NOT NULL PRIMARY KEY,
  Valor      NUMBER(10, 2),
  Juros      NUMBER(10, 2),
  Vencimento DATE
);

INSERT INTO CONTAS VALUES (100, 550, 50, SYSDATE-10);

SELECT * FROM CONTAS;

COMMIT;




--
DECLARE
   vDt_vencimento DATE;
   vConta  NUMBER := 100; --codigo da conta
   eConta_vencida EXCEPTION;
BEGIN
  SELECT vencimento INTO vDt_vencimento
  FROM CONTAS WHERE codigo = vConta;
  IF vDt_vencimento < TRUNC(SYSDATE) THEN
    RAISE eConta_vencida;
  END IF;
 EXCEPTION
  WHEN eConta_vencida THEN
    Dbms_Output.Put_Line('Conta vencida');
    UPDATE contas SET valor = valor + juros
    WHERE  codigo = vConta;
END;

--VALOR MUDA PARA 600
SELECT * FROM contas

---
---
DECLARE
   eFk_Erro EXCEPTION;
   PRAGMA EXCEPTION_INIT(eFk_Erro, -02291);
BEGIN
  INSERT INTO TBAIRRO VALUES ( 100, 100, 'RIO BRANCO');
EXCEPTION
   WHEN eFk_erro THEN
     RAISE_APPLICATION_ERROR(-20200, 'Cidade não existe!' );
END;
----



SELECT * FROM TBAIRRO;
SELECT * FROM TCIDADE;


