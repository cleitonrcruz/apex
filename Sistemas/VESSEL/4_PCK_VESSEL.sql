create or replace PACKAGE PCK_AUTENTICACAO AS  
/* 
  NOME              : PCK_VALIDACOES 
  DATA_CRIACAO      : 27/02/2024 
  CRIADO_POR        : ANDRE GOBI 
  ULTIMA_ATUALIZACAO: 27/02/2024 23:49 
  ESPECIFICACAO     : Package que contem os metodos de autenticacao utilizados pelo APEX 
*/ 
-- 
 C_SALT CONSTANT VARCHAR2(255) := 'UF\PSk¨VUT0NBTlRBUTIwMjQ='; 
-- 
 /*FUNCAO DE CALCULO DE HASH*/ 
 FUNCTION F_HASH (P_STRING IN VARCHAR2) RETURN VARCHAR2; 
  
 /*FUNCAO PARA VALIDAR SE SENHA ATENDE OS REQUISITOS MINIMOS DE SENHA*/ 
 FUNCTION F_VALIDA_SENHA(P_SENHA IN VARCHAR2) RETURN BOOLEAN; 
 /*FUNCAO QUE FAZ A AUTENTICACAO DO USUARIO DENTRO DO SISTEMA*/ 
 FUNCTION F_AUTENTICA_USUARIO (P_USERNAME IN VARCHAR2, P_PASSWORD IN VARCHAR2) RETURN BOOLEAN; 
 /*FUNCAO QUE GERA UMA SENHA ALEATORIA*/ 
 FUNCTION F_GERA_SENHA_ALEATORIA RETURN VARCHAR2; 
 /*FUNCAO PARA VALIDAR A PERMISSAO DO USUARIO*/ 
 FUNCTION F_VALIDA_PERMISSAO (P_USUARIO IN VARCHAR2, P_TIPO IN VARCHAR2, P_VALOR IN NUMBER, P_SOLUCAO IN NUMBER) RETURN BOOLEAN; 
  
 /*FUNCAO QUE RETORNA O PERFIL DO USUARIO (1- GESTOR / 2- CURADOR / 3- FABRICA DE SOFTWARE / 4- STAKEHOLDER)*/ 
 FUNCTION F_PERFIL_USUARIO (P_USUARIO IN VARCHAR2) RETURN NUMBER; 
  
 /*FUNCAO QUE RETORNA SE EXISTE VINCULO DE SOLUCAO COM USUARIO LOGADO*/ 
 FUNCTION F_USUARIO_SOLUCAO (P_ID_SOLUCAO IN NUMBER) RETURN NUMBER; 
-- 
 /*FUNCAO QUE RETORNA O ID DO USUARIO*/ 
 FUNCTION F_USUARIO RETURN NUMBER; 
 /**/ 
 FUNCTION F_NOME_USUARIO RETURN VARCHAR2; 
-- 
END; 
/
create or replace package "PCK_EMBARCACAO" as 
    PROCEDURE PRC_SALVAR_EMBARCACAO (P_COD_TEMP_EMBARCACAO IN NUMBER); 

    PROCEDURE PRC_COPIA_EMBARCACAO(
        p_cod_embarcacao IN NUMBER
    );
    -- 
    PROCEDURE PRC_EDITAR_EMBARCACAO(P_COD_EMBARCACAO      IN NUMBER 
                                 ,P_COD_TEMP_EMBARCACAO IN NUMBER DEFAULT NULL 
                                 ,PO_TEMP_EMBARCACAO   OUT NUMBER); 
    -- 
    PROCEDURE PRC_SALVAR_EMBARCACAO_NACIONAL (P_COD_TEMP_EMBARCACAO IN NUMBER); 
    -- 
    -- 
    PROCEDURE PRC_SALVAR_EMBARCACAO_ESTRANGEIRA(P_COD_TEMP_EMBARCACAO IN NUMBER); 
-- 
end "PCK_EMBARCACAO";
/
create or replace PACKAGE PCK_UTIL IS 
/* 
  NOME              : PCK_UTIL 
  DATA_CRIACAO      : 15/03/2024 
  CRIADO_POR        : ANDRE GOBI 
  ULTIMA_ATUALIZACAO: 15/03/2024 23:49 
  ESPECIFICACAO     : Package que contem utilidades ou funções sem vinculo com alguma entidade 
*/ 
-- 
 V_USUARIO_VALIDACAO VARCHAR2(255); 
-- 
 TYPE TP_STRING_ARRAY IS TABLE OF VARCHAR2(32767); 
-- 
 FUNCTION F_STRING_TO_ROWS (P_STRING   IN VARCHAR2 
                           ,P_CARACTER IN VARCHAR2) RETURN TP_STRING_ARRAY PIPELINED; 
 /**/ 
 FUNCTION F_DATA_SISTEMA RETURN VARCHAR2; 
 /**/ 
 FUNCTION F_HORA_SISTEMA RETURN VARCHAR2; 
 /**/ 
 FUNCTION GET_SYSDATE RETURN DATE; 
 /**/ 
 /**/ 
 FUNCTION GET_SYSTIMESTAMP RETURN TIMESTAMP; 
 /**/ 
 FUNCTION F_URL_COMENTARIO (P_APP_ID IN NUMBER, P_ID_PAGINA IN NUMBER, P_ID_ENTIDADE IN NUMBER, P_ID_COMENTARIO IN NUMBER) RETURN VARCHAR2; 
-- 
 /**/ 
 FUNCTION F_CALCULAR_DIAS_UTEIS(DATA_INICIO IN DATE,DATA_FIM IN DATE) RETURN NUMBER; 
 -- 
 FUNCTION F_MASK_CPF_CNPJ(P_DOCUMENTO IN VARCHAR2) RETURN VARCHAR2;  
 -- 
 FUNCTION F_VALIDA_CPF_CNPJ (P_CPF_CNPJ VARCHAR2) RETURN CHAR; 
 -- 
 FUNCTION F_CALCULA_HORA (P_TEMPO IN NUMBER) RETURN VARCHAR2; 
 -- 
 END; 
/
create or replace package PCK_VALIDACAO IS
/*
  NOME              : PCK_VALIDACOES
  DATA_CRIACAO      : 23/02/2024
  CRIADO_POR        : ANDRE GOBI
  ULTIMA_ATUALIZACAO: 23/02/2024 17:34
  ESPECIFICACAO     : Package que contem as validacoes utilizadas pelo APEX
*/
--
 FUNCTION F_VALIDA_EMAIL (P_EMAIL VARCHAR2) RETURN BOOLEAN;
 FUNCTION F_VALIDA_TELEFONE (P_TELEFONE IN VARCHAR2) RETURN BOOLEAN;
--
END PCK_VALIDACAO;
/
create or replace PACKAGE PCK_VALIDACAO_CADASTRO_EMBARCACAO AS

    procedure proc_valida_cadastro_estrangeira (
        p_cod_temp_embarcacao   in  number 
        , po_sucesso            out number 
        , po_body               out clob
        , po_body_optativo      out clob
    );

    procedure proc_valida_cadastro_nacional (
        p_cod_temp_embarcacao  in number
        , po_sucesso           out number
        , po_body              out clob
        , po_body_optativo     out clob
    );

    procedure proc_valida_cadastro_construcao (
        p_cod_temp_embarcacao  in number
        , po_sucesso           out number
        , po_body              out clob
        , po_body_optativo     out clob
    );

    procedure proc_valida_cadastro_reforma (
        p_cod_temp_embarcacao  in number
        , po_sucesso           out number
        , po_body              out clob
        , po_body_optativo     out clob
    );

    procedure proc_valida_cadastro_embarcacao (
        p_cod_temp_embarcacao   in  number 
        , po_sucesso            out number 
        , po_body               out clob
        , po_body_optativo      out clob
    );
END PCK_VALIDACAO_CADASTRO_EMBARCACAO;
/
create or replace PACKAGE PCK_VALIDACAO_CADASTRO_EMBARCACAO_1 AS 
-- 
 PROCEDURE PROC_VALIDA_CADASTRO_ESTRANGEIRA (P_COD_TEMP_EMBARCACAO IN NUMBER 
                                            ,PO_SUCESSO           OUT NUMBER 
                                            ,PO_BODY              OUT CLOB); 
-- 
END PCK_VALIDACAO_CADASTRO_EMBARCACAO_1;
/
create or replace PACKAGE BODY PCK_AUTENTICACAO AS 
-- 
 FUNCTION F_HASH (P_STRING IN VARCHAR2) RETURN VARCHAR2 IS 
-- 
 V_HASH VARCHAR2(255); 
-- 
 BEGIN 
  -- 
   V_HASH := UTL_RAW.CAST_TO_RAW( DBMS_OBFUSCATION_TOOLKIT.MD5(INPUT_STRING => SUBSTR(C_SALT, 9, 14) || P_STRING || SUBSTR(C_SALT, 4, 13))); 
  -- 
   RETURN V_HASH; 
  -- 
 END F_HASH; 
-- 
 FUNCTION F_VALIDA_SENHA(P_SENHA IN VARCHAR2) RETURN BOOLEAN IS 
--  
 V_TAMANHO       NUMBER; 
 V_TEM_MAIUSCULA BOOLEAN := FALSE; 
 V_TEM_NUMERO    BOOLEAN := FALSE; 
 V_TEM_ESPECIAL  BOOLEAN := FALSE; 
 V_CARACTERE     CHAR(1); 
-- 
 BEGIN 
  -- 
   V_TAMANHO := LENGTH(P_SENHA); 
  -- 
   IF V_TAMANHO < 8  
    THEN 
      -- 
       RETURN FALSE; 
   END IF; 
  -- 
   FOR I IN 1..V_TAMANHO LOOP 
    --  
     V_CARACTERE := SUBSTR(P_SENHA, I, 1); 
    --  
     IF ASCII(V_CARACTERE) BETWEEN ASCII('A') AND ASCII('Z')  
       THEN 
        -- 
         V_TEM_MAIUSCULA := TRUE; 
        -- 
     ELSIF ASCII(V_CARACTERE) BETWEEN ASCII('0') AND ASCII('9') 
       THEN 
        -- 
         V_TEM_NUMERO := TRUE; 
        -- 
     ELSIF REGEXP_LIKE(V_CARACTERE, '[[:punct:]]') 
       THEN 
        --  
         V_TEM_ESPECIAL := TRUE; 
        --   
     END IF; 
    --   
   END LOOP; 
  -- 
   RETURN V_TEM_MAIUSCULA AND V_TEM_NUMERO AND V_TEM_ESPECIAL; 
  --   
 END F_VALIDA_SENHA; 
-- 
 FUNCTION F_AUTENTICA_USUARIO (P_USERNAME IN VARCHAR2, P_PASSWORD IN VARCHAR2) RETURN BOOLEAN IS 
-- 
 V_EXISTE   NUMBER; 
 V_MENSAGEM VARCHAR2(255); 
-- 
 BEGIN 
  -- 
   SELECT COUNT(1) 
     INTO V_EXISTE 
     FROM USUARIO U 
    WHERE LOWER(U.EMAIL) = LOWER(P_USERNAME) 
      AND SENHA          = F_HASH(P_PASSWORD) 
      AND IND_ATIVO      = 'A'; 
  -- 
   IF V_EXISTE > 0 
    THEN 
      -- 
       APEX_UTIL.SET_AUTHENTICATION_RESULT(0); 
       RETURN TRUE; 
      -- 
    ELSE 
      -- 
       SELECT COUNT(*) 
         INTO V_EXISTE 
         FROM USUARIO U 
        WHERE LOWER(U.EMAIL) = LOWER(P_USERNAME) 
          AND U.IND_ATIVO = 'I'; 
      -- 
       IF V_EXISTE > 0 
        THEN 
          -- 
           V_MENSAGEM := 'Usuário está inativo no sistema.'; 
          -- 
        ELSE 
          -- 
           V_MENSAGEM := 'Usuário ou senha incorretos.'; 
          -- 
       END IF; 
      -- 
       APEX_UTIL.SET_AUTHENTICATION_RESULT(7); 
       APEX_UTIL.SET_CUSTOM_AUTH_STATUS(V_MENSAGEM); 
       RETURN FALSE; 
      -- 
   END IF; 
  -- 
 END  F_AUTENTICA_USUARIO; 
-- 
 FUNCTION F_GERA_SENHA_ALEATORIA RETURN VARCHAR2 IS 
--  
 V_SENHA VARCHAR2(12); 
-- 
 BEGIN 
  -- 
   V_SENHA := DBMS_RANDOM.STRING('U', 1) || DBMS_RANDOM.STRING('l', 1) || TRUNC(DBMS_RANDOM.VALUE(1, 10)) || '_' || DBMS_RANDOM.STRING('p', 4); 
  -- 
   V_SENHA := REPLACE(V_SENHA, '|', '/'); 
  -- 
   RETURN V_SENHA; 
  -- 
END F_GERA_SENHA_ALEATORIA; 
-- 
 FUNCTION F_VALIDA_PERMISSAO (P_USUARIO IN VARCHAR2, P_TIPO IN VARCHAR2, P_VALOR IN NUMBER, P_SOLUCAO IN NUMBER) RETURN BOOLEAN IS 
-- 
 /*TIPO: PF: PERFIL, PA: PAPEL, A: QLQR*/ 
-- 
 V_EXISTE NUMBER; 
-- 
 BEGIN 
   -- 
    IF P_TIPO IN ('PF', 'A') 
     THEN 
      -- 
       SELECT COUNT(*) 
         INTO V_EXISTE 
         FROM USUARIO U 
        WHERE LOWER(U.EMAIL) = LOWER(P_USUARIO) 
          AND PERFIL         = P_VALOR 
          AND ID_SOLUCAO     = P_SOLUCAO; 
      -- 
    ELSIF P_TIPO IN ('PA', 'A') 
     THEN 
      -- 
        SELECT COUNT(*) 
         INTO V_EXISTE 
         FROM USUARIO U 
        WHERE LOWER(U.EMAIL) = LOWER(P_USUARIO) 
          AND EXISTS (SELECT 1 
                        FROM USUARIO_SOLUCAO_PERMISSAO USP 
                       WHERE USP.ID_USUARIO = U.ID 
                         AND USP.ID_SOLUCAO = P_SOLUCAO 
                         AND USP.PAPEL      = P_VALOR); 
      -- 
    END IF; 
   -- 
    IF V_EXISTE > 0 
     THEN 
       -- 
        RETURN TRUE; 
       -- 
     ELSE 
       -- 
        RETURN FALSE; 
       -- 
    END IF; 
   -- 
 END F_VALIDA_PERMISSAO; 
-- 
 FUNCTION F_USUARIO RETURN NUMBER IS 
-- 
 V_ID USUARIO.ID%TYPE; 
-- 
 BEGIN 
   -- 
    SELECT ID 
      INTO V_ID 
      FROM USUARIO 
     WHERE LOWER(EMAIL) = LOWER(V('APP_USER')); 
   -- 
    RETURN V_ID; 
   -- 
 EXCEPTION 
  WHEN NO_DATA_FOUND 
    THEN  
      -- 
       RETURN NULL; 
      -- 
 END F_USUARIO; 
-- 
 FUNCTION F_PERFIL_USUARIO (P_USUARIO IN VARCHAR2) RETURN NUMBER IS 
 /*(1- GESTOR / 2- CURADOR / 3- FABRICA DE SOFTWARE / 4- STAKEHOLDER)*/ 
-- 
 V_PERFIL NUMBER; 
-- 
 BEGIN 
   -- 
    SELECT PERFIL 
      INTO V_PERFIL 
      FROM USUARIO 
     WHERE LOWER(EMAIL) = LOWER(P_USUARIO); 
   -- 
    RETURN V_PERFIL; 
   -- 
 END F_PERFIL_USUARIO; 
-- 
 FUNCTION F_USUARIO_SOLUCAO (P_ID_SOLUCAO IN NUMBER) RETURN NUMBER IS 
-- 
 V_EXISTE NUMBER; 
-- 
 BEGIN 
   -- 
    SELECT COUNT(1) 
      INTO V_EXISTE 
      FROM USUARIO U 
       ,   SOLUCAO S 
     WHERE U.ID_SOLUCAO   = S.ID 
       AND LOWER(U.EMAIL) = LOWER(V('APP_USER')) 
       AND S.ID           = P_ID_SOLUCAO; 
   -- 
    IF V_EXISTE = 0 
     THEN 
       -- 
        SELECT COUNT(1) 
          INTO V_EXISTE 
          FROM USUARIO U 
            ,  USUARIO_SOLUCAO_PERMISSAO US 
         WHERE U.ID            = US.ID_USUARIO 
           AND LOWER(U.EMAIL)  = LOWER(V('APP_USER')) 
           AND US.ID_SOLUCAO   = P_ID_SOLUCAO;  
       -- 
    END IF; 
   -- 
    RETURN V_EXISTE; 
   -- 
 END F_USUARIO_SOLUCAO; 
-- 
 FUNCTION F_NOME_USUARIO RETURN VARCHAR2 IS 
-- 
 V_NOME USUARIO.NOME%TYPE; 
-- 
 BEGIN 
   -- 
    SELECT NOME 
      INTO V_NOME 
      FROM USUARIO 
     WHERE LOWER(EMAIL) = LOWER(V('APP_USER')); 
   -- 
    RETURN V_NOME; 
   -- 
 EXCEPTION 
  WHEN NO_DATA_FOUND 
    THEN  
      -- 
       RETURN NULL; 
      -- 
 END F_NOME_USUARIO; 
