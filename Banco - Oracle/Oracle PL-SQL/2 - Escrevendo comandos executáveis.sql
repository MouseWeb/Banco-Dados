--Bloco anonimo

DECLARE
  VDESCONTO NUMBER(6,2) := 0.50;
  VCIDADE VARCHAR(30)   := 'NOVO HAMBURGO';
  VCOD_ALUNO  TALUNO.COD_ALUNO%TYPE := 5;
  VTOTAL NUMBER(8,2) := 1345.89;
BEGIN
  VTOTAL := Round(VTOTAL * VDESCONTO, 2);
  Dbms_Output.Put_Line('Total: '|| vTotal);

  VDESCONTO := 1.20;
  vCIDADE := InitCap(VCIDADE);
  Dbms_Output.Put_Line('Cidade: '||vCidade);
  Dbms_Output.Put_Line('Desconto: '||VDESCONTO);
  Dbms_Output.Put_Line('Aluno: '||VCOD_ALUNO);
END;


--
SELECT * FROM TCurso;
SELECT * FROM TAluno

DECLARE
  vPreco1 NUMBER(8,2)   := 10;
  vPreco2 NUMBER(8,2)   := 20;
  vFlag BOOLEAN; --True ou False
BEGIN
  vFlag := (vPreco1>vPreco2);
  IF (vFlag=True) THEN --Se vFlag = True Entao
    Dbms_Output.Put_Line('Verdadeiro');
  ELSE --Senao
    Dbms_Output.Put_Line('Falso');
  END IF; --Fim do If
  IF (VPRECO1>VPRECO2) THEN
    Dbms_Output.Put_Line('vPreco1 é maior');
  ELSE
    Dbms_Output.Put_Line('vPreco2 é maior');
  END IF;
END;


--Bind variable
VARIABLE vDESCONTO2 NUMBER

DECLARE
  VCOD_ALUNO NUMBER := 1;
BEGIN
  :vDESCONTO2 := 0.90;
  Dbms_Output.put_line('desconto 2: '||:vDESCONTO2);

  UPDATE TContrato SET
  TOTAL = TOTAL * :vDESCONTO2
  WHERE COD_ALUNO = VCOD_ALUNO;
END;

SELECT * FROM tcontrato




--Aninhamento
DECLARE
  VTESTE VARCHAR(10) := 'TESTE';
BEGIN

  DECLARE
    VTESTE VARCHAR(10) := 'XXXX';
  BEGIN
    Dbms_Output.Put_Line(VTESTE);
  END;
  --
  Dbms_Output.Put_Line(VTESTE);

END;



