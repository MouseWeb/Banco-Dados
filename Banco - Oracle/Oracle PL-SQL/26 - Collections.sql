
 -- Record e Collections - Script

DECLARE
--
    TYPE Rec_aluno IS RECORD
    ( cod_aluno NUMBER NOT NULL := 0,
    nome TALUNO.Nome%TYPE,
    cidade TALUNO.Cidade%TYPE );
--
    Registro rec_aluno;
BEGIN
    registro.cod_aluno := 50;
    registro.nome   := 'Marcio Konrath';
    registro.cidade := 'Novo Hamburgo';
    ---
    Dbms_Output.Put_Line('Codigo: '||registro.cod_aluno);
    Dbms_Output.Put_Line(' Nome: '||registro.nome);
    Dbms_Output.Put_Line('Cidade: '||registro.cidade);
---
END;
------

DECLARE
    reg TAluno%ROWTYPE; --Record
    vcep VARCHAR(10) := '98300000';
BEGIN
    SELECT COD_ALUNO, NOME, CIDADE
        INTO Reg.cod_aluno, Reg.nome, Reg.cidade
    FROM TALUNO
        WHERE COD_ALUNO = 1;
        vCep := '93500000';
        reg.cep := vCep;
    Dbms_Output.Put_Line('Codigo: ' ||reg.cod_aluno);
    Dbms_Output.Put_Line('Nome : ' ||reg.nome);
    Dbms_Output.Put_Line('Cidade: ' ||reg.cidade);
    Dbms_Output.Put_Line('Cep : ' ||reg.cep);
END;
--

DECLARE
    TYPE T_ALUNO IS TABLE OF TALUNO.NOME%TYPE
    INDEX BY BINARY_INTEGER; --Matriz
    REGISTRO T_ALUNO; --Record
BEGIN
    REGISTRO(1) := 'MARCIO';
    REGISTRO(2) := 'JOSE';
    REGISTRO(3) := 'PEDRO';
    --
    Dbms_Output.Put_Line('Nome 1: '||registro(1));
    Dbms_Output.Put_Line('Nome 2: '||registro(2));
    Dbms_Output.Put_Line('Nome 3: '||registro(3));
END;
--
SELECT cod_aluno, NOME FROM tALUNO WHERE COD_ALUNO = 1;
--
--
DECLARE
    TYPE nome_type IS TABLE OF taluno.nome%TYPE;
    nome_table nome_type := nome_type(); --Criando Instancia
BEGIN
    nome_table.EXTEND; -- alocando uma nova linha
    nome_table(1) := 'Marcelo';
    nome_table.EXTEND; -- alocando uma nova linha
    nome_table(2) := 'Marcio';
    Dbms_Output.Put_Line('Nome 1: '||nome_table(1));
    Dbms_Output.Put_Line('Nome 2: '||nome_table(2));
END;
--

DECLARE
    TYPE tipo IS TABLE OF VARCHAR2(40) INDEX BY VARCHAR2(2);
    --
    uf_capital tipo;
BEGIN
    uf_capital('RS') := 'PORTO ALEGRE';
    uf_capital('RJ') := 'RIO DE JANEIRO';
    uf_capital('PR') := 'CURITIBA';
    uf_capital('MT') := 'CUIABA';
    dbms_output.put_line(uf_capital('RS'));
    dbms_output.put_line(uf_capital('RJ'));
    dbms_output.put_line(uf_capital('PR'));
    dbms_output.put_line(uf_capital('MT'));
END;
-- VARRAY
DECLARE
    TYPE nome_varray IS VARRAY(5) OF taluno.nome%TYPE;
    nome_vetor nome_varray := nome_varray();
BEGIN
    nome_vetor.EXTEND;
    nome_vetor(1) := 'MasterTraining';
    Dbms_Output.Put_Line(nome_vetor(1));
END;

------------------------------------------------------------------------------------------------

-- Function Pipelined - Scripts