-- 
END; 
/
create or replace package body "PCK_EMBARCACAO" as 

    procedure prc_salvar_embarcacao (
        p_cod_temp_embarcacao   in  number 
    ) is
        v_nacionalidade varchar2(1);
        v_tipo_servico  varchar2(1);
    begin
        select nacionalidade, tipo_servico
            into v_nacionalidade, v_tipo_servico
        from temp_embarcacao
        where cod_embarcacao = p_cod_temp_embarcacao;

        if v_tipo_servico = 'O' then
            if v_nacionalidade = 'E' then
                prc_salvar_embarcacao_estrangeira (
                    p_cod_temp_embarcacao   => p_cod_temp_embarcacao
                );
            elsif v_nacionalidade = 'N' then
                prc_salvar_embarcacao_nacional (
                    p_cod_temp_embarcacao  => p_cod_temp_embarcacao
                );
            end if;
        else
            -- em construção e em reforma
            null;
        end if;
        
    end prc_salvar_embarcacao;

    -- --------------------------------
    -- 
    -- --------------------------------
    PROCEDURE PRC_COPIA_EMBARCACAO(
        p_cod_embarcacao IN NUMBER
    )
    IS
        CURSOR CUR_ARQUIVOS IS 
        SELECT * 
        FROM TEMP_EMBARCACAO_DOCUMENTO 
        WHERE COD_EMBARCACAO = p_cod_embarcacao; 

        CURSOR CUR_EMBARCACAO_VISTORIA IS 
        SELECT * 
        FROM TEMP_EMBARCACAO_VISTORIA 
        WHERE COD_EMBARCACAO = p_cod_embarcacao; 

        CURSOR CUR_TIPO_CARGA IS 
        SELECT * 
        FROM TEMP_EMBARCACAO_TIPO_CARGA 
        WHERE COD_TEMP_EMBARCACAO = p_cod_embarcacao; 

        CURSOR CUR_EMBARCACAO IS 
        SELECT * 
        FROM TEMP_EMBARCACAO 
        WHERE COD_EMBARCACAO = p_cod_embarcacao;

        te     CUR_EMBARCACAO%ROWTYPE; 
        v_cod_embarcacao number;
    BEGIN
        OPEN CUR_EMBARCACAO; 
        FETCH CUR_EMBARCACAO INTO te; 
        CLOSE CUR_EMBARCACAO; 

        -- Atualiza registros existentes em EMBARCACAO com base em TEMP_EMBARCACAO
        UPDATE EMBARCACAO e
        SET e.NACIONALIDADE               = te.NACIONALIDADE
        , e.IND_ARQUEACAO_BRUTA           = te.IND_ARQUEACAO_BRUTA
        , e.NUM_INSCRICAO                 = te.NUM_INSCRICAO
        , e.NUM_IMO                       = te.NUM_IMO
        , e.NOME                          = te.NOME
        , e.BANDEIRA_ORIGEM               = te.BANDEIRA_ORIGEM
        , e.BANDEIRA_ATUAL                = te.BANDEIRA_ATUAL
        , e.IND_NUM_IRIN                  = te.IND_NUM_IRIN
        , e.NUM_PRPM                      = te.NUM_PRPM
        , e.NUM_TIE                       = te.NUM_TIE
        , e.NUM_DPP                       = te.NUM_DPP
        , e.NUM_PROTOCOLO_INSCRICAO       = te.NUM_PROTOCOLO_INSCRICAO
        , e.NUM_INSCRICAO_PROVISORIA      = te.NUM_INSCRICAO_PROVISORIA
        , e.NUM_REB                       = te.NUM_REB
        , e.TIPO_NAVEGACAO                = te.TIPO_NAVEGACAO
        , e.AREA_NAVEGACAO                = te.AREA_NAVEGACAO
        , e.NATUREZA_TIPO_CARGA           = te.NATUREZA_TIPO_CARGA
        , e.TIPO_EMBARCACAO               = te.TIPO_EMBARCACAO
        , e.CLASSE_EMBARCACAO             = te.CLASSE_EMBARCACAO
        , e.SITUACAO                      = te.SITUACAO
        , e.ANO_EMBARCACAO                = te.ANO_EMBARCACAO
        , e.MATERIAL_CASCO                = te.MATERIAL_CASCO
        , e.TIPO_PROPULSAO                = te.TIPO_PROPULSAO
        , e.NUM_BHP                       = te.NUM_BHP
        , e.QTD_MOTOR                     = te.QTD_MOTOR
        , e.VALOR_ARQUEACAO_BRUTA         = te.VALOR_ARQUEACAO_BRUTA
        , e.VALOR_ARQUEACAO_LIQUIDA       = te.VALOR_ARQUEACAO_LIQUIDA
        , e.VALOR_TPB                     = te.VALOR_TPB
        , e.COMPRIMENTO_EMBARCACAO        = te.COMPRIMENTO_EMBARCACAO
        , e.COMPRIMENTO_BOCA              = te.COMPRIMENTO_BOCA
        , e.COMPRIMENTO_CALADO            = te.COMPRIMENTO_CALADO
        , e.VALOR_VELOCIDADE              = te.VALOR_VELOCIDADE
        , e.VALOR_CAPACIDADE              = te.VALOR_CAPACIDADE
        , e.IND_CAPACIDADE_CARGA          = te.IND_CAPACIDADE_CARGA
        , e.VALOR_CAPACIDADE_VEICULO      = te.VALOR_CAPACIDADE_VEICULO
        , e.VALOR_CAPACIDADE_TEUS         = te.VALOR_CAPACIDADE_TEUS
        , e.VALOR_CAPACIDADE_PASSAGEIROS  = te.VALOR_CAPACIDADE_PASSAGEIROS
        , e.SITUACAO_CADASTRAL            = te.SITUACAO_CADASTRAL
        , e.NUM_IRIN                      = te.NUM_IRIN
        , e.DOCUMENTO_PROPRIEDADE         = te.DOCUMENTO_PROPRIEDADE
        , e.PROCESSADO                    = te.PROCESSADO
        , e.USUARIO                       = te.USUARIO
        , e.DATA_CADASTRO                 = te.DATA_CADASTRO
        , e.DATA_ULTIMA_ATUALIZACAO       = te.DATA_ULTIMA_ATUALIZACAO
        , e.PAGINA_ETAPA                  = te.PAGINA_ETAPA
        , e.SITUACAO_REGISTRO             = te.SITUACAO_REGISTRO
        , e.CODIGO_EMBARCACAO_ATIVO       = te.CODIGO_EMBARCACAO_ATIVO
        , e.NUM_CASCO                     = te.NUM_CASCO
        , e.FINALIDADE_EMBARCACAO         = te.FINALIDADE_EMBARCACAO
        , e.CNPJ_ESTALEIRO                = te.CNPJ_ESTALEIRO
        , e.TIPO_SERVICO                  = te.TIPO_SERVICO
        , e.QUAL_ONUS                     = te.QUAL_ONUS
        , e.POSSUI_ONUS                   = te.POSSUI_ONUS
        , e.RAZAO_SOCIAL_PROPRIETARIO     = te.RAZAO_SOCIAL_PROPRIETARIO
        WHERE COD_EMBARCACAO                 = te.CODIGO_EMBARCACAO_ATIVO;

        IF SQL%ROWCOUNT = 0 THEN 

            v_cod_embarcacao := EMBARCACAO_SEQ.NEXTVAL;
            te.CODIGO_EMBARCACAO_ATIVO := v_cod_embarcacao;
        
            -- Insere registro na EMBARCACAO se não existir para o COD_EMBARCACAO passado
            INSERT INTO EMBARCACAO (
                  COD_EMBARCACAO                  , NACIONALIDADE
                , IND_ARQUEACAO_BRUTA             , NUM_INSCRICAO
                , NUM_IMO                         , NOME
                , BANDEIRA_ORIGEM                 , BANDEIRA_ATUAL
                , IND_NUM_IRIN                    , NUM_PRPM
                , NUM_TIE                         , NUM_DPP
                , NUM_PROTOCOLO_INSCRICAO         , NUM_INSCRICAO_PROVISORIA
                , NUM_REB                         , TIPO_NAVEGACAO
                , AREA_NAVEGACAO                  , NATUREZA_TIPO_CARGA
                , TIPO_EMBARCACAO                 , CLASSE_EMBARCACAO
                , SITUACAO                        , ANO_EMBARCACAO
                , MATERIAL_CASCO                  , TIPO_PROPULSAO
                , NUM_BHP                         , QTD_MOTOR
                , VALOR_ARQUEACAO_BRUTA           , VALOR_ARQUEACAO_LIQUIDA
                , VALOR_TPB                       , COMPRIMENTO_EMBARCACAO
                , COMPRIMENTO_BOCA                , COMPRIMENTO_CALADO
                , VALOR_VELOCIDADE                , VALOR_CAPACIDADE
                , IND_CAPACIDADE_CARGA            , VALOR_CAPACIDADE_VEICULO
                , VALOR_CAPACIDADE_TEUS           , VALOR_CAPACIDADE_PASSAGEIROS
                , SITUACAO_CADASTRAL              , NUM_IRIN
                , DOCUMENTO_PROPRIEDADE           , PROCESSADO
                , USUARIO                         , DATA_CADASTRO
                , DATA_ULTIMA_ATUALIZACAO         , PAGINA_ETAPA
                , SITUACAO_REGISTRO               , CODIGO_EMBARCACAO_ATIVO
                , NUM_CASCO                       , FINALIDADE_EMBARCACAO
                , CNPJ_ESTALEIRO                  , TIPO_SERVICO
                , QUAL_ONUS                       , RAZAO_SOCIAL_PROPRIETARIO
                , POSSUI_ONUS
            )
            SELECT 
                  v_cod_embarcacao                , NACIONALIDADE
                , IND_ARQUEACAO_BRUTA             , NUM_INSCRICAO
                , NUM_IMO                         , NOME
                , BANDEIRA_ORIGEM                 , BANDEIRA_ATUAL
                , IND_NUM_IRIN                    , NUM_PRPM
                , NUM_TIE                         , NUM_DPP
                , NUM_PROTOCOLO_INSCRICAO         , NUM_INSCRICAO_PROVISORIA
                , NUM_REB                         , TIPO_NAVEGACAO
                , AREA_NAVEGACAO                  , NATUREZA_TIPO_CARGA
                , TIPO_EMBARCACAO                 , CLASSE_EMBARCACAO
                , SITUACAO                        , ANO_EMBARCACAO
                , MATERIAL_CASCO                  , TIPO_PROPULSAO
                , NUM_BHP                         , QTD_MOTOR
                , VALOR_ARQUEACAO_BRUTA           , VALOR_ARQUEACAO_LIQUIDA
                , VALOR_TPB                       , COMPRIMENTO_EMBARCACAO
                , COMPRIMENTO_BOCA                , COMPRIMENTO_CALADO
                , VALOR_VELOCIDADE                , VALOR_CAPACIDADE
                , IND_CAPACIDADE_CARGA            , VALOR_CAPACIDADE_VEICULO
                , VALOR_CAPACIDADE_TEUS           , VALOR_CAPACIDADE_PASSAGEIROS
                , SITUACAO_CADASTRAL              , NUM_IRIN
                , DOCUMENTO_PROPRIEDADE           , PROCESSADO
                , USUARIO                         , DATA_CADASTRO
                , DATA_ULTIMA_ATUALIZACAO         , PAGINA_ETAPA
                , SITUACAO_REGISTRO               , CODIGO_EMBARCACAO_ATIVO
                , NUM_CASCO                       , FINALIDADE_EMBARCACAO
                , CNPJ_ESTALEIRO                  , TIPO_SERVICO
                , QUAL_ONUS                       , RAZAO_SOCIAL_PROPRIETARIO
                , POSSUI_ONUS
            FROM TEMP_EMBARCACAO te
            WHERE te.COD_EMBARCACAO = p_cod_embarcacao
            AND NOT EXISTS (
                SELECT 1 FROM EMBARCACAO e WHERE e.COD_EMBARCACAO = te.COD_EMBARCACAO
            );

        end if;
        
        /*ARQUIVOS*/ 
        -- 
        DELETE  
        FROM EMBARCACAO_DOCUMENTO 
        WHERE COD_EMBARCACAO = te.CODIGO_EMBARCACAO_ATIVO; 
        -- 
        FOR X IN CUR_ARQUIVOS 
        LOOP 
            INSERT INTO EMBARCACAO_DOCUMENTO (
                COD_EMBARCACAO_DOCUMENTO 
                , COD_EMBARCACAO 
                , IND_TIPO_DOCUMENTO 
                , NOME_ARQUIVO 
                , MIME_TYPE 
                , ARQUIVO 
                , DATA_VALIDADE 
                , TIPO
                , NUMERO
            ) VALUES (
                X.COD_EMBARCACAO_DOCUMENTO 
                ,te.CODIGO_EMBARCACAO_ATIVO 
                ,X.IND_TIPO_DOCUMENTO 
                ,X.NOME_ARQUIVO 
                ,X.MIME_TYPE 
                ,X.ARQUIVO 
                ,X.DATA_VALIDADE 
                ,X.TIPO
                ,X.NUMERO
            );  
        -- 
        END LOOP; 
        -- 

        /*TEMP_EMBARCACAO_TIPO_CARGA*/ 
        DELETE  
        FROM EMBARCACAO_TIPO_CARGA 
        WHERE COD_EMBARCACAO = te.CODIGO_EMBARCACAO_ATIVO; 
        -- 
        FOR X IN CUR_TIPO_CARGA 
        LOOP 
            INSERT INTO EMBARCACAO_TIPO_CARGA (
                COD_EMBARCACAO_TIPO_CARGA 
                , COD_EMBARCACAO 
                , COD_TIPO_CARGA 
                , CAPACIDADE 
            ) VALUES (
                X.COD_EMBARCACAO_TIPO_CARGA 
                ,te.CODIGO_EMBARCACAO_ATIVO 
                ,X.COD_TIPO_CARGA 
                ,X.CAPACIDADE 
            );  
        -- 
        END LOOP; 

        --
        /*TEMP_EMBARCACAO_VISTORIA*/ 
        DELETE  
        FROM EMBARCACAO_VISTORIA 
        WHERE COD_EMBARCACAO = te.CODIGO_EMBARCACAO_ATIVO; 
        
        FOR X IN CUR_EMBARCACAO_VISTORIA 
        LOOP 
            INSERT INTO EMBARCACAO_VISTORIA (
                COD_EMBARCACAO_VISTORIA 
                , COD_EMBARCACAO 
                , NUM_VISTORIA 
                , DATA_LANCAMENTO
                , DATA_VENCIMENTO 
            ) VALUES (
                X.COD_EMBARCACAO_VISTORIA 
                ,te.CODIGO_EMBARCACAO_ATIVO 
                ,X.NUM_VISTORIA 
                ,X.DATA_LANCAMENTO 
                ,X.DATA_VENCIMENTO 
            );  
        -- 
        END LOOP; 
        

        /*APAGA OS DADOS TEMPORARIOS*/ 
        DELETE  
        FROM TEMP_EMBARCACAO_DOCUMENTO 
        WHERE COD_EMBARCACAO = p_cod_embarcacao; 
        -- 
        DELETE  
        FROM TEMP_EMBARCACAO_TIPO_CARGA 
        WHERE COD_TEMP_EMBARCACAO = p_cod_embarcacao;
        --
        DELETE  
        FROM TEMP_EMBARCACAO_VISTORIA 
        WHERE COD_EMBARCACAO = p_cod_embarcacao;
        --
        DELETE  
        FROM TEMP_EMBARCACAO 
        WHERE COD_EMBARCACAO = p_cod_embarcacao;        
        
    END;
    

    -- 
    PROCEDURE PRC_SALVAR_EMBARCACAO_NACIONAL (P_COD_TEMP_EMBARCACAO IN NUMBER) IS 
        -- 
        CURSOR CUR_ARQUIVOS IS 
        SELECT * 
        FROM TEMP_EMBARCACAO_DOCUMENTO 
        WHERE COD_EMBARCACAO = P_COD_TEMP_EMBARCACAO; 
        -- 
        CURSOR CUR_EMBARCACAO IS 
        SELECT * 
        FROM TEMP_EMBARCACAO 
        WHERE COD_EMBARCACAO = P_COD_TEMP_EMBARCACAO; 
        -- 
        V_EMBARCACAO     CUR_EMBARCACAO%ROWTYPE; 
        -- 
    BEGIN 
        -- 
        OPEN CUR_EMBARCACAO; 
        FETCH CUR_EMBARCACAO INTO V_EMBARCACAO; 
        CLOSE CUR_EMBARCACAO; 
        -- 
        UPDATE EMBARCACAO 
        --ETAPA 1 
        SET NACIONALIDADE               = V_EMBARCACAO.NACIONALIDADE 
        ,  IND_ARQUEACAO_BRUTA          = V_EMBARCACAO.IND_ARQUEACAO_BRUTA 
        --ETAPA 2  
        ,  NUM_INSCRICAO                = V_EMBARCACAO.NUM_INSCRICAO 
        ,  NUM_IMO                      = V_EMBARCACAO.NUM_IMO 
        ,  NOME                         = V_EMBARCACAO.NOME 
        ,  DOCUMENTO_PROPRIEDADE        = V_EMBARCACAO.DOCUMENTO_PROPRIEDADE 
        ,  BANDEIRA_ORIGEM              = V_EMBARCACAO.BANDEIRA_ORIGEM 
        ,  BANDEIRA_ATUAL               = V_EMBARCACAO.BANDEIRA_ATUAL 
        ,  IND_NUM_IRIN                 = V_EMBARCACAO.IND_NUM_IRIN 
        ,  NUM_IRIN                     = V_EMBARCACAO.NUM_IRIN 
        ,  NUM_PRPM                     = V_EMBARCACAO.NUM_PRPM 
        ,  NUM_TIE                      = V_EMBARCACAO.NUM_TIE 
        ,  NUM_DPP                      = V_EMBARCACAO.NUM_DPP 
        ,  NUM_PROTOCOLO_INSCRICAO      = V_EMBARCACAO.NUM_PROTOCOLO_INSCRICAO 
        ,  NUM_INSCRICAO_PROVISORIA     = V_EMBARCACAO.NUM_INSCRICAO_PROVISORIA 
        ,  NUM_REB                      = V_EMBARCACAO.NUM_REB 
        --ETAPA 3 
        ,  TIPO_NAVEGACAO               = V_EMBARCACAO.TIPO_NAVEGACAO 
        ,  AREA_NAVEGACAO               = V_EMBARCACAO.AREA_NAVEGACAO 
        ,  NATUREZA_TIPO_CARGA          = V_EMBARCACAO.NATUREZA_TIPO_CARGA 
        --ETAPA 4 
        ,  TIPO_EMBARCACAO              = V_EMBARCACAO.TIPO_EMBARCACAO 
        ,  CLASSE_EMBARCACAO            = V_EMBARCACAO.CLASSE_EMBARCACAO 
        ,  SITUACAO                     = V_EMBARCACAO.SITUACAO 
        ,  ANO_EMBARCACAO               = V_EMBARCACAO.ANO_EMBARCACAO 
        ,  MATERIAL_CASCO               = V_EMBARCACAO.MATERIAL_CASCO 
        ,  TIPO_PROPULSAO               = V_EMBARCACAO.TIPO_PROPULSAO 
        ,  NUM_BHP                      = V_EMBARCACAO.NUM_BHP 
        ,  QTD_MOTOR                    = V_EMBARCACAO.QTD_MOTOR 
        ,  VALOR_ARQUEACAO_BRUTA        = V_EMBARCACAO.VALOR_ARQUEACAO_BRUTA 
        ,  VALOR_ARQUEACAO_LIQUIDA      = V_EMBARCACAO.VALOR_ARQUEACAO_LIQUIDA 
        ,  VALOR_TPB                    = V_EMBARCACAO.VALOR_TPB 
        ,  COMPRIMENTO_EMBARCACAO       = V_EMBARCACAO.COMPRIMENTO_EMBARCACAO 
        ,  COMPRIMENTO_BOCA             = V_EMBARCACAO.COMPRIMENTO_BOCA 
        ,  COMPRIMENTO_CALADO           = V_EMBARCACAO.COMPRIMENTO_CALADO 
        ,  VALOR_VELOCIDADE             = V_EMBARCACAO.VALOR_VELOCIDADE 
        ,  VALOR_CAPACIDADE             = V_EMBARCACAO.VALOR_CAPACIDADE 
        ,  IND_CAPACIDADE_CARGA         = V_EMBARCACAO.IND_CAPACIDADE_CARGA 
        ,  VALOR_CAPACIDADE_VEICULO     = V_EMBARCACAO.VALOR_CAPACIDADE_VEICULO 
        ,  VALOR_CAPACIDADE_TEUS        = V_EMBARCACAO.VALOR_CAPACIDADE_TEUS 
        ,  VALOR_CAPACIDADE_PASSAGEIROS = V_EMBARCACAO.VALOR_CAPACIDADE_PASSAGEIROS 
        WHERE COD_EMBARCACAO               = V_EMBARCACAO.CODIGO_EMBARCACAO_ATIVO; 

        IF SQL%ROWCOUNT = 0 THEN 
            -- 
            INSERT INTO EMBARCACAO(
                COD_EMBARCACAO 
                , NACIONALIDADE 
                , IND_ARQUEACAO_BRUTA 
                --ETAPA 2  
                , NUM_INSCRICAO 
                , NUM_IMO 
                , NOME 
                , DOCUMENTO_PROPRIEDADE 
                , BANDEIRA_ORIGEM 
                , BANDEIRA_ATUAL 
                , IND_NUM_IRIN 
                , NUM_IRIN 
                , NUM_PRPM 
                , NUM_TIE 
                , NUM_DPP 
                , NUM_PROTOCOLO_INSCRICAO 
                , NUM_INSCRICAO_PROVISORIA 
                , NUM_REB 
                --ETAPA 3 
                , TIPO_NAVEGACAO 
                , AREA_NAVEGACAO 
                , NATUREZA_TIPO_CARGA 
                --ETAPA 4 
                , TIPO_EMBARCACAO 
                , CLASSE_EMBARCACAO 
                , SITUACAO 
                , ANO_EMBARCACAO 
                , MATERIAL_CASCO 
                , TIPO_PROPULSAO 
                , NUM_BHP 
                , QTD_MOTOR 
                , VALOR_ARQUEACAO_BRUTA 
                , VALOR_ARQUEACAO_LIQUIDA 
                , VALOR_TPB 
                , COMPRIMENTO_EMBARCACAO 
                , COMPRIMENTO_BOCA 
                , COMPRIMENTO_CALADO 
                , VALOR_VELOCIDADE 
                , VALOR_CAPACIDADE 
                , IND_CAPACIDADE_CARGA 
                , VALOR_CAPACIDADE_VEICULO 
                , VALOR_CAPACIDADE_TEUS 
                , VALOR_CAPACIDADE_PASSAGEIROS
                , USUARIO
            ) VALUES (
                EMBARCACAO_SEQ.NEXTVAL 
                , V_EMBARCACAO.NACIONALIDADE 
                , V_EMBARCACAO.IND_ARQUEACAO_BRUTA 
                --ETAPA 2  
                , V_EMBARCACAO.NUM_INSCRICAO 
                , V_EMBARCACAO.NUM_IMO 
                , V_EMBARCACAO.NOME 
                , V_EMBARCACAO.DOCUMENTO_PROPRIEDADE 
                , V_EMBARCACAO.BANDEIRA_ORIGEM 
                , V_EMBARCACAO.BANDEIRA_ATUAL 
                , V_EMBARCACAO.IND_NUM_IRIN 
                , V_EMBARCACAO.NUM_IRIN 
                , V_EMBARCACAO.NUM_PRPM 
                , V_EMBARCACAO.NUM_TIE 
                , V_EMBARCACAO.NUM_DPP 
                , V_EMBARCACAO.NUM_PROTOCOLO_INSCRICAO 
                , V_EMBARCACAO.NUM_INSCRICAO_PROVISORIA 
                , V_EMBARCACAO.NUM_REB 
                --ETAPA 3 
                , V_EMBARCACAO.TIPO_NAVEGACAO 
                , V_EMBARCACAO.AREA_NAVEGACAO 
                , V_EMBARCACAO.NATUREZA_TIPO_CARGA 
                --ETAPA 4 
                , V_EMBARCACAO.TIPO_EMBARCACAO 
                , V_EMBARCACAO.CLASSE_EMBARCACAO 
                , V_EMBARCACAO.SITUACAO 
                , V_EMBARCACAO.ANO_EMBARCACAO 
                , V_EMBARCACAO.MATERIAL_CASCO 
                , V_EMBARCACAO.TIPO_PROPULSAO 
                , V_EMBARCACAO.NUM_BHP 
                , V_EMBARCACAO.QTD_MOTOR 
                , V_EMBARCACAO.VALOR_ARQUEACAO_BRUTA 
                , V_EMBARCACAO.VALOR_ARQUEACAO_LIQUIDA 
                , V_EMBARCACAO.VALOR_TPB 
                , V_EMBARCACAO.COMPRIMENTO_EMBARCACAO 
                , V_EMBARCACAO.COMPRIMENTO_BOCA 
                , V_EMBARCACAO.COMPRIMENTO_CALADO 
                , V_EMBARCACAO.VALOR_VELOCIDADE 
                , V_EMBARCACAO.VALOR_CAPACIDADE 
                , V_EMBARCACAO.IND_CAPACIDADE_CARGA 
                , V_EMBARCACAO.VALOR_CAPACIDADE_VEICULO 
                , V_EMBARCACAO.VALOR_CAPACIDADE_TEUS 
                , V_EMBARCACAO.VALOR_CAPACIDADE_PASSAGEIROS
                , V('APP_USER')
            ) RETURNING COD_EMBARCACAO INTO V_EMBARCACAO.CODIGO_EMBARCACAO_ATIVO; 
           -- 
        END IF; 
        -- 
        /*ARQUIVOS*/ 
        -- 
        DELETE  
        FROM EMBARCACAO_DOCUMENTO 
        WHERE COD_EMBARCACAO = V_EMBARCACAO.CODIGO_EMBARCACAO_ATIVO; 
        -- 
        FOR X IN CUR_ARQUIVOS 
        LOOP 
            INSERT INTO EMBARCACAO_DOCUMENTO (
                COD_EMBARCACAO_DOCUMENTO 
                , COD_EMBARCACAO 
                , IND_TIPO_DOCUMENTO 
                , NOME_ARQUIVO 
                , MIME_TYPE 
                , ARQUIVO 
                , DATA_VALIDADE 
                , TIPO
                , NUMERO
            ) VALUES (
                X.COD_EMBARCACAO_DOCUMENTO 
                ,V_EMBARCACAO.CODIGO_EMBARCACAO_ATIVO 
                ,X.IND_TIPO_DOCUMENTO 
                ,X.NOME_ARQUIVO 
                ,X.MIME_TYPE 
                ,X.ARQUIVO 
                ,X.DATA_VALIDADE 
                ,X.TIPO
                ,X.NUMERO
            );  
        -- 
        END LOOP; 
        -- 
        /*APAGA OS DADOS TEMPORARIOS*/ 
        DELETE  
        FROM TEMP_EMBARCACAO_DOCUMENTO 
        WHERE COD_EMBARCACAO = P_COD_TEMP_EMBARCACAO; 
        -- 
        DELETE  
        FROM TEMP_EMBARCACAO 
        WHERE COD_EMBARCACAO = P_COD_TEMP_EMBARCACAO; 
    -- 
    END PRC_SALVAR_EMBARCACAO_NACIONAL; 

