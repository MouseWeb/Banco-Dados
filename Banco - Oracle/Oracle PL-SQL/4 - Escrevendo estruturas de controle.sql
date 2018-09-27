DECLARE
  vNome VARCHAR(30) := 'Outro';
  vCidade VARCHAR(30);     vEstado VARCHAR(2) := 'RS';
BEGIN
  IF (vNome = 'Gaucho') THEN
    vCidade := 'Porto Alegre';    vEstado := 'RS';
  ELSIF (vNome = 'Carioca') THEN
    vCidade := 'Rio de Janeiro';  vEstado := 'RJ';
  ELSIF (vNome = 'Acreano') OR (vNome = 'Amapa') THEN
    vCidade := 'Nao existe';      vEstado := 'AC';
  ELSE
    IF (vEstado<>'RS') THEN
      vCidade := 'Estrangeiro';
      vEstado := 'XX';
    ELSE
      vCidade := 'Pelotas';
      vEstado := 'RS';
    END IF;
  END IF;
  Dbms_Output.Put_Line(vCidade||' - '||vEstado);
END;

--
-- Case When
--
DECLARE
  vEstado VARCHAR(2) := 'RR';
  vNome VARCHAR(30);
BEGIN
  CASE
    WHEN vEstado ='RS' THEN vNome := 'Gaucho';
    WHEN vEstado ='RJ' OR vEstado='ES' THEN vNome := 'Carioca';
  ELSE
    vNome := 'Outros';
  END CASE;
  Dbms_Output.Put_Line('Apelido: '||vNome);
END;
--





--Laço de repetição 1 até 10
DECLARE
  vContador INTEGER := 0;
BEGIN
  LOOP
    vContador := vContador + 1;
    Dbms_Output.Put_Line(vContador);
    EXIT WHEN vContador = 10;
  END LOOP;
  Dbms_Output.Put_Line('Fim do LOOP');
END;

--Laço de repetição 10 até 1
DECLARE
  vContador INTEGER := 10;
BEGIN
  LOOP
    vContador := vContador - 1;
    Dbms_Output.Put_Line(vContador);
    EXIT WHEN vContador = 0;
  END LOOP;
  Dbms_Output.Put_Line('Fim do LOOP');
END;






--For loop -> mais indicado para laços em tabelas
DECLARE
  vContador INTEGER;
BEGIN
  FOR vContador in 1..10
  LOOP
    --vContador := vContador + 1;
    Dbms_Output.Put_Line(vContador);
    --EXIT WHEN vContador = 5;
  END LOOP;
END;


--While Loop
DECLARE
  vContador INTEGER := 0;
  vTexto VARCHAR(10);
BEGIN
  WHILE vContador < 10
  LOOP
    vContador := vContador + 1;
    IF (vContador Mod 2)=0 THEN
      vTexto := 'Par';
    ELSE
      vTexto := 'Impar';
    END IF;
    Dbms_Output.Put_Line(vContador|| ' -> '||vTexto);
  END LOOP;
END;




