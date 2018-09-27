--Especificação ou declaração
CREATE OR REPLACE PACKAGE PKG_ALUNO
IS
  vCIDADE VARCHAR2(30);  --Variaveis publicas
  vMedia NUMBER(8,2);    --Variaveis publicas
  vNOME VARCHAR2(30);    --Variaveis publicas
  PROCEDURE DELETA_ALUNO(pCOD_ALUNO NUMBER);
  PROCEDURE MEDIA_CONTRATOS;
  PROCEDURE CON_ALUNO(pCOD_ALUNO NUMBER);
END;
/
---------
------ --Corpo
CREATE OR REPLACE PACKAGE BODY PKG_ALUNO --Corpo
IS
 --variaveis locais
 vTESTE VARCHAR(20);
 --************
 PROCEDURE MEDIA_CONTRATOS
 IS
 BEGIN
   vTESTE := 'teste';
   SELECT Avg(total) INTO vMEDIA FROM tcontrato;
 END;
 --************
 PROCEDURE CON_ALUNO(pCOD_ALUNO NUMBER)
 IS
 BEGIN
   vNOME := '';
   SELECT NOME INTO vNOME FROM TALUNO
   WHERE COD_ALUNO=pCOD_ALUNO;
 EXCEPTION
   WHEN No_Data_Found THEN
     Dbms_Output.Put_Line('Aluno não existe');
 END;
 ---*************
 PROCEDURE DELETA_ALUNO(pCOD_ALUNO NUMBER)
 IS
 BEGIN
  CON_ALUNO(pCOD_ALUNO);
  IF Length(vNOME) > 0 THEN
    DELETE FROM TALUNO WHERE COD_ALUNO = pCOD_ALUNO;
    Dbms_Output.Put_Line(vNOME||'->Excluido');
  END IF;
 END;

END;
--FIM do package


--USANDO
EXEC PKG_ALUNO.DELETA_ALUNO(666);

SELECT * FROM TALUNO;




--
DECLARE
  m NUMBER;
BEGIN
  pkg_aluno.media_contratos; --executa a procedure
  m := pkg_aluno.vMedia;
  Dbms_Output.Put_Line('Média: '||m);
END;



--
DECLARE
  nome VARCHAR(30);
BEGIN
  pkg_aluno.con_aluno(89); --executa a procedure
  nome := pkg_aluno.vnome;
  Dbms_Output.Put_Line('Nome '||nome);
END;


--
BEGIN
  pkg_aluno.con_aluno(1); --executa a procedure
  IF (pkg_aluno.vnome <> '') THEN
    Dbms_Output.Put_Line('Nome '||pkg_aluno.vnome);
  END IF;
END;