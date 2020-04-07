-- Hints de Pesquisa - Script
-- Conectado como system --Visão dos hints select * from v$sql_hint
-- Conectado como system grant select_catalog_role to DOUGLAS; grant select any dictionary to DOUGLAS;
-- first_rows: Para forçar o uso de índice de modo geral.  -- Faz com que o otimizador escolha um caminho que recupera N linhas primeiramente  
-- e ja mostra enquanto processa o resto

select * from taluno;
create index ind_aluno_nome on taluno(nome);
select /*+ first_rows(2) */ cod_aluno, nome from taluno
-- all_rows: Para forçar varredura completa na tabela.

select /*+ all_rows (10) */ cod_aluno, nome
from taluno;
-- full: Para forçar um scan completo na tabela. 
-- A hint full também pode causar resultados inesperados como varredura 
-- na tabela em ordem diferente da ordem padrão.
 
select /*+ full_rows (taluno) */ cod_aluno, nome
from taluno
where nome = 'DOUGLAS' ;
-- index: Força o uso de um índice. -- Nenhum índice é especificado.  -- O Oracle pesa todos os índices possíveis e escolhe um ou mais a serem usados.  -- Otimizador não fará um scan completo na tabela.

select /*+ index */ cod_aluno, nome
from taluno
where nome = 'DOUGLAS' ;
---Exemplo do uso da hint index informando os índices que devem ser utilizados:

select /*+ index (taluno ind_aluno_nome) */ cod_aluno, nome, cidade
from taluno
where nome = 'DOUGLAS' ;
-- no_index: Evitar que um índice especificado seja usado pelo Oracle.

select /*+ no_index (taluno ind_aluno_nome) */ cod_aluno, nome, cidade
from taluno
where nome = 'DOUGLAS' ;
-- index_join : Permite mesclar índice em uma única tabela.  -- Permite acessar somente os índices da tabela, e não apenas um scan  -- com menos bloco no total, é mais rápido do que usar um índice que faz scan na tabela por rowid.

create index ind_aluno_cidade on taluno(cidade)

select /*+ index_join (taluno ind_aluno_nome, ind_aluno_cidade) */ cod_aluno, nome, cidade
from taluno
where nome = 'DOUGLAS' AND cidade = 'NOVO HAMBURGO';
-- and_equal : Para acessar todos os índices que você especificar.  -- A hint and_equal faz com que o otimizador misture vários índices  -- para uma única tabela em vez de escolher qual é ao melhor.

select /*+ and_equal (taluno ind_aluno_nome, ind_aluno_cidade) */ cod_aluno, nome, cidade
from taluno
where nome = 'DOUGLAS' AND cidade = 'NOVO HAMBURGO';
-- index_ffs: Força um scan completo do índice.  -- Este hint pode oferecer grandes ganhos de desempenho quando a tabela  -- também possuir muitas colunas.

select /*+ index_ffs (taluno ind_aluno_nome) */ cod_aluno, nome
from taluno
where nome = 'DOUGLAS'



/*Hints de Pesquisa
CONHECENDO HINTS

Otimizador do Oracle é incrivelmente preciso na escolha do caminho de otimização correto e no uso de índices para milhares de registros no seu sistema, 
porem exise casos que é preciso mudar.  O ORACLE possui hints ou sugestões que você poderá usar para determinadas consultas, de modo que o otimizador 
seja desconsiderado, na esperança de conseguir melhor desempenho para determinada consulta.  Os hints modificam o caminho de execução quando um otimizador 
processa uma instrução específica. O parâmetro OPTIMIZER_MODE de init.ora pode ser usado para modificar todas as instruções no banco de dados para que sigam 
um caminho de execução específico, mas um hint para um caminho de execução diferente substitui qualquer coisa que esteja especificada no init.ora. Contudo, 
a otimização baseada em custo não será usada se as tabelas não tiverem sido analisadas.

Os hints podem ser muito úteis se soubermos quando e qual usar, mas eles podem ser maléficos se não forem utilizados na situação correta ou sem muito conhecimento 
de suas ações e consequências! Nas últimas versões do SGBD Oracle, um hint obsoleto pode gerar um plano de execução ruim, e consequentemente, impactar negativamente 
na performance da instrução SQL.

Veremos vários hints, como por exemplo: APPEND,PARALLEL e FIRST_ROWS, que são muito bons quando são utilizados nas situações adequadas! O hint APPEND, por exemplo, 
deve ser utilizado para otimizar cargas de dados via comando INSERT (através de carga direta) somente quando você tiver certeza de que outros usuários não estarão 
atualizando dados concorrentemente na tabela! Já o hint PARALLEL, só deve ser utilizado em consultas longas e quando houver recursos de processamento, memória e I/O 
disponíveis, ou seja, quando estes recursos, não estiverem sobrecarregados!