Function CREATE OR REPLACE FUNCTION CONSULTA_PRECO(pCod_Curso NUMBER)
    RETURN NUMBER AS vValor NUMBER; 
    BEGIN SELECT valor INTO vValor FROM TCurso
    WHERE cod_curso = pCod_Curso;
RETURN(vValor); END;

-- Teste | Usando function 
DECLARE 
    vCod NUMBER := &codigo; 
    vValor NUMBER; 
BEGIN 
    vValor := consulta_preco(vCod); 
    Dbms_Output.Put_Line('Preco do curso: '||vValor);
END;

-- Function PIPELINED

--Conectado como System 
GRANT CREATE ANY TYPE TO MARCIO;

--Registro - Array 
DROP TYPE TABLE_REG_ALUNO;

CREATE OR REPLACE TYPE REG_ALUNO AS OBJECT ( CODIGO INTEGER, NOME VARCHAR2(30), CIDADE VARCHAR(30) );

--Matriz 
CREATE OR REPLACE TYPE TABLE_REG_ALUNO AS TABLE OF REG_ALUNO;

-- Array [0][1][2][3][4]

/* Matriz [0][1][2][3][4] 
          [1][1][2][3][4] 
           [2][][][][]    */
           
--Function que retorna registros 
CREATE OR REPLACE FUNCTION GET_ALUNO(pCODIGO NUMBER)
    RETURN TABLE_REG_ALUNO PIPELINED IS outLista REG_ALUNO; 
    CURSOR CSQL IS 
        SELECT ALU.COD_ALUNO, ALU.NOME, ALU.CIDADE 
        FROM TALUNO ALU 
        WHERE ALU.COD_ALUNO = pCODIGO; 
        REG CSQL%ROWTYPE; 
    BEGIN 
        OPEN CSQL; 
        FETCH CSQL INTO REG; 
        outLista := REG_ALUNO(REG.COD_ALUNO, REG.NOME, REG.CIDADE); 
        PIPE ROW(outLista); --Escreve a linha CLOSE CSQL; RETURN; END;

--usando 
SELECT * FROM TABLE(GET_ALUNO(1));

--Usando 
SELECT ALU.*, CON.total FROM TABLE(GET_ALUNO(1)) ALU, TCONTRATO CON WHERE CON.COD_ALUNO = ALU.CODIGO

CREATE OR REPLACE FUNCTION GET_ALUNOS RETURN TABLE_REG_ALUNO PIPELINED IS outLista REG_ALUNO; CURSOR CSQL IS SELECT COD_ALUNO, NOME, CIDADE FROM TALUNO; REG CSQL%ROWTYPE; BEGIN FOR REG IN CSQL LOOP ----------....... outLista := REG_ALUNO(REG.COD_ALUNO,REG.NOME,REG.CIDADE); PIPE ROW(outLista); END LOOP; ------........ RETURN; END;

--Usando 
SELECT * FROM TABLE(GET_ALUNOS);

CREATE OR REPLACE TYPE REG_TOTALALUNO AS OBJECT ( COD_ALUNO INTEGER, NOME VARCHAR2(30), TOTAL NUMERIC(8,2) );

--Matriz 
CREATE OR REPLACE TYPE TABLE_REG_TOTALALUNO AS TABLE OF REG_TOTALALUNO;

--Function que retorna registros 
CREATE OR REPLACE FUNCTION get_totalaluno (
    pcodigo NUMBER
) RETURN table_reg_totalaluno
    PIPELINED
IS

    outlista   reg_totalaluno;
    CURSOR csql IS
    SELECT
        alu.cod_aluno,
        alu.nome,
        SUM(con.total) total
    FROM
        tcontrato   con,
        taluno      alu
    WHERE
        con.cod_aluno = alu.cod_aluno
        AND alu.cod_aluno = pcodigo
    GROUP BY
        alu.cod_aluno,
        alu.nome;

    reg        csql%rowtype;
