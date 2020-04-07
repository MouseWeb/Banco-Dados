
Estatísticas - Scripts
--Analisa apenas uma tabela - executar como usuário normal ANALYZE TABLE TALUNO COMPUTE STATISTICS;

--Estatística de schema - SYSTEM EXEC DBMS_UTILITY.ANALYZE_SCHEMA('CURSO','COMPUTE');

--Estatística de banco inteiro (Pode ser demorado) - SYSTEM EXEC DBMS_STATS.GATHER_DATABASE_STATS;

--Bloco anonimo para ler estatísticas do banco de dados - SYSTEM 

DECLARE
  libcac NUMBER(10, 2);
  rowcac NUMBER(10, 2);
  bufcac NUMBER(10, 2);
  redlog NUMBER(10, 2);
  spsize NUMBER;
  blkbuf NUMBER;
  logbuf NUMBER;
BEGIN
  SELECT VALUE
  INTO redlog
  FROM v$sysstat
  WHERE name = 'redo log space requests';
SELECT 100 * (SUM(pins) - SUM(reloads)) / SUM(pins)
  INTO libcac
  FROM v$librarycache;
 
  SELECT 100 * (SUM(gets) - SUM(getmisses)) / SUM(gets)
  INTO rowcac
  FROM v$rowcache;
SELECT 100 * (cur.VALUE + con.VALUE - phys.VALUE) /(cur.VALUE + con.VALUE)
  INTO bufcac
  FROM v$sysstat cur, v$sysstat con, v$sysstat phys, 
  v$statname ncu, v$statname nco, v$statname nph
  WHERE cur.statistic# = ncu.statistic#
  AND ncu.name = 'db block gets'
  AND con.statistic# = nco.statistic#
  AND nco.name = 'consistent gets'
  AND phys.statistic# = nph.statistic#
  AND nph.name = 'physical reads';
  SELECT VALUE INTO spsize
  FROM v$parameter
  WHERE name = 'shared_pool_size';
  SELECT VALUE INTO blkbuf
  FROM v$parameter
  WHERE name = 'db_block_buffers';
  SELECT VALUE INTO logbuf FROM v$parameter WHERE name = 'log_buffer';
  DBMS_OUTPUT.put_line('> SGA CACHE STATISTICS');
  DBMS_OUTPUT.put_line('> ********************');
  DBMS_OUTPUT.put_line('> SQL Cache Hit rate = ' || libcac);
  DBMS_OUTPUT.put_line('> Dict Cache Hit rate = ' || rowcac);
  DBMS_OUTPUT.put_line('> Buffer Cache Hit rate = ' || bufcac);
  DBMS_OUTPUT.put_line('> Redo Log space requests = ' || redlog);
  DBMS_OUTPUT.put_line('> ');
  DBMS_OUTPUT.put_line('> INIT.ORA SETTING');
  DBMS_OUTPUT.put_line('> ****************');
  DBMS_OUTPUT.put_line('> Shared Pool Size = ' || spsize || ' Bytes');
  DBMS_OUTPUT.put_line('> DB Block Buffer = ' || blkbuf || ' Blocks');
  DBMS_OUTPUT.put_line('> Log Buffer = ' || logbuf || ' Bytes');
  DBMS_OUTPUT.put_line('> ');
  IF libcac < 99 THEN
    DBMS_OUTPUT.put_line('*** HINT: Library Cache muito baixo! Aumente Shared Pool Size.');
  END IF;
  IF rowcac < 85 THEN
    DBMS_OUTPUT.put_line('*** HINT: Row Cache muito baixo! Aumente Shared Pool Size.');
  END IF;
  IF bufcac < 90 THEN
    DBMS_OUTPUT.put_line('*** HINT: Buffer Cache muito baixo! Aumente DB Block Buffer value.');
  END IF;
  IF redlog > 100 THEN
    DBMS_OUTPUT.put_line('*** HINT: Valor de Log Buffer é muito baixo!');
  END IF;
 
END;


Estatísticas
Coletando estatísticas para o otimizador de queries do Oracle
  Para que o Oracle monte planos de execução otimizados, é necessário que as estatísticas dos objetos estejam sempre atualizadas. Para atualizar as estatísticas dos objetos, podemos usar os métodos abaixo:

 

     Comando ANALYZE:

          - Calcula estatísticas globais de tabelas, índices e clusters;

          - Permite coletar estatísticas exatas ou estimada em um número ou percentual de linhas;

          - Não é tão preciso ao calcular, por exemplo, a cardinalidade, ao envolver valores distintos;

           - Exemplo p/ coletar estatísticas exatas de uma tabela: 

               ANALYZE TABLE TALUNO COMPUTE STATISTICS;

 

     Package DBMS_UTILITY:

          - As procedures desta package diferem do comando ANALYZE apenas pela possibilidade de permitir coletar estatísticas de um schema ou do banco de dados completo;

          - Exemplo p/ coletar estatísticas de um schema todo:

               EXEC DBMS_UTILITY.ANALYZE_SCHEMA('CURSO','COMPUTE');

   

     Package DBMS_STATS:

          - Permite coletar estatísticas exatas ou estimadas de objetos individualmente (tabelas, índices, cluster etc), schemas, banco de dados completo e de sistema;

          - Permite execução paralela, transferência de estatísticas entre servidores e é mais preciso que os métodos anteriores;

          - Gera historicos que são extremamente úteis para otimizar queries que efetuam pesquisas em colunas que possuem valores dispersos;

          - É o método de coleta de estatísticas atualmente recomendado pela Oracle e por especialistas no assunto;

          - Exemplos:

              a) Para coletar estatísticas estimadas (5%) de uma tabela:

                 EXEC DBMS_STATS.GATHER_TABLE_STATS(

OWNNAME=>'OWNER', TABNAME=>'TALUNO', ESTIMATE_PERCENT=>5);  

 

              b) Para coletar estatísticas estimadas (30%) de um schema:

                 EXEC DBMS_STATS.GATHER_SCHEMA_STATS('OWNER', estimate_percent=> 30);

 

              c) Para coletar estatísticas de todo o banco de dados: 

               EXEC DBMS_STATS.GATHER_DATABASE_STATS;

  

              d) Para coletar estatísticas de sistema (DD): 

               EXEC DBMS_STATS.GATHER_DICTIONARY_STATS;

Para coletar estatísticas de objetos:

  

        A partir do Oracle Database 10G, as estatísticas são coletadas automaticamente pelo Oracle, diariamente de 2ª à 6ª, em um horário compreendido geralmente entre 22h e 2h, e aos sábados começa às 6h e termina somente no Domingo, às 2h. É importante lembrar que ela só ocorre se o banco de dados estiver ocioso e somente nos objetos que tiveram mais que 10% de atualizações (inclui INSERT, UPDATE e DELETE). A partir do 11G, este valor de 10% é configurável.

           Pelo motivo dela ocorrer automaticamente, colete estatísticas somente quando você identificar alguma necessidade extra, como por exemplo, após uma carga de dados ou em banco de dados que trabalham 24X7 e que nunca ficam ociosos. Nestes casos, recomendo criar uma stored procedure contendo o código para coletar estatísticas de objetos do banco e criar em seguida um job para executar esta procedure periodicamente;

          Se o seu BD usa o CBO, evite coletar estatísticas através do comando ANALYZE TABLE e através da package DBMS_UTILITY.Se você fizer isso, suas estatísticas serão menos precisas e você não terá historicos;