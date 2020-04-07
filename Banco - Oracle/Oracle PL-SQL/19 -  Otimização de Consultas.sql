

/*Otimização de Consulta
AJUSTE DE SQL

Uma das principais vantagens da linguagem SQL é que você não precisa dizer ao banco de dados exatamente como ele deve obter os dados solicitados. 
Basta executar uma consulta especificando as informações desejadas e o software de banco de dados descobre a melhor maneira de obtê-las. Às vezes, 
você pode melhorar o desempenho de suas instruções SQL “ajustando-as”. Nas seções a seguir, você verá dicas de ajuste que podem fazer suas consultas 
executarem mais rapidamente e técnicas de ajuste mais avançadas.

USE UMA CLÁUSULA WHERE PARA FILTRAR LINHAS

Muitos iniciantes recuperam todas as linhas de uma tabela quando só querem uma delas (ou algumas poucas). Isso é muito desperdício. Uma estratégia melhor 
é adicionar uma cláusula WHERE em uma consulta. Desse modo, você restringe as linhas recuperadas apenas àquelas realmente necessárias.

Por exemplo, digamos que você queira os detalhes dos clientes nº 1 e 2. A consulta a seguir recupera todas as linhas da tabela customers no esquema store (desperdício):

RUIM (recupera todas as linhas da tabela customers)*/


SELECT * FROM TALUNO;
  

-- A próxima consulta adiciona uma cláusula WHERE ao exemplo anterior para obter apenas os

-- alunos nº 1 e 2:

-- BOM (usa uma cláusula WHERE para limitar as linhas recuperadas)

SELECT *
FROM TALUNO
WHERE COD_ALUNO IN (1, 2);
 
/*USE JOINS DE TABELA EM VEZ DE VÁRIAS CONSULTAS

Se você precisa de informações de várias tabelas relacionadas, deve usar condições de join, em vez
de várias consultas. No exemplo inadequado a seguir, são usadas duas consultas para obter o nome
e o tipo do produto nº 1 (usar duas consultas é desperdício). A primeira consulta obtém os valores
de coluna nome e cod_aluno da tabela products para o produto nº 1. A segunda consulta
utiliza esse valor de cod_aluno para obter a coluna name da tabela TALUNO.*/

-- RUIM (duas consultas separadas, quando uma seria suficiente)

SELECT nome, cod_aluno
FROM taluno
WHERE cod_aluno = 1;
 
/*Em vez de usar duas consultas, você deve escrever uma única consulta que utilize um join
entre as tabelas products e product_types. A consulta correta a seguir mostra isso:*/

-- BOM (uma única consulta com um join)

SELECT CON.DATA, ALU.NOME, TOTAL
FROM TCONTRATO CON, TALUNO ALU
WHERE CON.COD_ALUNO = ALU.COD_ALUNO
AND CON.COD_CONTRATO = 1;
 
/*Essa consulta resulta na recuperação do mesmo nome e tipo de produto do primeiro exemplo,
mas os resultados são obtidos com uma única consulta. Uma só consulta geralmente é mais
eficiente do que duas.

Você deve escolher a ordem de junção em sua consulta de modo a juntar menos linhas nas
tabelas posteriormente. 

USE REFERÊNCIAS DE COLUNA TOTALMENTE QUALIFICADAS AO FAZER JOINS

Sempre inclua apelidos de tabela em suas consultas e utilize o apelido de cada coluna (isso é conhecido
como “qualificar totalmente” suas referências de coluna). Desse modo, o banco de dados
não precisará procurar nas tabelas cada coluna utilizada em sua consulta.*/

-- RUIM (as colunas TOTAL não esta totalmente qualificada)

SELECT CON.DATA, ALU.NOME
FROM TCONTRATO CON, TALUNO ALU
WHERE CON.COD_ALUNO = ALU.COD_ALUNO
AND CON.COD_CONTRATO = 1;
 

/*USE EXPRESSÕES CASE EM VEZ DE VÁRIAS CONSULTAS

Use expressões CASE, em vez de várias consultas, quando precisar efetuar muitos cálculos nas
mesmas linhas em uma tabela. O exemplo inadequado a seguir usa várias consultas para contar o
número de produtos dentro de diversos intervalos de preço:*/

-- RUIM (três consultas separadas, quando uma única instrução CASE funcionaria)

SELECT COUNT(*) FROM TCURSO WHERE VALOR < 800;
 

SELECT COUNT(*) FROM TCURSO WHERE VALOR BETWEEN 1000 AND 1500;
  

