---------------------------------------------------- PACKAGE DE USUARIO ---------------------------------------------------

CREATE OR REPLACE PACKAGE PKG_USUARIO IS

  /*
    Package responsavel por realizar o cadastro dos usuario
  Autor : Washington
  */
  PROCEDURE prc_insere_usuario(	p_nome_usuario   	IN "Usuarios"."Nome"%TYPE,
								p_senha_usuario  	IN "Usuarios"."Senha"%TYPE,
								p_cpf_usuario		IN "Usuarios"."Cpf"%TYPE,
								p_ret_code     		OUT VARCHAR2,
								p_ret_msg      		OUT VARCHAR2);

  /*
    Package responsavel por realizar valida se existe usuario
  Autor : Washington
  */
  FUNCTION fnc_existe_usuario(p_cpf_usuario	IN "Usuarios"."Cpf"%TYPE,
                              p_ret_code OUT VARCHAR2,
                              p_ret_msg  OUT VARCHAR2) RETURN BOOLEAN;

END PKG_USUARIO;
/
CREATE OR REPLACE PACKAGE BODY PKG_USUARIO IS

  /*
    Package responsavel por realizar o cadastro dos usuario
  Autor : Washington
  */
  PROCEDURE prc_insere_usuario(	p_nome_usuario  	IN "Usuarios"."Nome"%TYPE,
								p_senha_usuario 	IN "Usuarios"."Senha"%TYPE,
								p_cpf_usuario		IN "Usuarios"."Cpf"%TYPE,
								p_ret_code     		OUT VARCHAR2,
								p_ret_msg      		OUT VARCHAR2) AS
                                v_id_usuario "Usuarios"."Id"%TYPE;
  BEGIN
  
	SELECT "SQ_Usuarios".NEXTVAL INTO v_id_usuario FROM DUAL;
	
    INSERT INTO "Usuarios" 
    ("Id","Nome","Senha","Cpf")
    VALUES
      (v_id_usuario, p_nome_usuario, p_senha_usuario, p_cpf_usuario);
  
    p_ret_code := '0';
    p_ret_msg  := 'Sucesso';
  
  EXCEPTION
    WHEN OTHERS THEN
      p_ret_code := '-1';
      p_ret_msg  := 'Erro indeterminado na pkg_usuario.prc_insere_usuario ' ||
                    SQLERRM;
    
  END prc_insere_usuario;

  /*
    Package responsavel por realizar valida se existe usuario
  Autor : Washington
  */
  FUNCTION fnc_existe_usuario(p_cpf_usuario	IN "Usuarios"."Cpf"%TYPE,
                              p_ret_code 	OUT VARCHAR2,
                              p_ret_msg  	OUT VARCHAR2) RETURN BOOLEAN IS
  
    v_exist "Usuarios"."Cpf"%TYPE;
  
  BEGIN
  
    SELECT "Cpf" INTO v_exist FROM "Usuarios" WHERE "Cpf" = p_cpf_usuario;
  
    p_ret_code := '0';
    p_ret_msg  := 'Sucesso';
    RETURN TRUE;
  
  EXCEPTION
    WHEN no_data_found THEN
      p_ret_code := '-1';
      p_ret_msg  := 'Nao existe usuario com o cpf ' || p_cpf_usuario;
      RETURN FALSE;
    WHEN OTHERS THEN
      p_ret_code := '-2';
      p_ret_msg  := 'Erro indeterminado na pkg_usuario.fnc_existe_usuario ' ||
                    SQLERRM;
      RETURN FALSE;
  END fnc_existe_usuario;

END PKG_USUARIO;
/

--------------------------------------------------------------------------------------------------------------------------