-- ----------------------
-- PRC_SALVAR_EMBARCACAO_ESTRANGEIRA
-- ----------------------

 PROCEDURE PRC_SALVAR_EMBARCACAO_ESTRANGEIRA (P_COD_TEMP_EMBARCACAO IN NUMBER) IS 
-- 
 CURSOR CUR_ARQUIVOS IS 
 SELECT * 
   FROM TEMP_EMBARCACAO_DOCUMENTO 
  WHERE COD_EMBARCACAO = P_COD_TEMP_EMBARCACAO; 
-- 
 CURSOR CUR_EMBARCACAO IS 
 SELECT * 
   FROM TEMP_EMBARCACAO 
  WHERE COD_EMBARCACAO = P_COD_TEMP_EMBARCACAO; 
-- 
 V_EMBARCACAO CUR_EMBARCACAO%ROWTYPE; 
-- 
 BEGIN 
   -- 
    OPEN CUR_EMBARCACAO; 
    FETCH CUR_EMBARCACAO INTO V_EMBARCACAO; 
    CLOSE CUR_EMBARCACAO; 
   -- 
    UPDATE EMBARCACAO 
       SET 
       --ETAPA 1 
           NACIONALIDADE                = V_EMBARCACAO.NACIONALIDADE 
        ,  NUM_CASCO                    = V_EMBARCACAO.NUM_CASCO
        ,  NUM_INSCRICAO                = V_EMBARCACAO.NUM_INSCRICAO
        ,  FINALIDADE_EMBARCACAO        = V_EMBARCACAO.FINALIDADE_EMBARCACAO
        ,  DOCUMENTO_PROPRIEDADE        = V_EMBARCACAO.DOCUMENTO_PROPRIEDADE
        ,  CNPJ_ESTALEIRO               = V_EMBARCACAO.CNPJ_ESTALEIRO        
       --ETAPA 2  
        ,  NUM_IMO                      = V_EMBARCACAO.NUM_IMO 
        ,  NOME                         = V_EMBARCACAO.NOME 
        ,  NUM_IRIN                     = V_EMBARCACAO.NUM_IRIN 
        ,  BANDEIRA_ATUAL               = V_EMBARCACAO.BANDEIRA_ATUAL 
        ,  BANDEIRA_ORIGEM              = V_EMBARCACAO.BANDEIRA_ORIGEM 
        -- verificar (Acredito que sejam campos exclusivos da Nacional)
        ,  IND_NUM_IRIN                 = V_EMBARCACAO.IND_NUM_IRIN        
        ,  NUM_PRPM                     = V_EMBARCACAO.NUM_PRPM 
        ,  NUM_TIE                      = V_EMBARCACAO.NUM_TIE 
        ,  NUM_DPP                      = V_EMBARCACAO.NUM_DPP 
        ,  NUM_PROTOCOLO_INSCRICAO      = V_EMBARCACAO.NUM_PROTOCOLO_INSCRICAO 
        ,  NUM_INSCRICAO_PROVISORIA     = V_EMBARCACAO.NUM_INSCRICAO_PROVISORIA 
        ,  NUM_REB                      = V_EMBARCACAO.NUM_REB     
        -- verificar (Acredito que sejam campos exclusivos da Nacional)
       --ETAPA 3 
        ,  TIPO_EMBARCACAO              = V_EMBARCACAO.TIPO_EMBARCACAO 
        ,  CLASSE_EMBARCACAO            = V_EMBARCACAO.CLASSE_EMBARCACAO 
        ,  SITUACAO                     = V_EMBARCACAO.SITUACAO
        ,  ANO_EMBARCACAO               = V_EMBARCACAO.ANO_EMBARCACAO 
        ,  MATERIAL_CASCO               = V_EMBARCACAO.MATERIAL_CASCO
        ,  TIPO_PROPULSAO               = V_EMBARCACAO.TIPO_PROPULSAO
        ,  NUM_BHP                      = V_EMBARCACAO.NUM_BHP 
        ,  QTD_MOTOR                    = V_EMBARCACAO.QTD_MOTOR
        ,  VALOR_ARQUEACAO_BRUTA        = V_EMBARCACAO.VALOR_ARQUEACAO_BRUTA 
        ,  VALOR_ARQUEACAO_LIQUIDA      = V_EMBARCACAO.VALOR_ARQUEACAO_LIQUIDA 
        ,  VALOR_TPB                    = V_EMBARCACAO.VALOR_TPB 
        ,  COMPRIMENTO_EMBARCACAO       = V_EMBARCACAO.COMPRIMENTO_EMBARCACAO 
        ,  COMPRIMENTO_BOCA             = V_EMBARCACAO.COMPRIMENTO_BOCA 
        ,  COMPRIMENTO_CALADO           = V_EMBARCACAO.COMPRIMENTO_CALADO 
        ,  VALOR_VELOCIDADE             = V_EMBARCACAO.VALOR_VELOCIDADE 
        ,  VALOR_CAPACIDADE             = V_EMBARCACAO.VALOR_CAPACIDADE
        ,  IND_CAPACIDADE_CARGA         = V_EMBARCACAO.IND_CAPACIDADE_CARGA
        ,  VALOR_CAPACIDADE_VEICULO     = V_EMBARCACAO.VALOR_CAPACIDADE_VEICULO
        ,  VALOR_CAPACIDADE_TEUS        = V_EMBARCACAO.VALOR_CAPACIDADE_TEUS
        ,  VALOR_CAPACIDADE_PASSAGEIROS = V_EMBARCACAO.VALOR_CAPACIDADE_PASSAGEIROS
        --ETAPA 4  
        ,  TIPO_NAVEGACAO               = V_EMBARCACAO.TIPO_NAVEGACAO 
        ,  AREA_NAVEGACAO               = V_EMBARCACAO.AREA_NAVEGACAO 
        ,  NATUREZA_TIPO_CARGA          = V_EMBARCACAO.NATUREZA_TIPO_CARGA        
        --
        ,  DATA_ULTIMA_ATUALIZACAO      = V_EMBARCACAO.DATA_ULTIMA_ATUALIZACAO
        ,  PAGINA_ETAPA                 = V_EMBARCACAO.PAGINA_ETAPA
     WHERE COD_EMBARCACAO               = V_EMBARCACAO.CODIGO_EMBARCACAO_ATIVO; 
   -- 
    IF SQL%ROWCOUNT = 0 
     THEN 
       -- 
        INSERT INTO EMBARCACAO(COD_EMBARCACAO 
                              ,NACIONALIDADE 
                              ,NUM_CASCO
                              ,NUM_INSCRICAO
                              ,FINALIDADE_EMBARCACAO
                              ,DOCUMENTO_PROPRIEDADE
                              ,CNPJ_ESTALEIRO
                             --ETAPA 2  
                              ,NUM_IMO 
                              ,NOME 
                              ,NUM_IRIN 
                              ,BANDEIRA_ATUAL
                              ,BANDEIRA_ORIGEM 
                              ,IND_NUM_IRIN 
                              -- verificar (Acredito que sejam campos exclusivos da Nacional)
                              ,NUM_PRPM 
                              ,NUM_TIE 
                              ,NUM_DPP 
                              ,NUM_PROTOCOLO_INSCRICAO 
                              ,NUM_INSCRICAO_PROVISORIA 
                              ,NUM_REB                               
                              -- verificar (Acredito que sejam campos exclusivos da Nacional)                             
                             --ETAPA 3
                              ,TIPO_EMBARCACAO 
                              ,CLASSE_EMBARCACAO 
                              ,SITUACAO 
                              ,ANO_EMBARCACAO
                              ,MATERIAL_CASCO 
                              ,TIPO_PROPULSAO
                              ,NUM_BHP
                              ,QTD_MOTOR 
                              ,VALOR_ARQUEACAO_BRUTA 
                              ,VALOR_ARQUEACAO_LIQUIDA 
                              ,VALOR_TPB 
                              ,COMPRIMENTO_EMBARCACAO 
                              ,COMPRIMENTO_BOCA 
                              ,COMPRIMENTO_CALADO 
                              ,VALOR_VELOCIDADE 
                              ,VALOR_CAPACIDADE
                              ,IND_CAPACIDADE_CARGA
                              ,VALOR_CAPACIDADE_VEICULO
                              ,VALOR_CAPACIDADE_TEUS
                              ,VALOR_CAPACIDADE_PASSAGEIROS
                              --ETAPA 4 
                              ,TIPO_NAVEGACAO 
                              ,AREA_NAVEGACAO 
                              ,NATUREZA_TIPO_CARGA
                              --
                              ,TIPO_SERVICO
                              ,DATA_ULTIMA_ATUALIZACAO
                              ,PAGINA_ETAPA
                              ,USUARIO) 
                             -- 
                       VALUES(EMBARCACAO_SEQ.NEXTVAL 
                             ,V_EMBARCACAO.NACIONALIDADE 
                             ,V_EMBARCACAO.NUM_CASCO
                             ,V_EMBARCACAO.NUM_INSCRICAO
                             ,V_EMBARCACAO.FINALIDADE_EMBARCACAO
                             ,V_EMBARCACAO.DOCUMENTO_PROPRIEDADE
                             ,V_EMBARCACAO.CNPJ_ESTALEIRO
                            --ETAPA 2  
                             ,V_EMBARCACAO.NUM_IMO 
                             ,V_EMBARCACAO.NOME 
                             ,V_EMBARCACAO.NUM_IRIN 
                             ,V_EMBARCACAO.BANDEIRA_ATUAL 
                             ,V_EMBARCACAO.BANDEIRA_ORIGEM 
                             ,V_EMBARCACAO.IND_NUM_IRIN 
                             -- verificar (Acredito que sejam campos exclusivos da Nacional)
                             ,V_EMBARCACAO.NUM_PRPM 
                             ,V_EMBARCACAO.NUM_TIE 
                             ,V_EMBARCACAO.NUM_DPP 
                             ,V_EMBARCACAO.NUM_PROTOCOLO_INSCRICAO 
                             ,V_EMBARCACAO.NUM_INSCRICAO_PROVISORIA 
                             ,V_EMBARCACAO.NUM_REB 
                             -- verificar (Acredito que sejam campos exclusivos da Nacional)
                            --ETAPA 3
                            ,V_EMBARCACAO.TIPO_EMBARCACAO 
                            ,V_EMBARCACAO.CLASSE_EMBARCACAO 
                            ,V_EMBARCACAO.SITUACAO 
                            ,V_EMBARCACAO.ANO_EMBARCACAO
                            ,V_EMBARCACAO.MATERIAL_CASCO 
                            ,V_EMBARCACAO.TIPO_PROPULSAO
                            ,V_EMBARCACAO.NUM_BHP
                            ,V_EMBARCACAO.QTD_MOTOR 
                            ,V_EMBARCACAO.VALOR_ARQUEACAO_BRUTA 
                            ,V_EMBARCACAO.VALOR_ARQUEACAO_LIQUIDA 
                            ,V_EMBARCACAO.VALOR_TPB 
                            ,V_EMBARCACAO.COMPRIMENTO_EMBARCACAO 
                            ,V_EMBARCACAO.COMPRIMENTO_BOCA 
                            ,V_EMBARCACAO.COMPRIMENTO_CALADO 
                            ,V_EMBARCACAO.VALOR_VELOCIDADE 
                            ,V_EMBARCACAO.VALOR_CAPACIDADE
                            ,V_EMBARCACAO.IND_CAPACIDADE_CARGA
                            ,V_EMBARCACAO.VALOR_CAPACIDADE_VEICULO
                            ,V_EMBARCACAO.VALOR_CAPACIDADE_TEUS
                            ,V_EMBARCACAO.VALOR_CAPACIDADE_PASSAGEIROS
                            --ETAPA 4 
                            ,V_EMBARCACAO.TIPO_NAVEGACAO 
                            ,V_EMBARCACAO.AREA_NAVEGACAO 
                            ,V_EMBARCACAO.NATUREZA_TIPO_CARGA
                            --
                            ,V_EMBARCACAO.TIPO_SERVICO
                            ,V_EMBARCACAO.DATA_ULTIMA_ATUALIZACAO
                            ,V_EMBARCACAO.PAGINA_ETAPA
                            ,V('APP_USER')) 
                   RETURNING COD_EMBARCACAO 
                        INTO V_EMBARCACAO.CODIGO_EMBARCACAO_ATIVO; 
       -- 
    END IF; 
   -- 
    /*ARQUIVOS*/ 
   -- 
    DELETE  
      FROM EMBARCACAO_DOCUMENTO 
     WHERE COD_EMBARCACAO = V_EMBARCACAO.CODIGO_EMBARCACAO_ATIVO; 
   -- 
    FOR X IN CUR_ARQUIVOS LOOP 
     -- 
      INSERT INTO EMBARCACAO_DOCUMENTO (COD_EMBARCACAO_DOCUMENTO 
                                       ,COD_EMBARCACAO 
                                       ,IND_TIPO_DOCUMENTO 
                                       ,NOME_ARQUIVO 
                                       ,MIME_TYPE 
                                       ,ARQUIVO 
                                       ,DATA_VALIDADE 
                                       ,TIPO) 
           VALUES (X.COD_EMBARCACAO_DOCUMENTO 
                  ,V_EMBARCACAO.CODIGO_EMBARCACAO_ATIVO 
                  ,X.IND_TIPO_DOCUMENTO 
                  ,X.NOME_ARQUIVO 
                  ,X.MIME_TYPE 
                  ,X.ARQUIVO 
                  ,X.DATA_VALIDADE 
                  ,X.TIPO);  
     -- 
    END LOOP; 
   -- 
    /*APAGA OS DADOS TEMPORARIOS*/ 
    DELETE  
      FROM TEMP_EMBARCACAO_DOCUMENTO 
     WHERE COD_EMBARCACAO = P_COD_TEMP_EMBARCACAO; 
   -- 
    DELETE  
      FROM TEMP_EMBARCACAO 
     WHERE COD_EMBARCACAO = P_COD_TEMP_EMBARCACAO; 
   -- 
 END PRC_SALVAR_EMBARCACAO_ESTRANGEIRA; 
