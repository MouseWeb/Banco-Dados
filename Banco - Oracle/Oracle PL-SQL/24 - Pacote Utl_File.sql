Pacote UTL_FILE
Oracle UTL_FILE

O pacote UTL_FILE é um conjunto de componentes que tem como função permitir o acesso ou geração de arquivos externos ao banco de dados. Um exemplo seria importarmos scripts em SQL ou PL/SQL para o nosso sistema.
O pacote é constituído de 18 componentes, são eles: Exceptions, Functions, Procedures e Types.

Para utilizarmos o pacote, teremos que interromper os serviços do banco de dados e modificar o arquivo initXE.ora (ORACLE 11G Express Edition), onde iremos acrescentar o parâmetro UTL_FILE_DIR, afim de determinar quais os diretórios do sistema está livre para o acesso.

Abra o CMD do windows ou terminar Linux e vamos informar ao banco de dados que podemos gravar e recuperar dados do sistema operacional, através dos seguintes passos:

COMANDOS UTL_FILE

Procedimentos da package UTL_FILE

FOPEN
abre um arquivo para entrada ou saída, criando um arquivo de saída caso o arquivo especificado não exista

IS_OPEN
indica se determinado arquivo está ou não aberto

FCLOSE
fecha um arquivo

FCLOSE_ALL
fecha todos os arquivos abertos

GET_LINE
lê uma linha de um arquivo aberto

PUT
escreve uma linha no arquivo. Não acrescenta automaticamente o caractere de fim de linha

PUT_LINE
escreve uma linha no arquivo, acrescentando automaticamente o caractere de fim de linha
NEW_LINE
inclui o caractere de fim de linha no arquivo, o que irá gerar uma nova linha em branco
FFLUSH
escreve, fisicamente, todas as pendências para um arquivo

Exceções package UTL_FILE

INVALID_PATH
diretório ou nome de arquivo inválido

INVALID_MODE
o parâmetro de modo de abertura é inválido

INVALID_FILEHANDLE
especificador de arquivo inválido

INVALID_OPERATION
o arquivo não pode ser aberto ou a operação é inválida

READ_ERROR
ocorreu um erro do sistema operacional durante a leitura de um arquivo

WRITE_ERROR
ocorreu um erro do sistema operacional durante a gravação de um arquivo

INTERNAL_ERROR
erro não especificado no PL/SQL

NO_DATA_FOUND
nesse caso, é disparada quando o fim do arquivo é encontrado em processamento de leitura seqüencial de um arquivo de texto

Exemplo para geração de arquivo texto:

CREATE OR REPLACE DIRECTORY DIRETORIO AS 'F:\Temp';

DECLARE
 arquivo_saida UTL_File.File_Type;
 Cursor Cur_Linha is
 SELECT COD_ALUNO, NOME, CIDADE FROM TALUNO; 
BEGIN
 arquivo_saida := UTL_File.Fopen('DIRETORIO','Lista.txt','w');
 For Reg_Linha in Cur_linha Loop
 UTL_File.Put_Line(arquivo_saida, Reg_linha.COD_ALUNO||'-'||Reg_linha.NOME);
 UTL_File.Put_Line(arquivo_saida, Reg_linha.COD_ALUNO);
 End Loop;
 UTL_File.Fclose(arquivo_saida);
 Dbms_Output.Put_Line('Arquivo gerado com sucesso.');
EXCEPTION
 WHEN UTL_FILE.INVALID_OPERATION THEN
 Dbms_Output.Put_Line('Operação inválida no arquivo.');
 UTL_File.Fclose(arquivo_saida);
 WHEN UTL_FILE.WRITE_ERROR THEN
 Dbms_Output.Put_Line('Erro de gravação no arquivo.');
 UTL_File.Fclose(arquivo_saida);
 WHEN UTL_FILE.INVALID_PATH THEN
 Dbms_Output.Put_Line('Diretório inválido.');
 UTL_File.Fclose(arquivo_saida);
 WHEN UTL_FILE.INVALID_MODE THEN
 Dbms_Output.Put_Line('Modo de acesso inválido.');
 UTL_File.Fclose(arquivo_saida);
 WHEN Others THEN
 Dbms_Output.Put_Line('Problemas na geração do arquivo.');
 UTL_File.Fclose(arquivo_saida);
END;
Exemplo: Roteiro para leitura de arquivo texto:

DECLARE
 arquivo UTL_File.File_Type;
 Linha Varchar2(100);
BEGIN
 arquivo := UTL_File.Fopen('DIRETORIO','Lista.txt', 'r');
 Loop
 UTL_File.Get_Line(arquivo, Linha);
 Dbms_Output.Put_Line('Registro: '||linha);
 End Loop;
 UTL_File.Fclose(arquivo);
 Dbms_Output.Put_Line('Arquivo processado com sucesso.');
EXCEPTION
 WHEN No_data_found THEN
 UTL_File.Fclose(arquivo);
 WHEN UTL_FILE.INVALID_PATH THEN
 Dbms_Output.Put_Line('Diretório inválido.');
 UTL_File.Fclose(arquivo);
 WHEN Others THEN
 Dbms_Output.Put_Line ('Problemas na leitura do arquivo.');
 UTL_File.Fclose(arquivo);
END;
MAIS EXEMPLOS DE UTL_FILE

Rodar bloco anonimo conectado com seu usuario normal

DECLARE
 VLINHA VARCHAR2(2000) := '';
 VARQUIVO UTL_FILE.FILE_TYPE;
BEGIN
 VARQUIVO := UTL_FILE.FOPEN('DIRETORIO', 'Lista.TXT', 'w');
 FOR x in 1..8 LOOP
 VLINHA := 'LINHA ' || x;
 UTL_FILE.PUT_LINE(VARQUIVO, VLINHA);
 Dbms_Output.Put_Line('Registro: '||Vlinha);
 END LOOP;
 UTL_FILE.FCLOSE(VARQUIVO);
END;
Confira o arquivo na pasta F:\temp