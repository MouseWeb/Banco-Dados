--
CREATE OR REPLACE FUNCTION CONSULTA_PRECO
(pCod_Curso NUMBER) RETURN NUMBER
AS
  vValor NUMBER;
BEGIN
  SELECT valor INTO vValor FROM TCurso
  WHERE cod_curso = pCod_Curso;

  RETURN(vValor);
END;
/
--Teste | Usando function
DECLARE
  vCod NUMBER := &codigo;
  vValor NUMBER;
BEGIN
  vValor := consulta_preco(vCod);
  Dbms_Output.Put_Line('Preco do curso: '||vValor);
END;

-------------------------------------------------------

CREATE OR REPLACE FUNCTION f_existe_aluno
( pcod_aluno IN taluno.cod_aluno%TYPE)
RETURN BOOLEAN 
IS 
  valunos NUMBER(10);
BEGIN
    SELECT cod_aluno
    INTO valunos
    FROM taluno
    WHERE cod_aluno = pcod_aluno;
    RETURN( TRUE );
EXCEPTION
    WHEN others THEN
        RETURN( FALSE );
END;

DECLARE 
    vcodigo INTEGER := 2;
BEGIN
    IF f_existe_aluno(vcodigo) then
        dbms_output.put_line('C�digo encontrado');
    ELSE
        dbms_output.put_line('C�digo n�o encontrado');
    END IF;
END;

-----------------------------------------------

CREATE OR REPLACE PROCEDURE p_cadastra_aluno
(pcod_aluno IN taluno.cod_aluno%TYPE,
 pnome      IN taluno.nome%TYPE,
 pcidade    IN taluno.cidade%TYPE,
 pestado    IN taluno.estado%TYPE)
 IS
BEGIN
    IF (NOT f_existe_aluno(pcod_aluno) ) THEN
        INSERT INTO taluno(cod_aluno, nome, cidade, estado) 
        VALUES (pcod_aluno, pnome, pcidade, pestado);
        dbms_output.put_line('Aluno Cadastrado com sucesso');
    ELSE 
        dbms_output.put_line('C�DIGO J� EXISTE');
    END IF;
END;

BEGIN
    p_cadastra_aluno(seq_aluno.nextval, 'Douglas' ,'Guarulhos' ,'SP' );
END;

-----------------------------------------------

CREATE OR REPLACE FUNCTION f_cadastra_aluno
(pcod_aluno IN taluno.cod_aluno%TYPE,
 pnome      IN taluno.nome%TYPE

-----------------------------------------------

--Conectado como System
GRANT CREATE ANY TYPE TO DOUGLAS;

--Registro - Array
DROP TYPE TABLE_REG_ALUNO;

CREATE OR REPLACE TYPE REG_ALUNO AS OBJECT
( CODIGO INTEGER,
  NOME VARCHAR2(30),
  CIDADE VARCHAR(30)  );


--Matriz
CREATE OR REPLACE TYPE TABLE_REG_ALUNO AS TABLE OF REG_ALUNO;


-- Array
  [0][1][2][3][4]

-- Matriz
   [0][1][2][3][4]
   [1][1][2][3][4]
   [2][][][][]
--Function que retorna registros
CREATE OR REPLACE FUNCTION GET_ALUNO(pCODIGO NUMBER)
RETURN TABLE_REG_ALUNO PIPELINED
IS
 outLista REG_ALUNO;
 CURSOR CSQL IS
   SELECT ALU.COD_ALUNO, ALU.NOME, ALU.CIDADE
   FROM TALUNO ALU
   WHERE ALU.COD_ALUNO = pCODIGO;
 REG CSQL%ROWTYPE;
BEGIN
  OPEN CSQL;
  FETCH CSQL INTO REG;
  outLista := REG_ALUNO(REG.COD_ALUNO, REG.NOME, REG.CIDADE);
  PIPE ROW(outLista); --Escreve a linha
  CLOSE CSQL;
  RETURN;
END;
--usando
SELECT * FROM TABLE(GET_ALUNO(1));


--Usando
SELECT ALU.*, CON.total
FROM TABLE(GET_ALUNO(1)) ALU, TCONTRATO CON
WHERE CON.COD_ALUNO = ALU.CODIGO


CREATE OR REPLACE FUNCTION GET_ALUNOS
RETURN TABLE_REG_ALUNO PIPELINED
IS
 outLista REG_ALUNO;
 CURSOR CSQL IS
   SELECT COD_ALUNO, NOME, CIDADE FROM TALUNO;
 REG CSQL%ROWTYPE;
BEGIN
 FOR REG IN CSQL
 LOOP   ----------.......
   outLista := REG_ALUNO(REG.COD_ALUNO,REG.NOME,REG.CIDADE);
   PIPE ROW(outLista);
 END LOOP; ------........
 RETURN;
END;

--Usando
SELECT * FROM TABLE(GET_ALUNOS);



1) Criar uma FUNCTION que retorne o valor total de contrato
   por aluno (receber como parametro o codigo do aluno)
   Cod_Aluno, NomeAluno, TotalContrato
   (Retorna somente 1 linha)
   usando cursor

   SELECT ALU.COD_ALUNO, ALU.NOME, Sum(CON.TOTAL) TOTAL
   FROM TCONTRATO CON, TALUNO ALU
   WHERE CON.COD_ALUNO = ALU.COD_ALUNO
   AND ALU.COD_ALUNO = pCodigo
   GROUP BY ALU.COD_ALUNO, ALU.NOME;