-- 
 /**/ 
 PROCEDURE PRC_EDITAR_EMBARCACAO(P_COD_EMBARCACAO      IN NUMBER 
                                ,P_COD_TEMP_EMBARCACAO IN NUMBER DEFAULT NULL 
                                ,PO_TEMP_EMBARCACAO   OUT NUMBER) IS 
-- 
 CURSOR CUR_EMBARCACAO IS 
 SELECT * 
   FROM EMBARCACAO 
  WHERE COD_EMBARCACAO = P_COD_EMBARCACAO; 
-- 
 CURSOR CUR_ARQUIVO_EMBARCACAO IS 
 SELECT * 
   FROM EMBARCACAO_DOCUMENTO 
  WHERE COD_EMBARCACAO = P_COD_EMBARCACAO; 
-- 
 V_COD_TEMP_EMBARCACAO NUMBER; 
 V_EXISTE_ARQUIVO      NUMBER; 
-- 
 BEGIN 
   -- 
    FOR X IN CUR_EMBARCACAO LOOP 
     -- 
      UPDATE TEMP_EMBARCACAO 
         SET PROCESSADO                   = 'P', 
             USUARIO                      = V('APP_USER'), 
             DATA_CADASTRO                = SYSDATE-3/24, 
             DATA_ULTIMA_ATUALIZACAO      = SYSDATE, 
             SITUACAO_REGISTRO            = 'P', 
             PAGINA_ETAPA                 = 5 
       WHERE CODIGO_EMBARCACAO_ATIVO      = X.COD_EMBARCACAO; 
     -- 
      V_COD_TEMP_EMBARCACAO := P_COD_TEMP_EMBARCACAO; 
     -- 
      IF SQL%ROWCOUNT = 0 
       THEN 
         -- 
          INSERT INTO TEMP_EMBARCACAO ( COD_EMBARCACAO, 
                                        NACIONALIDADE, 
                                        IND_ARQUEACAO_BRUTA, 
                                        NUM_INSCRICAO, 
                                        NUM_IMO, 
                                        NOME, 
                                        BANDEIRA_ORIGEM, 
                                        BANDEIRA_ATUAL, 
                                        IND_NUM_IRIN, 
                                        NUM_PRPM, 
                                        NUM_TIE, 
                                        NUM_DPP, 
                                        NUM_PROTOCOLO_INSCRICAO, 
                                        NUM_INSCRICAO_PROVISORIA, 
                                        NUM_REB, 
                                        TIPO_NAVEGACAO, 
                                        AREA_NAVEGACAO, 
                                        NATUREZA_TIPO_CARGA, 
                                        TIPO_EMBARCACAO, 
                                        CLASSE_EMBARCACAO, 
                                        SITUACAO, 
                                        ANO_EMBARCACAO, 
                                        MATERIAL_CASCO, 
                                        TIPO_PROPULSAO, 
                                        NUM_BHP, 
                                        QTD_MOTOR, 
                                        VALOR_ARQUEACAO_BRUTA, 
                                        VALOR_ARQUEACAO_LIQUIDA, 
                                        VALOR_TPB, 
                                        COMPRIMENTO_EMBARCACAO, 
                                        COMPRIMENTO_BOCA, 
                                        COMPRIMENTO_CALADO, 
                                        VALOR_VELOCIDADE, 
                                        VALOR_CAPACIDADE, 
                                        IND_CAPACIDADE_CARGA, 
                                        VALOR_CAPACIDADE_VEICULO, 
                                        VALOR_CAPACIDADE_TEUS, 
                                        VALOR_CAPACIDADE_PASSAGEIROS, 
                                        SITUACAO_CADASTRAL, 
                                        NUM_IRIN, 
                                        PROCESSADO, 
                                        USUARIO, 
                                        DATA_CADASTRO, 
                                        DATA_ULTIMA_ATUALIZACAO, 
                                        PAGINA_ETAPA, 
                                        SITUACAO_REGISTRO, 
                                        DOCUMENTO_PROPRIEDADE, 
                                        CODIGO_EMBARCACAO_ATIVO,
                                        TIPO_SERVICO) 
                               VALUES ( TEMP_EMBARCACAO_SEQ.NEXTVAL, 
                                        X.NACIONALIDADE, 
                                        X.IND_ARQUEACAO_BRUTA, 
                                        X.NUM_INSCRICAO, 
                                        X.NUM_IMO, 
                                        X.NOME, 
                                        X.BANDEIRA_ORIGEM, 
                                        X.BANDEIRA_ATUAL, 
                                        X.IND_NUM_IRIN, 
                                        X.NUM_PRPM, 
                                        X.NUM_TIE, 
                                        X.NUM_DPP, 
                                        X.NUM_PROTOCOLO_INSCRICAO, 
                                        X.NUM_INSCRICAO_PROVISORIA, 
                                        X.NUM_REB, 
                                        X.TIPO_NAVEGACAO, 
                                        X.AREA_NAVEGACAO, 
                                        X.NATUREZA_TIPO_CARGA, 
                                        X.TIPO_EMBARCACAO, 
                                        X.CLASSE_EMBARCACAO, 
                                        X.SITUACAO, 
                                        X.ANO_EMBARCACAO, 
                                        X.MATERIAL_CASCO, 
                                        X.TIPO_PROPULSAO, 
                                        X.NUM_BHP, 
                                        X.QTD_MOTOR, 
                                        X.VALOR_ARQUEACAO_BRUTA, 
                                        X.VALOR_ARQUEACAO_LIQUIDA, 
                                        X.VALOR_TPB, 
                                        X.COMPRIMENTO_EMBARCACAO, 
                                        X.COMPRIMENTO_BOCA, 
                                        X.COMPRIMENTO_CALADO, 
                                        X.VALOR_VELOCIDADE, 
                                        X.VALOR_CAPACIDADE, 
                                        X.IND_CAPACIDADE_CARGA, 
                                        X.VALOR_CAPACIDADE_VEICULO, 
                                        X.VALOR_CAPACIDADE_TEUS, 
                                        X.VALOR_CAPACIDADE_PASSAGEIROS, 
                                        X.SITUACAO_CADASTRAL, 
                                        X.NUM_IRIN, 
                                        'P', 
                                        V('APP_USER'), 
                                        SYSDATE-3/24, 
                                        SYSDATE-3/24, 
                                        '', 
                                        'P', 
                                        X.DOCUMENTO_PROPRIEDADE, 
                                        X.COD_EMBARCACAO,
                                        X.TIPO_SERVICO) 
                              RETURNING COD_EMBARCACAO 
                                   INTO V_COD_TEMP_EMBARCACAO; 
 
         -- 
      END IF; 
     -- 
      FOR Y IN CUR_ARQUIVO_EMBARCACAO LOOP 
       -- 
        SELECT COUNT(*) 
          INTO V_EXISTE_ARQUIVO 
          FROM TEMP_EMBARCACAO_DOCUMENTO 
         WHERE COD_EMBARCACAO_DOCUMENTO = Y.COD_EMBARCACAO_DOCUMENTO; 
       -- 
        IF V_EXISTE_ARQUIVO = 0 
         THEN 
           -- 
            INSERT INTO TEMP_EMBARCACAO_DOCUMENTO(COD_EMBARCACAO_DOCUMENTO 
                                                 ,COD_EMBARCACAO 
                                                 ,IND_TIPO_DOCUMENTO 
                                                 ,NOME_ARQUIVO 
                                                 ,MIME_TYPE 
                                                 ,ARQUIVO 
                                                 ,DATA_VALIDADE 
                                                 ,TIPO) 
                 VALUES(Y.COD_EMBARCACAO_DOCUMENTO 
                       ,V_COD_TEMP_EMBARCACAO 
                       ,Y.IND_TIPO_DOCUMENTO 
                       ,Y.NOME_ARQUIVO 
                       ,Y.MIME_TYPE 
                       ,Y.ARQUIVO 
                       ,Y.DATA_VALIDADE 
                       ,Y.TIPO);  
           -- 
        END IF; 
       -- 
      END LOOP;  
     -- 
    END LOOP; 
   -- 
    PO_TEMP_EMBARCACAO := V_COD_TEMP_EMBARCACAO; 
   -- 
 END PRC_EDITAR_EMBARCACAO; 
-- 
end "PCK_EMBARCACAO";
/
create or replace PACKAGE BODY PCK_UTIL IS 
-- 
 FUNCTION F_STRING_TO_ROWS (P_STRING   IN VARCHAR2 
                           ,P_CARACTER IN VARCHAR2) RETURN TP_STRING_ARRAY PIPELINED IS 
 -- 
 V_ARRAY APEX_APPLICATION_GLOBAL.VC_ARR2; 
 -- 
 BEGIN 
  --  
   V_ARRAY := APEX_UTIL.STRING_TO_TABLE(P_STRING, P_CARACTER); 
  -- 
   FOR I IN 1 .. V_ARRAY.COUNT LOOP 
    -- 
     PIPE ROW(V_ARRAY(I)); 
    --  
   END LOOP; 
  --  
 END F_STRING_TO_ROWS; 
-- 
 FUNCTION F_DATA_SISTEMA RETURN VARCHAR2 IS 
-- 
 V_DATA VARCHAR2(255); 
-- 
 BEGIN 
   -- 
    V_DATA := TO_CHAR(SYSDATE-3/24, 'DD/MM/YYYY'); 
   -- 
    RETURN V_DATA;  
   -- 
 END F_DATA_SISTEMA; 
-- 
 FUNCTION F_HORA_SISTEMA RETURN VARCHAR2 IS 
-- 
 V_HORA VARCHAR2(255); 
-- 
 BEGIN 
   -- 
    V_HORA := TO_CHAR(SYSDATE-3/24, 'HH24:MI:SS'); 
   -- 
    RETURN V_HORA;  
   -- 
 END F_HORA_SISTEMA; 
-- 
 FUNCTION F_URL_COMENTARIO (P_APP_ID IN NUMBER, P_ID_PAGINA IN NUMBER, P_ID_ENTIDADE IN NUMBER, P_ID_COMENTARIO IN NUMBER) RETURN VARCHAR2 IS 
-- 
 V_URL VARCHAR2(500); 
-- 
 BEGIN 
   -- 
    V_URL := APEX_PAGE.GET_URL (P_APPLICATION => P_APP_ID, 
                                P_PAGE        => 1, 
                                P_ITEMS       => 'P0_ID_PAGINA,P0_ID,P0_ID_COMENTARIO', 
                                P_VALUES      => P_ID_PAGINA || ',' || P_ID_ENTIDADE || ',' || P_ID_COMENTARIO); 
   -- 
    V_URL := 'https://' || OWA_UTIL.GET_CGI_ENV('HTTP_HOST') || V_URL ; 
   -- 
    RETURN V_URL; 
   -- 
 END F_URL_COMENTARIO; 
--  
-- 
 FUNCTION GET_SYSDATE RETURN DATE IS 
-- 
 V_AJUST_SYSDATE DATE; 
-- 
 BEGIN 
   -- 
    V_AJUST_SYSDATE := SYSDATE - INTERVAL '3' HOUR; 
   -- 
     RETURN V_AJUST_SYSDATE; 
   -- 
 END GET_SYSDATE; 
-- 
 
 FUNCTION GET_SYSTIMESTAMP RETURN TIMESTAMP IS 
-- 
  V_AJUST_SYSTIMESTAMP TIMESTAMP; 
-- 
BEGIN 
  -- 
  V_AJUST_SYSTIMESTAMP := SYSDATE - INTERVAL '3' HOUR; 
  RETURN V_AJUST_SYSTIMESTAMP; 
   -- 
 END GET_SYSTIMESTAMP; 
 
  -- 
 
 FUNCTION F_CALCULAR_DIAS_UTEIS(DATA_INICIO IN DATE, DATA_FIM IN DATE) RETURN NUMBER IS 