SELECT COUNT(*)
FROM TCURSO
WHERE VALOR > 1200;


-- Em vez de usar três consultas, você deve escrever uma única que utilize expressões CASE. Isso está mostrado no exemplo correto a seguir:
-- BOM (uma única consulta com uma expressão CASE)

SELECT
COUNT(CASE WHEN VALOR < 800 THEN 1 ELSE null END) baixo,
COUNT(CASE WHEN VALOR BETWEEN 800 AND 1200 THEN 1 ELSE null END) medio,
COUNT(CASE WHEN VALOR > 1500 THEN 1 ELSE null END) alto
FROM TCURSO;
  
/* ADICIONE ÍNDICES NAS TABELAS

Ao procurar um tópico específico em um livro, você pode percorrer o livro inteiro ou utilizar o
índice para encontrar o local. Conceitualmente, um índice de uma tabela de banco de dados é
semelhante ao índice de um livro, exceto que os índices de banco de dados são usados para encontrar
linhas específicas em uma tabela. O inconveniente dos índices é que, quando uma linha é
adicionada na tabela, é necessário tempo adicional para atualizar o índice da nova linha.
Geralmente, você deve criar um índice em uma coluna quando está recuperando um pequeno
número de linhas de uma tabela que contenha muitas linhas. Uma boa regra geral é:
Crie um índice quando uma consulta recuperar <= 10% do total de linhas de uma tabela.
Isso significa que a coluna do índice deve conter uma ampla variedade de valores. Uma boa
candidata à indexação seria uma coluna contendo um valor exclusivo para cada linha (por exemplo,
um número de CPF). Uma candidata ruim para indexação seria uma coluna que contivesse
somente uma pequena variedade de valores (por exemplo, N, S, E, O ou 1, 2, 3, 4, 5, 6). Um banco
de dados Oracle cria um índice automaticamente para a chave primária de uma tabela e para as
colunas incluídas em uma restrição única.
Além disso, se o seu banco de dados é acessado por muitas consultas hierárquicas (isto é,
uma consulta contendo uma cláusula CONNECT BY), você deve adicionar índices nas colunas referenciadas
nas cláusulas START WITH e CONNECT BY
Por fim, para uma coluna que contenha uma pequena variedade de valores e seja usada
freqüentemente na cláusula WHERE de consultas, você deve considerar a adição de um índice de
bitmap nessa coluna. Os índices de bitmap são normalmente usados em ambientes de data warehouse,
que são bancos de dados contendo volumes de dados muito grandes. Os dados de um
data warehouse normalmente são lidos por muitas consultas, mas não são modificados por muitas
transações concorrentes.
Normalmente, o administrador do banco de dados é responsável pela criação de índices.
Entretanto, como desenvolvedor de aplicativos, você poderá fornecer informações para ele sobre
quais colunas são boas candidatas à indexação, pois talvez saiba mais sobre o aplicativo do que o
DBA.

USE WHERE EM VEZ DE HAVING

A cláusula WHERE é usada para filtrar linhas; a cláusula HAVING, para filtrar grupos de linhas. Como
a cláusula HAVING filtra grupos de linhas depois que elas foram agrupadas (o que leva algum tempo
para ser feito), quando possível, você deve primeiro filtrar as linhas usando uma cláusula WHERE.
Desse modo, você evita o tempo gasto para agrupar as linhas filtradas.

? Utiliza a cláusula GROUP BY para agrupar as linhas em blocos

? Utiliza a cláusula HAVING para filtrar os resultados retornados em funções de grupo*/

-- RUIM (usa HAVING em vez de WHERE)

SELECT COD_ALUNO, AVG(TOTAL)
FROM TCONTRATO
GROUP BY COD_ALUNO
HAVING COD_ALUNO IN (1, 2);
 

-- A consulta correta a seguir reescreve o exemplo anterior usando WHERE, em vez de HAVING,para primeiro filtrar as linhas naquelas cujo valor de cod_aluno é 1 ou 2:
-- BOM (usa WHERE em vez de HAVING)

SELECT COD_ALUNO, AVG(TOTAL)
FROM TCONTRATO
WHERE COD_ALUNO IN (1, 2)
GROUP BY COD_ALUNO;
 

