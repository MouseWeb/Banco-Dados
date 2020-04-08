Manipulando XML - Scripts
--XML

SELECT XMLELEMENT("cod_aluno", cod_aluno) AS Aluno
FROM taluno;
SELECT XMLELEMENT("Nome", Nome) || XMLELEMENT("Cidade", cidade)
AS Aluno
FROM taluno;
SELECT XMLELEMENT("DataContrato", TO_CHAR(data, 'MM/DD/YYYY'))||''
AS Data_Contrato
FROM tcontrato;
SELECT XMLELEMENT("Aluno",
XMLELEMENT("cod_aluno", cod_aluno),
XMLELEMENT("nome", nome)) AS aluno
FROM taluno;
-------------------------------
SELECT XMLELEMENT("Aluno",
XMLATTRIBUTES(
cod_aluno AS "cod_aluno",
nome as "nome",
cidade AS "cidade" ) )AS Aluno
FROM taluno;
-------------------------------
SELECT XMLELEMENT("Aluno",
XMLFOREST( cod_aluno AS "codigo",
nome AS "nome",
cidade as "cidade"))AS Aluno
FROM TAluno;
SELECT XMLELEMENT("Aluno",
XMLFOREST(cod_aluno,
nome,
cidade))AS Aluno
FROM taluno
Select * from taluno
SELECT XMLELEMENT("Aluno",
XMLATTRIBUTES(cod_aluno as "cod_aluno"),
XMLFOREST(nome AS "nome", cidade AS "cidade", cep AS "cep") 
)AS aluno
FROM TALUNO
------------------------
SELECT XMLPARSE(CONTENT
'<TAluno><nome>Márcio Konrath</nome></TAluno>'
WELLFORMED
) AS ALUNO
FROM dual;
--Criando arquivo XML a partir de tabela

--Primeiramente temos que configurar o Oracle para aceitar criar arquivos
--Abra o CMD como Administrador set ORACLE_SID=curso
-- SQLPLUS SYS/123 AS SYSDBA

--Fechar o banco de dados SHUTDOWN IMMEDIATE;
--Iniciar o banco de dos sem abrir STARTUP MOUNT;
--Alterar o parâmetro UTL_FILE_DIR: ALTER SYSTEM SET UTL_FILE_DIR = '*' SCOPE = SPFILE;

--Fechar novamente o banco SHUTDOWN IMMEDIATE;
--Abrir o banco STARTUP
--Verificar se o parâmetro foi alterado SHOW PARAMETER UTL_FILE_DIR
--Dar privilegio para qualquer usuário para trabalhar com UTL_FILE GRANT EXECUTE ON UTL_FILE TO PUBLIC;

--Conectar novamente ao usuário no SQL Developer

              ------------ Gerando arquivo xml -------------------
Declare
  p_directory VARCHAR2(100) := 'D:\Temp';
  p_file_name VARCHAR2(50) := 'arquivo.xml';
  v_file UTL_FILE.FILE_TYPE;
  v_amount INTEGER:= 32767;
  v_xml_data XMLType;
  v_xml clob;
  v_char_buffer VARCHAR2(32767);
BEGIN
  -- abre o arquivo para gravar o texto (até v_amount
  -- caracteres por vez)
  v_file:= UTL_FILE.FOPEN(P_DIRECTORY,p_file_name,'w', v_amount);
  -- grava a linha inicial em v_file
  UTL_FILE.PUT_LINE(v_file, '<?xml version="1.0"?>');
  -- recupera os alunos e os armazena em v_xml_data
  SELECT XMLELEMENT(
  "Aluno",
  XMLFOREST(
  cod_aluno AS "codigo",
  nome AS "nome"
  ))AS Aluno
  INTO v_xml_data
  from taluno where cod_aluno = 1; 
 
  -- obtém o valor da string de v_xml_data e o armazena em v_char_buffer
  v_char_buffer:= v_xml_data.GETSTRINGVAL();
  -- copia os caracteres de v_char_buffer no arquivo
  UTL_FILE.PUT(v_file, v_char_buffer);
  -- descarrega os dados restantes no arquivo
  UTL_FILE.FFLUSH(v_file);
  -- fecha o arquivo
  UTL_FILE.FCLOSE(v_file);
end;


           ------------- Lendo arquivo ----------------
DECLARE
  arq_leitura UTL_File.File_Type;
  Linha Varchar2(250);
