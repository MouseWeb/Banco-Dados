--INSERT DE USUÁRIO

/*
NIVEIS - DAR INSERT DE ACORDO COM A OPÇÃO DE USUARIO

M - MÉDICO
A - ADMINISTRADOR
P - PACIENTE

*/

INSERT INTO TBL_USUARIOS (idusuario,usu_nome,usu_login,usu_senha,usu_telefone,usu_email,usu_logradouro,usu_bairro,
						  usu_cidade,usu_cep,usu_estado,usu_num,usu_complemento,usu_nivel)
						  
						  VALUES (NULL,'NOME','LOGIN','SENHA','TEL','EMAIL','LOGRADOURO','BAIRRO','CIDADE','CEP','ESTADO','NUM','COMPL.','A');
						  
-- INSERT DE RELATO


INSERT INTO TBL_RELATOS (idrelato,rel_marca,rel_nome,rel_dosagem,rel_qd_med_ini,rel_qd_med_inter,rel_descricao,rel_gravidade,rel_edv_desap)
						  
						  VALUES (NULL,'MARCA','MAR_NOME','DOSAGEM','2018/04/01','2018/04/30','DESC','GRAVIDADE','DESAPARECEU');
						  
						
--SELECT RELATO

	select idrelato,
		   rel_marca,
		   rel_nome,
		   rel_dosagem, 
		   date_format(rel_qd_med_ini,'%d/%m/%Y') as rel_qd_med_ini , 
		   date_format(rel_qd_med_inter,'%d/%m/%Y') as rel_qd_med_inter ,
		   rel_descricao,
		   rel_gravidade,
		   --DESAPARECEU É O NOME DA NOVA COLUNA DA TABELA,  RESULTADO DO CASE COM A RESPOSTA SIM OU NAO
		   --DESAPARECEU? 1 OU 0 (SIM OU NAO) ESSE CASE FAZ ISSO) ADICIONA SIM OU NÃO NO LUGAR DE 0 OU 1 E CRIA ESSA NOVA COLUNA DESAPARECEU
		   case when rel_edv_desap = 1 then 'SIM' else 'NÃO' end 'desapareceu' 
		   
		   from tbl_relatos
		   
--SELECT LOGIN - Vou pegar o niel tambem, caso voce queira saber pra qual tela jogar ele
	
	SELECT USU_LOGIN , USU_SENHA , USU_NIVEL FROM TBL_USUARIOS WHERE USU_LOGIN = 'PARAMETRO' AND USU_SENHA = 'PARAMETRO'
	
	
 --VALIDACAO SE O O USUARIO JA EXISTE NO SISTEMA ANTES DE CRIAR UM NOVO
 -- SE O COUNT RETORNAR 1 VC NAO DEIXA INSERIR O USUARIO, PQ JA EXISTE 1 COM O NOME
 -- SE RETORNAR 0, SIGNIFICA QUE SUA CONSULTA DO BANCO NAO RETORNOU NENHUMA LINHA, OU SEJA, NAO EXISTE NENHUM USUÁRIO COM O PARAMETRO PASSADO
 
 SELECT COUNT(*) USU_LOGIN FROM TBL_USUARIOS WHERE USU_LOGIN = 'PARAMETRO'
 
 

						
					
					


								  
								  
								  
						  
		