/*USE UNION ALL EM VEZ DE UNION

Você usa UNION ALL para obter todas as linhas recuperadas por duas consultas, incluindo as linhas
duplicadas; UNION é usado para obter todas as linhas não duplicadas recuperadas pelas consultas.
Como UNION remove as linhas duplicadas (o que leva algum tempo para ser feito), quando possível,
você deve usar UNION ALL.

A consulta inadequada a seguir usa UNION (ruim, porque UNION ALL funcionaria) para obter
as linhas das tabelas products e more_products. Observe que todas as linhas não duplicadas de
products e more_products são recuperadas:*/

-- RUIM (usa UNION em vez de UNION ALL)

SELECT COD_ALUNO, NOME, CIDADE
FROM TALUNO
 
WHERE ESTADO = 'RS'
UNION
SELECT COD_ALUNO, NOME, CIDADE
FROM COD_ALUNO = 1;

-- A consulta correta a seguir reescreve o exemplo anterior para usar UNION ALL. Observe que todas as linhas de products e more_products são recuperadas, incluindo as duplicadas:
-- BOM (usa UNION ALL em vez de UNION)

SELECT COD_ALUNO, NOME, CIDADE
FROM TALUNO
 
WHERE ESTADO = 'RS'
UNION ALL
SELECT COD_ALUNO, NOME, CIDADE
FROM COD_ALUNO = 1;
USE EXISTS EM VEZ DE IN

/*Você usa IN para verificar se um valor está contido em uma lista. EXISTS é usado para verificar
a existência de linhas retornadas por uma subconsulta. EXISTS é diferente de IN: EXISTS apenas
verifica a existência de linhas, enquanto IN verifica os valores reais. Normalmente, EXISTS oferece
melhor desempenho do que IN com subconsultas. Portanto, quando possível, use EXISTS em vez de IN.
Consulte a seção intitulada “Usando EXISTS e NOT EXISTS em uma subconsulta correlacionada”,
(um ponto importante a lembrar é que as subconsultas correlacionadas podem
trabalhar com valores nulos).
A consulta inadequada a seguir usa IN (ruim, porque EXISTS funcionaria) para recuperar os
produtos que foram comprados:*/

-- RUIM (usa IN em vez de EXISTS)

SELECT COD_CURSO, NOME
FROM TCURSO
WHERE COD_CURSO IN
(SELECT COD_CURSO
FROM TITEM);
 
-- BOM (usa EXISTS em vez de IN)

SELECT COD_CURSO, NOME
FROM TCURSO cur
WHERE EXISTS
(SELECT 1
FROM TITEM ite
WHERE ite.COD_CURSO = cur.COD_CURSO);
USE EXISTS EM VEZ DE DISTINCT;

/*Você pode suprimir a exibição de linhas duplicadas usando DISTINCT. EXISTS é usado para verificar
a existência de linhas retornadas por uma subconsulta. Quando possível, use EXISTS em vez de
DISTINCT, pois DISTINCT classifica as linhas recuperadas antes de suprimir as linhas duplicadas.
A consulta inadequada a seguir usa DISTINCT (ruim, porque EXISTS funcionaria) para recuperar
os produtos que foram comprados:*/

-- RUIM (usa DISTINCT quando EXISTS funcionaria)

SELECT DISTINCT ITE.COD_CURSO, CUR.NOME

FROM TCURSO cur, TITEM ite

WHERE ITE.COD_CURSO = CUR.COD_CURSO;

 

A consulta correta a seguir reescreve o exemplo anterior usando EXISTS em vez de DISTINCT:

 

-- BOM (usa EXISTS em vez de DISTINCT)

SELECT product_id, name
FROM products outer
WHERE EXISTS
(SELECT 1
FROM purchases inner
WHERE inner.product_id = outer.product_id);
 

 

USE GROUPING SETS EM VEZ DE CUBE

Normalmente, a cláusula GROUPING SETS oferece melhor desempenho do que CUBE. Portanto,

quando possível, você deve usar GROUPING SETS em vez de CUBE. Isso foi abordado detalhadamente

na seção intitulada “Usando a cláusula GROUPING SETS”.

 

USE VARIÁVEIS DE BIND

O software de banco de dados Oracle coloca as instruções SQL em cache; uma instrução SQL colocada

no cache é reutilizada se uma instrução idêntica é enviada para o banco de dados. Quando

uma instrução SQL é reutilizada, o tempo de execução é reduzido. Entretanto, a instrução SQL

deve ser absolutamente idêntica para ser reutilizada. Isso significa que:

? Todos os caracteres na instrução SQL devem ser iguais

? Todas as letras na instrução SQL devem ter a mesma caixa

? Todos os espaços na instrução SQL devem ser iguais

