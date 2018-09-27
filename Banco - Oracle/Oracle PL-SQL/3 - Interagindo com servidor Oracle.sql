
DECLARE
  vValor NUMBER(8, 2);
  vNome  VARCHAR2(30);
BEGIN
  SELECT valor, nome
  INTO   vValor, vNome
  FROM   tcurso
  WHERE  cod_curso = &cod_Curso;

  Dbms_Output.Put_Line('Valor: '|| To_Char(vValor,'fm9999.99'));

  Dbms_Output.Put_Line('Curso: '|| InitCap(vNome));
END;

SELECT * FROM TCurso;




DECLARE
   vDt_compra  tcontrato.Data%TYPE;
   vDt_curso   tcontrato.Data%TYPE;
BEGIN
   SELECT data, data + 10
   INTO   vDt_compra, vDt_curso
   FROM   tcontrato
   WHERE  cod_contrato = &Contrato;
   Dbms_Output.Put_Line('Data Compra: '||vDt_compra);
   Dbms_Output.Put_Line('Data Curso: '||vDt_curso);
END;

SELECT * FROM TCONTRATO;



SELECT Max(COD_CONTRATO) FROM TCONTRATO;
CREATE SEQUENCE SEQ_CONTRATO1 START WITH 11;
--
DECLARE
  vCod tcontrato.cod_contrato%TYPE;
BEGIN
  SELECT SEQ_CONTRATO1.NEXTVAL
  INTO   vCod FROM   Dual;

  INSERT INTO TContrato(COD_CONTRATO, DATA,
                        COD_ALUNO, DESCONTO)
  VALUES(vCod, SYSDATE, 2, NULL);

  Dbms_Output.Put_Line('Criado Contrato: '||vCod);
END;



--Pegar o valor atual
SELECT Seq_Contrato1.CURRVAL FROM Dual;

SELECT * FROM TCONTRATO;


-----Update
DECLARE
  vValor TCurso.Valor%TYPE := &Valor;
BEGIN
  UPDATE tcurso SET
  Valor = Valor + vValor
  WHERE  carga_horaria >= 25;
END;
--
SELECT * FROM tcurso;

-----Delete
DECLARE
  vContrato TContrato.COD_CONTRATO%TYPE := &contrato;
BEGIN
  DELETE FROM TContrato
  WHERE  Cod_Contrato = vContrato;
END;

SELECT * FROM tcontrato;


-- Erro No_Data_Found
-- Select Into que nao encontra registros
DECLARE
   vdt_compra    tcontrato.data%TYPE;
   vTotal       tcontrato.total%TYPE;
   vDt_atual    DATE := SYSDATE;
BEGIN
   SELECT data, total
   INTO   vdt_compra, vTotal
   FROM   tcontrato WHERE  Data = vDt_atual;	--
   Dbms_Output.Put_Line('Resultado Select');
END;







DECLARE
   vContrato   NUMBER := &cod_contrato;
   vtexto VARCHAR2(50);
BEGIN
  UPDATE TContrato SET
  desconto = desconto + 2
  WHERE Cod_Contrato = VContrato;

  vtexto := SQL%ROWCOUNT;
  --Retorna qtde de registros afetados
  --pelo comando sql

  Dbms_Output.Put_Line(vtexto|| ' linhas atualizadas.');
END;

--

--- Exercicios   --- Pagina 95



1)
DECLARE
   vCod NUMBER;
BEGIN
   SELECT max(cod_depto) INTO vCod
   FROM   tdepartamento;
   Dbms_Output.Put_Line(vCod);
END;

2)
DECLARE
   vCod NUMBER;
BEGIN
   SELECT max(cod_depto) INTO vCod
   FROM   tdepartamento;
   vCod := vCod + 10;
   INSERT INTO tdepartamento  (cod_depto, nome, loca)
   VALUES (vCod, '&nome', NULL);
   Dbms_Output.Put_Line(vCod);
END;


3)
DECLARE
  vNome TDEPARTAMENTO.NOME%TYPE;
  vLocal TDEPARTAMENTO.LOCAL%TYPE;
BEGIN
  UPDATE TDEPARTAMENTO SET
  NOME = '&NOME'   ,
  LOCAL = '&LOCAL'
  WHERE COD_DEPTO = &cod_depto;
  --
  --SELECT NOME,LOCAL INTO vNome, vLocal
  --FROM TDEPARTAMENTO
  --WHERE COD_DEPTO = &cod_depto;
  --
  Dbms_Output.Put_Line('Departamento: '||vNome);
  Dbms_Output.Put_Line('Local: '||vLocal);
END;

4)
DECLARE
  vQtde VARCHAR(10);
BEGIN
  DELETE FROM TDEPARTAMENTO
  WHERE COD_DEPTO = &cod_depto;
  vQtde := SQL%ROWCOUNT;
  Dbms_Output.Put_Line('Registros deletados: '|| vQtde);
END;





