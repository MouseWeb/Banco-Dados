  --
  SELECT COD_CONTRATO, DATA, TOTAL
  FROM TCONTRATO
  WHERE TOTAL >=
   ( SELECT VALOR FROM TCURSO
     WHERE COD_CURSO = 3 );


  -- Errado (Só pode retornar 1
  -- linha na subconsulta)
  SELECT COD_CONTRATO, DATA, TOTAL
  FROM TCONTRATO
  WHERE TOTAL >=
    ( SELECT VALOR FROM TCURSO
      WHERE VALOR > 500 );

  SELECT * from TALUNO

  --Todos os Alunos da mesma cidade do Aluno 1,
  --Menos o Aluno 1
  SELECT COD_ALUNO, NOME, CIDADE
  FROM TALUNO
  WHERE CIDADE = ( SELECT CIDADE FROM TALUNO
                   WHERE COD_ALUNO = 1 )
  AND COD_ALUNO <> 1;

  --Todos os alunos da mesma cidade e
  --estado do aluno 1
  --menos o aluno 1
  SELECT COD_ALUNO, NOME, CIDADE, ESTADO
  FROM TALUNO
  WHERE (CIDADE,ESTADO) =
            ( SELECT CIDADE,ESTADO FROM TALUNO
              WHERE COD_ALUNO = 1 )
  AND COD_ALUNO <> 1 ;

  SELECT * FROM TALUNO

  --Soma todos os itens, e mostra somente cujo o
  --valor minimo seja maior que o valor medio
  --dos cursos
  SELECT COD_CURSO, Min(VALOR),Sum(VALOR),
         Count(*) QTDE
  FROM TITEM
  WHERE cod_curso > 0
  GROUP BY COD_CURSO
  HAVING Min(VALOR) >=
        (SELECT Avg(VALOR) FROM TCURSO)
  ORDER BY Cod_Curso;


  --Soma o total de contrato por aluno e mostra
  --somente cujo o menor contrato seja maior que
  --o valor medio de curso
  SELECT COD_ALUNO, Min(TOTAL), Sum(TOTAL)
  FROM TCONTRATO
  GROUP BY COD_ALUNO
  HAVING Min(TOTAL) >
     (SELECT Avg(VALOR) FROM TCURSO);


  --Todos os cursos que estao na tabela de
  --Item (Vendidos)
  SELECT COD_CURSO, NOME, VALOR
  FROM TCURSO
  WHERE COD_CURSO IN (SELECT COD_CURSO FROM TITEM)


  --Todos os Cursos que nao Estao na Tabela de Item
  --(Nao Vendidos)
  SELECT COD_CURSO, NOME, VALOR
  FROM TCURSO
  WHERE COD_CURSO NOT IN (SELECT COD_CURSO FROM TITEM)
  ORDER BY NOME


  -----Codigo equivalente a subselect
  --( se os valores sao conhecidos )
  SELECT cod_curso, nome, valor
  FROM tcurso WHERE cod_curso IN (1,2,3,4) ;


  ---
  SELECT Cod_curso, nome, valor
  FROM Tcurso
  WHERE Cod_curso = 1
  OR Cod_curso = 2
  OR Cod_curso = 3
  OR Cod_curso = 4;


  --Todos cursos que foram vendidos
  --pelo valor padrao
  SELECT * FROM TITEM
  WHERE (COD_CURSO, VALOR) IN
        (SELECT COD_CURSO, VALOR FROM TCURSO)


  --SubConsulta na clausula From
  SELECT ITE.COD_CONTRATO, ITE.VALOR, ITE.COD_CURSO,
         CUR.COD_CURSO codigo, CUR.VALOR
  FROM TITEM ITE,
       ( SELECT COD_CURSO, VALOR
         FROM TCURSO WHERE VALOR > 500 ) CUR

  WHERE CUR.COD_CURSO = ITE.COD_CURSO