-- 
 V_CONTADOR NUMBER := 0; 
-- 
 BEGIN 
   -- 
    FOR I IN 0 .. ABS(DATA_FIM - DATA_INICIO) LOOP 
        IF TO_CHAR(DATA_INICIO + I, 'D') BETWEEN 2 AND 6 THEN 
            V_CONTADOR := V_CONTADOR + 1; 
        END IF; 
    END LOOP; 
 
    RETURN V_CONTADOR; 
   -- 
 END F_CALCULAR_DIAS_UTEIS; 
 -- 
 FUNCTION F_MASK_CPF_CNPJ(P_DOCUMENTO IN VARCHAR2) RETURN VARCHAR2 IS 
--  
 V_CPF  VARCHAR2(30); 
 V_CNPJ VARCHAR2(30); 
 V_DOC  VARCHAR2(14) := REPLACE(REPLACE(REPLACE(P_DOCUMENTO ,'.'),'/'),'-'); 
-- 
  BEGIN 
   -- 
    IF LENGTH(V_DOC) <= 11 AND LENGTH(V_DOC) > 0  
     THEN 
       -- 
        V_CPF := LPAD(V_DOC,11,0); 
       -- 
        V_CPF := SUBSTR(V_CPF, 1,3)||'.'|| 
                 SUBSTR(V_CPF, 4,3)||'.'|| 
                 SUBSTR(V_CPF, 7,3)||'-'|| 
                 SUBSTR(V_CPF,10,2); 
       -- 
        RETURN V_CPF; 
       -- 
    ELSIF LENGTH(V_DOC) > 11 
     THEN 
       -- 
        V_CNPJ := LPAD(V_DOC,14,0); 
       -- 
        V_CNPJ := SUBSTR(V_CNPJ, 1,2)||'.'|| 
                  SUBSTR(V_CNPJ, 3,3)||'.'|| 
                  SUBSTR(V_CNPJ, 6,3)||'/'|| 
                  SUBSTR(V_CNPJ, 9,4)||'-'|| 
                  SUBSTR(V_CNPJ,13,2); 
       -- 
        RETURN V_CNPJ; 
       -- 
     ELSE 
       -- 
        RETURN NULL; 
       -- 
    END IF; 
   -- 
  END F_MASK_CPF_CNPJ; 
 -- 
 FUNCTION F_VALIDA_CPF_CNPJ (P_CPF_CNPJ VARCHAR2) RETURN CHAR IS 
-- 
  TYPE ARRAY_DV IS VARRAY(2) OF PLS_INTEGER; 
  V_ARRAY_DV ARRAY_DV := ARRAY_DV(0, 0); 
  CPF_DIGIT  CONSTANT PLS_INTEGER := 11; 
  CNPJ_DIGIT CONSTANT PLS_INTEGER := 14; 
  IS_CPF       BOOLEAN; 
  IS_CNPJ      BOOLEAN; 
  V_CPF_NUMBER VARCHAR2(20); 
  TOTAL        NUMBER := 0; 
  COEFICIENTE  NUMBER := 0; 
  DV1          NUMBER := 0; 
  DV2          NUMBER := 0; 
  DIGITO       NUMBER := 0; 
  J            INTEGER; 
  I            INTEGER; 
  V_RETORNO    NUMBER := 1; 
-- 
BEGIN 
  -- 
  IF P_CPF_CNPJ IS NULL THEN 
    RETURN '0'; 
  END IF; 
  -- 
  /* 
    RETIRA OS CARACTERES NÃO NUMÉRICOS DO CPF/CNPJ 
    CASO SEJA ENVIADO PARA VALIDAÇÃO UM VALOR COM 
    A MÁSCARA. 
  */ 
  V_CPF_NUMBER := REGEXP_REPLACE(P_CPF_CNPJ, '[^0-9]'); 
  -- 
  /* 
    VERIFICA SE O VALOR PASSADO É UM CPF ATRAVÉS DO 
    NÚMERO DE DÍGITOS INFORMADOS. CPF = 11 
  */ 
  IS_CPF := (LENGTH(V_CPF_NUMBER) = CPF_DIGIT); 
  -- 
  IF IS_CPF = TRUE THEN 
    -- 
    IF V_CPF_NUMBER IN ('00000000000', '11111111111', '22222222222', '33333333333', '44444444444', 
                        '55555555555', '66666666666', '77777777777', '88888888888', '99999999999') THEN 
      RETURN '0'; 
      V_RETORNO := 0; 
    END IF; 
    -- 
  END IF; 
  -- 
  /* 
    VERIFICA SE O VALOR PASSADO É UM CNPJ ATRAVÉS DO 
    NÚMERO DE DÍGITOS INFORMADOS. CNPJ = 14 
  */ 
  IS_CNPJ := (LENGTH(V_CPF_NUMBER) = CNPJ_DIGIT); 
  -- 
  IF IS_CNPJ = TRUE THEN 
    -- 
    IF V_CPF_NUMBER IN ('00000000000000', '11111111111111', '22222222222222', '33333333333333', '44444444444444', 
                        '55555555555555', '66666666666666', '77777777777777', '88888888888888', '99999999999999') THEN 
      RETURN '0'; 
      V_RETORNO := 0; 
    END IF; 
    -- 
  END IF; 
  -- 
  IF (IS_CPF OR IS_CNPJ) THEN 
    TOTAL := 0; 
  ELSE 
    RETURN '0'; 
    V_RETORNO := 0; 
  END IF; 
  -- 
  /* 
    ARMAZENA OS VALORES DE DÍGITOS INFORMADOS PARA 
    POSTERIOR COMPARAÇÃO COM OS DÍGITOS VERIFICADORES CALCULADOS. 
  */ 
  DV1 := TO_NUMBER(SUBSTR(V_CPF_NUMBER, LENGTH(V_CPF_NUMBER) - 1, 1)); 
  DV2 := TO_NUMBER(SUBSTR(V_CPF_NUMBER, LENGTH(V_CPF_NUMBER), 1)); 
  V_ARRAY_DV(1) := 0; 
  V_ARRAY_DV(2) := 0; 
  -- 
  /* 
    LAÇO PARA CÁLCULO DOS DÍGITOS VERIFICADORES. 
    É UTILIZADO MÓDULO 11 CONFORME NORMA DA RECEITA FEDERAL. 
  */ 
  IF V_RETORNO = 1 THEN 
    -- 
    FOR J IN 1 .. 2 LOOP 
      TOTAL := 0; 
      COEFICIENTE := 2; 
      FOR I IN REVERSE 1 .. ((LENGTH(V_CPF_NUMBER) - 3) + J) LOOP 
        DIGITO := TO_NUMBER(SUBSTR(V_CPF_NUMBER, I, 1)); 
        TOTAL := TOTAL + (DIGITO * COEFICIENTE); 
        COEFICIENTE := COEFICIENTE + 1; 
        IF (COEFICIENTE > 9) AND IS_CNPJ THEN 
          COEFICIENTE := 2; 
        END IF; 
      END LOOP; -- FOR I 
      V_ARRAY_DV(J) := 11 - MOD(TOTAL, 11); 
      IF (V_ARRAY_DV(J) >= 10) THEN 
        V_ARRAY_DV(J) := 0; 
      END IF; 
    END LOOP; -- FOR J IN 1..2 
    -- 
    /* 
      COMPARA OS DÍGITOS CALCULADOS COM OS INFORMADOS PARA INFORMAR RESULTADO. 
    */ 
    IF (DV1 = V_ARRAY_DV(1)) AND (DV2 = V_ARRAY_DV(2)) THEN 
      RETURN '1'; 
    END IF; 
    -- 
    RETURN '0'; 
    -- 
  END IF; 
  -- 
 END F_VALIDA_CPF_CNPJ; 
 -- 
 FUNCTION F_CALCULA_HORA (P_TEMPO IN NUMBER) RETURN VARCHAR2 IS 
--  
 V_HORA   NUMBER; 
 V_MINUTO NUMBER; 
 V_RESULTADO  VARCHAR2(100); 
-- 
 BEGIN 
   --EXTRAI A PARTE INTEIRA PARA AS HORAS 
    V_HORA := TRUNC(P_TEMPO); 
 
   --EXTRAI A PARTE FRACIONÁRIA E CONVERTE PARA MINUTOS 
    V_MINUTO := ROUND((P_TEMPO - V_HORA) * 60); 
    
   --FORMATA A STRING DE RESULTADO 
    IF V_MINUTO > 0 
     THEN 
       -- 
        V_RESULTADO := V_HORA || ' Hora(s) e ' || V_MINUTO || ' Minuto(s)'; 
       -- 
     ELSE 
       -- 
        V_RESULTADO := V_HORA || ' Hora(s)'; 
       -- 
    END IF; 
   -- 
    RETURN V_RESULTADO; 
   -- 
 END F_CALCULA_HORA; 
 -- 
END; 
/
create or replace package BODY PCK_VALIDACAO IS
--
 FUNCTION F_VALIDA_EMAIL (P_EMAIL VARCHAR2) RETURN BOOLEAN IS
-- 
 V_EMAIL VARCHAR2(255) := '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
--
 BEGIN
   --
    IF REGEXP_LIKE(P_EMAIL, V_EMAIL) 
    THEN
     --
      RETURN TRUE;
     -- 
    ELSE
     -- 
      RETURN FALSE;
     -- 
  END IF;
 -- 
  EXCEPTION
    WHEN OTHERS THEN
     -- 
      RETURN FALSE;
     --
 END F_VALIDA_EMAIL;
--
 FUNCTION F_VALIDA_TELEFONE (P_TELEFONE IN VARCHAR2) RETURN BOOLEAN IS
--
 V_TELEFONE VARCHAR2(255);
--
 BEGIN
   --
    V_TELEFONE := REGEXP_REPLACE(P_TELEFONE, '[^0-9]', '');
   --
    IF V_TELEFONE IS NOT NULL AND LENGTH(V_TELEFONE) IN (10,11)
     THEN
       --
        RETURN TRUE;
       --
     ELSE
       --
        RETURN FALSE;
       --
    END IF;
   --
 END F_VALIDA_TELEFONE;
