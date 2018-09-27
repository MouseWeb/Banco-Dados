-- Crie comandos SQL para inserir os dados apresentados a seguir:
-- 
-- Tabela TIPO:
-- 1, Banco de dados
-- 2, Programação
-- 3, Modelagem de dados
-- 
-- Tabela INSTRUTOR:
-- 1, André Milani, 1111-1111
-- 2, Carlos Tosin, 1212-1212
-- 
-- Tabela CURSO:
-- 1, Java Fundamentos, 2, 2, 270
-- 2, Java Avançado, 2, 2, 330
-- 3, SQL Completo, 1, 1, 170
-- 4, Php Básico, 2, 1, 270
-- 
-- Tabela ALUNO:
-- 1, José, Rua XV de Novembro 72, jose@softblue.com.br
-- 2, Wagner, Av. Paulista, wagner@softblue.com.br
-- 3, Emílio, Rua Lajes 103, ap: 701, emilio@softblue.com.br
-- 4, Cris, Rua Tauney 22, cris@softblue.com.br
-- 5, Regina, Rua Salles 305, regina@softblue.com.br
-- 6, Fernando, Av. Central 30, fernando@softblue.com.br
-- 
-- Tabela PEDIDO:
-- 1, 2, 15/04/2010, 11:23:32
-- 2, 2, 15/04/2010, 14:36:21
-- 3, 3, 16/04/2010, 11:17:45
-- 4, 4, 17/04/2010, 14:27:22
-- 5, 5, 18/04/2010, 11:18:19
-- 6, 6, 19/04/2010, 13:47:35
-- 7, 6, 20/04/2010, 18:13:44
-- 
-- Tabela PEDIDO_DETALHE:
-- 1, 1, 270
-- 1, 2, 330
-- 2, 1, 270
-- 2, 2, 330
-- 2, 3, 170
-- 3, 4, 270
-- 4, 2, 330
-- 4, 4, 270
-- 5, 3, 170
-- 6, 3, 170
-- 7, 4, 270

-- SOLUÇÃO
-- ================================================================================
--
-- Observe que para todas as tabelas, com exceção de ALUNO, 
-- será apresentado as duas formas de incluir os dados.
-- A primeira informando os campos e a ordem em que seriam informados, 
-- e a segunda assumindo que todos os campos da tabela seriam informados.
--

--
-- Tabela TIPO:
--
INSERT INTO TIPO (CODIGO, TIPO) VALUES (1, 'Banco de dados');
INSERT INTO TIPO VALUES (2, 'Programação');
INSERT INTO TIPO VALUES (3, 'Modelagem de dados');

--
-- Tabela INSTRUTOR:
--
INSERT INTO INSTRUTOR (CODIGO, INSTRUTOR, TELEFONE) VALUES (1, 'André Milani', '1111-1111');
INSERT INTO INSTRUTOR VALUES (2, 'Carlos Tosin', '1212-1212');

--
-- Tabela CURSO:
--
INSERT INTO CURSO (CODIGO, CURSO, TIPO, INSTRUTOR, VALOR) VALUES (1, 'Java Fundamentos', 2, 2, 270);
INSERT INTO CURSO VALUES (2, 'Java Avançado', 2, 2, 330);
INSERT INTO CURSO VALUES (3, 'SQL Completo', 1, 1, 170);
INSERT INTO CURSO VALUES (4, 'Php Básico', 2, 1, 270);

--
-- Tabela ALUNO:
--
INSERT INTO ALUNO (CODIGO, ALUNO, ENDERECO, EMAIL) VALUES (1, 'José', 'Rua XV de Novembro 72', 'jose@softblue.com.br');
INSERT INTO ALUNO (CODIGO, ALUNO, ENDERECO, EMAIL) VALUES (2, 'Wagner', 'Av. Paulista', 'wagner@softblue.com.br');
INSERT INTO ALUNO (CODIGO, ALUNO, ENDERECO, EMAIL) VALUES (3, 'Emílio', 'Rua Lajes 103, ap: 701', 'emilio@softblue.com.br');
INSERT INTO ALUNO (CODIGO, ALUNO, ENDERECO, EMAIL) VALUES (4, 'Cris', 'Rua Tauney 22', 'cris@softblue.com.br');
INSERT INTO ALUNO (CODIGO, ALUNO, ENDERECO, EMAIL) VALUES (5, 'Regina', 'Rua Salles 305', 'regina@softblue.com.br');
INSERT INTO ALUNO (CODIGO, ALUNO, ENDERECO, EMAIL) VALUES (6, 'Fernando', 'Av. Central 30', 'fernando@softblue.com.br');

--
-- Tabela PEDIDO:
--
INSERT INTO PEDIDO (CODIGO, ALUNO, DATAHORA) VALUES (1, 2, '2010-04-15 11:23:32');
INSERT INTO PEDIDO VALUES (2, 2, '2010-04-15 14:36:21');
INSERT INTO PEDIDO VALUES (3, 3, '2010-04-16 11:17:45');
INSERT INTO PEDIDO VALUES (4, 4, '2010-04-17 14:27:22');
INSERT INTO PEDIDO VALUES (5, 5, '2010-04-18 11:18:19');
INSERT INTO PEDIDO VALUES (6, 6, '2010-04-19 13:47:35');
INSERT INTO PEDIDO VALUES (7, 6, '2010-04-20 18:13:44');

--
-- Tabela PEDIDO_DETALHE:
--
INSERT INTO PEDIDO_DETALHE (PEDIDO, CURSO, VALOR) VALUES (1, 1, 270);
INSERT INTO PEDIDO_DETALHE VALUES (1, 2, 330);
INSERT INTO PEDIDO_DETALHE VALUES (2, 1, 270);
INSERT INTO PEDIDO_DETALHE VALUES (2, 2, 330);
INSERT INTO PEDIDO_DETALHE VALUES (2, 3, 170);
INSERT INTO PEDIDO_DETALHE VALUES (3, 4, 270);
INSERT INTO PEDIDO_DETALHE VALUES (4, 2, 330);
INSERT INTO PEDIDO_DETALHE VALUES (4, 4, 270);
INSERT INTO PEDIDO_DETALHE VALUES (5, 3, 170);
INSERT INTO PEDIDO_DETALHE VALUES (6, 3, 170);
INSERT INTO PEDIDO_DETALHE VALUES (7, 4, 270);