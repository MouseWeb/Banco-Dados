-- Exibir todas as informações de todos os alunos
SELECT * FROM ALUNO;

-- Exibir somente o título de cada curso da Softblue
SELECT CURSO FROM CURSO;

-- Exibir somente o título e valor de cada curso da Softblue cujo preço seja maior que 200
SELECT CURSO, VALOR FROM CURSO WHERE VALOR > 200;

-- Exibir somente o título e valor de cada curso da Softblue cujo preço seja maior que 200 e menor que 300
SELECT CURSO, VALOR FROM CURSO WHERE VALOR > 200 AND VALOR < 300;

-- Outra solução para o exercício seria esta
SELECT CURSO, VALOR FROM CURSO WHERE VALOR BETWEEN 200 AND 300;

-- Exibir as informações da tabela PEDIDOS para os pedidos realizados entre 15/04/2010 e 18/04/2010
SELECT * FROM PEDIDO WHERE DATAHORA > '2010-04-15' AND DATAHORA < '2010-04-19';

-- Outra solução para o exercício seria esta
SELECT * FROM PEDIDO WHERE DATAHORA BETWEEN '2010-04-15' AND '2010-04-19';

-- Exibir as informações da tabela PEDIDOS para os pedidos realizados na data de 15/04/2010
SELECT * FROM PEDIDO WHERE DATE(DATAHORA) = '2010-04-15';