BEGIN
  arq_leitura := UTL_File.Fopen('D:\Temp\','arquivo.xml', 'r');
  Dbms_Output.Put_Line('Processamento');
  Loop
    UTL_File.Get_Line(arq_leitura, Linha);
    DBMS_OUTPUT.PUT('Linha XML: '||Linha);
    exit;
  End Loop;
  UTL_File.Fclose(arq_leitura);
  Dbms_Output.Put_Line('Arquivo processado com sucesso.');
EXCEPTION
  WHEN No_data_found THEN
    UTL_File.Fclose(arq_leitura);
    Commit;
  WHEN UTL_FILE.INVALID_PATH THEN
    Dbms_Output.Put_Line('Diretório inválido.');
    UTL_File.Fclose(arq_leitura);
  WHEN Others THEN
  Dbms_Output.Put_Line ('Problemas na leitura do arquivo.');
  UTL_File.Fclose(arq_leitura);
END;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Manipulando XML
PL/SQL E XML

A XML (Extensible Markup Language) é uma linguagem de marcação de propósito geral. Ela permite compartilhar dados estruturados na Internet e pode ser usada para codificar 
dados e outros documentos. A XML apresenta as seguintes vantagens: 

? Pode ser lida por seres humanos e computadores e é armazenada como texto puro
? É independente de plataforma
? Suporta Unicode, o que significa que ela pode armazenar informações escritas em muitos idiomas
? Usa um formato autodocumentado que contém a estrutura do documento, nomes de elemento e valores de elemento Por causa dessas vantagens, a XML é muito usada para armazenamento 
e processamento de documentos, sendo aplicada por muitas organizações para o envio de dados entre seus sistemas de computador. Por exemplo, muitos fornecedores permitem que seus 
clientes enviem pedidos de compra como arquivos XML pela Internet.

GERANDO CÓDIGO XML A PARTIR DE DADOS RELACIONAIS

O banco de dados Oracle contém várias funções SQL que podem ser usadas para gerar código XML e, nesta seção, você vai ver como gerar código XML a partir de dados relacionais 
utilizando algumas dessas funções.

XMLELEMENT() A função XMLELEMENT() é usada para gerar elementos XML a partir de dados relacionais. Você fornece um nome para o elemento e a coluna que deseja recuperar para a 
função XMLELEMENT() e ela retorna os elementos como objetos XMLType. XMLType é um tipo interno do banco de dados Oracle utilizado para representar dados XML. Por padrão, 
um objeto XMLType armazena os dados XML como texto em um CLOB (Character Large Object). O exemplo a seguir se conecta no SQL Developer com usuário de desenvolvimento e usa 
objetos XMLType. 

CONNECT store/store_password 

SELECT XMLELEMENT("cod_aluno", cod_aluno)
AS aluno
FROM taluno;
ALUNO
----------------------------
<cod_aluno>1</cod_aluno>
<cod_aluno>2</cod_aluno>
<cod_aluno>3</cod_aluno>
<cod_aluno>4</cod_aluno>
<cod_aluno>5</cod_aluno>
Conforme você pode ver a partir desses resultados, XMLELEMENT ("cod_aluno", cod_aluno) retorna os valores de cod_aluno dentro de uma tag cod_aluno. Você pode usar o
nome de tag que desejar, como mostrado no exemplo a seguir, que utiliza a tag "cod_alu":
SELECT XMLELEMENT("cod_alu", cod_aluno)
AS aluno
FROM TAluno;
ALUNO
--------------------
<cod_alu>1</cod_alu>
<cod_alu>2</cod_alu>
<cod_alu>3</cod_alu>
<cod_alu>4</cod_alu>
<cod_alu>5</cod_alu>
O exemplo a seguir obtém os valores de nome e cidade do aluno n° 2: 

SELECT XMLELEMENT("nome", nome) || XMLELEMENT("cidade", cidade)
AS alunos
FROM taluno
WHERE cod_aluno = 2;
ALUNOS
-----------------------------------------------------
<nome>MARCIO</nome><cidade>NOVO HAMBURGO</cidade>
O exemplo a seguir incorpora duas chamadas de XMLELEMENT() dentro de uma chamada externa de XMLELEMENT(). 
Observe que os elementos cod_aluno e nome retornados estão contidos dentro de um elemento customer externo: 

SELECT XMLELEMENT(
"aluno",
XMLELEMENT("cod_aluno", cod_aluno),
XMLELEMENT("nome", nome)
)
AS alunos FROM TAluno
WHERE cod_aluno IN (1, 2);
ALUNOS
------------------------------
<aluno>
<cod_aluno>1</cod_aluno>
<nome>PEDRO</nome>
</aluno>
<aluno>
<cod_aluno>2</cod_aluno>
<nome>MARCIO</nome>
</aluno >
OBS

Algumas quebras de linhas e espaços foram adicionados no código XML retornado por essa consulta para torná-lo mais fácil de ler. O mesmo foi feito em alguns dos outros 
exemplos deste capítulo. Você pode recuperar dados relacionais normais, assim como código XML, conforme mostrado no exemplo a seguir, que recupera a coluna cod_aluno 
como um resultado relacional normal e as colunas nome e cidade concatenadas como elementos XML:

SELECT cod_aluno, XMLELEMENT("aluno", nome) AS aluno
FROM TAluno;
COD_ALUNO ALUNO
----------- ----------------------------------
1 <aluno>PEDRO</aluno>
2 <aluno>MARCIO</aluno>
XMLFOREST()

Você usa XMLFOREST() para gerar uma “floresta” de elementos XML. XMLFOREST() concatena elementos XML sem que você precise usar o operador de concatenação || com várias chamadas 
de XMLELEMENT(). O exemplo a seguir usa XMLFOREST() para obter cod_aluno, nome e cidade dos alunos n° 1 e 2:

SELECT XMLELEMENT(
"aluno",
XMLFOREST(
cod_aluno AS "cod",
nome AS "nome",
cidade AS "dob"
) )
AS aluno
FROM aluno
WHERE cod_aluno IN (1, 2);
ALUNO
-----------------------------
<aluno>
<id>1</id>
<nome>PEDRO</nome>
<cidade>PORTO ALEGRE</cidade>
</aluno>
<aluno>
<id>2</id>
<nome>MARCIO</nome>
<cidade>NOVO HAMBURGO</cidade>
</aluno>
A consulta a seguir coloca o nome do cliente dentro da tag de elemento aluno usado

XMLATTRIBUTES():

SELECT XMLELEMENT(
"aluno",
XMLATTRIBUTES(nome AS "nome"),
XMLFOREST(cidade AS "cidade", estado as “estado”)
)
AS xml_aluno
FROM TAluno
WHERE cod_aluno IN (1, 2);
XML_ALUNO
-------------------------------
<aluno nome="PEDRO">
<cidade>PORTO ALEGRE</cidade>
<estado>RS</estado>
</aluno>
<aluno nome="MARCIO">
<cidade>NOVO HAMBURGO</cidade>
<estado>02/05/1968</estado>
</aluno>