Se você precisa fornecer valores de coluna diferentes em uma instrução, pode usar variáveis

de bind em vez de valores de coluna literais. Exemplos que esclarecem essas idéias são mostrados

a seguir.

 

Instruções SQL não idênticas

Nesta seção, você verá algumas instruções SQL não idênticas. As consultas não idênticas a seguir

recuperam os produtos nº 1 e 2:

SELECT * FROM products WHERE product_id = 1;

SELECT * FROM products WHERE product_id = 2;

Essas consultas não são idênticas, pois o valor 1 é usado na primeira instrução, mas o valor 2

é usado na segunda. As consultas não idênticas têm espaços em posições diferentes:

SELECT * FROM products WHERE product_id = 1;

SELECT * FROM products WHERE product_id = 1;

As consultas não idênticas a seguir usam uma caixa diferente para alguns dos caracteres:

select * from products where product_id = 1;

SELECT * FROM products WHERE product_id = 1;

Agora que você já viu algumas instruções não idênticas, vejamos instruções SQL idênticas

que utilizam variáveis de bind.

 

Instruções SQL idênticas que usam variáveis de bind

Você pode garantir que uma instrução seja idêntica utilizando variáveis de bind para representar

valores de coluna. Uma variável de bind é criada com o comando VARIABLE do SQL*Plus. Por

exemplo, o comando a seguir cria uma variável chamada v_product_id de tipo NUMBER:

VARIABLE v_product_id NUMBER

 

COMPARANDO O CUSTO DA EXECUÇÃO DE CONSULTAS

O software de banco de dados Oracle usa um subsistema conhecido como otimizador para gerar

o caminho mais eficiente para acessar os dados armazenados nas tabelas. O caminho gerado pelo

otimizador é conhecido como plano de execução. O Oracle Database 10g e as versões superiores

reúnem estatísticas sobre os dados de suas tabelas e índices automaticamente, para gerar o melhor

plano de execução (isso é conhecido como otimização baseada em custo).

A comparação dos planos de execução gerados pelo otimizador permite a você julgar o custo

relativo de uma instrução SQL em relação à outra. É possível usar os resultados para aprimorar

suas instruções SQL. Nesta seção, você vai aprender a ver e interpretar dois exemplos de planos de

execução.


 

Examinando planos de execução

O otimizador gera um plano de execução para uma instrução SQL. Você pode examinar o plano de

execução usando o comando EXPLAIN PLAN do SQL*Plus. O comando EXPLAIN PLAN preenche

uma tabela chamada plan_table com o plano de execução da instrução SQL (plan_table é freqüentemente

referida como “tabela de plano”). Você pode então examinar esse plano de execução

consultando a tabela de plano. A primeira coisa que você deve fazer é verificar se a tabela de plano

já existe no banco de dados.

 

Gerando um plano de execução

Uma vez que você tenha uma tabela de plano, pode usar o comando EXPLAIN PLAN para gerar um

plano de execução para uma instrução SQL. A sintaxe do comando EXPLAIN PLAN é:

EXPLAIN PLAN SET STATEMENT_ID = id_instrução FOR instrução_sql;

onde

? id_instrução é o nome que você deseja dar ao plano de execução. Pode ser qualquer

texto alfanumérico.

? instrução_sql é a instrução SQL para a qual você deseja gerar um plano de execução.

O exemplo a seguir gera o plano de execução para uma consulta que recupera todas as linhas

da tabela customers (observe que o valor de id_instrução é configurado como 'CUSTOMERS'):

EXPLAIN PLAN SET STATEMENT_ID = 'CUSTOMERS' FOR

SELECT customer_id, first_name, last_name FROM customers;

Explained

Depois que o comando terminar, você pode examinar o plano de execução armazenado na

tabela de plano. Você vai aprender a fazer isso a seguir.

NOTA

A consulta na instrução EXPLAIN PLAN não retorna linhas da tabela customers. A instrução

EXPLAIN PLAN simplesmente gera o plano de execução que seria usado se a consulta fosse

executada.

Consultando a tabela de plano

Para consultar a tabela de plano, fornecemos um script SQL*Plus chamado explain_plan.sql no

diretório SQL. O script solicita o valor de statement_id (id_instrução) e depois exibe o plano de

execução para essa instrução.

O script explain_plan.sql contém as seguintes instruções:

-- Exibe o plano de execução da statement_id especificada

