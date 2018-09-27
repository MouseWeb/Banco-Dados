--
-- Inclua a coluna DATA_NASCIMENTO na tabela ALUNO do tipo string, de tamanho 10 caracteres
--
ALTER TABLE ALUNO ADD DATA_NASCIMENTO VARCHAR(10);

--
-- Altere a coluna DATA_NASCIMENTO para NASCIMENTO e seu tipo de dado para DATE
--
ALTER TABLE ALUNO CHANGE DATA_NASCIMENTO NASCIMENTO DATE NULL;

--
-- Crie um novo índice na tabela ALUNO, para o campo ALUNO
--
ALTER TABLE ALUNO ADD INDEX INDEX_ALUNO(ALUNO);

--
-- Inclua o campo EMAIL na tabela INSTRUTOR, com tamanho de 100 caracteres
--
ALTER TABLE INSTRUTOR ADD EMAIL VARCHAR(100);

--
-- Crie um novo índice na tabela CURSO, para o campo INSTRUTOR
--
ALTER TABLE CURSO ADD INDEX INDEX_INSTRUTOR(INSTRUTOR);

--
-- Remova o campo EMAIL da tabela INSTRUTOR
--
ALTER TABLE INSTRUTOR DROP EMAIL;