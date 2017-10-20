CREATE OR REPLACE PACKAGE PKG_ENDERECO IS

/*
    Package responsavel por realizar o cadastro dos enderecos
  Autor : Washington
  */
  
  PROCEDURE prc_insere_endereco(  p_usuarioid       IN "EnderecoUsuarios"."UsuarioId"%TYPE,
                                  p_rua             IN "EnderecoUsuarios"."Rua"%TYPE,
                                  p_numero         	IN "EnderecoUsuarios"."Numero"%TYPE,
                                  p_bairro       	IN "EnderecoUsuarios"."Bairro"%TYPE,
                                  p_complemento     IN "EnderecoUsuarios"."Complemento"%TYPE,
                                  p_estado          IN "EnderecoUsuarios"."Estado"%TYPE,
                                  p_cep             IN "EnderecoUsuarios"."Cep"%TYPE,
                                  p_cidade          IN "EnderecoUsuarios"."Cidade"%TYPE,
                                  p_ret_code     	OUT VARCHAR2,
                                  p_ret_msg      	OUT VARCHAR2);

 FUNCTION fnc_valida_campo_endereco(  p_rua             IN "EnderecoUsuarios"."Rua"%TYPE,
                                      p_numero         	IN "EnderecoUsuarios"."Numero"%TYPE,
                                      p_bairro       	IN "EnderecoUsuarios"."Bairro"%TYPE,
                                      p_complemento     IN "EnderecoUsuarios"."Complemento"%TYPE,
                                      p_estado          IN "EnderecoUsuarios"."Estado"%TYPE,
                                      p_cep             IN "EnderecoUsuarios"."Cep"%TYPE,
                                      p_cidade          IN "EnderecoUsuarios"."Cidade"%TYPE,
                                      p_ret_code     	OUT VARCHAR2,
                                      p_ret_msg      	OUT VARCHAR2) RETURN BOOLEAN;
                               
END PKG_ENDERECO;
/

CREATE OR REPLACE PACKAGE BODY PKG_ENDERECO AS

  /*
    Package responsavel por realizar o cadastro dos usuario
  Autor : Washington
  */
  PROCEDURE prc_insere_endereco(  p_usuarioid       IN "EnderecoUsuarios"."UsuarioId"%TYPE,
                                  p_rua             IN "EnderecoUsuarios"."Rua"%TYPE,
                                  p_numero         	IN "EnderecoUsuarios"."Numero"%TYPE,
                                  p_bairro       	IN "EnderecoUsuarios"."Bairro"%TYPE,
                                  p_complemento     IN "EnderecoUsuarios"."Complemento"%TYPE,
                                  p_estado          IN "EnderecoUsuarios"."Estado"%TYPE,
                                  p_cep             IN "EnderecoUsuarios"."Cep"%TYPE,
                                  p_cidade          IN "EnderecoUsuarios"."Cidade"%TYPE,
                                  p_ret_code     	OUT VARCHAR2,
                                  p_ret_msg      	OUT VARCHAR2) IS
  
  BEGIN
    INSERT INTO "EnderecoUsuarios"
      ("UsuarioId", "Rua", "Numero", "Bairro", "Complemento", "Estado", "Cep", "Cidade")
    VALUES
      (p_usuarioid, p_rua, p_numero, p_bairro, p_complemento, p_estado, p_cep, p_cidade);
  
    p_ret_code := '0';
    p_ret_msg  := 'Sucesso';
  
  EXCEPTION
    WHEN OTHERS THEN
      p_ret_code := '-1';
      p_ret_msg  := 'Erro indeterminado na pkg_endereco.prc_insere_endereco ' ||
                    SQLERRM;
    
  END prc_insere_endereco;

  /*
    Package responsavel por realizar valida se existe usuario
  Autor : Washington
  */
  FUNCTION fnc_valida_campo_endereco(  p_rua            IN "EnderecoUsuarios"."Rua"%TYPE,
                                       p_numero         IN "EnderecoUsuarios"."Numero"%TYPE,
                                       p_bairro       	IN "EnderecoUsuarios"."Bairro"%TYPE,
                                       p_complemento    IN "EnderecoUsuarios"."Complemento"%TYPE,
                                       p_estado         IN "EnderecoUsuarios"."Estado"%TYPE,
                                       p_cep            IN "EnderecoUsuarios"."Cep"%TYPE,
                                       p_cidade         IN "EnderecoUsuarios"."Cidade"%TYPE,
                                       p_ret_code     	OUT VARCHAR2,
                                       p_ret_msg      	OUT VARCHAR2) RETURN BOOLEAN IS

  BEGIN
    IF p_rua IS NULL THEN
      p_ret_code := '-1';
      p_ret_msg  := 'Campo rua não informado' ;
      RETURN FALSE;
    END IF;
    IF p_numero IS NULL THEN
      p_ret_code := '-2';
      p_ret_msg  := 'Campo numero não informado' ;
      RETURN FALSE;
    END IF;
    IF p_bairro IS NULL THEN
      p_ret_code := '-3';
      p_ret_msg  := 'Campo bairro não informado' ;
      RETURN FALSE;
    END IF;
    IF p_complemento IS NULL THEN
      p_ret_code := '-4';
      p_ret_msg  := 'Campo complemento não informado' ;
      RETURN FALSE;
    END IF;
    IF p_estado IS NULL THEN
      p_ret_code := '-5';
      p_ret_msg  := 'Campo estado não informado' ;
      RETURN FALSE;
    END IF;
    IF p_cep IS NULL THEN
      p_ret_code := '-6';
      p_ret_msg  := 'Campo cep não informado' ;
      RETURN FALSE;
    END IF;
    IF p_cidade IS NULL THEN
      p_ret_code := '-7';
      p_ret_msg  := 'Campo cidade não informado' ;
      RETURN FALSE;
    END IF;  
  
    p_ret_code := '0';
    p_ret_msg  := 'Sucesso';
    RETURN TRUE;
  
  EXCEPTION
    WHEN OTHERS THEN
      p_ret_code := '-9';
      p_ret_msg  := 'Erro indeterminado na pkg_usuario.fnc_existe_usuario ' ||
                    SQLERRM;
      RETURN FALSE;
  END fnc_valida_campo_endereco;

END PKG_ENDERECO;
/