BEGIN
    OPEN csql;
    FETCH csql INTO reg;
    outlista := reg_totalaluno(reg.cod_aluno, reg.nome, reg.total);
    PIPE ROW ( outlista );
    CLOSE csql;
    return;
END;
SELECT * FROM TABLE(GET_TOTALALUNO(1));

2) Criar uma FUNCTION que retorne Cod_Contrato, Data, NomeAluno, Total ( Usar FOR LOOP )

DROP TYPE TABLE_REG_LISTAALUNO; 

CREATE OR REPLACE TYPE REG_LISTAALUNO AS OBJECT ( DATA DATE, NOME VARCHAR(20), TOTAL NUMERIC(8,2) );

--Matriz 
    CREATE OR REPLACE TYPE TABLE_REG_LISTAALUNO AS TABLE OF REG_LISTAALUNO;

CREATE OR REPLACE FUNCTION get_listaaluno RETURN table_reg_listaaluno
    PIPELINED
IS

    outlista   reg_listaaluno;
    CURSOR csql IS
    SELECT
        trunc(con.data) data,
        alu.nome,
        SUM(con.total) total
    FROM
        taluno      alu,
        tcontrato   con
    WHERE
        con.cod_aluno = alu.cod_aluno
    GROUP BY
        trunc(con.data),
        alu.nome;

    reg        csql%rowtype;
BEGIN FOR reg IN csql LOOP ----------....... outLista := REG_LISTAALUNO(REG.DATA,REG.NOME, REG.TOTAL); PIPE ROW(outLista); END LOOP; ------........ RETURN; END;

SELECT * FROM TABLE(GET_LISTAALUNO);

----------------------------------------------------------------------------------------------------------

 ---------  Bulk Collect -----------------
/* O uso do Bulk Collect é aplicado para a manipulação de grande massa de dados. Com seu uso correto, podemos ter vários tipos de ganhos.

Podemos ter: Aplicações mais rápidas, alocação dos dados na memória, sem a necessidade de refazer a busca no banco. Porem temos um risco também, pois se não aplicarmos corretamente as diretrizes na PGA(Program Global Area), podemos ter problemas na quantidade de dados carregados na memória.

Para estes problemas temos a claúsula LIMIT, que limita os dados que foram para a memória.

Exemplo: */

CREATE TABLE TPRODUTO (
  COD_PRODUTO NUMBER(5),
  DESCRICAO VARCHAR2(40),
  CONSTRAINT PRODUTO_PK PRIMARY KEY (COD_PRODUTO));
Inserindo os dados na tabela:

BEGIN
  INSERT INTO TPRODUTO
  SELECT LEVEL, DBMS_RANDOM.STRING('A', 40) FROM DUAL CONNECT BY LEVEL <= 100;
  COMMIT;
END;
--Vamos agora usar o Bulk Collect com limite de 50 registros. 
--Vamos colocar a cada loop apenas 50 registros na memória.

DECLARE
  CURSOR CUR_PRODUTO IS
  SELECT COD_PRODUTO, DESCRICAO FROM TPRODUTO;
  TYPE TROW_PRODUTO IS TABLE OF CUR_PRODUTO%ROWTYPE INDEX BY PLS_INTEGER;
  ROW_PRODUTO TROW_PRODUTO;
BEGIN
  OPEN CUR_PRODUTO;
  LOOP
    FETCH CUR_PRODUTO BULK COLLECT INTO ROW_PRODUTO LIMIT 50;
    EXIT WHEN ROW_PRODUTO.COUNT = 0;
    FOR I IN 1 .. ROW_PRODUTO.Count LOOP
      DBMS_OUTPUT.PUT_LINE('Código: ' || ROW_PRODUTO(I).COD_PRODUTO || ' Descrição: ' || ROW_PRODUTO(I).DESCRICAO);
    END LOOP;
  END LOOP;
  CLOSE CUR_PRODUTO;
END;
