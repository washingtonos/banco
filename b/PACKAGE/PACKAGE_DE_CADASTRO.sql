CREATE OR REPLACE PACKAGE pkg_cadastro IS
  /*
    Package responsavel por realizar o processo de cadastro dos usuario
  Autor : Washington
  */
  PROCEDURE prc_cadastro_usuario(   p_nome_usuario   	IN "Usuarios"."Nome"%TYPE,
                                    p_senha_usuario  	IN "Usuarios"."Senha"%TYPE,
                                    p_cpf_usuario		IN "Usuarios"."Cpf"%TYPE,
                                    p_id_usuario        IN "EnderecoUsuarios"."UsuarioId"%TYPE,
                                    p_rua               IN "EnderecoUsuarios"."Rua"%TYPE,
                                    p_numero         	IN "EnderecoUsuarios"."Numero"%TYPE,
                                    p_bairro            IN "EnderecoUsuarios"."Bairro"%TYPE,
                                    p_complemento       IN "EnderecoUsuarios"."Complemento"%TYPE,
                                    p_estado            IN "EnderecoUsuarios"."Estado"%TYPE,
                                    p_cep               IN "EnderecoUsuarios"."Cep"%TYPE,
                                    p_cidade            IN "EnderecoUsuarios"."Cidade"%TYPE,
                                    p_ret_code     		OUT VARCHAR2,
                                    p_ret_msg      		OUT VARCHAR2);
                                    

END pkg_cadastro;
/

CREATE OR REPLACE PACKAGE BODY pkg_cadastro AS
  /*
    Package responsavel por realizar o processo de cadastro dos usuario
  Autor : Washington
  */
  PROCEDURE prc_cadastro_usuario(   p_nome_usuario   	IN "Usuarios"."Nome"%TYPE,
                                    p_senha_usuario  	IN "Usuarios"."Senha"%TYPE,
                                    p_cpf_usuario		IN "Usuarios"."Cpf"%TYPE,
                                    p_id_usuario        IN "EnderecoUsuarios"."UsuarioId"%TYPE,
                                    p_rua               IN "EnderecoUsuarios"."Rua"%TYPE,
                                    p_numero         	IN "EnderecoUsuarios"."Numero"%TYPE,
                                    p_bairro            IN "EnderecoUsuarios"."Bairro"%TYPE,
                                    p_complemento       IN "EnderecoUsuarios"."Complemento"%TYPE,
                                    p_estado            IN "EnderecoUsuarios"."Estado"%TYPE,
                                    p_cep               IN "EnderecoUsuarios"."Cep"%TYPE,
                                    p_cidade            IN "EnderecoUsuarios"."Cidade"%TYPE,
                                    p_ret_code     		OUT VARCHAR2,
                                    p_ret_msg      		OUT VARCHAR2) IS 
								 
   BEGIN
   
     -- valida se existe usuario
	   IF pkg_usuario.fnc_existe_usuario(p_cpf_usuario => p_cpf_usuario,
	                                     p_ret_code => p_ret_code,
			                             p_ret_msg => p_ret_msg) THEN
         RETURN;
       END IF;
	   
	   -- insere usuario
	   pkg_usuario.prc_insere_usuario(p_nome_usuario => p_nome_usuario,
									  p_cpf_usuario          => p_cpf_usuario,
									  p_senha_usuario        => p_senha_usuario,
									  p_ret_code     => p_ret_code,
									  p_ret_msg      => p_ret_msg);
	
       -- valida se o insert funcionou	
       IF p_ret_code <> '0' THEN
	     ROLLBACK;
	     RETURN;
	   END IF;
	   
	   
	  -- valida campos do endereco
	  IF NOT pkg_endereco.fnc_valida_campo_endereco( p_rua          => p_rua,
                                                     p_numero       => p_numero,
                                                     p_bairro       => p_bairro,
                                                     p_complemento  => p_complemento,
                                                     p_estado       => p_estado,
                                                     p_cep          => p_cep,
                                                     p_cidade       => p_cidade,
                                                     p_ret_code     => p_ret_code,
                                                     p_ret_msg      => p_ret_msg) THEN
	    RETURN;
      END IF;
	  	  
	  -- insere endereco
	  pkg_endereco.prc_insere_endereco( p_id_usuario   => p_id_usuario,
                                        p_rua          => p_rua,
                                        p_numero       => p_numero,
                                        p_bairro       => p_bairro,
                                        p_complemento  => p_complemento,
                                        p_estado       => p_estado,
                                        p_cep          => p_cep,
                                        p_cidade       => p_cidade,
                                        p_ret_code     => p_ret_code,
                                        p_ret_msg      => p_ret_msg);
	  
	  -- valida se o insert funcionou
	  IF p_ret_code <> '0' THEN
	     ROLLBACK;
	     RETURN;
	   END IF;
	  
	  COMMIT;
   
   END;

END pkg_cadastro;
/