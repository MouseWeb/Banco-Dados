
CREATE OR REPLACE PROCEDURE aumenta_precocurso(pCod_Curso NUMBER)
IS
  -- Variaveis
BEGIN
  --Aumenta 50%
  UPDATE TCURSO SET
  VALOR = VALOR * 1.5
  WHERE COD_CURSO = pCod_Curso;
END;

--Teste
SELECT * FROM TCURSO;
EXEC AUMENTA_PRECOCURSO(1); --Executa a procedure

--com bloco anonimo
declare
  vcod INTEGER := &codigo;
begin
  AUMENTA_PRECOCURSO(vcod);
end;


--
CREATE OR REPLACE PROCEDURE Aumenta_Preco
(pCODIGO IN TCURSO.COD_CURSO%TYPE)
IS
BEGIN
  UPDATE TCURSO
  SET    VALOR = VALOR * 1.1
  WHERE  COD_CURSO = pCodigo;
END;

EXEC Aumenta_Preco(1);





CREATE OR REPLACE PROCEDURE Consulta_Aluno
( pCodigo        IN  TALUNO.Cod_Aluno%TYPE,
  pNome          OUT TALUNO.Nome%TYPE,
  pCep           OUT TALUNO.Cep%TYPE,
  pCidade        OUT TALUNO.Cidade%TYPE)
IS
BEGIN
  SELECT nome, Cep, cidade
  INTO   pNome, pCep, pCidade
  FROM   taluno
  WHERE  cod_aluno = pCodigo;
END;


--Teste
DECLARE
  vnome VARCHAR2(30);
  vcidade VARCHAR(30);
  vcep VARCHAR(10);
  vCod INTEGER := &Codigo;
BEGIN
  --executa a procedure
 -- Consulta_aluno(vcod, vnome, vcep, vcidade);

  Consulta_Aluno(pNome => vnome,
                 pCodigo => vcod,
                 pCidade => vcidade,
                 pCep => vcep);

  Dbms_Output.Put_Line(vNome);
  Dbms_Output.Put_Line(vCidade);
  Dbms_Output.Put_Line(vcep);
END;

CREATE OR REPLACE PROCEDURE Consulta_Aluno2
(pRegistro IN OUT TALUNO%ROWTYPE)
IS
  CURSOR CSQL IS
    SELECT * FROM TALUNO WHERE cod_aluno = pRegistro.COD_ALUNO;
BEGIN
  OPEN CSQL;
  FETCH CSQL INTO pRegistro;
  CLOSE CSQL;
END;

--Teste
DECLARE
  vRegistro TALUNO%ROWTYPE;
BEGIN
  vRegistro.COD_ALUNO := &Codigo;
  Consulta_Aluno2(vRegistro);
  Dbms_Output.Put_Line(vRegistro.Nome);
  Dbms_Output.Put_Line(vRegistro.Cidade||' Cep: '||vRegistro.Cep);
END;


--------------------------------------------
CREATE OR REPLACE PROCEDURE formata_numero
(pTelefone IN OUT VARCHAR2)
IS
BEGIN
   pTelefone := SUBSTR(pTelefone, 1, 4)||'-'||
                SUBSTR(pTelefone, 5, 4);
END;

---------------------Teste
DECLARE
  vTelefone VARCHAR2(20);
BEGIN
  vTelefone := '12345678';
  formata_numero(vtelefone);
  Dbms_Output.Put_Line(vTelefone); --1234-5678
END;


--Exercicio
1) Criar uma procedure para cadastrar aluno,
usar SEQUENCE, usar bloco anonimo para executar
e imprimir o valor do codigo criado.

  out   in     in
 (pcod, pnome, pcidade)

 CREATE SEQUENCE seq_aluno START WITH 100;

 SELECT Seq_Aluno.NEXTVAL INTO pCod FROM Dual;


2)Criar uma procedure para excluir registros da tabela de
  contrato (TContrato) passar como parametros de entrada
  o codigo do contrato a ser excluido e receber a quantidade
  de registros excluidos como saida e imprimir esta informaçao.

DELETE FROM TABELA WHERE COD_CONTRATO = pCod; --param tipo in
pQtde := SQL%ROWCOUNT; --parametro do tipo out







CREATE SEQUENCE seq_alu START WITH 999

2)Criar uma procedure para excluir registros da tabela de
contrato (TContrato) passar como parametros de entrada
o codigo do contrato a ser excluido e receber a quantidade
de registros excluidos como saida e imprimir esta informaçao.




--vCod NUMBER;
--Pcod := Seq_Alu.NEXTVAL;

CREATE SEQUENCE seq_alu START WITH 500;
-------------------------------------------------------
CREATE OR REPLACE PROCEDURE cad_aluno
(pcod OUT NUMBER,
 pnome IN VARCHAR,
 pcidade IN VARCHAR)
IS
BEGIN
  SELECT SEQ_ALU.NEXTVAL INTO PCOD FROM DUAL;
  INSERT INTO taluno(cod_Aluno,Nome,Cidade)
  VALUES (pCod,pNome,pCidade);
END;
-----------------------------------------------------
DECLARE
  vcod NUMBER;
  vnome VARCHAR(20)   := '&nome';
  vcidade VARCHAR(20) := '&cidade';
BEGIN
  cad_aluno(vcod,vnome,vcidade);
  Dbms_Output.Put_Line('Aluno cadastrado, Codigo->'||vcod);
END;


2)Criar uma procedure para excluir registros da tabela de
contrato (TContrato) passar como parametros de entrada
o codigo do contrato a ser excluido e receber a quantidade
de registros excluidos como saida e imprimir esta informaçao.




  ex:
  exclui_contrato(cod,mensagem);

  impressao: 0 contrato excluido

  vmsg := SQL%ROWCOUNT ||' contrato excluido';


----
CREATE OR REPLACE PROCEDURE exclui_contrato
  (pCod IN NUMBER, pMsg OUT VARCHAR)
AS
BEGIN
  DELETE FROM TCONTRATO
  WHERE COD_CONTRATO = pCod;
  pMsg := SQL%ROWCOUNT ||' Contrato Excluido ';
END;

----Teste
DECLARE
  vMsg VARCHAR(40);
BEGIN
  Exclui_Contrato(&codigo, vMsg);
  Dbms_Output.Put_Line(vMsg);
END;