--
END PCK_VALIDACAO;
/
create or replace PACKAGE BODY PCK_VALIDACAO_CADASTRO_EMBARCACAO AS

    procedure proc_valida_cadastro_embarcacao (
        p_cod_temp_embarcacao   in  number 
        , po_sucesso            out number 
        , po_body               out clob
        , PO_BODY_OPTATIVO      out clob
    ) is
        v_nacionalidade varchar2(1);
        v_tipo_servico  varchar2(1);
        v_sucesso       number;
        v_body          clob;
        V_BODY_OPTATIVO clob;

        v_url clob;
    begin
        select nacionalidade, tipo_servico
            into v_nacionalidade, v_tipo_servico
        from temp_embarcacao
        where cod_embarcacao = p_cod_temp_embarcacao;

        if v_tipo_servico = 'O' then
            if v_nacionalidade = 'E' then
                proc_valida_cadastro_estrangeira (
                    p_cod_temp_embarcacao   => p_cod_temp_embarcacao
                    , po_sucesso            => v_sucesso
                    , po_body               => v_body
                    , PO_BODY_OPTATIVO      => V_BODY_OPTATIVO
                );
            elsif v_nacionalidade = 'N' then
                proc_valida_cadastro_nacional (
                    p_cod_temp_embarcacao  => p_cod_temp_embarcacao
                    , po_sucesso           => v_sucesso
                    , po_body              => v_body
                    , PO_BODY_OPTATIVO     => V_BODY_OPTATIVO
                );
            else
                v_sucesso := 0;

                v_url := APEX_PAGE.GET_URL (
                    p_page   => 5,
                    p_items  => 'P5_ITEM_FOCUS',
                    p_values => 'P5_NACIONALIDADE' 
                );

                V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';   
                V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
                V_BODY := V_BODY || '<strong> Campo 1.1: </strong> Nacionalidade - Preenchimento obrigatório!';
                V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
            end if;
        elsif v_tipo_servico = 'C' then
            proc_valida_cadastro_construcao (
                p_cod_temp_embarcacao   => p_cod_temp_embarcacao
                , po_sucesso            => v_sucesso
                , po_body               => v_body
                , po_body_optativo      => v_body_optativo
            );
        elsif v_tipo_servico = 'R' then
            proc_valida_cadastro_reforma (
                p_cod_temp_embarcacao   => p_cod_temp_embarcacao
                , po_sucesso            => v_sucesso
                , po_body               => v_body
                , po_body_optativo      => v_body_optativo
            );
        end if;

        po_sucesso          := v_sucesso;
        po_body             := v_body;
        PO_BODY_OPTATIVO    := V_BODY_OPTATIVO;
        
    end proc_valida_cadastro_embarcacao;

    procedure proc_valida_cadastro_construcao (
        p_cod_temp_embarcacao    in number
        , po_sucesso             out number
        , po_body                out clob
        , po_body_optativo       out clob
    ) is
        v_body      clob;

        v_erro      number := 0;
        v_opicional number := 0;
        v_body_optativo clob;

        V_ERRO_OPTATIVO NUMBER := 0;

        v_url clob;
        v_url_page varchar2(20);
        
        cursor cur_embarcacao is
        select *
        from temp_embarcacao
        where cod_embarcacao = p_cod_temp_embarcacao;
        
        v_embarcacao cur_embarcacao%rowtype;
        
        v_contrato_em_eficacia         number;
        v_cronograma_fis_fin           number;
        v_quadro_usos_fontes           number;
        v_arranjo_geral_embarcacao     number;
        v_licenca_provisoria           number;
        v_outros_documentos            number;
    begin
        open cur_embarcacao;
            fetch cur_embarcacao into v_embarcacao;
        close cur_embarcacao;      

        if v_erro > 0 then
            v_body := v_body || chr(13) || '<br>' || chr(13);
        end if;

        /*CAMPOS OBRIGATORIOS*/
        /***VALIDAÇÕES DA 2ª ETAPA (2)***/

        -- página para voltar no link
        v_url_page := 24;

        if v_embarcacao.nome is null then

            v_url := apex_page.get_url (
                p_page   => v_url_page,
                p_items  => 'P24_ITEM_FOCUS',
                p_values => 'P24_NOME' 
            );

            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 2.2: </strong> Nome - Informe um nome a embarcação!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        /*CAMPOS OBRIGATORIOS*/
        /***VALIDAÇÕES DA 3ª ETAPA (3)***/

        -- página para voltar no link
        v_url_page := 11;

        IF V_EMBARCACAO.TIPO_EMBARCACAO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_TIPO' 
            );

            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.1.</strong> Tipo da embarcação - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 

        IF V_EMBARCACAO.MATERIAL_CASCO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_MATERIAL_CASCO' 
            );
            
            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.5.</strong> Material de Construção do Casco - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 

        IF V_EMBARCACAO.NUM_BHP IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_BHP' 
            );
            
            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.7.</strong> BHP (potêncial) - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 

        IF V_EMBARCACAO.VALOR_ARQUEACAO_BRUTA IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_ARQUEACAO_BRUTA' 
            );
            
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.9.</strong> Arqueação Bruta AB/TAB (t) - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        IF V_EMBARCACAO.VALOR_TPB IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_TPB' 
            );
            
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.11.</strong> TPB - Tonelagem de Porte Bruto - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        IF V_EMBARCACAO.COMPRIMENTO_EMBARCACAO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_COMPRIMENTO_EMBARCACAO' 
            );
            
            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.12.</strong> Comprimento da embarcação (m) - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 
        
        IF V_EMBARCACAO.COMPRIMENTO_BOCA IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_BOCA' 
            );
            
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.13.</strong> BOCA (m) - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        IF V_EMBARCACAO.COMPRIMENTO_CALADO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_CALADO' 
            );
            
            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.14.</strong> Calado MÁX (m) / Draft - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 

        /***VALIDAÇÕES DA 4ª ETAPA (11)***/
        /*CAMPOS 4.1*/
        --
        v_url_page := 10;

        IF V_EMBARCACAO.TIPO_NAVEGACAO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P10_ITEM_FOCUS',
                p_values => 'P10_TIPO_NAVEGACAO' 
            );
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 4.1.</strong> Modalidade(s) de Navegação - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        /*CAMPOS OPICIONAIS*/

        /***OPICIONAIS DA 1ª ETAPA (1)***/
        v_url_page := 5;

        IF V_EMBARCACAO.NUM_INSCRICAO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P5_ITEM_FOCUS',
                p_values => 'P5_NUM_INSCRICAO' 
            );
                        
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 1.3.</strong> Número de inscrição - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';

        END IF; 

        IF V_EMBARCACAO.FINALIDADE_EMBARCACAO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P5_ITEM_FOCUS',
                p_values => 'P5_FINALIDADE_EMBARCACAO' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 1.4.</strong> Qual a finalidade do cadastro? - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';

        END IF; 

        IF V_EMBARCACAO.CNPJ_ESTALEIRO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P5_ITEM_FOCUS',
                p_values => 'P5_CNPJ_ESTALEIRO' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 1.6.</strong> CNPJ do estaleiro - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';

        END IF; 

        /***OPICIONAIS DA 2ª ETAPA (2)***/
        v_url_page := 24;

        select count(1)
        into v_contrato_em_eficacia
        from temp_embarcacao_documento
        where cod_embarcacao     = v_embarcacao.cod_embarcacao
        and ind_tipo_documento = 'CE';

        select count(1)
        into v_cronograma_fis_fin
        from temp_embarcacao_documento
        where cod_embarcacao     = v_embarcacao.cod_embarcacao
        and ind_tipo_documento = 'CF';

        select count(1)
        into v_quadro_usos_fontes
        from temp_embarcacao_documento
        where cod_embarcacao     = v_embarcacao.cod_embarcacao
        and ind_tipo_documento = 'Q';

        select count(1)
        into v_arranjo_geral_embarcacao
        from temp_embarcacao_documento
        where cod_embarcacao     = v_embarcacao.cod_embarcacao
        and ind_tipo_documento = 'AG';

        select count(1)
        into v_licenca_provisoria
        from temp_embarcacao_documento
        where cod_embarcacao     = v_embarcacao.cod_embarcacao
        and ind_tipo_documento = 'LP';

        select count(1)
        into v_outros_documentos
        from temp_embarcacao_documento
        where cod_embarcacao     = v_embarcacao.cod_embarcacao
        and ind_tipo_documento = 'O';

        IF v_contrato_em_eficacia = 0 THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P24_ITEM_FOCUS',
                p_values => 'ADICIONAR_DOC_CONTRATO_EM_EFICACIA' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.4</strong> Contrato (em eficácia) do serviço da embarcação  - Envio de documentação optativo!</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
        END IF;

        IF V_EMBARCACAO.DATA_ASSINATURA_CONTRATO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P24_ITEM_FOCUS',
                p_values => 'P24_DATA_ASSINATURA_CONTRATO' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.5.</strong> Data de assinatura do contrato (início do serviço) - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';

        END IF; 

        IF V_EMBARCACAO.DATA_ASSINATURA_CONTRATO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P24_ITEM_FOCUS',
                p_values => 'P24_PREVISAO_CONCLUSAO_SERVICO' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.6.</strong> Previsão de conclusão do serviço - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';

        END IF; 

        IF v_cronograma_fis_fin = 0 THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P24_ITEM_FOCUS',
                p_values => 'ADICIONAR_DOC_CRONOGRAMA' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.7</strong> Cronograma físico-financeiro do contrato do serviço - Envio de documentação optativo!</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
        END IF;

        IF V_EMBARCACAO.SITUACAO_SERVICO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P24_ITEM_FOCUS',
                p_values => 'P24_SITUACAO_SERVICO' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.8.</strong> Situação do serviço - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';

        END IF; 

        IF v_quadro_usos_fontes = 0 THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P24_ITEM_FOCUS',
                p_values => 'ADICIONAR_DOC_QUADRO' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.9</strong> Quadro de usos e fontes - Envio de documentação optativo!</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
        END IF;

        IF v_arranjo_geral_embarcacao = 0 THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P24_ITEM_FOCUS',
                p_values => 'ADICIONAR_DOC_ARRANJO' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.10</strong> Arranjo geral da embarcação e plano de capacidade - Envio de documentação optativo!</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
        END IF;

        IF v_licenca_provisoria = 0 THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P24_ITEM_FOCUS',
                p_values => 'ADICIONAR_DOC_LICENCA_PROVISORIA' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.11</strong> Licença provisória de construção ou reforma da embarcação pela Autoridade Marítima Brasileira - Envio de documentação optativo!</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
        END IF;

        IF v_outros_documentos = 0 THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P24_ITEM_FOCUS',
                p_values => 'ADICIONAR_DOC_OUTROS' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.12</strong> Outros documentos complementares - Envio de documentação optativo!</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
        END IF;

        /*** CONCLUSAO ***/
        IF V_ERRO > 0 THEN
            PO_SUCESSO := 0;
        ELSE
            PO_SUCESSO := 1;
        END IF;
        
        PO_BODY             := V_BODY; 
        PO_BODY_OPTATIVO    := V_BODY_OPTATIVO;

    end proc_valida_cadastro_construcao;

    procedure proc_valida_cadastro_reforma (
        p_cod_temp_embarcacao    in number
        , po_sucesso             out number
        , po_body                out clob
        , po_body_optativo       out clob
    ) is
        v_body      clob;

        v_erro      number := 0;
        v_opicional number := 0;
        v_body_optativo clob;

        V_ERRO_OPTATIVO NUMBER := 0;

        V_URL clob;
        V_URL_PAGE varchar2(20);
        
        cursor cur_embarcacao is
        select *
        from temp_embarcacao
        where cod_embarcacao = p_cod_temp_embarcacao;
        
        v_embarcacao cur_embarcacao%rowtype;
        
        v_contrato_em_eficacia          number;
        v_cronograma_fis_fin            number;
        v_quadro_usos_fontes            number;
        v_arranjo_geral_embarcacao      number;
        v_licenca_provisoria            number;
        v_outros_documentos             number;
        V_DOC_PROPRIEDADE               NUMBER;
    begin
        open cur_embarcacao;
            fetch cur_embarcacao into v_embarcacao;
        close cur_embarcacao;      

        if v_erro > 0 then
            v_body := v_body || chr(13) || '<br>' || chr(13);
        end if;

        /*CAMPOS OBRIGATORIOS*/
        /***VALIDAÇÕES DA 2ª ETAPA (2)***/

        -- página para voltar no link
        V_URL_PAGE := 25;

        --  2.2 Nome da embarcação --
        if v_embarcacao.nome is null then

            v_url := apex_page.get_url (
                p_page   => V_URL_PAGE,
                p_items  => 'P25_ITEM_FOCUS',
                p_values => 'P25_NOME' 
            );

            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||V_URL||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 2.2.</strong> Nome - Informe um nome a embarcação!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;
        --

        -- 2.3 DOC PROPRIEDADE --
        SELECT COUNT(1)
          INTO V_DOC_PROPRIEDADE
          FROM TEMP_EMBARCACAO_DOCUMENTO
         WHERE COD_EMBARCACAO     = V_EMBARCACAO.COD_EMBARCACAO
           AND IND_TIPO_DOCUMENTO = 'P';

        IF V_DOC_PROPRIEDADE = 0 THEN

            V_URL := APEX_PAGE.GET_URL (
                P_PAGE   => V_URL_PAGE,
                P_ITEMS  => 'P25_ITEM_FOCUS',
                P_VALUES => 'ADICIONAR_DOC_PROPRIEDADE' 
            );
        
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||V_URL||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 2.3.</strong> Documentação de propriedade - Envio de documentação obrigatória!</a>';
            V_BODY := V_BODY || '</p>';
            
        END IF;
        --

        -- 2.4 Contrato (em eficácia) do serviço da embarcação --
        SELECT COUNT(1)
          INTO V_CONTRATO_EM_EFICACIA
          FROM TEMP_EMBARCACAO_DOCUMENTO
         WHERE COD_EMBARCACAO     = V_EMBARCACAO.COD_EMBARCACAO
           AND IND_TIPO_DOCUMENTO = 'CE';

        IF V_CONTRATO_EM_EFICACIA = 0 THEN

            V_URL := APEX_PAGE.GET_URL (
                P_PAGE   => V_URL_PAGE,
                P_ITEMS  => 'P25_ITEM_FOCUS',
                P_VALUES => 'ADICIONAR_DOC_CONTRATO_EM_EFICACIA' 
            );
        
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||V_URL||'"><i class="fa fa-info-circle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 2.4.</strong> Contrato (em eficácia) do serviço da embarcação  - Envio de documentação obrigatória!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;
        -- 

        --
        SELECT COUNT(1)
          INTO V_CRONOGRAMA_FIS_FIN
          FROM TEMP_EMBARCACAO_DOCUMENTO
         WHERE COD_EMBARCACAO     = V_EMBARCACAO.COD_EMBARCACAO
           AND IND_TIPO_DOCUMENTO = 'CF';

        IF V_CRONOGRAMA_FIS_FIN = 0 THEN

            V_URL := APEX_PAGE.GET_URL (
                P_PAGE   => V_URL_PAGE,
                P_ITEMS  => 'P25_ITEM_FOCUS',
                P_VALUES => 'ADICIONAR_DOC_CRONOGRAMA' 
            );
        
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||V_URL||'"><i class="fa fa-info-circle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 2.7.</strong> Cronograma físico-financeiro do contrato do serviço - Envio de documentação obrigatória!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;
        --

        --
        SELECT COUNT(1)
          INTO V_QUADRO_USOS_FONTES
          FROM TEMP_EMBARCACAO_DOCUMENTO
         WHERE COD_EMBARCACAO     = V_EMBARCACAO.COD_EMBARCACAO
           AND IND_TIPO_DOCUMENTO = 'Q';

        IF V_QUADRO_USOS_FONTES = 0 THEN

            V_URL := APEX_PAGE.GET_URL (
                P_PAGE   => V_URL_PAGE,
                P_ITEMS  => 'P25_ITEM_FOCUS',
                P_VALUES => 'ADICIONAR_DOC_QUADRO' 
            );
        
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 2.9.</strong> Quadro de usos e fontes - Envio de documentação obrigatória!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;
        --

        --
        SELECT COUNT(1)
          INTO V_ARRANJO_GERAL_EMBARCACAO
          FROM TEMP_EMBARCACAO_DOCUMENTO
         WHERE COD_EMBARCACAO     = V_EMBARCACAO.COD_EMBARCACAO
           AND IND_TIPO_DOCUMENTO = 'AG';

        IF V_ARRANJO_GERAL_EMBARCACAO = 0 THEN

            V_URL := APEX_PAGE.GET_URL (
                P_PAGE   => V_URL_PAGE,
                P_ITEMS  => 'P25_ITEM_FOCUS',
                P_VALUES => 'ADICIONAR_DOC_ARRANJO' 
            );
        
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 2.10.</strong> Arranjo geral da embarcação e plano de capacidade - Envio de documentação obrigatória!</a>';
            V_BODY := V_BODY || '</p>';
            
        END IF;
        --

        --
        SELECT COUNT(1)
          INTO V_LICENCA_PROVISORIA
          FROM TEMP_EMBARCACAO_DOCUMENTO
         WHERE COD_EMBARCACAO     = V_EMBARCACAO.COD_EMBARCACAO
           AND IND_TIPO_DOCUMENTO = 'LP';

        IF V_LICENCA_PROVISORIA = 0 THEN

            V_URL := APEX_PAGE.GET_URL (
                P_PAGE   => V_URL_PAGE,
                P_ITEMS  => 'P25_ITEM_FOCUS',
                P_VALUES => 'ADICIONAR_DOC_LICENCA_PROVISORIA' 
            );
        
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 2.11.</strong> Licença provisória de construção ou reforma da embarcação pela Autoridade Marítima Brasileira - 
                Envio de documentação obrigatória!</a>';
            V_BODY := V_BODY || '</p>';
            V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13);
        END IF;
        --

        /***VALIDAÇÕES OBRIGATÓRIAS DA 3ª ETAPA***/

        -- página para voltar no link
        v_url_page := 11;

        IF V_EMBARCACAO.TIPO_EMBARCACAO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_TIPO' 
            );

            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.1.</strong> Tipo da embarcação - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 

        IF V_EMBARCACAO.MATERIAL_CASCO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_MATERIAL_CASCO' 
            );
            
            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.5.</strong> Material de Construção do Casco - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 

        IF V_EMBARCACAO.NUM_BHP IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_BHP' 
            );
            
            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.7.</strong> BHP (potêncial) - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 

        IF V_EMBARCACAO.VALOR_ARQUEACAO_BRUTA IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_ARQUEACAO_BRUTA' 
            );
            
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.9.</strong> Arqueação Bruta AB/TAB (t) - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        IF V_EMBARCACAO.VALOR_TPB IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_TPB' 
            );
            
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.11.</strong> TPB - Tonelagem de Porte Bruto - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        IF V_EMBARCACAO.COMPRIMENTO_EMBARCACAO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_COMPRIMENTO_EMBARCACAO' 
            );
            
            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.12.</strong> Comprimento da embarcação (m) - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 
        
        IF V_EMBARCACAO.COMPRIMENTO_BOCA IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_BOCA' 
            );
            
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.13.</strong> BOCA (m) - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        IF V_EMBARCACAO.COMPRIMENTO_CALADO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_CALADO' 
            );
            
            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.14.</strong> Calado MÁX (m) / Draft - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
            V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
        END IF;  

        /***VALIDAÇÕES DA 4ª ETAPA***/
        --
        v_url_page := 10;

        IF V_EMBARCACAO.TIPO_NAVEGACAO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P10_ITEM_FOCUS',
                p_values => 'P10_TIPO_NAVEGACAO' 
            );
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 4.1.</strong> Modalidade(s) de Navegação - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 


        /***VALIDAÇÕES OPICIONAIS DA 1ª ETAPA***/
       /*** 1ª ETAPA***/
        --
        V_URL_PAGE := 5;
        --

        --
        IF V_EMBARCACAO.NUM_INSCRICAO IS NULL THEN 

            V_URL := APEX_PAGE.GET_URL (
                P_PAGE   => V_URL_PAGE,
                P_ITEMS  => 'P5_ITEM_FOCUS',
                P_VALUES => 'P5_NUM_INSCRICAO' 
            );
                        
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 1.3.</strong> Número de inscrição - Preenchimento opcional!</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';

        END IF; 
        --

        --
        IF V_EMBARCACAO.FINALIDADE_EMBARCACAO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P5_ITEM_FOCUS',
                p_values => 'P5_FINALIDADE_EMBARCACAO' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 1.4.</strong> Qual a finalidade do cadastro? - Preenchimento opcional!</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';

        END IF; 
        --

        --
        IF V_EMBARCACAO.DOCUMENTO_PROPRIEDADE IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P5_ITEM_FOCUS',
                p_values => 'P5_PROPRIEDADE' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 1.5.</strong> Propriedade (CNPJ ou CPF) - Preenchimento opcional!</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';

        END IF; 
        --

        --
        IF V_EMBARCACAO.CNPJ_ESTALEIRO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P5_ITEM_FOCUS',
                p_values => 'P5_CNPJ_ESTALEIRO' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 1.6.</strong> CNPJ do estaleiro - Preenchimento opcional!</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || CHR(13) || '<br>' || CHR(13); 

        END IF; 
        --

        /***OPICIONAIS DA 2ª ETAPA***/

        --
        IF V_EMBARCACAO.DATA_ASSINATURA_CONTRATO IS NULL THEN 

            V_URL := APEX_PAGE.GET_URL (
                p_page   => V_URL_PAGE,
                p_items  => 'P25_ITEM_FOCUS',
                p_values => 'P25_DATA_ASSINATURA_CONTRATO' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||V_URL||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.5.</strong> Data de assinatura do contrato (início do serviço) - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';

        END IF;
        --

        --
        IF V_EMBARCACAO.DATA_ASSINATURA_CONTRATO IS NULL THEN 

            V_URL := APEX_PAGE.GET_URL (
                p_page   => V_URL_PAGE,
                p_items  => 'P25_ITEM_FOCUS',
                p_values => 'P25_PREVISAO_CONCLUSAO_SERVICO' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||V_URL||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.6.</strong> Previsão de conclusão do serviço - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';

        END IF; 
        --

        --
        IF V_EMBARCACAO.SITUACAO_SERVICO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P25_ITEM_FOCUS',
                p_values => 'P25_SITUACAO_SERVICO' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.8.</strong> Situação do serviço - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';

        END IF;
        --

        --
        SELECT COUNT(1)
        INTO V_OUTROS_DOCUMENTOS
        FROM TEMP_EMBARCACAO_DOCUMENTO
        WHERE COD_EMBARCACAO     = V_EMBARCACAO.COD_EMBARCACAO
        AND IND_TIPO_DOCUMENTO = 'O';

        IF V_OUTROS_DOCUMENTOS = 0 THEN

            V_URL := APEX_PAGE.GET_URL (
                P_PAGE   => V_URL_PAGE,
                P_ITEMS  => 'P25_ITEM_FOCUS',
                P_VALUES => 'ADICIONAR_DOC_OUTROS' 
            );
        
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1;
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.12.</strong> Outros documentos complementares - Envio de documentação optativa!</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || CHR(13) || '<br>' || CHR(13);

        END IF;
        --

        /** Terceira etapa **/
        --
        V_URL_PAGE := 11;
        --
        IF V_EMBARCACAO.QTD_MOTOR IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_QTD_MOTORES_UTILIZADOS' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 3.8.</strong> Quantidade de motores utilizados - Preenchimento opcional!</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || CHR(13) || '<br>' || CHR(13); 

        END IF; 

        /*** CONCLUSAO ***/
        IF V_ERRO > 0 THEN
            PO_SUCESSO := 0;
        ELSE
            PO_SUCESSO := 1;
        END IF;
        
        PO_BODY             := V_BODY; 
        PO_BODY_OPTATIVO    := V_BODY_OPTATIVO;
    end proc_valida_cadastro_reforma;

    PROCEDURE PROC_VALIDA_CADASTRO_NACIONAL (
        P_COD_TEMP_EMBARCACAO    IN NUMBER
        , PO_SUCESSO             OUT NUMBER
        , PO_BODY                OUT CLOB
        , PO_BODY_OPTATIVO       OUT CLOB
    ) IS
        V_BODY      CLOB;

        V_ERRO      NUMBER := 0;
        V_OPICIONAL NUMBER := 0;
        V_BODY_OPTATIVO CLOB;
        V_ERRO_OPTATIVO NUMBER := 0;

        v_url clob;
        v_url_page varchar2(20);
        
        CURSOR CUR_EMBARCACAO IS
        SELECT *
        FROM TEMP_EMBARCACAO
        WHERE COD_EMBARCACAO = P_COD_TEMP_EMBARCACAO;
        
        V_EMBARCACAO CUR_EMBARCACAO%ROWTYPE;
        
        V_DOC_PROPRIEDADE              NUMBER;
        V_DOC_SEGURANCA                NUMBER;
        V_DOC_COMPLEMENTAR             NUMBER;
        V_FOTO_EMBARCACAO              NUMBER;
        V_NUM_PRPM                     NUMBER;
        V_NUM_TIE                      NUMBER;
        V_NUM_DPP                      NUMBER;
        V_NUM_PROTOCOLO_INSCRICAO      NUMBER;
        V_NUM_INSCRICAO_PROVISORIA     NUMBER;
        V_NATUREZA_TIPO_CARGA          NUMBER := 0;
        V_BHP                          NUMBER := 0;
        V_VALOR_CAPACIDADE_VEICULO     NUMBER := 0;
        V_VALOR_CAPACIDADE_TEUS        NUMBER := 0;
        V_VALOR_CAPACIDADE_PASSAGEIROS NUMBER := 0;
        V_TIPO_CARGA                   NUMBER;
        V_POSSUI_CLASSE                NUMBER;
    BEGIN

        OPEN CUR_EMBARCACAO;
            FETCH CUR_EMBARCACAO INTO V_EMBARCACAO;
        CLOSE CUR_EMBARCACAO;      

        if v_erro > 0 then
            V_BODY := V_BODY || chr(13) || '<br>' || chr(13);
        end if;

        -- página para voltar no link
        v_url_page := 2;

        /*CAMPOS OBRIGATORIOS*/
        /***VALIDAÇÕES DA 2ª ETAPA (2)***/

        /*CAMPOS OBRIGATORIOS*/
        --
        IF V_EMBARCACAO.NOME IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P2_ITEM_FOCUS',
                p_values => 'P2_NOME' 
            );

            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 2.2: </strong> Nome - Informe um nome a embarcação!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        
        /*CAMPO 2.3, 2.5, 2.6 E 2.7*/
        SELECT COUNT(1)
        INTO V_DOC_PROPRIEDADE
        FROM TEMP_EMBARCACAO_DOCUMENTO
        WHERE COD_EMBARCACAO     = V_EMBARCACAO.COD_EMBARCACAO
        AND IND_TIPO_DOCUMENTO = 'P';
        --
        SELECT COUNT(1)
        INTO V_DOC_SEGURANCA
        FROM TEMP_EMBARCACAO_DOCUMENTO
        WHERE COD_EMBARCACAO     = V_EMBARCACAO.COD_EMBARCACAO
        AND IND_TIPO_DOCUMENTO = 'S';
        --
        SELECT COUNT(1)
        INTO V_DOC_COMPLEMENTAR
        FROM TEMP_EMBARCACAO_DOCUMENTO
        WHERE COD_EMBARCACAO     = V_EMBARCACAO.COD_EMBARCACAO
        AND IND_TIPO_DOCUMENTO = 'C';
        --
        SELECT COUNT(1)
        INTO V_FOTO_EMBARCACAO
        FROM TEMP_EMBARCACAO_DOCUMENTO
        WHERE COD_EMBARCACAO     = V_EMBARCACAO.COD_EMBARCACAO
        AND IND_TIPO_DOCUMENTO = 'F';

        select count(*)
        INTO V_TIPO_CARGA
        from TEMP_EMBARCACAO_TIPO_CARGA
        where COD_TEMP_EMBARCACAO = V_EMBARCACAO.COD_EMBARCACAO;

        -- Verifica o tipo embarcação possui classo para verificar preenchimento obrigatório
        select count(*)
        INTO V_POSSUI_CLASSE
        from CLASSE_EMBARCACAO
        where COD_TIPO_EMBARCACAO = V_EMBARCACAO.TIPO_EMBARCACAO;

        
        IF V_DOC_PROPRIEDADE = 0 THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P2_ITEM_FOCUS',
                p_values => 'ADICIONAR_DOC_PROPRIEDADE' 
            );
        
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 2.3: </strong> Documentação de propriedade - Envio de documentação obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        IF V_DOC_SEGURANCA = 0 THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P2_ITEM_FOCUS',
                p_values => 'ADICIONAR_DOC_SEGURANCA'
            );

            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 2.5: </strong> Documentação de segurança - Envio de documentação obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 

        IF V_FOTO_EMBARCACAO = 0 THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P2_ITEM_FOCUS',
                p_values => 'ADICIONAR_FOTOS_EMBARCACAO'
            );

            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 2.7: </strong> Fotos da embarcação - Envio de documentação obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 
          
        IF V_EMBARCACAO.BANDEIRA_ORIGEM IS NULL THEN
            
            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P2_ITEM_FOCUS',
                p_values => 'P2_BANDEIRA_ORIGEM' 
            );

            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 2.8: </strong> Bandeira de origem - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        IF V_EMBARCACAO.BANDEIRA_ATUAL IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P2_ITEM_FOCUS',
                p_values => 'P2_BANDEIRA_ATUAL' 
            );

            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 2.9: </strong> Bandeira atual - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;
        
        IF V_EMBARCACAO.IND_NUM_IRIN = 'Y' AND V_EMBARCACAO.NUM_IRIN IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P2_ITEM_FOCUS',
                p_values => 'P2_NUMERO_IRIN' 
            );

            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 2.11: </strong> Número IRIM - Preenchimento obrigatório quando 2.10. Possui Número IRIM = "SIM"</a>';
            V_BODY := V_BODY || '</p>';
        END IF;
        
        
        /*CAMPOS OBRIGATORIOS*/

        /***VALIDAÇÕES DA 3ª ETAPA (10)***/
        /*CAMPOS 3.1, 3.2 E 3.3*/
        --

        -- página para voltar no link
        v_url_page := 11;

        IF V_EMBARCACAO.TIPO_EMBARCACAO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_TIPO' 
            );

            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.1.</strong> Tipo da embarcação - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 
        
        IF V_EMBARCACAO.CLASSE_EMBARCACAO IS NULL AND V_POSSUI_CLASSE > 0 THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_CLASSE' 
            );

            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.2.</strong> Classe - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        IF V_EMBARCACAO.SITUACAO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_SITUACAO' 
            );
            
            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.3.</strong> Situação - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 
        
        IF V_EMBARCACAO.ANO_EMBARCACAO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_ANO_CONSTRUCAO' 
            );
            
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.4.</strong> Ano de Construção - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        IF V_EMBARCACAO.MATERIAL_CASCO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_MATERIAL_CASCO' 
            );
            
            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.5.</strong> Material de Construção do Casco - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 
        
        IF V_EMBARCACAO.TIPO_PROPULSAO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_PROPULSAO_UTILIZADA' 
            );
            
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.6.</strong> Propulsão Utilizada - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        IF V_EMBARCACAO.NUM_BHP IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_BHP' 
            );
            
            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.7.</strong> BHP (potêncial) - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 
        
        IF V_EMBARCACAO.VALOR_ARQUEACAO_BRUTA IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_ARQUEACAO_BRUTA' 
            );
            
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.9.</strong> Arqueação Bruta AB/TAB (t) - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        IF V_EMBARCACAO.VALOR_ARQUEACAO_LIQUIDA IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_ARQUEACAO_LIQUIDA' 
            );
            
            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.10.</strong> Arqueação Líquida AB/TAB (t) - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 
        
        IF V_EMBARCACAO.VALOR_TPB IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_TPB' 
            );
            
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.11.</strong> TPB - Tonelagem de Porte Bruto - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        IF V_EMBARCACAO.COMPRIMENTO_EMBARCACAO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_COMPRIMENTO_EMBARCACAO' 
            );
            
            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.12.</strong> Comprimento da embarcação (m) - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 
        
        IF V_EMBARCACAO.COMPRIMENTO_BOCA IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_BOCA' 
            );
            
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.13.</strong> BOCA (m) - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;

        IF V_EMBARCACAO.COMPRIMENTO_CALADO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_CALADO' 
            );
            
            V_ERRO := V_ERRO + 1;

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.14.</strong> Calado MÁX (m) / Draft - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF; 
        
        IF V_EMBARCACAO.VALOR_VELOCIDADE IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_VELOCIDADE' 
            );
            
            V_ERRO := V_ERRO + 1;
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 3.15.</strong> Velocidade (nós) / Speed (Knots) - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;
        --

        /***VALIDAÇÕES DA 4ª ETAPA (11)***/
        /*CAMPOS 4.1 - 4.20*/
        --
        v_url_page := 10;

        IF V_EMBARCACAO.TIPO_NAVEGACAO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P10_ITEM_FOCUS',
                p_values => 'P10_TIPO_NAVEGACAO' 
            );
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 4.1.</strong> Modalidade(s) de Navegação - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;
        
        IF V_EMBARCACAO.AREA_NAVEGACAO IS NULL and V_EMBARCACAO.TIPO_NAVEGACAO in (4,2,6) THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P10_ITEM_FOCUS',
                p_values => 'P10_AREA_NAVEGACAO' 
            );
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
            V_BODY := V_BODY || '<strong> Campo 4.2.</strong> Área de Navegação - Preenchimento obrigatório!</a>';
            V_BODY := V_BODY || '</p>';
        END IF;
 
        /*CAMPOS OPICIONAIS*/
        /*TITULO*/
        --V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<h3> O sistema identificou a(s) seguinte(s) pendência(s) que não impede(m) o envio a Antaq: </h3>'; 
        --V_BODY := V_BODY || '<h4 align="center"> Documentação </h4>';
        /***OPICIONAIS DA 1ª ETAPA (1)***/
        v_url_page := 5;

        IF V_EMBARCACAO.NUM_INSCRICAO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P5_ITEM_FOCUS',
                p_values => 'P5_NUM_INSCRICAO' 
            );
                        
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 1.3.</strong> Número de inscrição - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';

        END IF; 

        /* só estrangeiro agora
        IF V_EMBARCACAO.FINALIDADE_EMBARCACAO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P5_ITEM_FOCUS',
                p_values => 'P5_FINALIDADE_EMBARCACAO' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 1.4.</strong> Qual a finalidade do cadastro? - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || CHR(13) || '<br>' || CHR(13); 

        END IF; */

        IF V_EMBARCACAO.DOCUMENTO_PROPRIEDADE IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P5_ITEM_FOCUS',
                p_values => 'P5_PROPRIEDADE' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 1.5.</strong> Propriedade (CNPJ ou CPF) - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || CHR(13) || '<br>' || CHR(13); 

        END IF; 
        --
        /***OPICIONAIS DA 2ª ETAPA (2)***/
        v_url_page := 2;

        IF V_EMBARCACAO.NUM_IMO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P2_ITEM_FOCUS',
                p_values => 'P2_NUMERO_IMO' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.1.</strong> Número IMO - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || CHR(13) || '<br>' || CHR(13); 

        END IF; 

        IF V_DOC_COMPLEMENTAR = 0 THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P2_ITEM_FOCUS',
                p_values => 'ADICIONAR_DOC_COMPLEMENTAR' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.6: </strong> Documentação complementar - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || CHR(13) || '<br>' || CHR(13);
        END IF;

        --
        /***OPICIONAIS DA 3ª ETAPA (3)***/
        --
        v_url_page := 11;
        IF V_EMBARCACAO.QTD_MOTOR IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P11_ITEM_FOCUS',
                p_values => 'P11_QTD_MOTORES_UTILIZADOS' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 3.8.</strong> Quantidade de motores utilizados - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || CHR(13) || '<br>' || CHR(13); 

        END IF; 

        --
        /***OPICIONAIS DA 4ª ETAPA (4)***/
        --
        v_url_page := 10;
        IF V_TIPO_CARGA = 0 THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P10_NATUREZA_TIPO_CARGA' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 4.3</strong> Tipos de cargas - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || CHR(13) || '<br>' || CHR(13); 

        END IF; 

        /*** CONCLUSAO ***/
        IF V_ERRO > 0 THEN
            PO_SUCESSO := 0;
        ELSE
            PO_SUCESSO := 1;
        END IF;
        
        PO_BODY             := V_BODY; 
        PO_BODY_OPTATIVO    := V_BODY_OPTATIVO;
    
    END PROC_VALIDA_CADASTRO_NACIONAL;

    /***
    Cadastro Estrangeiro
    */
    PROCEDURE PROC_VALIDA_CADASTRO_ESTRANGEIRA (
          P_COD_TEMP_EMBARCACAO IN  NUMBER 
        , PO_SUCESSO            OUT NUMBER 
        , PO_BODY               OUT CLOB
        , PO_BODY_OPTATIVO      OUT CLOB
    ) IS 
    
        V_BODY          CLOB;         
        V_ERRO          NUMBER := 0; 
        V_BODY_OPTATIVO CLOB;
        V_ERRO_OPTATIVO NUMBER := 0;

        v_url_page VARCHAR2(22);
        v_url clob;
        
        CURSOR CUR_EMBARCACAO IS 
        SELECT * 
        FROM TEMP_EMBARCACAO 
        WHERE COD_EMBARCACAO = P_COD_TEMP_EMBARCACAO; 
        
        V_EMBARCACAO CUR_EMBARCACAO%ROWTYPE; 
        
        V_DOC_COMPROBATORIA     NUMBER; 
        V_NUM_IMO               NUMBER; 
        V_NUM_IRIN              NUMBER; 
        V_TIPO_NAVAVEGACAO      NUMBER; 
        V_BHP                   NUMBER; 
        V_TEUS                  NUMBER; 
        V_ANO                   NUMBER; 
        V_FINALIDADE_EMBARCACAO NUMBER;
        V_EMBARCACAO_TIPO_CARGA NUMBER;
        
    BEGIN 
        
        OPEN CUR_EMBARCACAO; 
        FETCH CUR_EMBARCACAO INTO V_EMBARCACAO; 
        CLOSE CUR_EMBARCACAO;         

        /***VALIDAÇÕES DA 1ª ETAPA***/ 

        /*CAMPOS OPTATIVOS: 1.4*/
        /*CAMPO 1.4*/ 
        SELECT COUNT(1) 
          INTO V_FINALIDADE_EMBARCACAO 
          FROM TEMP_EMBARCACAO
         WHERE COD_EMBARCACAO           = V_EMBARCACAO.COD_EMBARCACAO 
           AND FINALIDADE_EMBARCACAO    IS NOT NULL; 
        
        v_url_page := 5;

        IF V_FINALIDADE_EMBARCACAO = 0  THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P5_FINALIDADE_EMBARCACAO' 
            );
            
            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 1.4: </strong> Qual a finalidade do cadastro? - Preenchimento opcional.</a>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || CHR(13) || '<br>' || CHR(13); 

        END IF; 
        /*CAMPO 1.4*/ 

        /*CAMPOS OPTATIVOS*/ 
       

        /***VALIDAÇÕES DA 2ª ETAPA***/ 

        /*CAMPOS OPTATIVOS*/
         
        /*CAMPO 2.1 Número IMO*/
        SELECT COUNT(1) 
          INTO V_NUM_IMO 
          FROM TEMP_EMBARCACAO 
         WHERE COD_EMBARCACAO = V_EMBARCACAO.COD_EMBARCACAO 
           AND NUM_IMO IS NOT NULL; 
        
        v_url_page := 4;

        IF V_NUM_IMO = 0  THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P4_NUMERO_IMO' 
            );

            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.1: </strong> Número IMO - Preenchimento opcional.</a>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>';

        END IF; 

        /*CAMPO 2.1 Número IMO*/

        /*CAMPO 2.11 Número IRIN*/
        IF V_EMBARCACAO.NUM_IRIN IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P4_NUMERO_IRIN' 
            );

            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 2.11: </strong> Número IRIN - Preenchimento opcional.</a>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || CHR(13) || '<br>' || CHR(13); 

        END IF; 
        /*CAMPO 2.11 Número IRIN*/

        /*CAMPOS OPTATIVOS*/ 

        /*CAMPOS OBRIGATORIOS*/ 

        /*CAMPO 2.2 Certificado de classe da embarcação*/
        IF V_EMBARCACAO.NOME IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P4_NOME' 
            );

            V_ERRO := V_ERRO + 1; 
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
            V_BODY := V_BODY || '<strong> Campo 2.2: </strong> Nome da embarcação - Preenchimento obrigatório!</a>'; 
            V_BODY := V_BODY || '</p>';

        END IF; 
        /*CAMPO 2.2 Certificado de classe da embarcação*/

        /*CAMPO 2.4 Certificado de classe da embarcação*/
        SELECT COUNT(1) 
        INTO V_DOC_COMPROBATORIA 
        FROM TEMP_EMBARCACAO_DOCUMENTO 
        WHERE COD_EMBARCACAO     = V_EMBARCACAO.COD_EMBARCACAO 
        AND IND_TIPO_DOCUMENTO = 'E'; 
        
        IF V_DOC_COMPROBATORIA = 0  THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'ADICIONAR_DOC_PROPRIEDADE' 
            );

            V_ERRO := V_ERRO + 1; 
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
            V_BODY := V_BODY || '<strong> Campo 2.4: </strong> Certificado de classe da embarcação - Envio de documentação obrigatório!</a>'; 
            V_BODY := V_BODY || '</p>';

        END IF; 
        /*CAMPO 2.4 Certificado de classe da embarcação */
        
        /*CAMPO 2.8 Bandeira de Origem */
        IF V_EMBARCACAO.BANDEIRA_ORIGEM IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P4_BANDEIRA_ORIGEM' 
            );

            V_ERRO := V_ERRO + 1; 
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
            V_BODY := V_BODY || '<strong> Campo 2.8: </strong> Bandeira de Origem - Preenchimento obrigatório!</a>'; 
            V_BODY := V_BODY || '</p>';
            V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 

        END IF; 
        /*CAMPO 2.8 Bandeira de Origem */

        /*CAMPOS OBRIGATORIOS*/ 


        /***VALIDAÇÕES DA 3ª ETAPA***/ 

        /*CAMPOS OPTATIVOS*/
        /*CAMPOS OPTATIVOS*/

        /*CAMPOS OBRIGATORIOS*/ 

        /*CAMPO 3.1 Tipo */
        v_url_page := 11;

        IF V_EMBARCACAO.TIPO_EMBARCACAO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P11_TIPO' 
            );

            V_ERRO := V_ERRO + 1; 
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
            V_BODY := V_BODY || '<strong> Campo 3.1: </strong> Tipo - Preenchimento obrigatório!</a>'; 
            V_BODY := V_BODY || '</p>';

        END IF; 
        /*CAMPO 3.1 Tipo */
        
        /*CAMPO 3.2 Classe */
        IF V_EMBARCACAO.CLASSE_EMBARCACAO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P11_CLASSE' 
            );

            V_ERRO := V_ERRO + 1; 
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
            V_BODY := V_BODY || '<strong> Campo 3.2: </strong> Classe - Preenchimento obrigatório!</a>'; 
            V_BODY := V_BODY || '</p>';

        END IF; 
        /*CAMPO 3.2 Classe */

        /*CAMPO 3.3 Situação */
        IF V_EMBARCACAO.SITUACAO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P11_SITUACAO' 
            );

            V_ERRO := V_ERRO + 1; 

            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
            V_BODY := V_BODY || '<strong> Campo 3.3: </strong> Situação - Preenchimento obrigatório!</a>'; 
            V_BODY := V_BODY || '</p>';
        END IF; 

        /*CAMPO 3.3 Situação */
        
        /*CAMPO 3.4 Ano de Construção */
        IF V_EMBARCACAO.ANO_EMBARCACAO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P11_ANO_CONSTRUCAO' 
            );

            V_ERRO := V_ERRO + 1; 
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
            V_BODY := V_BODY || '<strong> Campo 3.4: </strong> Ano de construção - Preenchimento obrigatório!</a>'; 
            V_BODY := V_BODY || '</p>';

        END IF; 

        /*CAMPO 3.9 Arqueação Bruta AB/TAB (t) */
        IF V_EMBARCACAO.VALOR_ARQUEACAO_BRUTA IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P11_ARQUEACAO_BRUTA' 
            );

            V_ERRO := V_ERRO + 1; 
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
            V_BODY := V_BODY || '<strong> Campo 3.9: </strong> Arqueação Bruta AB/TAB (t) - Preenchimento obrigatório!</a>'; 
            V_BODY := V_BODY || '</p>';

        END IF; 
        /*CAMPO 3.9 Arqueação Bruta AB/TAB (t) */

        /*CAMPO 3.10 Arqueação Líquida AB/TAB (t) */
        IF V_EMBARCACAO.VALOR_ARQUEACAO_LIQUIDA IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P11_ARQUEACAO_LIQUIDA' 
            );

            V_ERRO := V_ERRO + 1; 
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
            V_BODY := V_BODY || '<strong> Campo 3.10: </strong> Arqueação Líquida AB/TAB (t) - Preenchimento obrigatório!</a>'; 
            V_BODY := V_BODY || '</p>';

        END IF; 
        /*CAMPO 3.10 Arqueação Líquida AB/TAB (t) */

        /*CAMPO 3.11 TPB – Tonelagem de Porte Bruto */
        IF V_EMBARCACAO.VALOR_TPB IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P11_TPB' 
            );

            V_ERRO := V_ERRO + 1; 
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
            V_BODY := V_BODY || '<strong> Campo 3.11: </strong> TPB – Tonelagem de Porte Bruto - Preenchimento obrigatório!</a>'; 
            V_BODY := V_BODY || '</p>';

        END IF; 
        /*CAMPO 3.11 TPB – Tonelagem de Porte Bruto */

        /*CAMPO 3.12 Comprimento da embarcação (m) */
        IF V_EMBARCACAO.COMPRIMENTO_EMBARCACAO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P11_COMPRIMENTO_EMBARCACAO' 
            );

            V_ERRO := V_ERRO + 1; 
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
            V_BODY := V_BODY || '<strong> Campo 3.12: </strong> Comprimento da embarcação (m) - Preenchimento obrigatório!</a>'; 
            V_BODY := V_BODY || '</p>';

        END IF; 
        /*CAMPO 3.12 Comprimento da embarcação (m) */

        /*CAMPO 3.13 BOCA */
        IF V_EMBARCACAO.COMPRIMENTO_BOCA IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P11_BOCA' 
            );

            V_ERRO := V_ERRO + 1; 
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
            V_BODY := V_BODY || '<strong> Campo 3.13: </strong> BOCA - Preenchimento obrigatório!</a>'; 
            V_BODY := V_BODY || '</p>';

        END IF; 
        /*CAMPO 3.13 BOCA */
        
        /*CAMPO 3.14 Calado MÁX (m) / Draft */
        IF V_EMBARCACAO.COMPRIMENTO_CALADO IS NULL THEN

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P11_CALADO' 
            );

            V_ERRO := V_ERRO + 1; 
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
            V_BODY := V_BODY || '<strong> Campo 3.14: </strong> Calado MÁX (m) / Draft - Preenchimento obrigatório!</a>'; 
            V_BODY := V_BODY || '</p>';

        END IF; 
        /*CAMPO 3.14 Calado MÁX (m) / Draft */
        
        /*CAMPO 3.15. Velocidade (nós) / Speed (Knots) */
        IF V_EMBARCACAO.VALOR_VELOCIDADE IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P11_VELOCIDADE' 
            );

            V_ERRO := V_ERRO + 1; 
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
            V_BODY := V_BODY || '<strong> Campo 3.15: </strong> Velocidade (nós) / Speed (Knots) - Preenchimento obrigatório!</a>'; 
            V_BODY := V_BODY || '</p>';
            V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
            
        END IF; 
        /*CAMPO 3.15. Velocidade (nós) / Speed (Knots) */

        /***VALIDAÇÕES DA 3ª ETAPA***/ 

        /*CAMPOS OBRIGATORIOS*/ 

        /***VALIDAÇÕES DA 4ª ETAPA***/ 

        /*CAMPOS OBRIGATORIOS*/ 
        v_url_page := 10;

        /*CAMPO 4.1 Modalidade(s) de Navegação */
        IF V_EMBARCACAO.TIPO_NAVEGACAO IS NULL THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P10_TIPO_NAVEGACAO' 
            );

            V_ERRO := V_ERRO + 1; 
            
            V_BODY := V_BODY || '<p style="text-align: left; margin: 0;">';
            V_BODY := V_BODY || '<a href="'||v_url||'"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
            V_BODY := V_BODY || '<strong> Campo 4.1: </strong> Modalidade(s) de Navegação - Preenchimento obrigatório!</a>'; 
            V_BODY := V_BODY || '</p>';
            V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 

        END IF; 
        /*CAMPO 4.1 Modalidade(s) de Navegação */

        /*CAMPOS OBRIGATORIOS*/ 

        /*CAMPOS OPTATIVOS*/

        /*CAMPO 4.3 Tipos da carga */
        SELECT COUNT(1)
          INTO V_EMBARCACAO_TIPO_CARGA
          FROM TEMP_EMBARCACAO_TIPO_CARGA
         WHERE COD_TEMP_EMBARCACAO = V_EMBARCACAO.COD_EMBARCACAO;

        IF V_EMBARCACAO_TIPO_CARGA = 0 THEN 

            v_url := APEX_PAGE.GET_URL (
                p_page   => v_url_page,
                p_items  => 'P'||v_url_page||'_ITEM_FOCUS',
                p_values => 'P10_NATUREZA_TIPO_CARGA' 
            );

            V_ERRO_OPTATIVO := V_ERRO_OPTATIVO + 1; 
            
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<p style="text-align: left; margin: 0;">';
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<a href="'||v_url||'"><i class="fa fa-info-circle" aria-hidden="true"></i>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '<strong> Campo 4.3: </strong> Tipos da carga - Preenchimento opcional.</a>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || '</p>'; 
            V_BODY_OPTATIVO := V_BODY_OPTATIVO || CHR(13) || '<br>' || CHR(13); 

        END IF; 

        IF V_ERRO > 0 THEN 
            V_BODY          := V_BODY           || CHR(13) || '<br>' || CHR(13);             
        END IF; 
    
        
        IF V_ERRO > 0 THEN 
            V_BODY          := V_BODY || CHR(13) || '<br>' || CHR(13); 
        END IF; 
        /***VALIDAÇÕES DA 4ª ETAPA (14)***/ 
        
        /*** CONCLUSAO ***/ 
        IF V_ERRO > 0 THEN 
            PO_SUCESSO := 0; 
        ELSE 
            PO_SUCESSO := 1; 
        END IF; 
        
        PO_BODY             := V_BODY;  
        PO_BODY_OPTATIVO    := V_BODY_OPTATIVO;

    END PROC_VALIDA_CADASTRO_ESTRANGEIRA; 