UNDEFINE v_statement_id;
SELECT
id ||
DECODE(id, 0, '', LPAD(' ', 2*(level – 1))) || ' ' ||
operation || ' ' ||
options || ' ' ||
object_name || ' ' ||
object_type || ' ' ||
DECODE(cost, NULL, '', 'Cost = ' || position)
AS execution_plan
FROM plan_table
CONNECT BY PRIOR id = parent_id
AND statement_id = '&&v_statement_id'
START WITH id = 0
AND statement_id = '&v_statement_id';
 

Um plano de execução é organizado em uma hierarquia de operações de banco de dados

semelhante a uma árvore; os detalhes dessas operações são armazenados na tabela de plano. A

operação com o valor de id igual a 0 é a raiz da hierarquia e todas as outras operações do plano

procedem dessa raiz. A consulta do script recupera os detalhes das operações, começando com a

operação raiz e, então, percorre a árvore a partir da raiz.

O exemplo a seguir mostra como executar o script explain_plan.sql para recuperar o plano

'CUSTOMERS' criado anteriormente:

SQL> @ c:\sql_book\sql\explain_plan.sql

Enter value for v_statement_id: CUSTOMERS

old 12: statement_id = '&&v_statement_id'

new 12: statement_id = 'CUSTOMERS'

old 14: statement_id = '&v_statement_id'

new 14: statement_id = 'CUSTOMERS'

EXECUTION_PLAN

----------------------------------------------

0 SELECT STATEMENT Cost = 3

1 TABLE ACCESS FULL CUSTOMERS TABLE Cost = 1

As operações mostradas na coluna EXECUTION_PLAN são executadas na seguinte ordem:

? A operação recuada mais à direita é executada primeiro, seguida de todas as operações

pai que estão acima dela.

? Para operações com o mesmo recuo, a operação mais acima é executada primeiro, seguida

de todas as operações pai que estão acima dela.

Cada operação envia seus resultados de volta no encadeamento até sua operação pai imediata

e, então, a operação pai é executada. Na coluna EXECUTION_PLAN, a ID da operação é mostrada

na extremidade esquerda. No exemplo de plano de execução, a operação 1 é executada primeiro,

com seus resultados sendo passados para a operação 0. O exemplo a seguir ilustra a ordem para

um exemplo mais complexo:

0 SELECT STATEMENT Cost = 6
1 MERGE JOIN Cost = 1
2 TABLE ACCESS BY INDEX ROWID PRODUCT_TYPES TABLE Cost = 1
3 INDEX FULL SCAN PRODUCT_TYPES_PK INDEX (UNIQUE) Cost = 1
4 SORT JOIN Cost = 2
5 TABLE ACCESS FULL PRODUCTS TABLE Cost = 1
A ordem em que as operações são executadas nesse exemplo é 3, 2, 5, 4, 1 e 0.

Agora que você já conhece a ordem na qual as operações são executadas, é hora de aprender

para o que elas fazem realmente.  O plano de execução da consulta 'CUSTOMERS' era:

0 SELECT STATEMENT Cost = 3

1 TABLE ACCESS FULL CUSTOMERS TABLE Cost = 1

A operação 1 é executada primeiro, com seus resultados sendo passados para a operação 0.

A operação 1 envolve uma varredura integral — indicada pela string TABLE ACCESS FULL — da

tabela customers. Este é o comando original usado para gerar a consulta 'CUSTOMERS':

EXPLAIN PLAN SET STATEMENT_ID = 'CUSTOMERS' FOR
SELECT customer_id, first_name, last_name FROM customers;
 

Uma varredura integral da tabela é realizada porque a instrução SELECT especifica que todas

as linhas da tabela customers devem ser recuperadas.

O custo total da consulta é de três unidades de trabalho, conforme indicado na parte referente

ao custo mostrada à direita da operação 0 no plano de execução (0 SELECT STATEMENT Cost =

3). Uma unidade de trabalho é a quantidade de processamento que o software precisa para realizar

determinada operação. Quanto mais alto o custo, mais trabalho o software do banco de dados precisa

realizar para concluir a instrução SQL.

NOTA

Se você estiver usando uma versão do banco de dados anterior ao Oracle Database 10g, a saída

do custo da instrução global poderá estar em branco. Isso ocorre porque as versões de banco de

dados anteriores não reúnem estatísticas de tabela automaticamente. Para reunir estatísticas, você

precisa usar o comando ANALYZE. Você vai aprender a fazer isso na seção “Reunindo estatísticas

de tabela”.

Planos de execução envolvendo joins de tabela

Os planos de execução para consultas com joins de tabelas são mais complexos. O exemplo a seguir

