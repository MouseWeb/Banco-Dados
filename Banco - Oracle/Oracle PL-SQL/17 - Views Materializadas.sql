--Conectado como system --Direito para criar view materializada GRANT CREATE ANY MATERIALIZED VIEW TO marcio;
--Criar log para view CREATE MATERIALIZED VIEW LOG ON taluno TABLESPACE tbs_dados
--Excluir View DROP MATERIALIZED VIEW V_MAT;

--Criar View 
CREATE MATERIALIZED VIEW v_mat
TABLESPACE tbs_dados
    BUILD IMMEDIATE
    REFRESH
        FAST
        ON COMMIT
AS
    ( SELECT
        cod_aluno,
        nome,
        cidade
    FROM
        taluno
    WHERE
        cidade = 'NOVO HABURGO'
    );

INSERT INTO taluno (cod_aluno,nome,cidade) VALUES (seq_aluno.NEXTVAL,'TESTE 2','NOVO HAMBURGO');

SELECT
    *
FROM
    taluno;

SELECT
    *
FROM
    v_mat;


/* View Materializada Conteúdo
Views Materializadas Utilizamos elas para fazermos cálculos, armazenamentos de dados e dar agilidade na troca de informações entre um banco de dados ou entre tabelas. 
Este recurso é muito utilizado em ambientes de Data Warehouse, que trabalha com uma enorme quantidade de informações. Pois com elas conseguimos melhorar a performance 
do sistema e trazer diversos benefícios ao Oracle.

As Views Materializadas são utilizadas para fazer atualizações, a própria Oracle garante que as atualizações são feitas com sucesso numa tabela destinatária após terem 
sido efetivadas nas tabelas originais. Isso nos dá mais tranquilidade na administração e no desenvolvimento.

Exemplo de como se faz uma Views Materializadas:

CREATE MATERIALIZED VIEW VM_ALUNO BUILD IMMEDIATE  REFRESH FAST ENABLE QUERY REWRITE  AS (SELECT * FROM TALUNO WHERE CIDADE=’NOVO HAMBURGO’) BUILD IMMEDIATE

A View Materializada deverá utilizar os dados imediatamente na query rewrite (Seu SELECT), desde modo os dados serão processados com mais agilidade.

Existe também outro método, chamado build deferred que significa que a view não terá nenhum tipo de dados a ser utilizada automaticamente, esse modo seria um processamento 
manual das informações, que será depois atualizado pelo Refresh, resumindo, que com essa opção o comando SELECT não será executado imediatamente.

REFRESH FAST

Esse método é para dizer que as modificações serão utilizadas somente pela View Materializada, para utilizar este recurso com segurança, sugiro criar uma View Materializada 
Log, para ter controle sobre as modificações que estão sendo feitas.

ENABLE QUERY REWRITE

Essa linha de comando é o que indica que o SELECT presente dentro da View Materializada será reescrita e atualizada para os novos valores passados pela VIEW. A query rewrite 
pode ter três níveis de integridade que vai desde o modo ENFORCED até o STALE_TOLERATED, que indicará ao banco de dados que tipo de confiança ele poderá ter nos dados. 
Sobre as integridades, falaremos na próxima coluna também, pois e um pouco mais delicado.

AS SELECT

Aqui será colocado seu SELECT, onde poderá fazer alguns cálculos ou visualizações de informações para outras tabelas, como no exemplo de SELECT a seguir.

SELECT * FROM TALUNO WHERE cidade = ’NOVO HAMBURGO’
SELECTS que devemos utilizar dentro das Views Materializadas devem seguir um padrão delas, como, por exemplo, não utilizar cláusulas como UNION, UNION ALL, INTERSECT e MINUS. */