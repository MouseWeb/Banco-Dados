

DECLARE
   --
   TYPE Rec_aluno IS RECORD
   ( cod_aluno NUMBER NOT NULL := 0,
     nome    TALUNO.Nome%TYPE,
     cidade TALUNO.Cidade%TYPE );
   --
   Registro rec_aluno;
BEGIN
   registro.cod_aluno := 50;
   registro.nome      := 'Master';
   registro.cidade    := 'Novo Hamburgo';
   ---
   Dbms_Output.Put_Line('Codigo: '||registro.cod_aluno);
   Dbms_Output.Put_Line('  Nome: '||registro.nome);
   Dbms_Output.Put_Line('Cidade: '||registro.cidade);
   ---
END;



------

DECLARE
  reg TAluno%ROWTYPE;  --Record
  vcep VARCHAR(10) := '98300000';
BEGIN
  SELECT COD_ALUNO, NOME, CIDADE
  INTO Reg.cod_aluno, Reg.nome, Reg.cidade
  FROM TALUNO
  WHERE COD_ALUNO = 1;

  vCep := '93500000';
  reg.cep := vCep;

  Dbms_Output.Put_Line('Codigo: ' ||reg.cod_aluno);
  Dbms_Output.Put_Line('Nome  : ' ||reg.nome);
  Dbms_Output.Put_Line('Cidade: ' ||reg.cidade);
  Dbms_Output.Put_Line('Cep   : ' ||reg.cep);
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
    SELECT cod_aluno, NOME
    FROM tALUNO WHERE COD_ALUNO = 1;

--




--
DECLARE
  TYPE nome_type IS TABLE OF taluno.nome%TYPE;
  nome_table nome_type := nome_type();  --Criando Instancia
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
  TYPE tipo IS TABLE OF VARCHAR2(30) INDEX BY VARCHAR2(2);
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




--  VARRAY
DECLARE
  TYPE nome_varray IS VARRAY(5) OF taluno.nome%TYPE;
  nome_vetor nome_varray := nome_varray();
BEGIN
  nome_vetor.EXTEND;
  nome_vetor(1) := 'Master';
  Dbms_Output.Put_Line(nome_vetor(1));
END;