gera o plano de execução de uma consulta que junta as tabelas products e product_types:

EXPLAIN PLAN SET STATEMENT_ID = 'PRODUCTS' FOR
SELECT p.name, pt.name
FROM products p, product_types pt
WHERE p.product_type_id = pt.product_type_id;
O plano de execução dessa consulta está mostrado no exemplo a seguir:

@ c:\sql_book\sql\explain_plan.sql

Enter value for v_statement_id: PRODUCTS

EXECUTION_PLAN

----------------------------------------------------------------

0 SELECT STATEMENT Cost = 6
1 MERGE JOIN Cost = 1
2 TABLE ACCESS BY INDEX ROWID PRODUCT_TYPES TABLE Cost = 1
3 INDEX FULL SCAN PRODUCT_TYPES_PK INDEX (UNIQUE) Cost = 1
4 SORT JOIN Cost = 2
5 TABLE ACCESS FULL PRODUCTS TABLE Cost = 1
 

ID da operação Descrição

3 Varredura integral do índice product_types_pk (que é um índice exclusivo)

para obter os endereços das linhas na tabela product_types. Os

endereços estão na forma de valores de ROWID, os quais são passados para

a operação 2.

2 Acesso às linhas da tabela product_types usando a lista de valores de

ROWID passada da operação 3. As linhas são passadas para a operação 1.

5 Acesso às linhas da tabela products. As linhas são passadas para a operação

4.

4 Classificação das linhas passadas da operação 5. As linhas classificadas são

passadas para a operação 1.

1 Mesclagem das linhas passadas das operações 2 e 5. As linhas mescladas

são passadas para a operação 0.

0 Retorno das linhas da operação 1 para o usuário. O custo total da consulta

é de 6 unidades de trabalho.

Reunindo estatísticas de tabela

Se estiver usando uma versão do banco de dados anterior ao Oracle Database 10g (como a 9i),

você mesmo terá de reunir estatísticas de tabela usando o comando ANALYZE. Por padrão, se

nenhuma estatística estiver disponível, a otimização baseada em regra será utilizada. Normalmente,

a otimização baseada em regra não é tão boa quanto a otimização baseada em custo. Os

exemplos a seguir usam o comando ANALYZE para reunir estatísticas para as tabelas products e

product_types:

ANALYZE TABLE products COMPUTE STATISTICS;

ANALYZE TABLE product_types COMPUTE STATISTICS;

Uma vez reunidas as estatísticas, a otimização baseada em custo será usada em vez da otimização

baseada em regra.

Comparando planos de execução

Comparando o custo total mostrado no plano de execução para diferentes instruções SQL, você

pode determinar o valor do ajuste de seu código SQL. Nesta seção, você verá como comparar dois

planos de execução e a vantagem de usar EXISTS em vez de DISTINCT (uma dica dada anteriormente).

O exemplo a seguir gera um plano de execução para uma consulta que usa EXISTS:

EXPLAIN PLAN SET STATEMENT_ID = 'EXISTS_QUERY' FOR
SELECT product_id, name
FROM products outer
WHERE EXISTS
(SELECT 1
FROM purchases inner
WHERE inner.product_id = outer.product_id);
EXPLAIN PLAN SET STATEMENT_ID = 'DISTINCT_QUERY' FOR
SELECT DISTINCT pr.product_id, pr.name
FROM products pr, purchases pu
WHERE pr.product_id = pu.product_id;
O plano de execução dessa consulta está mostrado no exemplo a seguir:

@ c:\sql_book\sql\explain_plan.sql

Enter value for v_statement_id: DISTINCT_QUERY

EXECUTION_PLAN

--------------------------------------------------------------

0 SELECT STATEMENT Cost = 5
1 HASH UNIQUE Cost = 1
2 MERGE JOIN Cost = 1
3 TABLE ACCESS BY INDEX ROWID PRODUCTS TABLE Cost = 1
4 INDEX FULL SCAN PRODUCTS_PK INDEX (UNIQUE) Cost = 1
5 SORT JOIN Cost = 2
6 INDEX FULL SCAN PURCHASES_PK INDEX (UNIQUE) Cost = 1
O custo da consulta é de 5 unidades de trabalho. Essa consulta é mais dispendiosa do que a

anterior, que usou EXISTS (essa consulta tinha um custo de apenas 4 unidades de trabalho). Esses

resultados provam que é melhor usar EXISTS do que DISTINCT.

Referência Oracle DataBase 11G SQL