--
END PCK_VALIDACAO_CADASTRO_EMBARCACAO;
/
create or replace PACKAGE BODY PCK_VALIDACAO_CADASTRO_EMBARCACAO_1 AS 
-- 
 PROCEDURE PROC_VALIDA_CADASTRO_ESTRANGEIRA (P_COD_TEMP_EMBARCACAO IN NUMBER 
                                            ,PO_SUCESSO           OUT NUMBER 
                                            ,PO_BODY              OUT CLOB) IS 
-- 
 V_BODY      CLOB; 
 V_ERRO      NUMBER := 0; 
 V_OPICIONAL NUMBER := 0; 
-- 
 CURSOR CUR_EMBARCACAO IS 
 SELECT * 
   FROM TEMP_EMBARCACAO 
  WHERE COD_EMBARCACAO = P_COD_TEMP_EMBARCACAO; 
-- 
 V_EMBARCACAO CUR_EMBARCACAO%ROWTYPE; 
-- 
 V_DOC_COMPROBATORIA NUMBER; 
 V_NUM_IMO           NUMBER; 
 V_NUM_IRIN          NUMBER; 
 V_TIPO_NAVAVEGACAO  NUMBER; 
 V_BHP               NUMBER; 
 V_TEUS              NUMBER; 
 V_ANO               NUMBER; 