2) Criar uma FUNCTION que retorne
   NomeAluno, DataContrato,  TotalContrato
   ( Usar FOR LOOP )






CREATE OR REPLACE TYPE REG_TOTALALUNO AS OBJECT
( COD_ALUNO INTEGER,
  NOME VARCHAR2(30),
  TOTAL NUMERIC(8,2)  );

--Matriz
CREATE OR REPLACE TYPE TABLE_REG_TOTALALUNO AS
  TABLE OF REG_TOTALALUNO;

--Function que retorna registros
CREATE OR REPLACE FUNCTION GET_TOTALALUNO(PCODIGO NUMBER)
RETURN TABLE_REG_TOTALALUNO PIPELINED
IS
 outLista REG_TOTALALUNO;
 CURSOR CSQL IS
   SELECT ALU.COD_ALUNO, ALU.NOME, Sum(CON.TOTAL) TOTAL
   FROM TCONTRATO CON, TALUNO ALU
   WHERE CON.COD_ALUNO = ALU.COD_ALUNO AND ALU.COD_ALUNO=PCODIGO
   GROUP BY ALU.COD_ALUNO, ALU.NOME;
 REG CSQL%ROWTYPE;
BEGIN
  OPEN CSQL;
  FETCH CSQL INTO REG;
  outLista:=REG_TOTALALUNO(REG.COD_ALUNO, REG.NOME, REG.TOTAL);
  PIPE ROW(outLista);
  CLOSE CSQL;
  RETURN;
END;

SELECT * FROM TABLE(GET_TOTALALUNO(2));

2) Criar uma FUNCTION que retorne
 Cod_Contrato, Data, NomeAluno, Total
 ( Usar FOR LOOP )

DROP TYPE TABLE_REG_LISTAALUNO;
CREATE OR REPLACE TYPE REG_LISTAALUNO AS OBJECT
( DATA DATE,  NOME VARCHAR(20), TOTAL NUMERIC(8,2) );

--Matriz
CREATE OR REPLACE TYPE TABLE_REG_LISTAALUNO AS
  TABLE OF REG_LISTAALUNO;

CREATE OR REPLACE FUNCTION GET_LISTAALUNO
RETURN TABLE_REG_LISTAALUNO PIPELINED
IS
 outLista REG_LISTAALUNO;
 CURSOR CSQL IS
   SELECT Trunc(CON.DATA) DATA, ALU.NOME, Sum(CON.TOTAL) TOTAL
   FROM TALUNO ALU, TCONTRATO CON
   WHERE CON.COD_ALUNO = ALU.COD_ALUNO
   GROUP BY Trunc(CON.DATA), ALU.NOME;
 REG CSQL%ROWTYPE;
BEGIN
  FOR REG IN CSQL
  LOOP      ----------.......
    outLista := REG_LISTAALUNO(REG.DATA,REG.NOME, REG.TOTAL);
    PIPE ROW(outLista);
  END LOOP; ------........
  RETURN;
END;

SELECT * FROM TABLE(GET_LISTAALUNO);




