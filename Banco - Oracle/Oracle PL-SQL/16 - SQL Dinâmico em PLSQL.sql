CREATE TABLE GRANDES_CONTRATOS
( COD INTEGER,
  DATA DATE,
  TOTAL NUMERIC(12,2)
);
--
CREATE OR REPLACE PROCEDURE insere_grandes_contratos
(pTotal IN tcontrato.total%TYPE)
IS
BEGIN
  EXECUTE IMMEDIATE ' INSERT INTO grandes_contratos    ' ||
                    ' SELECT cod_contrato, data, total ' ||
                    ' FROM tcontrato                   ' ||
                    ' WHERE total >  :1   '
                    USING pTotal;
 COMMIT;
END;
--
EXEC insere_grandes_contratos(1000);
SELECT * FROM GRANDES_CONTRATOS;


SELECT * FROM grandes_contratos;
DELETE FROM grandes_contratos;




CREATE TABLE grandes_contratos
  AS SELECT cod_contrato, data, total
  FROM tcontrato


CREATE OR REPLACE PROCEDURE consulta_generica
(pColunas   IN VARCHAR2,
 pTabelas   IN VARCHAR2,
 pCondicoes IN VARCHAR2     )
IS
  TYPE refCursor IS REF CURSOR;
  cCursor1       refCursor;
  vRetorno VARCHAR2(4000);
  vRet VARCHAR2(4000);
BEGIN
  OPEN cCursor1 FOR ' SELECT '||pColunas||
                    ' FROM '||pTabelas||
                    ' WHERE '||pCondicoes;
  LOOP
    FETCH cCursor1 INTO vRetorno, vret;
    EXIT WHEN cCursor1%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(vRetorno||' - '||vret);
  END LOOP;
  CLOSE cCursor1;
END;
--
EXEC Consulta_Generica ('NOME,CIDADE','TALUNO','1=1');