-- 
 BEGIN 
  -- 
   OPEN CUR_EMBARCACAO; 
   FETCH CUR_EMBARCACAO INTO V_EMBARCACAO; 
   CLOSE CUR_EMBARCACAO; 
  -- 
   /*CAMPOS OBRIGATORIOS*/ 
   /*TITULO*/ 
   V_BODY := '<h3> O sistema identificou a(s) seguinte(s) pendência(s) que impede(m) o envio a Antaq: </h3>';  
   V_BODY := V_BODY || CHR(13); 
  -- 
   /***VALIDAÇÕES DA 2ª ETAPA (4)***/ 
   /*CAMPO 2.1, 2.2, 2.3 E 2.4*/ 
   SELECT COUNT(1) 
     INTO V_DOC_COMPROBATORIA 
     FROM TEMP_EMBARCACAO_DOCUMENTO 
    WHERE COD_EMBARCACAO     = V_EMBARCACAO.COD_EMBARCACAO 
      AND IND_TIPO_DOCUMENTO = 'B'; 
  -- 
   IF V_DOC_COMPROBATORIA = 0 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 2.1: </strong> Documentação comprobatória - Envio de documentação obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_EMBARCACAO.NUM_IMO IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 2.2: </strong> Número IMO - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   SELECT COUNT(*) 
     INTO V_NUM_IMO 
     FROM EMBARCACAO E 
    WHERE E.NUM_IMO         = V_EMBARCACAO.NUM_IMO 
      AND E.COD_EMBARCACAO != V_EMBARCACAO.CODIGO_EMBARCACAO_ATIVO; 
  -- 
   IF V_NUM_IMO > 0 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 2.2: </strong> Número IMO - Já existe uma embarcação com o Nº IMO informado'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_EMBARCACAO.NOME IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 2.3: </strong> Nome - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_EMBARCACAO.NUM_IRIN IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 2.4: </strong> Número IRIN - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   SELECT COUNT(*) 
     INTO V_NUM_IRIN 
     FROM EMBARCACAO E 
    WHERE E.NUM_IMO         = V_EMBARCACAO.NUM_IMO 
      AND E.COD_EMBARCACAO != V_EMBARCACAO.CODIGO_EMBARCACAO_ATIVO; 
  -- 
   IF V_NUM_IRIN > 0 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 2.4: </strong> Número IRIN - Já existe uma embarcação com o Nº IRIN informado'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_EMBARCACAO.BANDEIRA_ATUAL IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 2.5: </strong> Bandeira atual - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_ERRO > 0 
    THEN 
      -- 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   /***VALIDAÇÕES DA 3ª ETAPA (13)***/ 
   /*CAMPOS 3.1, 3.2 E 3.3*/ 
  -- 
   IF V_EMBARCACAO.TIPO_NAVEGACAO IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 3.1: </strong> Modalidade de navegação - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  --  
   IF V_EMBARCACAO.AREA_NAVEGACAO IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 3.2: </strong> Área de navegação - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   FOR X IN ( SELECT COLUMN_VALUE 
                FROM (PCK_UTIL.F_STRING_TO_ROWS(V_EMBARCACAO.TIPO_NAVEGACAO, ':')) 
               WHERE COLUMN_VALUE NOT IN (5,3) ) LOOP 
    -- 
     V_TIPO_NAVAVEGACAO := V_TIPO_NAVAVEGACAO + 1; 
    -- 
   END LOOP; 
  -- 
   IF V_EMBARCACAO.NATUREZA_TIPO_CARGA IS NULL AND V_TIPO_NAVAVEGACAO > 0 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 3.3: </strong> Natureza ou tipo de carga - Quando Tipo de Navegação for diferente de Apoio Marítimo ou Apoio Portuário ou (e) Rebocador/Empurrador, a natureza ou tipo carga deve ser informado.'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_ERRO > 0 
    THEN 
      -- 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   /***VALIDAÇÕES DA 4ª ETAPA (14)***/ 
   /*CAMPOS 4.1 - 4.20*/ 
  -- 
   IF V_EMBARCACAO.TIPO_EMBARCACAO IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 4.1: </strong> Tipo - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_EMBARCACAO.CLASSE_EMBARCACAO IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 4.2: </strong> Classe - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_EMBARCACAO.SITUACAO IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 4.3: </strong> Situação - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_EMBARCACAO.ANO_EMBARCACAO IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 4.4: </strong> Ano de construção - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   V_ANO := EXTRACT(YEAR FROM SYSDATE); 
  -- 
   IF V_EMBARCACAO.ANO_EMBARCACAO IS NOT NULL AND V_EMBARCACAO.ANO_EMBARCACAO > V_ANO 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 4.4: </strong> Ano de construção - O ano de construção não pode ser maior que o ano atual ('|| V_ANO || '). Por favor, insira um ano válido.'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13);  
      -- 
   END IF; 
  -- 
   FOR X IN ( SELECT COLUMN_VALUE 
                FROM (PCK_UTIL.F_STRING_TO_ROWS(V_EMBARCACAO.TIPO_NAVEGACAO, ':')) 
               WHERE COLUMN_VALUE IN (3,5) ) LOOP 
    -- 
     V_BHP := V_BHP + 1; 
    -- 
   END LOOP; 
  -- 
   IF V_EMBARCACAO.NUM_BHP IS NULL AND V_BHP > 0 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 4.5: </strong> BHP - Quando Tipo de Navegação for igual a Apoio Marítimo ou Apoio Portuário, o BHP deve ser informado.'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_EMBARCACAO.VALOR_ARQUEACAO_BRUTA IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 4.6: </strong> Arqueação bruta - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_EMBARCACAO.VALOR_ARQUEACAO_LIQUIDA IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 4.7: </strong> Arqueação líquida - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_EMBARCACAO.VALOR_TPB IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 4.8: </strong> TPB Tonelagem de porte bruto - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   FOR X IN ( SELECT COLUMN_VALUE 
                FROM (PCK_UTIL.F_STRING_TO_ROWS(V_EMBARCACAO.TIPO_NAVEGACAO, ':')) 
               WHERE COLUMN_VALUE IN (8) ) LOOP 
    -- 
     V_TEUS := V_TEUS + 1; 
    -- 
   END LOOP; 
  -- 
   IF V_EMBARCACAO.VALOR_CAPACIDADE_TEUS IS NULL AND V_TEUS > 0 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 4.9: </strong> Capacidade de TEUs - Quando Tipo de Navegação for igual a Porta Conteiner, a capacidade de TEUs deve ser informado.'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_EMBARCACAO.COMPRIMENTO_EMBARCACAO IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 4.10: </strong> Comprimento da embarcação - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_EMBARCACAO.COMPRIMENTO_BOCA IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 4.11: </strong> Boca(m) - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_EMBARCACAO.COMPRIMENTO_CALADO IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 4.12: </strong> Calado MÁX(m)/Draft - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_EMBARCACAO.VALOR_VELOCIDADE IS NULL 
    THEN 
      -- 
       V_ERRO := V_ERRO + 1; 
      -- 
       V_BODY := V_BODY || '<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>'; 
       V_BODY := V_BODY || '<strong> Campo 4.13: </strong> Velocidade(nós) / Speed (knots) - Preenchimento obrigatório!'; 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   IF V_ERRO > 0 
    THEN 
      -- 
       V_BODY := V_BODY || CHR(13) || '<br>' || CHR(13); 
      -- 
   END IF; 
  -- 
   /*** CONCLUSAO ***/ 
   IF V_ERRO > 0 
    THEN 
      -- 
       PO_SUCESSO := 0; 
      -- 
    ELSE 
      -- 
       PO_SUCESSO := 1; 
      -- 
   END IF; 
  -- 
   PO_BODY := V_BODY;  
  -- 
 END PROC_VALIDA_CADASTRO_ESTRANGEIRA; 
-- 
END PCK_VALIDACAO_CADASTRO_EMBARCACAO_1;
/