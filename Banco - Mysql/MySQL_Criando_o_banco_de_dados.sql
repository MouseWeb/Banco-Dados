-- Programe o código SQL necessário para gerar a estrutura do banco de dados criado
-- no módulo Normalização de Dados (Formas Normais).
-- 
-- Observação: Não é necessário criar o código que popula as tabelas, pois este é o 
-- tema do próximo módulo.

--
-- Cria o banco de dados e acessa o mesmo
--
CREATE DATABASE SOFTBLUE DEFAULT CHARSET=latin1;
USE SOFTBLUE;

--
-- Cria a tabela TIPO
--
CREATE TABLE TIPO (
	CODIGO INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,	-- Código interno (PK)
	TIPO VARCHAR(32) NOT NULL,				-- Descrição
	PRIMARY KEY(CODIGO)					-- Define o campo CODIGO como PK (Primary Key)
);

--
-- Cria a tabela INSTRUTOR
--
CREATE TABLE INSTRUTOR (
	CODIGO INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,	-- Código interno (PK)
	INSTRUTOR VARCHAR(64) NOT NULL,				-- Nome com até 64 caracteres
	TELEFONE VARCHAR(9) NULL,				-- Telefone, podendo ser nulo caso não tenha
	PRIMARY KEY(CODIGO)					-- Define o campo CODIGO como PK (Primary Key)
);

--
-- Cria a tabela CURSO
--
CREATE TABLE CURSO (
	CODIGO INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,	-- Código interno (PK)
	CURSO VARCHAR(64) NOT NULL,				-- Título com até 64 caracteres
	TIPO INTEGER UNSIGNED NOT NULL,				-- Código do tipo de curso (idêntico a PK em CURSO)
	INSTRUTOR INTEGER UNSIGNED NOT NULL,			-- Código do instrutor (idêntico a PK em INSTRUTOR)
	VALOR DOUBLE NOT NULL,					-- Valor do curso
	PRIMARY KEY(CODIGO),					-- Define o campo CODIGO como PK (Primary Key)
	INDEX FK_TIPO(TIPO),					-- Define o campo TIPO como um índice
	INDEX FK_INSTRUTOR(INSTRUTOR),				-- Define o campo INSTRUTOR como um índice
	FOREIGN KEY(TIPO) REFERENCES TIPO(CODIGO),		-- Cria o relacionamento (FK) com a tabela TIPO
	FOREIGN KEY(INSTRUTOR) REFERENCES INSTRUTOR(CODIGO)	-- Cria o relacionamento (FK) com a tabela INSTRUTOR
);								

--
-- Cria a tabela ALUNO
--
CREATE TABLE ALUNO (
	CODIGO INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,	-- Código interno (PK)
	ALUNO VARCHAR(64) NOT NULL,				-- Nome com até 64 caracteres
	ENDERECO VARCHAR(230) NOT NULL,				-- Endereço com até 230 caracteres
	EMAIL VARCHAR(128) NOT NULL,				-- E-mail com até 128 caracteres
	PRIMARY KEY(CODIGO)					-- Define o campo CODIGO como PK (Primary Key)
);

--
-- Cria a tabela PEDIDO
--
CREATE TABLE PEDIDO (
	CODIGO INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,	-- Código interno (PK)
	ALUNO INTEGER UNSIGNED NOT NULL,			-- Código do aluno (idêntico a PK em ALUNO)
	DATAHORA DATETIME NOT NULL,				-- Armazena data e hora em uma única coluna
	PRIMARY KEY(CODIGO),					-- Define o campo CODIGO como PK (Primary Key)
	INDEX FK_ALUNO(ALUNO),					-- Define o campo ALUNO como um índice
	FOREIGN KEY(ALUNO) REFERENCES ALUNO(CODIGO)		-- Cria o relacionamento (FK) com a tabela ALUNO
);

--
-- Cria a tabela PEDIDO_DETALHE
--
CREATE TABLE PEDIDO_DETALHE (
	PEDIDO INTEGER UNSIGNED NOT NULL,			-- Código do pedido (idêntico a PK em PEDIDO)
	CURSO INTEGER UNSIGNED NOT NULL,			-- Código do curso (idêntico a PK em CURSO)
	VALOR DOUBLE NOT NULL,					-- Valor do curso
	INDEX FK_PEDIDO(PEDIDO),				-- Define o campo ALUNO como um índice
	INDEX FK_CURSO(CURSO),					-- Define o campo ALUNO como um índice
	PRIMARY KEY(PEDIDO, CURSO),				-- Define a chave primária composta
	FOREIGN KEY(PEDIDO) REFERENCES PEDIDO(CODIGO),		-- Cria o relacionamento (FK) com a tabela PEDIDO
	FOREIGN KEY(CURSO) REFERENCES CURSO(CODIGO)		-- Cria o relacionamento (FK) com a tabela CURSO
);

