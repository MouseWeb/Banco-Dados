Monitorando uso dos índices
Monitorando uso dos índices

Existem muitos bancos de dados em que índices estão criados mais não são utilizados. Por exemplo, ter criado um índice para um determinado procedimento, que é executado somente uma vez e após seu uso não é removido, ou até mesmo o Oracle perceber que leitura por scans completos pode ser mais vantajoso do que utilizar um determinado índice (isso acontece).

Criar índice em uma base, deve ser algo realmente estudado, pois podem ter impacto negativo sobre o desempenho das operações DML. Além de modificar o valor do bloco da data, também é necessário atualizar o bloco do índice.

Por esse motivo que devesse notar muito bem a utilização de um índice, caso não seja utilizado prejudica o desempenho do banco de dados.

Abaixo está um exemplo para descobrir se um índice está sendo ou não utilizado

--Criação de tabela de teste

create table teste (codigo number,  nome varchar2(40) );

  --Criação de indice create index ind_codigo on teste (codigo);

--Novo registro insert into teste values (1, 'MARCIO');

commit;

--Verificado se o índices já foi usado

select index_name, table_name, used from v$object_usage;

--Alterado índice

alter index ind_codigo monitoring usage;

--Select para usar o indice select * from teste where codigo=1;


--Verificado se o índices já foi usado novamente

select index_name, table_name, used from v$object_usage;

--Alterado índice para não ser monitorado

alter index ind_codigo nomonitoring usage;

Veja que a view v$OBJECT_USAGE, terá cada índice do seu esquema cujo uso está sendo monitorando, caso o índice não for usado, pode ser exclui-lo para melhorar performance de DML.

-------------------------------------------------------------------------------------------------

Criação de Índices
Criação de Índices
Porque o índice é importante?
Índices (Index) são importantes pois diminuem processamento e I/O em disco. Quando usamos um comando SQL para retirar informações de uma tabela, na qual, a coluna da mesma não possui um índice, o Oracle faz um Acesso Total a Tabela para procurar o dado, ou seja, realiza-se um FULL TABLE SCAN degradando a performance do Banco de Dados Oracle. Com o índice isso não ocorre, pois com o índice isso apontará para a linha exata da tabela daquela coluna retirando o dado muito mais rápido.

Crie Índices quando:

Uma coluna contiver uma grande faixa de valores

Uma coluna contiver muitos valores nulos

Quando uma ou mais colunas forem usadas frequentemente em clausulas WHERE ou emJOINS

Se a tabela for muito grande e as consultas realizadas recuperarem menos de 5% dos registros.

NÃO Crie Índices quando:

As colunas não são usadas frequentemente como condição nas consultas

A tabela for pequena ou se os resultados das consultas forem maiores que 5-10% dos registros.

A tabela for atualizada com frequência

As colunas fizerem parte de uma expressão*

* Expressão é quando usado regra de filtro na clausula where, como por exemplo:

SELECT TABLE_NAME

FROM ALL_TABLES

WHERE TABLE_NAME||OWNER = 'DUALSYS'

Observe que na clausula de comparação as colunas TABLE_NAME e OWNER fazem uma expressão de comparação e por consequencia um índice não ajudaria em nada.

 

Outras coisas importantes de lembrar:

ÍNDICES NÃO SÃO ALTERÁVEIS! (Para você alterar um índice você deve removê-lo e recriá-lo. )
ÍNDICES ONERAM A PERFORMANCE DE INSERT / UPDATE  ( Não dá pra fazer milagres, se sua tabela tiver muitos índices as performances de alterações podem ser comprometidas )