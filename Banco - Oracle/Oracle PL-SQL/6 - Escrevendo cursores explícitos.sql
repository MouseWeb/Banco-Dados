
DECLARE
   vcod_aluno TAluno.Cod_Aluno%TYPE;
   vNome   TAluno.nome%TYPE;
   CURSOR c1 IS
     SELECT cod_aluno, nome
     FROM   taluno;

BEGIN
   OPEN c1; -- abre cursor
   LOOP
      FETCH c1 INTO vCod_Aluno, vNome;  --pega registro atual
      EXIT WHEN c1%ROWCOUNT > 10 OR c1%NOTFOUND;
      Dbms_Output.Put_Line('Codigo: '||
        LPad(vcod_aluno,4,'0')||' - '||'Nome: '||vNome);
   END LOOP;
   CLOSE c1; --fecha cursor
END;



--

DECLARE
   CURSOR c1 IS
      SELECT * FROM TAluno;
   Reg c1%ROWTYPE;  --record
BEGIN
   OPEN c1; --
   LOOP
      FETCH c1 INTO reg;
      EXIT WHEN c1%ROWCOUNT > 10 OR c1%NOTFOUND;
      Dbms_Output.Put_Line('Codigo: '||
                  LPad(reg.cod_aluno,5,'0')||'-'||
                 'Nome: '||reg.nome);
   END LOOP;
   CLOSE c1; --
END;
--


-----
DECLARE
  CURSOR c1 IS
    SELECT * FROM TAluno;
  Reg TAluno%ROWTYPE;
BEGIN
  FOR reg IN c1  --open, laço, fetch, close, exit when
  LOOP
    Dbms_Output.Put_Line('Codigo: '||
       LPad(reg.cod_aluno,5,'0')||' - ' || 'Nome: '||reg.nome);
  END LOOP;
END;
--
DECLARE
  Reg TALUNO%ROWTYPE;
BEGIN
  FOR reg IN (SELECT * FROM TALUNO)
  LOOP
    Dbms_Output.Put_Line(reg.cod_aluno ||' - ' || reg.nome);
  END LOOP;
END;


---
---
DECLARE
  CURSOR c1 (pCod_aluno NUMBER) IS
    SELECT * FROM TAluno
    WHERE Cod_aluno = pCod_aluno
   FOR UPDATE OF NOME NOWAIT;
  --bloquea a coluna nome para alteracao
  Reg c1%ROWTYPE;
BEGIN
  OPEN c1(&codigo);
  FETCH c1 INTO reg;
  Dbms_Output.Put_Line(reg.cod_aluno ||' - ' || reg.nome);
  CLOSE c1; --libera o registro para alteracao
END;
--



DECLARE
   CURSOR c1 IS
     SELECT * FROM TALUNO
     FOR UPDATE;
   Reg_aluno c1%ROWTYPE;
BEGIN
   FOR reg_aluno IN c1
   LOOP
      UPDATE TALUNO
      SET    nome = InitCap(reg_aluno.nome)
      WHERE CURRENT OF c1;  --bloqueia somente o reg atual
      Dbms_Output.Put_Line('Nome: '||InitCap(reg_aluno.nome));
   END LOOP;
   COMMIT;
END;

