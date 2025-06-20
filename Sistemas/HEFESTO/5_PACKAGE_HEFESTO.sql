create or replace PACKAGE PCK_API_MGI IS
/*
  NOME               : PCK_API_MGI
  DATA_CRIACAO       : 30/10/2024
  CRIADO_POR         : ANDRE GOBI
  ULTIMA_ATUALIZACAO : 09/11/2024
  ESPECIFICACAO      : Package que contem os metodos utilizados pelo API Programa de Gestão - PGD, integrando os dados a SEGES/MGI
                       url: https://api-pgd.dth.api.gov.br/docs#/
*/
--
 CS_URL_API                  CONSTANT VARCHAR2(255) := 'https://api-pgd.dth.api.gov.br';
 CS_SISTEMA                  CONSTANT VARCHAR2(255) := 'Hefesto/2.0.0 (https://des-apex.antaq.gov.br/ords/r/hefesto/hefesto)';
 CS_ORIGEM_UNIDADE           CONSTANT VARCHAR2(25)  := 'SIORG';
 CS_COD_UNIDADE_AUTORIZADORA CONSTANT NUMBER        :=  54843;
--
 CS_USUARIO_API  CONSTANT VARCHAR2(255) := 'giordano.azevedo@antaq.gov.br';
 CS_PASSWORD_API CONSTANT VARCHAR2(255) := 'UWQ3SQYBZ6';
--
 V_TOKEN       VARCHAR2(500);
 V_STATUS_CODE NUMBER;
--
 PROCEDURE PRC_LOGIN_API(PO_ACCESS_TOKEN OUT VARCHAR2
                        ,PO_TOKEN_TYPE   OUT VARCHAR2);
--
 PROCEDURE PRC_AUTENTICACAO;
--
 PROCEDURE PRC_REGISTRA_LOG (P_PROCESSO IN VARCHAR2
                            ,P_URL      IN VARCHAR2
                            ,P_METODO   IN VARCHAR2
                            ,P_STATUS   IN NUMBER
                            ,P_REQUEST  IN CLOB
                            ,P_RESPONSE IN CLOB
                            ,P_CHAVE    IN NUMBER);
--
 PROCEDURE PRC_PARTICIPANTE (P_COD_TERMO_CIENCIA IN NUMBER);
--
 PROCEDURE PRC_PLANO_ENTREGA (P_COD_PLANO IN NUMBER);
--
 PROCEDURE PRC_PLANO_TRABALHO (P_COD_PLANO_TRABALHO IN NUMBER);
--
 TYPE REC_PARTICIPANTE IS RECORD (ORIGEM_UNIDADE           VARCHAR2(25)
                                 ,COD_UNIDADE_AUTORIZADORA NUMBER 
                                 ,COD_UNIDADE_LOCATACAO    NUMBER
                                 ,MATRICULA_SIAPE          VARCHAR2(255)
                                 ,COD_UNIDADE_INSTITUIDORA NUMBER
                                 ,CPF                      VARCHAR2(25)
                                 ,SITUACAO                 NUMBER
                                 ,MODALIDADE_EXECUCAO      NUMBER
                                 ,DATA_ASSINATURA_TCR      VARCHAR2(25)); 
--
 TYPE TP_PARTICIPANTE IS TABLE OF REC_PARTICIPANTE;
--
 TYPE REC_PLANO_ENTREGA IS RECORD(ORIGEM_UNIDADE            VARCHAR2(25)
                                 ,COD_UNIDADE_AUTORIZADORA  NUMBER
                                 ,COD_UNIDADE_INSTITUIDORA  NUMBER
                                 ,COD_UNIDADE_EXECUTORA     NUMBER
                                 ,ID_PLANO_ENTREGA          VARCHAR2(25)
                                 ,STATUS                    NUMBER
                                 ,DATA_INICIO               VARCHAR2(25)
                                 ,DATA_TERMINO              VARCHAR2(25)
                                 ,AVALIACAO                 NUMBER
                                 ,DATA_AVALIACAO            VARCHAR2(25)
                                --
                                 ,ID_ENTREGA                VARCHAR2(25)
                                 ,NOME_ENTREGA              VARCHAR2(300)
                                 ,ENTREGA_CANCELADA         NUMBER
                                 ,META_ENTREGA              NUMBER  
                                 ,TIPO_META                 VARCHAR2(25)
                                 ,DATA_ENTREGA              VARCHAR2(25) 
                                 ,NOME_UNIDADE_DEMANDANTE   VARCHAR2(300)
                                 ,NOME_UNIDADE_DESTINATARIA VARCHAR2(300));
--
 TYPE TP_PLANO_ENTREGA IS TABLE OF REC_PLANO_ENTREGA;
--
 TYPE REC_PLANO_TRABALHO IS RECORD(ORIGEM_UNIDADE                   VARCHAR2(25)
                                  ,COD_UNIDADE_AUTORIZADORA         NUMBER
                                  ,ID_PLANO_TRABALHO                VARCHAR2(25)
                                  ,STATUS                           NUMBER
                                  ,COD_UNIDADE_EXECUTORA            NUMBER
                                  ,CPF_PARTICIPANTE                 VARCHAR2(25)
                                  ,MATRICULA_SIAPE                  VARCHAR2(255)
                                  ,COD_UNIDADE_LOTACAO_PARTICIPANTE NUMBER
                                  ,DATA_INICIO                      VARCHAR2(25)
                                  ,DATA_TERMINO                     VARCHAR2(25)
                                  ,CARGA_HORARIA_DISPONIVEL         NUMBER
                                 -- 
                                  ,ID_CONTRIBUICAO                  VARCHAR2(25)
                                  ,TIPO_CONTRIBUICAO                NUMBER
                                  ,PERCENTUAL_CONTRIBUICAO          NUMBER
                                  ,ID_PLANO_ENTREGAS                VARCHAR2(25)
                                  ,ID_ENTREGA                       VARCHAR2(25)
                                 --
                                  ,ID_PERIODO_AVALIATIVO             VARCHAR2(25)
                                  ,DATA_INICIO_PERIODO_AVALIATIVO    VARCHAR2(25)
                                  ,DATA_FIM_PERIODO_AVALIATIVO       VARCHAR2(25)
                                  ,AVALIACAO_REGISTROS_EXECUCAO      NUMBER
                                  ,DATA_AVALIACAO_REGISTROS_EXECUCAO VARCHAR2(25));
--
 TYPE TP_PLANO_TRABALHO IS TABLE OF REC_PLANO_TRABALHO;
--
 FUNCTION FNC_PARTICIPANTE (P_COD_SERVIDOR IN NUMBER, P_TOKEN IN VARCHAR2) 
   RETURN TP_PARTICIPANTE PIPELINED;
--
 FUNCTION FNC_PLANO_ENTREGA (P_COD_PLANO IN NUMBER, P_TOKEN IN VARCHAR2) 
   RETURN TP_PLANO_ENTREGA PIPELINED;
--
 FUNCTION FNC_PLANO_TRABALHO (P_COD_PLANO_TRABALHO IN NUMBER, P_TOKEN IN VARCHAR2)
   RETURN TP_PLANO_TRABALHO PIPELINED;
--
 PROCEDURE PRC_REGISTRO_INTEGRACAO (P_CODIGO      IN NUMBER   DEFAULT NULL
                                   ,P_API         IN VARCHAR2 DEFAULT NULL
                                   ,P_PROCESSO    IN VARCHAR2 DEFAULT NULL
                                   ,P_CHAVE       IN VARCHAR2 DEFAULT NULL
                                   ,P_STATUS_CODE IN NUMBER   DEFAULT NULL);
--
 PROCEDURE PRC_INTEGRAR_TERMO_CIENCIA;
-- 
 PROCEDURE PRC_INTEGRAR_PLANO_ENTREGA;
--
 PROCEDURE PRC_INTEGRAR_PLANO_TRABALHO;
--
end;
/
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
create or replace PACKAGE PCK_DATA_VIGENCIA IS

    -- Procedure para atualizar a situação do projeto, considerando o se encontra-se como pactuado e se está em data vigente
    PROCEDURE PROC_ATUALIZAR_SITUACAO_PROJETO;

    -- Procedure para atualizar a situação do plano de entregas, considerando o se encontra-se como pactuado e se está em data vigente
    PROCEDURE PROC_ATUALIZAR_SITUACAO_PLANO_ENTREGA;

    -- Procedure para atualizar a situação do plano de trabalho, considerando o se encontra-se como pactuado e se está em data vigente
    PROCEDURE PROC_ATUALIZAR_SITUACAO_PLANO_TRABALHO;

    -- Procedure para atualizar a situação do plano de trabalho, considerando o se encontra-se como pactuado e se está em data vigente
    PROCEDURE PROC_ATUALIZAR_SITUACAO_PLANO_TRABALHO_ATIVIDADE;

END PCK_DATA_VIGENCIA;
/
create or replace PACKAGE PCK_FERIADO AS
/*
    NOME              : PCK_FERIADO
    DATA_CRIACAO      : 18/10/2024
    CRIADO_POR        : CLEITON CRUZ
    ULTIMA_ATUALIZACAO: 18/10/2024
    ATUALIZADO_POR    : CLEITON CRUZ
    ESPECIFICACAO     : Package que administra procedimentos da rotina de feriados.
*/

    -- Procedimento que irá inativar feriamos cadastrados com tipo de data Móvel
    PROCEDURE PRC_INATIVAR_FERIADOS_MOVEIS;

END PCK_FERIADO;
/
create or replace PACKAGE "PCK_HEFESTO" AS
/*
  NOME              : PCK_VALIDACOES
  DATA_CRIACAO      : 27/03/2024
  CRIADO_POR        : ADSON LIMA
  ULTIMA_ATUALIZACAO: 27/03/2024 08:49
  ESPECIFICACAO     : Package que contem os componente de HEFESTO.
*/
--==============================================================================
-- PROCEDURE
--==============================================================================
PROCEDURE PC_COPIA_PLANO_ENTREGA (P_COD_PLANO IN NUMBER, P_DESCRICAO_PLANO IN VARCHAR2, P_COD_PLANO_NEW OUT NUMBER, P_CAMPO OUT VARCHAR2, P_STATUS OUT VARCHAR2, P_MSG OUT VARCHAR2);
--
FUNCTION F_CONTROLE_ACESSO (P_USER IN VARCHAR2,P_COD_PERFIL IN VARCHAR2,P_COD_PAGE IN VARCHAR2,P_ACAO IN VARCHAR2) RETURN NUMBER;
--
FUNCTION F_UORG_ACESSO (P_USER IN VARCHAR2,P_GLOBAL_PERFIL_COD IN NUMBER,P_UORG IN NUMBER) RETURN NUMBER;

END "PCK_HEFESTO";
/
create or replace PACKAGE "PCK_LOG" AS

--==============================================================================
-- COMMENTS ABOUT PROCEDURE
--==============================================================================
PROCEDURE PRC_INSERT_LOG (
    P_TABLE_NAME      IN     VARCHAR2,
    P_ACTION          IN     VARCHAR2,
    P_COLUMM          IN     VARCHAR2,
    P_COLUMM_LABEL    IN     VARCHAR2,
    P_OLD_VALUES      IN     VARCHAR2,
    P_NEW_VALUES      IN     VARCHAR2,
    P_ID              IN     NUMBER );


END "PCK_LOG";
/
create or replace PACKAGE PCK_NOTIFICACAO AS 
/*
  NOME              : PCK_NOTIFICACAO
  DATA_CRIACAO      : 04/09/2024
  CRIADO_POR        : ANDRE GOBI
  ULTIMA_ATUALIZACAO: 04/09/2024 12:02
  ESPECIFICACAO     : Package que contem os metodos de notificacao do sistema
*/
--
 C_URL_BASE        VARCHAR2(255) := PCK_UTIL.F_URL_APLICACAO;
--
 TYPE REC_EMAIL_PARAMETRO IS RECORD (PARAMETRO VARCHAR2(255)
                                    ,SEQUENCIA NUMBER);
--
 TYPE TAB_EMAIL_PARAMETRO IS TABLE OF REC_EMAIL_PARAMETRO;                                     
 /**/
 FUNCTION F_EMAIL_PARAMETRO(P_ID_EMAIL IN NUMBER) RETURN TAB_EMAIL_PARAMETRO PIPELINED;
--
 /**/
 PROCEDURE PROC_ENVIA_EMAIL (P_ID_EMAIL                IN NUMBER
                            ,P_DESTINATARIO            IN VARCHAR2
                            ,P_PARAMETROS              IN VARCHAR2
                            ,P_SPLIT                   IN VARCHAR2
                            ,P_PARAMETRO_ASSUNTO       IN VARCHAR2);

 /*
  Quando inicar um novo mês Então sistema deverá enviar automaticamente o E-mail-05 conforme a RNG-139
  NOME              : ENV_EMAIL_RNG_139
  DATA_CRIACAO      : 18/10/2024
  CRIADO_POR        : ADSON LIMA
  ULTIMA_ATUALIZACAO: 18/10/2024 12:02
*/
  PROCEDURE ENV_EMAIL_RNG_139;

/**/
   FUNCTION F_EMAIL_DESTINATARIO_TESTE RETURN VARCHAR2; 
--
END;
/
create or replace package PCK_PLANO_ENTREGA as

    --
    FUNCTION F_CALCULAR_PERCENTUAL_DIAS_UTEIS(p_cod_projeto_tarefa IN NUMBER, p_data_inicio IN DATE, p_data_fim IN DATE) RETURN NUMBER;
    --
    
end PCK_PLANO_ENTREGA;
/
create or replace PACKAGE PCK_PLANO_TRABALHO IS
/*
  NOME              : PCK_PLANO_TRABALHO
  DATA_CRIACAO      : 27/02/2024
  CRIADO_POR        : ANDRE GOBI
  ULTIMA_ATUALIZACAO: 25/10/2024 16:44
  ESPECIFICACAO     : Package que contem os metodos utilizados pelo Plano de trabalho
  ATUALIZAÇÕES:
  25/10/2024 - Larissa Leite - Taiga #588, #566 - Ajustada PRC_CALCULA_CARGA_HORARIA_DISPONIVEL para não subtrair novamente desta conta um feriado que já esteja contido dentro de um período de afastamento/ocorrência. Isso acarretava em horas negativas.
  06/11/2024 - Larissa Leite - Taiga #669, #583, #703 - Ajustada PRC_CALCULA_CARGA_HORARIA_DISPONIVEL para considerar carga horária devida e passar a tratar horas personalizadas pelo usuário ao cadastrar ocorrencia. Criada PRC_ENVIA_EMAIL_PLANO_CADASTRADO para controle de emails quando novo plano.
  12/11/2024 - Adson Lima - Taiga #828 - Ajustada PRC_CALCULA_CARGA_HORARIA_DISPONIVEL para considerar a os feriados inativos não contabilizar os feriados nos finais de semana.

*/
--
 FUNCTION F_CALCULA_HORAS_SITUACAO (P_COD_PLANO_TRABALHO IN NUMBER
                                   ,P_COD_SITUACAO       IN VARCHAR2)
   RETURN NUMBER;
--
 /*RETORNA AS CARGAS HORARIAS DO PLANO DE TRABALHO*/
 FUNCTION F_RETORNA_CARGA_HORARIA_MIN (P_COD_PLANO_TRABALHO IN NUMBER)
   RETURN NUMBER;
--
 FUNCTION F_RETORNA_CARGA_HORARIA_MAX (P_COD_PLANO_TRABALHO IN NUMBER)
   RETURN NUMBER;
--
 /*CALCULA A CARGA HORARIA DISPONIVEL DE UM SERVIDOR, DENTRO DE UM DETERMINADO PERIODO*/
 PROCEDURE PRC_CALCULA_CARGA_HORARIA_DISPONIVEL(P_COD_SERVIDOR       IN NUMBER
                                               ,P_DATA_INICIO        IN DATE
                                               ,P_DATA_FIM           IN DATE
                                               ,PO_COD_UORG         OUT NUMBER
                                               ,PO_CARGA_HORARIA    OUT NUMBER
                                               ,PO_DIAS_UTEIS       OUT NUMBER
                                               ,PO_DIAS_AFASTAMENTO OUT NUMBER
                                               ,PO_CARGA_HORARIA_DEVIDA OUT NUMBER);
--
 /*FAZ O REGISTRO DAS OCORRENCIAS DO SISTEMA*/
 PROCEDURE PRC_REGISTRA_OCORRENCIA (P_COD_OCORRENCIA  IN  NUMBER DEFAULT NULL
                                   ,P_COD_SERVIDOR    IN  NUMBER
                                   ,P_TIPO_OCORRENCIA IN  NUMBER
                                   ,P_TIPO_DEBITO     IN  NUMBER
                                   ,P_DESCRICAO       IN  VARCHAR2
                                   ,P_DATA_INICIO     IN  DATE
                                   ,P_DATA_FIM        IN  DATE
                                   ,PO_COD_OCORRENCIA OUT NUMBER
                                   ,P_MES_LIMITE_COMPENSACAO IN NUMBER DEFAULT NULL
                                   ,P_HORA_DURACAO IN NUMBER DEFAULT NULL);
--
 /*FAZ A BUSCA DAS CARGAS HORARIAS E ATUALIZA OS PLANOS DE TRABALHO DE UM SERVIDOR*/
 PROCEDURE PRC_RECALCULAR_HORAS_SERVIDOR (P_COD_SERVIDOR IN NUMBER);
--

--
 /*ENVIA EMAIL DE NOTIFICAÇÃO PARA OS SERVIDORES E REPONSAVEIS*/
 PROCEDURE PRC_ENVIA_EMAIL_PLANO_CONCLUIDO (P_COD_PLANO_TRABALHO IN NUMBER);
 PROCEDURE PRC_ENVIA_EMAIL_PLANO_CADASTRADO (P_COD_PLANO_TRABALHO IN NUMBER);
--


END;
/
create or replace PACKAGE "PCK_PROJETO" AS
/*
    NOME              : PCK_FERIADO
    DATA_CRIACAO      : 18/10/2024
    CRIADO_POR        : CLEITON CRUZ
    ULTIMA_ATUALIZACAO: 18/10/2024
    ATUALIZADO_POR    : CLEITON CRUZ
    ESPECIFICACAO     : Package da rotina de projetos
*/

--
    FUNCTION F_DIAS_UTEIS_FIM_SEMANA_FERIADO(DATA_INICIO IN DATE, DATA_FIM IN DATE, COD_UORG_FK IN VARCHAR2) RETURN NUMBER; 
--

--
END "PCK_PROJETO";
/
create or replace PACKAGE PCK_TCR AS
/*
    NOME              : PCK_TCR
    DATA_CRIACAO      : 07/11/2024
    CRIADO_POR        : LARISSA LEITE
    ESPECIFICACAO     : Package que administra procedimentos da rotina de TCR.
*/

    PROCEDURE PRC_ENVIA_EMAIL_TCR_CADASTRADO(P_COD_TERMO_CIENCIA IN NUMBER);

END PCK_TCR;
/
create or replace package "PCK_UORG" as
/*
  NOME              : PCK_UORG
  DATA_CRIACAO      : 11/11/2024
  CRIADO_POR        : Adson Lima
  ULTIMA_ATUALIZACAO: 11/11/2024 04:35
  ESPECIFICACAO      : Package que contem os metodos utilizados para UORG.
                       url: https://tree.taiga.io/project/gustavocsm-antaq-hefesto/us/703?milestone=415396
*/

   -- USUÁRIO RECEBERA UM E-MAIL IFORMANDO QUE A UORG DE EXERCICIO FOI ALTERADA 
   -- Card https://tree.taiga.io/project/gustavocsm-antaq-hefesto/us/703?milestone=415396

   PROCEDURE UORG_ENVIA_EMAIL_DIF_UORG;

end "PCK_UORG";
/
create or replace PACKAGE PCK_UTIL IS 
/* 
  NOME              : PCK_UTIL 
  DATA_CRIACAO      : 15/03/2024 
  CRIADO_POR        : ANDRE GOBI 
  ULTIMA_ATUALIZACAO: 30/09/2024 09:53 
  ALTERADO_POR      : CLEITON CRUZ 
  ALTERAÇÃO         : Inclusão da função F_CALCULAR_PERCENTUAL_DIAS_UTEIS 
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
 FUNCTION F_URL_APLICACAO RETURN VARCHAR2; 
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
  -- A FUNCAO VALIDA DIA UTIL
 FUNCTION F_VALIDA_DIA_UTIL(P_DATA IN DATE) RETURN VARCHAR2;
 --
 FUNCTION F_CALCULAR_HORAS_UTEIS(DATA_INICIO IN DATE, DATA_FIM IN DATE, HORA_UTIL IN NUMBER) RETURN NUMBER; 
 -- 
 FUNCTION F_MASK_CPF_CNPJ(P_DOCUMENTO IN VARCHAR2) RETURN VARCHAR2;  
 -- 
 FUNCTION F_VALIDA_CPF_CNPJ (P_CPF_CNPJ VARCHAR2) RETURN CHAR; 
 -- 
 FUNCTION F_CALCULA_HORA (P_TEMPO IN NUMBER) RETURN VARCHAR2; 
 -- 
 FUNCTION MASCARA_CPF(p_nro_cpf IN VARCHAR2) RETURN VARCHAR2; 
 -- 
 FUNCTION F_CALCULAR_PERCENTUAL_DIAS_UTEIS(p_data_inicio IN DATE, p_data_fim IN DATE, p_percentual IN NUMBER) RETURN DATE; 
 --
 FUNCTION F_GET_PARAMETRO_CONFIGURACAO(P_PARAMETRO IN VARCHAR2) RETURN VARCHAR2;
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
create or replace PACKAGE body PCK_API_MGI IS
--#
 PROCEDURE PRC_LOGIN_API(PO_ACCESS_TOKEN OUT VARCHAR2
                        ,PO_TOKEN_TYPE   OUT VARCHAR2) IS
--
 V_BODY VARCHAR2(4000);
 V_RES  CLOB;
--
 BEGIN
   --
    V_BODY := 'grant_type='                            || CHR(38) ||
              'username='      || CS_USUARIO_API       || CHR(38) ||
              'password='      || CS_PASSWORD_API      || CHR(38) || 
              'scope='                                 || CHR(38) ||
              'client_id='                             || CHR(38) || 
              'client_secret=';
   --
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(1).NAME  := 'content-type';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(1).VALUE := 'application/x-www-form-urlencoded';
   -- 
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(2).NAME  := 'User-Agent';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(2).VALUE := CS_SISTEMA;
   --
    V_RES := APEX_WEB_SERVICE.MAKE_REST_REQUEST(P_URL         => CS_URL_API || '/token'
                                               ,P_HTTP_METHOD => 'POST'
                                               ,P_BODY        => V_BODY);
   --
    /*GRAVA O LOG DA API*/
    PRC_REGISTRA_LOG (P_PROCESSO => 'PCK_API_MGI.PRC_LOGIN_API'
                     ,P_URL      => CS_URL_API || '/token'
                     ,P_METODO   => 'POST'
                     ,P_STATUS   => APEX_WEB_SERVICE.G_STATUS_CODE
                     ,P_REQUEST  => V_BODY
                     ,P_RESPONSE => V_RES
                     ,P_CHAVE    => 0);
   --
    V_STATUS_CODE := APEX_WEB_SERVICE.G_STATUS_CODE;
   --
    IF APEX_WEB_SERVICE.G_STATUS_CODE = 200
     THEN
       --
        APEX_JSON.PARSE(V_RES);
       --
        PO_ACCESS_TOKEN := APEX_JSON.GET_VARCHAR2('access_token');
        PO_TOKEN_TYPE   := APEX_JSON.GET_VARCHAR2('token_type');
       --
    END IF;
   --
 END PRC_LOGIN_API;
--#
 PROCEDURE PRC_AUTENTICACAO IS
--
 V_AUTH_TOKEN VARCHAR2(500);
 V_AUTH_TYPE  VARCHAR2(255);
--
 BEGIN
   --
    SELECT C001
      INTO V_TOKEN
      FROM APEX_COLLECTIONS
     WHERE COLLECTION_NAME = 'TOKEN_PCK_API_MGI';
   --
 EXCEPTION
  WHEN NO_DATA_FOUND
   THEN
     --
      PRC_LOGIN_API(PO_ACCESS_TOKEN => V_AUTH_TOKEN
                   ,PO_TOKEN_TYPE   => V_AUTH_TYPE);
     --
      APEX_COLLECTION.CREATE_COLLECTION(P_COLLECTION_NAME    => 'TOKEN_PCK_API_MGI'
                                       ,P_TRUNCATE_IF_EXISTS => 'YES');
     --
      APEX_COLLECTION.ADD_MEMBER(P_COLLECTION_NAME => 'TOKEN_PCK_API_MGI'
                                ,P_C001            => V_AUTH_TOKEN
                                ,P_C002            => V_AUTH_TYPE);
     --
      V_TOKEN := V_AUTH_TOKEN;
     --
 END PRC_AUTENTICACAO;
--
--#
 PROCEDURE PRC_PARTICIPANTE (P_COD_TERMO_CIENCIA IN NUMBER) IS
--
 CURSOR C_PARTICIPANTE IS
 SELECT TC.COD_TERMO_CIENCIA
    ,   TC.COD_REGIME_EXECUCAO_FK    MODALIDADE_EXECUCAO
    ,   TO_CHAR(CAST(DATA_ASSINATURA AS TIMESTAMP), 'YYYY-MM-DD"T"HH24:MI:SS.FF3') AS DATA_ASSINATURA_TCR
    ,   SE.CPF
    ,   SE.NUM_SIAPE MATRICULA_SIAPE
    ,   (SELECT U.COD_SIORG
           FROM BAR_UORG U
          WHERE U.COD = SE.COD_UORG) COD_UORG_LOTACAO
   FROM TERMO_CIENCIA TC
    ,   VW_BAR_SERVIDOR SE
  WHERE TC.COD_SERVIDOR_FK   = SE.CODIGO_SERVIDOR
    AND TC.COD_TERMO_CIENCIA = P_COD_TERMO_CIENCIA;
--
 V_PARTICIPANTE C_PARTICIPANTE%ROWTYPE;
--
 V_REQUEST VARCHAR2(1000);
 V_BODY    CLOB;
 V_RES     CLOB;
--
 BEGIN
   --
    OPEN  C_PARTICIPANTE;
    FETCH C_PARTICIPANTE INTO V_PARTICIPANTE;
    CLOSE C_PARTICIPANTE;
   --
    V_REQUEST := CS_URL_API || '/organizacao/'  || CS_ORIGEM_UNIDADE                ||
                               '/'              || CS_COD_UNIDADE_AUTORIZADORA      || 
                               '/'              || V_PARTICIPANTE.COD_UORG_LOTACAO  || 
                               '/participante/' || V_PARTICIPANTE.MATRICULA_SIAPE;
   --
    APEX_JSON.INITIALIZE_CLOB_OUTPUT;
   --
    APEX_JSON.OPEN_OBJECT(); --root
     --
      APEX_JSON.WRITE('origem_unidade',           CS_ORIGEM_UNIDADE);
      APEX_JSON.WRITE('cod_unidade_autorizadora', CS_COD_UNIDADE_AUTORIZADORA);
      APEX_JSON.WRITE('cod_unidade_lotacao',      V_PARTICIPANTE.COD_UORG_LOTACAO);
      APEX_JSON.WRITE('matricula_siape',          TO_CHAR(V_PARTICIPANTE.MATRICULA_SIAPE));
      APEX_JSON.WRITE('cod_unidade_instituidora', CS_COD_UNIDADE_AUTORIZADORA);
      APEX_JSON.WRITE('cpf',                      TO_CHAR(V_PARTICIPANTE.CPF));
      APEX_JSON.WRITE('situacao',                 1);
      APEX_JSON.WRITE('modalidade_execucao',      V_PARTICIPANTE.MODALIDADE_EXECUCAO);
      APEX_JSON.WRITE('data_assinatura_tcr',      V_PARTICIPANTE.DATA_ASSINATURA_TCR);
     --
    APEX_JSON.CLOSE_OBJECT(); --root 
   --
    V_BODY := APEX_JSON.GET_CLOB_OUTPUT;
    APEX_JSON.FREE_OUTPUT;
   --
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(1).NAME  := 'content-type';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(1).VALUE := 'application/json';
   -- 
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(2).NAME  := 'User-Agent';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(2).VALUE := CS_SISTEMA;
   --
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(3).NAME  := 'Authorization';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(3).VALUE := 'Bearer ' || V_TOKEN;
   --
    V_RES := APEX_WEB_SERVICE.MAKE_REST_REQUEST(P_URL         => V_REQUEST
                                               ,P_HTTP_METHOD => 'PUT'
                                               ,P_BODY        => V_BODY);
   --
    V_STATUS_CODE := APEX_WEB_SERVICE.G_STATUS_CODE;
   --
    /*GRAVA O LOG DA API*/
    PRC_REGISTRA_LOG (P_PROCESSO => 'PCK_API_MGI.PRC_PARTICIPANTE'
                     ,P_URL      => V_REQUEST
                     ,P_METODO   => 'PUT'
                     ,P_STATUS   => APEX_WEB_SERVICE.G_STATUS_CODE
                     ,P_REQUEST  => V_BODY
                     ,P_RESPONSE => V_RES
                     ,P_CHAVE    => P_COD_TERMO_CIENCIA);
   --
 END PRC_PARTICIPANTE;
--#
 PROCEDURE PRC_PLANO_ENTREGA (P_COD_PLANO IN NUMBER) IS
--
 CURSOR C_PLANO_ENTREGA IS
 SELECT PL.COD_PLANO COD
     ,  TO_CHAR(CAST(TO_DATE(PS.INICIO_SEMESTRE || '/' || TO_CHAR(PL.ANO, 'YYYY'), 'DD/MM/YYYY') AS TIMESTAMP), 'YYYY-MM-DD"T"HH24:MI:SS.FF3') DATA_INICIO
     ,  TO_CHAR(CAST(TO_DATE(PS.FIM_SEMESTRE    || '/' || TO_CHAR(PL.ANO, 'YYYY'), 'DD/MM/YYYY') AS TIMESTAMP), 'YYYY-MM-DD"T"HH24:MI:SS.FF3') DATA_FIM
     ,  DECODE(PL.IND_ATIVO, 'A', 1, 'I', 0) STATUS
     ,  '' AVALIACAO
     ,  (SELECT U.COD_SIORG
           FROM BAR_UORG U
          WHERE U.COD = PL.COD_UORG) COD_UORG
     ,  '' DATA_AVALIACAO
   FROM PLANO PL
     ,  PLANO_ENTREGA_SEMESTRE PS
  WHERE PL.COD_PLANO       = P_COD_PLANO
    AND PL.COD_SEMESTRE_FK = PS.COD_SEMESTRE;
--
 CURSOR C_ENTREGA IS
 SELECT PE.COD_PLANO_ENTREGA COD_ENTREGA
     ,  NVL(PE.DESCRICAO_ENTREGA,
            (SELECT PJ.DESCR_PROJETO_TAREFA
               FROM PROJETO_TAREFA PJ
              WHERE PJ.COD_PROJETO_TAREFA = PE.SELECIONE_ENTREGA)) DESCRICAO_ENTREGA
     ,  PE.META
     ,  DECODE(PE.TIPO_META, 1, 'percentual', 2, 'unidade') TIPO_META
     ,  TO_CHAR(CAST(PE.DATA_FIM AS TIMESTAMP), 'YYYY-MM-DD"T"HH24:MI:SS.FF3') DATA_FIM
     ,  (SELECT UO.SIGLA_UORG || ' - ' || UO.NOME_UORG
           FROM BAR_UORG UO
          WHERE UO.COD = PE.DEMANDANTE) DEMANDANTE
     ,  (SELECT UO.SIGLA_UORG || ' - ' || UO.NOME_UORG
           FROM BAR_UORG UO
          WHERE UO.COD = PE.DESTINATARIO) DESTINATARIO
   FROM PLANO_ENTREGA PE
  WHERE PE.COD_PLANO = P_COD_PLANO;
--
 V_PLANO_ENTREGA C_PLANO_ENTREGA%ROWTYPE;
--
 V_REQUEST VARCHAR2(1000);
 V_BODY    CLOB;
 V_RES     CLOB;
--
 BEGIN
   --
    OPEN  C_PLANO_ENTREGA;
    FETCH C_PLANO_ENTREGA INTO V_PLANO_ENTREGA;
    CLOSE C_PLANO_ENTREGA;
   --
    V_REQUEST := CS_URL_API || '/organizacao/'    || CS_ORIGEM_UNIDADE            ||
                               '/'                || CS_COD_UNIDADE_AUTORIZADORA  || 
                               '/plano_entregas/' || V_PLANO_ENTREGA.COD;
   --
    APEX_JSON.INITIALIZE_CLOB_OUTPUT;
   --
    APEX_JSON.OPEN_OBJECT(); --root
     --
      APEX_JSON.WRITE('origem_unidade',           CS_ORIGEM_UNIDADE);
      APEX_JSON.WRITE('cod_unidade_autorizadora', CS_COD_UNIDADE_AUTORIZADORA);
      APEX_JSON.WRITE('cod_unidade_instituidora', CS_COD_UNIDADE_AUTORIZADORA);
      APEX_JSON.WRITE('cod_unidade_executora',    V_PLANO_ENTREGA.COD_UORG);
      APEX_JSON.WRITE('id_plano_entregas',        TO_CHAR(V_PLANO_ENTREGA.COD));
      APEX_JSON.WRITE('status',                   V_PLANO_ENTREGA.STATUS);
      APEX_JSON.WRITE('data_inicio',              V_PLANO_ENTREGA.DATA_INICIO);
      APEX_JSON.WRITE('data_termino',             V_PLANO_ENTREGA.DATA_FIM);
      APEX_JSON.WRITE('avaliacao',                V_PLANO_ENTREGA.AVALIACAO, TRUE);
      APEX_JSON.WRITE('data_avaliacao',           V_PLANO_ENTREGA.DATA_AVALIACAO, TRUE);
     --
      APEX_JSON.OPEN_ARRAY('entregas');
       --
        FOR X IN C_ENTREGA LOOP
         --
          APEX_JSON.OPEN_OBJECT();
           --
            APEX_JSON.WRITE('id_entrega'               , TO_CHAR(X.COD_ENTREGA));
            APEX_JSON.WRITE('entrega_cancelada'        , FALSE);
            APEX_JSON.WRITE('nome_entrega'             , X.DESCRICAO_ENTREGA);
            APEX_JSON.WRITE('meta_entrega'             , X.META);
            APEX_JSON.WRITE('tipo_meta'                , X.TIPO_META);
            APEX_JSON.WRITE('data_entrega'             , X.DATA_FIM);
            APEX_JSON.WRITE('nome_unidade_demandante'  , X.DEMANDANTE);
            APEX_JSON.WRITE('nome_unidade_destinataria', X.DESTINATARIO);
           --
          APEX_JSON.CLOSE_OBJECT();
         --
        END LOOP;
       --
      APEX_JSON.CLOSE_ARRAY(); --entregas
     --
    APEX_JSON.CLOSE_OBJECT(); --root 
   --
    V_BODY := APEX_JSON.GET_CLOB_OUTPUT;
    APEX_JSON.FREE_OUTPUT;
   --
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(1).NAME  := 'content-type';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(1).VALUE := 'application/json';
   -- 
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(2).NAME  := 'User-Agent';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(2).VALUE := CS_SISTEMA;
   --
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(3).NAME  := 'Authorization';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(3).VALUE := 'Bearer ' || V_TOKEN;
   --
    V_RES := APEX_WEB_SERVICE.MAKE_REST_REQUEST(P_URL         => V_REQUEST
                                               ,P_HTTP_METHOD => 'PUT'
                                               ,P_BODY        => V_BODY);
    
   --
    V_STATUS_CODE := APEX_WEB_SERVICE.G_STATUS_CODE;
   --
    /*GRAVA O LOG DA API*/
    PRC_REGISTRA_LOG (P_PROCESSO => 'PCK_API_MGI.PRC_PLANO_ENTREGA'
                     ,P_URL      => V_REQUEST
                     ,P_METODO   => 'PUT'
                     ,P_STATUS   => APEX_WEB_SERVICE.G_STATUS_CODE
                     ,P_REQUEST  => V_BODY
                     ,P_RESPONSE => V_RES
                     ,P_CHAVE    => P_COD_PLANO);
   --
 END PRC_PLANO_ENTREGA;
--#
 PROCEDURE PRC_PLANO_TRABALHO (P_COD_PLANO_TRABALHO IN NUMBER) IS
--
 CURSOR C_PLANO_TRABALHO  IS
 SELECT PT.COD_PLANO_TRABALHO COD
    ,   (SELECT U.COD_SIORG
           FROM BAR_UORG U
          WHERE U.COD = PT.COD_UORG) COD_UORG
    ,   SE.CPF
    ,   SE.NUM_SIAPE MATRICULA_SIAPE
    ,   (SELECT U.COD_SIORG
           FROM BAR_UORG U
          WHERE U.COD = SE.COD_UORG) COD_UORG_LOTACAO
    ,   TO_CHAR(CAST(PT.DATA_INICIO AS TIMESTAMP), 'YYYY-MM-DD"T"HH24:MI:SS.FF3') DATA_INICIO
    ,   TO_CHAR(CAST(PT.DATA_FIM    AS TIMESTAMP), 'YYYY-MM-DD"T"HH24:MI:SS.FF3') DATA_FIM
    ,   PT.IND_CARGA_HORARIA_MINIMA CARGA_HORARIA
    ,   CASE WHEN PT.IND_ATIVO = 'I'
             THEN 1 --CANCELADO
             WHEN PT.IND_ATIVO = 'A' AND PT.IND_PLANO_SITUACAO IN ('E', 'S')
             THEN 3 --EM EXECUCAO
             WHEN PT.IND_ATIVO = 'A' AND PT.IND_PLANO_SITUACAO IN ('AV', 'P')
             THEN 4 --CONCLUIDO
        END AS STATUS
   FROM PLANO_TRABALHO PT
    ,   VW_BAR_SERVIDOR SE
  WHERE PT.COD_SERVIDOR       = SE.CODIGO_SERVIDOR
    AND PT.COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO;
--
 CURSOR C_CONTRIBUICAO IS
 SELECT PTA.COD_ATIVIDADE                                           ID_CONTRIBUICAO
   ,   DECODE(PTA.IND_TIPO_ATIVIDADE, 'VE', 1, 'NV', 2, 'VO', 3)    TIPO_CONTRIBUICAO
   ,   TRUNC((PTA.IND_ESFORCO / PT.IND_CARGA_HORARIA_MINIMA) * 100) PERCENTUAL_CONTRIBUICAO
   ,   PL.COD_PLANO                                                 ID_PLANO_ENTREGAS
   ,   PTA.COD_PLANO_ENTREGA                                        ID_ENTREGA
  FROM PLANO_TRABALHO PT
   ,   PLANO_TRABALHO_ATIVIDADE PTA
   ,   PLANO_ENTREGA PE
   ,   PLANO PL
 WHERE PT.COD_PLANO_TRABALHO = PTA.COD_PLANO_TRABALHO
   AND PTA.COD_PLANO_ENTREGA = PE.COD_PLANO_ENTREGA
   AND PE.COD_PLANO          = PL.COD_PLANO
   AND PT.COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO;
--
 CURSOR C_AVALIACAO IS
 SELECT PTA.COD_ATIVIDADE                                                            ID_PERIODO_AVALIATIVO
    ,  TO_CHAR(CAST(TRUNC(PTA.DATA_INICIO_EXECUCAO) AS TIMESTAMP), 'YYYY-MM-DD"T"HH24:MI:SS.FF3')     DATA_INICIO_PERIODO_AVALIATIVO
    ,  TO_CHAR(CAST(TRUNC(PTA.DATA_FIM_EXECUCAO)    AS TIMESTAMP), 'YYYY-MM-DD"T"HH24:MI:SS.FF3')     DATA_FIM_PERIODO_AVALIATIVO
    ,  DECODE(PTA.COD_MENCAO, 'E', 1
                            , 'D', 2
                            , 'A', 3
                            , 'I', 4
                            , 'N', 5)                                                AVALIACAO_REGISTROS_EXECUCAO
    ,  TO_CHAR(CAST(TRUNC(PTA.AVALIACAO_DATA) AS TIMESTAMP), 'YYYY-MM-DD"T"HH24:MI:SS.FF3') DATA_AVALIACAO_REGISTROS_EXECUCAO
  FROM PLANO_TRABALHO PT
    ,  PLANO_TRABALHO_ATIVIDADE PTA
 WHERE PT.COD_PLANO_TRABALHO = PTA.COD_PLANO_TRABALHO
   AND PTA.COD_MENCAO        IS NOT NULL
   AND PT.COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO;
--
 V_PLANO_TRABALHO C_PLANO_TRABALHO%ROWTYPE;
--
 V_REQUEST VARCHAR2(1000);
 V_BODY    CLOB;
 V_RES     CLOB;
--
 BEGIN
   --
    OPEN  C_PLANO_TRABALHO;
    FETCH C_PLANO_TRABALHO INTO V_PLANO_TRABALHO;
    CLOSE C_PLANO_TRABALHO;
   --
    V_REQUEST := CS_URL_API || '/organizacao/'    || CS_ORIGEM_UNIDADE            ||
                               '/'                || CS_COD_UNIDADE_AUTORIZADORA  || 
                               '/plano_trabalho/' || V_PLANO_TRABALHO.COD;
   --
    APEX_JSON.INITIALIZE_CLOB_OUTPUT;
   --
    APEX_JSON.OPEN_OBJECT(); --root
     --
      APEX_JSON.WRITE('origem_unidade',                   CS_ORIGEM_UNIDADE);
      APEX_JSON.WRITE('cod_unidade_autorizadora',         CS_COD_UNIDADE_AUTORIZADORA);
      APEX_JSON.WRITE('id_plano_trabalho',                TO_CHAR(V_PLANO_TRABALHO.COD));
      APEX_JSON.WRITE('status',                           V_PLANO_TRABALHO.STATUS);
      APEX_JSON.WRITE('cod_unidade_executora',            V_PLANO_TRABALHO.COD_UORG);
      APEX_JSON.WRITE('cpf_participante',                 TO_CHAR(V_PLANO_TRABALHO.CPF));
      APEX_JSON.WRITE('matricula_siape',                  TO_CHAR(V_PLANO_TRABALHO.MATRICULA_SIAPE));
      APEX_JSON.WRITE('cod_unidade_lotacao_participante', V_PLANO_TRABALHO.COD_UORG_LOTACAO);
      APEX_JSON.WRITE('data_inicio',                      V_PLANO_TRABALHO.DATA_INICIO);
      APEX_JSON.WRITE('data_termino',                     V_PLANO_TRABALHO.DATA_FIM);
      APEX_JSON.WRITE('carga_horaria_disponivel',         V_PLANO_TRABALHO.CARGA_HORARIA);
     --
      APEX_JSON.OPEN_ARRAY('contribuicoes');
       --
        FOR CT IN C_CONTRIBUICAO LOOP
         --
          APEX_JSON.OPEN_OBJECT();
           --
            APEX_JSON.WRITE('id_contribuicao',   TO_CHAR(CT.ID_CONTRIBUICAO));
            APEX_JSON.WRITE('tipo_contribuicao', CT.TIPO_CONTRIBUICAO);
           --
            IF CT.PERCENTUAL_CONTRIBUICAO = 0
             THEN
               --
                APEX_JSON.WRITE('percentual_contribuicao', 1);
               --
             ELSE
               --
                APEX_JSON.WRITE('percentual_contribuicao', CT.PERCENTUAL_CONTRIBUICAO);
               --
            END IF;
           -- 
            APEX_JSON.WRITE('id_plano_entregas', TO_CHAR(CT.ID_PLANO_ENTREGAS));
            APEX_JSON.WRITE('id_entrega',        TO_CHAR(CT.ID_ENTREGA));
           --
          APEX_JSON.CLOSE_OBJECT();
         --
        END LOOP;
       --
      APEX_JSON.CLOSE_ARRAY(); --contribuicoes
     --
      APEX_JSON.OPEN_ARRAY('avaliacoes_registros_execucao');
       --
      /*  FOR AV IN C_AVALIACAO LOOP
         --
          APEX_JSON.OPEN_OBJECT();
           --
            APEX_JSON.WRITE('id_periodo_avaliativo'            , TO_CHAR(AV.ID_PERIODO_AVALIATIVO));
            APEX_JSON.WRITE('data_inicio_periodo_avaliativo'   , AV.DATA_INICIO_PERIODO_AVALIATIVO);
            APEX_JSON.WRITE('data_fim_periodo_avaliativo'      , AV.DATA_FIM_PERIODO_AVALIATIVO);
            APEX_JSON.WRITE('avaliacao_registros_execucao'     , AV.AVALIACAO_REGISTROS_EXECUCAO);
            APEX_JSON.WRITE('data_avaliacao_registros_execucao', AV.DATA_AVALIACAO_REGISTROS_EXECUCAO);
           --
          APEX_JSON.CLOSE_OBJECT();
         --
        END LOOP;*/
       --
      APEX_JSON.CLOSE_ARRAY(); --avaliacoes_registros_execucao
     --
    APEX_JSON.CLOSE_OBJECT(); --root 
   --
    V_BODY := APEX_JSON.GET_CLOB_OUTPUT;
    APEX_JSON.FREE_OUTPUT;
   --
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(1).NAME  := 'content-type';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(1).VALUE := 'application/json';
   -- 
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(2).NAME  := 'User-Agent';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(2).VALUE := CS_SISTEMA;
   --
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(3).NAME  := 'Authorization';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(3).VALUE := 'Bearer ' || V_TOKEN;
   --
    V_RES := APEX_WEB_SERVICE.MAKE_REST_REQUEST(P_URL         => V_REQUEST
                                               ,P_HTTP_METHOD => 'PUT'
                                               ,P_BODY        => V_BODY);
   --
    V_STATUS_CODE := APEX_WEB_SERVICE.G_STATUS_CODE;
   --
    /*GRAVA O LOG DA API*/
    PRC_REGISTRA_LOG (P_PROCESSO => 'PCK_API_MGI.PRC_PLANO_TRABALHO'
                     ,P_URL      => V_REQUEST
                     ,P_METODO   => 'PUT'
                     ,P_STATUS   => APEX_WEB_SERVICE.G_STATUS_CODE
                     ,P_REQUEST  => V_BODY
                     ,P_RESPONSE => V_RES
                     ,P_CHAVE    => P_COD_PLANO_TRABALHO); 
   --
 END PRC_PLANO_TRABALHO;
--#
 PROCEDURE PRC_REGISTRA_LOG (P_PROCESSO IN VARCHAR2
                            ,P_URL      IN VARCHAR2
                            ,P_METODO   IN VARCHAR2
                            ,P_STATUS   IN NUMBER
                            ,P_REQUEST  IN CLOB
                            ,P_RESPONSE IN CLOB
                            ,P_CHAVE    IN NUMBER) IS
--
 BEGIN
   --
    INSERT INTO LOG_API (PROCESSO, URL, METODO, STATUS_CODE, REQUEST, RESPONSE, CHAVE_REGISTRO)
         VALUES (P_PROCESSO
                ,P_URL
                ,P_METODO
                ,P_STATUS
                ,P_REQUEST
                ,P_RESPONSE
                ,P_CHAVE);
   --
    COMMIT;
   --
 END PRC_REGISTRA_LOG;
--#
 FUNCTION FNC_PARTICIPANTE (P_COD_SERVIDOR IN NUMBER, P_TOKEN IN VARCHAR2) 
   RETURN TP_PARTICIPANTE PIPELINED IS
--
 V_REQUEST VARCHAR2(1000);
 V_RES     CLOB;
--
 CURSOR C_SERVIDOR IS
 SELECT SE.NUM_SIAPE MATRICULA_SIAPE
    ,   (SELECT U.COD_SIORG
           FROM BAR_UORG U
          WHERE U.COD = SE.COD_UORG) COD_UORG_LOTACAO
   FROM VW_BAR_SERVIDOR SE
  WHERE SE.CODIGO_SERVIDOR = P_COD_SERVIDOR;
--
 V_SERVIDOR     C_SERVIDOR%ROWTYPE;
 V_PARTICIPANTE REC_PARTICIPANTE;
--
 BEGIN
   --
    OPEN  C_SERVIDOR;
    FETCH C_SERVIDOR INTO V_SERVIDOR;
    CLOSE C_SERVIDOR;
   --
    V_REQUEST := CS_URL_API || '/organizacao/'  || CS_ORIGEM_UNIDADE            ||
                               '/'              || CS_COD_UNIDADE_AUTORIZADORA  || 
                               '/'              || V_SERVIDOR.COD_UORG_LOTACAO  || 
                               '/participante/' || V_SERVIDOR.MATRICULA_SIAPE;
   --
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(1).NAME  := 'content-type';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(1).VALUE := 'application/json';
   -- 
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(2).NAME  := 'User-Agent';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(2).VALUE := CS_SISTEMA;
   --
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(3).NAME  := 'Authorization';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(3).VALUE := 'Bearer ' || P_TOKEN;
   --
    V_RES := APEX_WEB_SERVICE.MAKE_REST_REQUEST(P_URL         => V_REQUEST
                                               ,P_HTTP_METHOD => 'GET');
   --
    IF APEX_WEB_SERVICE.G_STATUS_CODE = 200
     THEN
       --
        APEX_JSON.PARSE(V_RES);
       --
        V_PARTICIPANTE.ORIGEM_UNIDADE           := APEX_JSON.GET_VARCHAR2('origem_unidade');
        V_PARTICIPANTE.COD_UNIDADE_AUTORIZADORA := APEX_JSON.GET_NUMBER  ('cod_unidade_autorizadora');
        V_PARTICIPANTE.COD_UNIDADE_LOCATACAO    := APEX_JSON.GET_NUMBER  ('cod_unidade_lotacao');
        V_PARTICIPANTE.MATRICULA_SIAPE          := APEX_JSON.GET_VARCHAR2('matricula_siape');
        V_PARTICIPANTE.COD_UNIDADE_INSTITUIDORA := APEX_JSON.GET_NUMBER  ('cod_unidade_instituidora');
        V_PARTICIPANTE.CPF                      := APEX_JSON.GET_VARCHAR2('cpf');
        V_PARTICIPANTE.SITUACAO                 := APEX_JSON.GET_NUMBER  ('situacao');
        V_PARTICIPANTE.MODALIDADE_EXECUCAO      := APEX_JSON.GET_NUMBER  ('modalidade_execucao');
        V_PARTICIPANTE.DATA_ASSINATURA_TCR      := APEX_JSON.GET_VARCHAR2('data_assinatura_tcr');
       --
        PIPE ROW(V_PARTICIPANTE);
       --
    END IF;
   --
    RETURN;
   --
 END FNC_PARTICIPANTE;
--#
 FUNCTION FNC_PLANO_ENTREGA (P_COD_PLANO IN NUMBER, P_TOKEN IN VARCHAR2) 
   RETURN TP_PLANO_ENTREGA PIPELINED IS
--
 CURSOR C_PLANO_ENTREGA IS
 SELECT PL.COD_PLANO COD
     ,  (SELECT U.COD_SIORG
           FROM BAR_UORG U
          WHERE U.COD = PL.COD_UORG) COD_UORG
   FROM PLANO PL
  WHERE PL.COD_PLANO  = P_COD_PLANO;
--
 V_PLANO_ENTREGA C_PLANO_ENTREGA%ROWTYPE;
--
 V_REQUEST VARCHAR2(1000);
 V_RES     CLOB;
 V_PLANO   REC_PLANO_ENTREGA;
--
 BEGIN
   --
    OPEN  C_PLANO_ENTREGA;
    FETCH C_PLANO_ENTREGA INTO V_PLANO_ENTREGA;
    CLOSE C_PLANO_ENTREGA;
   --
    V_REQUEST := CS_URL_API || '/organizacao/'    || CS_ORIGEM_UNIDADE            ||
                               '/'                || CS_COD_UNIDADE_AUTORIZADORA  || 
                               '/plano_entregas/' || V_PLANO_ENTREGA.COD;
   --
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(1).NAME  := 'content-type';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(1).VALUE := 'application/json';
   -- 
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(2).NAME  := 'User-Agent';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(2).VALUE := CS_SISTEMA;
   --
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(3).NAME  := 'Authorization';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(3).VALUE := 'Bearer ' || P_TOKEN;
   --
    V_RES := APEX_WEB_SERVICE.MAKE_REST_REQUEST(P_URL         => V_REQUEST
                                               ,P_HTTP_METHOD => 'GET');
   --
    IF APEX_WEB_SERVICE.G_STATUS_CODE = 200
     THEN
       --
        APEX_JSON.PARSE(V_RES);
       --
        V_PLANO.ORIGEM_UNIDADE           := APEX_JSON.GET_VARCHAR2('origem_unidade');
        V_PLANO.COD_UNIDADE_AUTORIZADORA := APEX_JSON.GET_NUMBER  ('cod_unidade_autorizadora');
        V_PLANO.COD_UNIDADE_INSTITUIDORA := APEX_JSON.GET_NUMBER  ('cod_unidade_instituidora');
        V_PLANO.COD_UNIDADE_EXECUTORA    := APEX_JSON.GET_NUMBER  ('cod_unidade_executora');
        V_PLANO.ID_PLANO_ENTREGA         := APEX_JSON.GET_VARCHAR2('id_plano_entregas');
        V_PLANO.STATUS                   := APEX_JSON.GET_NUMBER  ('status');
        V_PLANO.DATA_INICIO              := APEX_JSON.GET_VARCHAR2('data_inicio');
        V_PLANO.DATA_TERMINO             := APEX_JSON.GET_VARCHAR2('data_termino');
        V_PLANO.AVALIACAO                := APEX_JSON.GET_NUMBER  ('avaliacao');
        V_PLANO.DATA_AVALIACAO           := APEX_JSON.GET_VARCHAR2('data_avaliacao');
       --
        IF NVL(APEX_JSON.GET_COUNT('entregas'),0) > 0
         THEN
           --
            FOR X IN 1.. APEX_JSON.GET_COUNT('entregas') LOOP
             --
              V_PLANO.ID_ENTREGA   := APEX_JSON.GET_VARCHAR2(P_PATH => 'entregas[%d].id_entrega'  , P0 => X);
              V_PLANO.NOME_ENTREGA := APEX_JSON.GET_VARCHAR2(P_PATH => 'entregas[%d].nome_entrega', P0 => X);
             --
              IF APEX_JSON.GET_BOOLEAN(P_PATH => 'entregas[%d].entrega_cancelada', P0 => X) = TRUE
               THEN
                 --
                  V_PLANO.ENTREGA_CANCELADA := 1;
                 --
               ELSE
                 --
                  V_PLANO.ENTREGA_CANCELADA := 0;
                 --
              END IF;
             -- 
              V_PLANO.META_ENTREGA              := APEX_JSON.GET_NUMBER  (P_PATH => 'entregas[%d].meta_entrega'             , P0 => X);
              V_PLANO.TIPO_META                 := APEX_JSON.GET_VARCHAR2(P_PATH => 'entregas[%d].tipo_meta'                , P0 => X);
              V_PLANO.DATA_ENTREGA              := APEX_JSON.GET_VARCHAR2(P_PATH => 'entregas[%d].data_entrega'             , P0 => X);
              V_PLANO.NOME_UNIDADE_DEMANDANTE   := APEX_JSON.GET_VARCHAR2(P_PATH => 'entregas[%d].nome_unidade_demandante'  , P0 => X);
              V_PLANO.NOME_UNIDADE_DESTINATARIA := APEX_JSON.GET_VARCHAR2(P_PATH => 'entregas[%d].nome_unidade_destinataria', P0 => X); 
             --
              PIPE ROW(V_PLANO);
             --
            END LOOP;
           --
         ELSE
           --
            PIPE ROW(V_PLANO);
           --
        END IF;
       --
    END IF;
   --
    RETURN;
   --
 END FNC_PLANO_ENTREGA;
--#
 FUNCTION FNC_PLANO_TRABALHO (P_COD_PLANO_TRABALHO IN NUMBER, P_TOKEN IN VARCHAR2)
   RETURN TP_PLANO_TRABALHO PIPELINED IS
--
 V_REQUEST VARCHAR2(1000);
 V_RES     CLOB;
 V_PLANO   REC_PLANO_TRABALHO;
--
 CURSOR C_PLANO_TRABALHO IS 
 SELECT PT.COD_PLANO_TRABALHO COD
    ,   (SELECT U.COD_SIORG
           FROM BAR_UORG U
          WHERE U.COD = PT.COD_UORG) COD_UORG
   FROM PLANO_TRABALHO PT
  WHERE PT.COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO;
--
 V_PLANO_TRABALHO C_PLANO_TRABALHO%ROWTYPE;
--
 BEGIN
   --
    OPEN  C_PLANO_TRABALHO;
    FETCH C_PLANO_TRABALHO INTO V_PLANO_TRABALHO;
    CLOSE C_PLANO_TRABALHO;
   --
    V_REQUEST := CS_URL_API || '/organizacao/'    || CS_ORIGEM_UNIDADE            ||
                               '/'                || CS_COD_UNIDADE_AUTORIZADORA  || 
                               '/plano_trabalho/' || V_PLANO_TRABALHO.COD;
   --
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(1).NAME  := 'content-type';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(1).VALUE := 'application/json';
   -- 
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(2).NAME  := 'User-Agent';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(2).VALUE := CS_SISTEMA;
   --
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(3).NAME  := 'Authorization';
    APEX_WEB_SERVICE.G_REQUEST_HEADERS(3).VALUE := 'Bearer ' || P_TOKEN;
   --
    V_RES := APEX_WEB_SERVICE.MAKE_REST_REQUEST(P_URL         => V_REQUEST
                                               ,P_HTTP_METHOD => 'GET');
   --
    IF APEX_WEB_SERVICE.G_STATUS_CODE = 200
     THEN
       --
        APEX_JSON.PARSE(V_RES);
       --
        V_PLANO.ORIGEM_UNIDADE                   := APEX_JSON.GET_VARCHAR2('origem_unidade');
        V_PLANO.COD_UNIDADE_AUTORIZADORA         := APEX_JSON.GET_NUMBER  ('cod_unidade_autorizadora');
        V_PLANO.ID_PLANO_TRABALHO                := APEX_JSON.GET_VARCHAR2('id_plano_trabalho');
        V_PLANO.STATUS                           := APEX_JSON.GET_NUMBER  ('status');
        V_PLANO.COD_UNIDADE_EXECUTORA            := APEX_JSON.GET_NUMBER  ('cod_unidade_executora');
        V_PLANO.CPF_PARTICIPANTE                 := APEX_JSON.GET_VARCHAR2('cpf_participante');
        V_PLANO.MATRICULA_SIAPE                  := APEX_JSON.GET_VARCHAR2('matricula_siape');
        V_PLANO.COD_UNIDADE_LOTACAO_PARTICIPANTE := APEX_JSON.GET_NUMBER  ('cod_unidade_lotacao_participante');
        V_PLANO.DATA_INICIO                      := APEX_JSON.GET_VARCHAR2('data_inicio');
        V_PLANO.DATA_TERMINO                     := APEX_JSON.GET_VARCHAR2('data_termino');
        V_PLANO.CARGA_HORARIA_DISPONIVEL         := APEX_JSON.GET_NUMBER  ('carga_horaria_disponivel');
       --
        IF NVL(APEX_JSON.GET_COUNT('contribuicoes'),0) > 0
         THEN
          --
           FOR X IN 1.. APEX_JSON.GET_COUNT('contribuicoes') LOOP
             --
              V_PLANO.ID_CONTRIBUICAO         := APEX_JSON.GET_VARCHAR2(P_PATH => 'contribuicoes[%d].id_contribuicao'        , P0 => X);
              V_PLANO.TIPO_CONTRIBUICAO       := APEX_JSON.GET_NUMBER  (P_PATH => 'contribuicoes[%d].tipo_contribuicao'      , P0 => X);
              V_PLANO.PERCENTUAL_CONTRIBUICAO := APEX_JSON.GET_NUMBER  (P_PATH => 'contribuicoes[%d].percentual_contribuicao', P0 => X);
              V_PLANO.ID_PLANO_ENTREGAS       := APEX_JSON.GET_VARCHAR2(P_PATH => 'contribuicoes[%d].id_plano_entregas'      , P0 => X);
              V_PLANO.ID_ENTREGA              := APEX_JSON.GET_VARCHAR2(P_PATH => 'contribuicoes[%d].id_entrega'             , P0 => X);
             --
              PIPE ROW(V_PLANO);
             --
           END LOOP;
          --
           ELSE
             --
              PIPE ROW(V_PLANO);
             --
          --
        END IF;
       --
    END IF;    
   --
 END FNC_PLANO_TRABALHO;
--#
 PROCEDURE PRC_REGISTRO_INTEGRACAO (P_CODIGO      IN NUMBER   DEFAULT NULL
                                   ,P_API         IN VARCHAR2 DEFAULT NULL
                                   ,P_PROCESSO    IN VARCHAR2 DEFAULT NULL
                                   ,P_CHAVE       IN VARCHAR2 DEFAULT NULL
                                   ,P_STATUS_CODE IN NUMBER   DEFAULT NULL) IS
--
 /*
   INSERCAO DO REGISTRO NO LOG:
      PCK_API_MGI.PRC_REGISTRO_INTEGRACAO (P_API         => 'PCK_API_MGI'
                                          ,P_PROCESSO    => 'TERMO_CIENCIA'
                                          ,P_CHAVE       => 463);
   ATUALIZACAO DO REGISTRO:
      PCK_API_MGI.PRC_REGISTRO_INTEGRACAO (P_CODIGO       => 2
                                          ,P_STATUS_CODE  => 202); 

 */
--
 V_INTEGRACAO INTEGRACAO_API%ROWTYPE;
--
 BEGIN
   --
    IF P_CODIGO IS NULL
     THEN
       --
        UPDATE INTEGRACAO_API
           SET DATA_CRIACAO = LOCALTIMESTAMP
         WHERE API          = P_API
           AND PROCESSO     = P_PROCESSO
           AND CHAVE        = P_CHAVE;
       --
        IF SQL%ROWCOUNT = 0
         THEN
           --
            INSERT INTO INTEGRACAO_API(API, PROCESSO, CHAVE)
                 VALUES (P_API
                        ,P_PROCESSO
                        ,P_CHAVE);
           --
        END IF;
       --
     ELSE
       --
        UPDATE INTEGRACAO_API
           SET DATA_ENVIO  = LOCALTIMESTAMP
            ,  STATUS_CODE = P_STATUS_CODE
         WHERE COD         = P_CODIGO;
       --
    END IF;
   --
 END PRC_REGISTRO_INTEGRACAO;
--#
 PROCEDURE PRC_INTEGRAR_TERMO_CIENCIA IS
--
 CURSOR C_DADOS IS
 SELECT IA.COD
     ,  IA.CHAVE
   FROM INTEGRACAO_API IA
  WHERE IA.API         = 'PCK_API_MGI'
    AND IA.PROCESSO    = 'TERMO_CIENCIA'
    AND IA.DATA_ENVIO  IS NULL
  ORDER BY DATA_CRIACAO ASC;
--
 BEGIN
   --
    FOR X IN C_DADOS LOOP
     --
      BEGIN
        --
         PRC_AUTENTICACAO;
        --
         PRC_PARTICIPANTE (X.CHAVE);
        --
         PCK_API_MGI.PRC_REGISTRO_INTEGRACAO (P_CODIGO       => X.COD
                                             ,P_STATUS_CODE  => V_STATUS_CODE); 
        --
      END;
     --
    END LOOP;
   --
 END PRC_INTEGRAR_TERMO_CIENCIA;
--#
 PROCEDURE PRC_INTEGRAR_PLANO_ENTREGA IS
--
 CURSOR C_DADOS IS
 SELECT IA.COD
     ,  IA.CHAVE
   FROM INTEGRACAO_API IA
  WHERE IA.API         = 'PCK_API_MGI'
    AND IA.PROCESSO    = 'PLANO_ENTREGA'
    AND IA.DATA_ENVIO  IS NULL
  ORDER BY DATA_CRIACAO ASC;
--
 BEGIN
   --
    FOR X IN C_DADOS LOOP
     --
      BEGIN
        --
         PRC_AUTENTICACAO;
        --
         PRC_PLANO_ENTREGA (X.CHAVE);
        --
         PCK_API_MGI.PRC_REGISTRO_INTEGRACAO (P_CODIGO       => X.COD
                                             ,P_STATUS_CODE  => V_STATUS_CODE); 
        --
      END;
     --
    END LOOP;
   --
 END PRC_INTEGRAR_PLANO_ENTREGA;
--#
 PROCEDURE PRC_INTEGRAR_PLANO_TRABALHO IS
--
 CURSOR C_DADOS IS
 SELECT IA.COD
     ,  IA.CHAVE
   FROM INTEGRACAO_API IA
  WHERE IA.API         = 'PCK_API_MGI'
    AND IA.PROCESSO    = 'PLANO_TRABALHO'
    AND IA.DATA_ENVIO  IS NULL
  ORDER BY DATA_CRIACAO ASC;
--
 BEGIN
   --
    FOR X IN C_DADOS LOOP
     --
      BEGIN
        --
         PRC_AUTENTICACAO;
        --
         PRC_PLANO_TRABALHO (X.CHAVE);
        --
         PCK_API_MGI.PRC_REGISTRO_INTEGRACAO (P_CODIGO       => X.COD
                                             ,P_STATUS_CODE  => V_STATUS_CODE); 
        --
      END;
     --
    END LOOP;
   --
 END PRC_INTEGRAR_PLANO_TRABALHO;
--
end;
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
create or replace PACKAGE BODY PCK_DATA_VIGENCIA IS

    --
    PROCEDURE PROC_ATUALIZAR_SITUACAO_PROJETO IS
        
        BEGIN
            
            
            FOR i IN (
                        SELECT 
                        QRY.COD_PROJETO,
                        QRY.MENOR_DATA
                        FROM(
                        SELECT 
                        P.COD_PROJETO,  
                        MIN(PT.DATA_INICIO_TAREFA) AS MENOR_DATA     
                        FROM PROJETO P  JOIN PROJETO_TAREFA PT ON  P.COD_PROJETO = PT.COD_PROJETO_FK
                        GROUP BY P.COD_PROJETO,PCK_UTIL.GET_SYSDATE) QRY
                           WHERE TRUNC(QRY.MENOR_DATA) <= TRUNC(PCK_UTIL.GET_SYSDATE)  

                        )
            LOOP
                  UPDATE PROJETO P
                   SET P.COD_SITUACAO_REGISTRO_FK = 4 -- Em Execução
                 WHERE /*P.IND_ATIVO = 'A'
                   AND*/ P.COD_SITUACAO_REGISTRO_FK = 3 -- Pactuado
                   AND P.COD_PROJETO = i.COD_PROJETO;
            END LOOP;
    

    END PROC_ATUALIZAR_SITUACAO_PROJETO;
    --

    --
    PROCEDURE PROC_ATUALIZAR_SITUACAO_PLANO_ENTREGA IS
        
        BEGIN
            
            UPDATE PLANO P
               SET P.SITUACAO = 4 -- Em Execução
             WHERE P.IND_ATIVO = 'A'
               AND P.SITUACAO = 3 -- Pactuado
               AND EXISTS ( SELECT 1
                              FROM PLANO_ENTREGA PL
                             WHERE PL.COD_PLANO    = P.COD_PLANO
                               AND PL.IND_ATIVO    = 'A'
                               AND PL.DATA_INICIO  IS NOT NULL
                               AND PL.DATA_FIM     IS NOT NULL
                               AND TRUNC(SYSDATE)  >= TRUNC(PL.DATA_INICIO)
                               AND TRUNC(SYSDATE)  <= TRUNC(PL.DATA_FIM)
                          );

    END PROC_ATUALIZAR_SITUACAO_PLANO_ENTREGA;
    --

    --
    PROCEDURE PROC_ATUALIZAR_SITUACAO_PLANO_TRABALHO IS
        
        BEGIN
            
            UPDATE PLANO_TRABALHO PT
               SET PT.IND_PLANO_SITUACAO = 'E' -- Em Execução
             WHERE PT.IND_ATIVO          = 'A'
               AND PT.IND_PLANO_SITUACAO = 'P' -- Pactuado
               AND EXISTS ( SELECT 1
                              FROM PLANO_TRABALHO_ATIVIDADE PTA
                             WHERE PTA.COD_PLANO_TRABALHO = PT.COD_PLANO_TRABALHO
                               --AND PTA.IND_ATIVO          = 'A'
                               --AND PTA.DATA_INICIO  IS NOT NULL
                               AND PTA.DATA_PRAZO     IS NOT NULL
                               --AND TRUNC(SYSDATE)  >= TRUNC(PTA.DATA_INICIO)
                               AND TRUNC(PCK_UTIL.GET_SYSDATE)  <= TRUNC(PTA.DATA_PRAZO)
                          );

    END PROC_ATUALIZAR_SITUACAO_PLANO_TRABALHO;
    --
    -- MIGRA AS ATIVIDADE DO PLANO DE TRABALHO 10 DIAS APOS A DATA FIM DO PLANO DE TRABALHO.
    PROCEDURE PROC_ATUALIZAR_SITUACAO_PLANO_TRABALHO_ATIVIDADE IS
        
        BEGIN
            FOR i IN (SELECT PA.COD_ATIVIDADE,
                             PT.COD_PLANO_TRABALHO
                        FROM PLANO_TRABALHO_ATIVIDADE PA
                            ,  VW_PLANO_ENTREGA PE
                            ,  PLANO_TRABALHO PT
                        WHERE PA.COD_PLANO_ENTREGA  = PE.COD_PLANO_ENTREGA(+)
                        AND PA.IND_SITUACAO       = 'E'
                        AND PT.COD_PLANO_TRABALHO = PA.COD_PLANO_TRABALHO
                        AND PT.DATA_FIM + 10 < PCK_UTIL.GET_SYSDATE
                        ORDER BY PA.IND_ESFORCO DESC
                    )
            LOOP
                /*Aqui é possível ler cada campo da tupla usando a variável "i"*/
                   UPDATE PLANO_TRABALHO_ATIVIDADE
                       SET IND_SITUACAO  = 'A'
                     WHERE COD_ATIVIDADE = i.COD_ATIVIDADE;

                   UPDATE PLANO_TRABALHO
                   SET IND_PLANO_SITUACAO  = 'S'
                   WHERE COD_PLANO_TRABALHO = i.COD_PLANO_TRABALHO;

                   
            END LOOP;

    END PROC_ATUALIZAR_SITUACAO_PLANO_TRABALHO_ATIVIDADE;
    --

END PCK_DATA_VIGENCIA;
/
create or replace PACKAGE BODY PCK_FERIADO AS

    -- PROCEDURE QUE INATIVA FERIADOS COM DATA MÓVEL
    PROCEDURE PRC_INATIVAR_FERIADOS_MOVEIS IS
    BEGIN

        UPDATE FERIADO
           SET IND_ATIVO = 'I'
         WHERE TIPO_FERIADO = 'M'
           AND DATA_MOVEL IS NOT NULL
           AND EXTRACT(YEAR FROM DATA_MOVEL) < EXTRACT(YEAR FROM SYSDATE);
    
    END PRC_INATIVAR_FERIADOS_MOVEIS;

END PCK_FERIADO;
/
create or replace PACKAGE BODY "PCK_HEFESTO" AS

--==============================================================================
-- PROCEDURE COPIA PLANO ENTREGA
--==============================================================================
PROCEDURE  PC_COPIA_PLANO_ENTREGA (P_COD_PLANO IN  NUMBER, P_DESCRICAO_PLANO IN VARCHAR2, P_COD_PLANO_NEW OUT NUMBER, P_CAMPO OUT VARCHAR2, P_STATUS OUT VARCHAR2, P_MSG OUT VARCHAR2)
IS
V_NEW_COD_PLANO NUMBER;
V_EXISTE NUMBER;
V_MSG VARCHAR2(200);
V_ERROR  EXCEPTION; 
BEGIN

    -- VALIDA PLANO DE ENTREGA SELECIONADO
     IF P_COD_PLANO IS NULL THEN
        P_CAMPO := 'P40_COD_PLANO';  
        V_MSG := 'Esse campo é obrigatório.';       
        RAISE V_ERROR; 
     END IF;


     -- VALIDA DESCRIÇÃO DO PLANO DE ENTREGA
     IF P_DESCRICAO_PLANO IS NULL THEN
        V_MSG := 'Esse campo é obrigatório.';
        P_CAMPO := 'P40_DESCRICA_NOVO_PLANO';  
        RAISE V_ERROR; 
     END IF;


    -- VALIDA DESCRIÇÃO DO PLANO DE ENTREGA SE EXISTE
    BEGIN 
        SELECT COUNT(*)
        INTO V_EXISTE
        FROM PLANO 
        WHERE UPPER(DESCRICAO_PLANO) = UPPER(P_DESCRICAO_PLANO);
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
    V_EXISTE := 0;
    END;

    IF V_EXISTE > 0 THEN 
        P_CAMPO := 'P40_DESCRICA_NOVO_PLANO';  
        V_MSG := 'Plano '||P_DESCRICAO_PLANO||'. já cadastrado.';
        RAISE V_ERROR; 
    END IF;


    -- INSERINDO PLANO SELECIONADO PARA A COPIA
    INSERT INTO PLANO(                             
                      COD_PLANO,
                      DESCRICAO_PLANO,
                      COD_UORG,
                      SITUACAO
                       )
                      VALUES 
                      (
                       PLANO_SEQ.NEXTVAL,
                       P_DESCRICAO_PLANO,
                       (SELECT COD_UORG FROM PLANO WHERE COD_PLANO = P_COD_PLANO),
                       1
                      ) RETURNING COD_PLANO INTO V_NEW_COD_PLANO;


    -- INSERINDO OS ITENS DO PLANO SELECIONADO SELECIONADO
    FOR R_ITENS IN (
                    SELECT 
                                  COD_PLANO_ENTREGA,
                                  COD_PLANO,
                                  DESCRICAO_ENTREGA,
                                  DATA_INICIO,
                                  DATA_FIM,
                                  CATEGORIA,
                                  COD_UORG,
                                  COD_PROJETO,
                                  PRIMEIRO_NIVEL_MACROPROCESSO,
                                  SEGUNDO_NIVEL,
                                  TERCEIRO_NIVEL,
                                  RESULTADO_SOCIEDADE,
                                  QUARTO_NIVEL,
                                  DEMANDANTE,
                                  DESTINATARIO,
                                  TIPO_META,
                                  META,
                                  SELECIONE_ENTREGA
                    FROM 
                        PLANO_ENTREGA WHERE COD_PLANO = P_COD_PLANO
                    ORDER BY COD_PLANO_ENTREGA ASC
                 )
    LOOP

    INSERT INTO PLANO_ENTREGA(                                 
                                  COD_PLANO_ENTREGA,
                                  COD_PLANO,
                                  DESCRICAO_ENTREGA,
                                  DATA_INICIO,
                                  DATA_FIM,
                                  CATEGORIA,
                                  COD_UORG,
                                  COD_PROJETO,
                                  PRIMEIRO_NIVEL_MACROPROCESSO,
                                  SEGUNDO_NIVEL,
                                  TERCEIRO_NIVEL,
                                  RESULTADO_SOCIEDADE,
                                  QUARTO_NIVEL,
                                  DEMANDANTE,
                                  DESTINATARIO,
                                  TIPO_META,
                                  META,
                                  SELECIONE_ENTREGA )
                                  VALUES ( 
                                  PLANO_ENTREGA_SEQ.NEXTVAL,
                                  V_NEW_COD_PLANO,
                                  R_ITENS.DESCRICAO_ENTREGA,
                                  R_ITENS.DATA_INICIO,
                                  R_ITENS.DATA_FIM,
                                  R_ITENS.CATEGORIA,
                                  R_ITENS.COD_UORG,
                                  R_ITENS.COD_PROJETO,
                                  R_ITENS.PRIMEIRO_NIVEL_MACROPROCESSO,
                                  R_ITENS.SEGUNDO_NIVEL,
                                  R_ITENS.TERCEIRO_NIVEL,
                                  R_ITENS.RESULTADO_SOCIEDADE,
                                  R_ITENS.QUARTO_NIVEL,
                                  R_ITENS.DEMANDANTE,
                                  R_ITENS.DESTINATARIO,
                                  R_ITENS.TIPO_META,
                                  R_ITENS.META,
                                  R_ITENS.SELECIONE_ENTREGA
                                  );

    END LOOP;

        P_COD_PLANO_NEW := V_NEW_COD_PLANO;
        P_STATUS := 'OK';

EXCEPTION
    WHEN V_ERROR THEN
      P_STATUS := 'ERROR';
      P_MSG :=  V_MSG;

 WHEN OTHERS THEN

          RAISE_APPLICATION_ERROR(-20001,'Mensage Erro - '||SQLCODE||' -ERROR- '||SQLERRM);

END PC_COPIA_PLANO_ENTREGA;


-- FUNÇÃO PARA VALIDAR OS ACESSOS
FUNCTION F_CONTROLE_ACESSO (P_USER IN VARCHAR2,P_COD_PERFIL IN VARCHAR2,P_COD_PAGE IN VARCHAR2,P_ACAO IN VARCHAR2) RETURN NUMBER IS
--
 V_EXIST NUMBER;
--
 BEGIN
   --
    SELECT COUNT(*) INTO V_EXIST
    FROM PERFIL P,
    USUARIO U,
    PERFIL_GERENCIA_ACESSO PG,
    PERFIL_CONTROLE_ACESSO PCA
    WHERE 
    U.ID = PG.COD_USUARIO_FK
    AND PG.COD_PERFIL_FK = P.COD_PERFIL
    AND PCA.COD_PERFIL_FK = P.COD_PERFIL
    AND PG.IND_ATIVO = 'A'
    AND U.EMAIL = LOWER(P_USER)
    AND PG.COD_PERFIL_FK = P_COD_PERFIL
    AND PCA.COD_PAGE = P_COD_PAGE
    AND ':'||PCA.ACAO||':' LIKE '%:'||P_ACAO||':%'
    GROUP BY P.NOME_PERFIL,
           P.COD_PERFIL           
    ORDER BY P.COD_PERFIL ;
   --
   IF V_EXIST > 0 THEN
   RETURN 1;
   ELSE
   RETURN 0;
   END IF;
   -- 
 EXCEPTION
    WHEN NO_DATA_FOUND 
      THEN
        --
         RETURN 0;
        --
 END F_CONTROLE_ACESSO;


-- FUNÇÃO PARA VALIDAR OS ACESSOS
FUNCTION F_UORG_ACESSO (P_USER IN VARCHAR2,P_GLOBAL_PERFIL_COD IN NUMBER,P_UORG IN NUMBER) RETURN NUMBER IS
--
 V_EXIST NUMBER;
--
 BEGIN
   --

    SELECT COUNT(*) INTO V_EXIST
      FROM BAR_UORG OU,
      USUARIO U,
      PERFIL_GERENCIA_ACESSO CPGA
    WHERE 
    OU.COD = CPGA.COD_UORG_FK
    AND U.ID = CPGA.COD_USUARIO_FK 
    AND OU.COD = P_UORG
    AND CPGA.COD_PERFIL_FK = P_GLOBAL_PERFIL_COD
    AND U.EMAIL = LOWER(P_USER);

   --
   IF V_EXIST > 0 THEN
   RETURN 1;
   ELSE
   RETURN 0;
   END IF;
   -- 
 EXCEPTION
    WHEN NO_DATA_FOUND 
      THEN
        --
         RETURN 0;
        --
 END F_UORG_ACESSO;



END "PCK_HEFESTO";
/
create or replace PACKAGE BODY "PCK_LOG" AS

--==============================================================================
-- PUBLIC API, SEE SPECIFICATION
--==============================================================================
PROCEDURE PRC_INSERT_LOG (
    P_TABLE_NAME      IN     VARCHAR2,
    P_ACTION          IN     VARCHAR2,
    P_COLUMM          IN     VARCHAR2,
    P_COLUMM_LABEL    IN     VARCHAR2,
    P_OLD_VALUES      IN     VARCHAR2,
    P_NEW_VALUES      IN     VARCHAR2,
    P_ID              IN     NUMBER)
IS
    V_LOG_MESSAGE VARCHAR2(300);
BEGIN

    IF P_ACTION = 'UPDATE' THEN
        V_LOG_MESSAGE := 'CAMPO '||P_COLUMM_LABEL||' DE  "'||P_OLD_VALUES||'" PARA "'||P_NEW_VALUES||'".';
        ELSE IF P_ACTION = 'INSERT' THEN
        V_LOG_MESSAGE := 'CADASTRADO.';
            ELSE IF P_ACTION = 'DELETE' THEN
                V_LOG_MESSAGE := 'EXCLUIDO.';
            END IF;
        END IF;
    END IF;

        INSERT INTO LOG_REGISTRO 
                            (
                             COD_LOG_REGISTRO,
                             LOG_DATE, 
                             TABLE_NAME, 
                             ACTION, 
                             OLD_VALUES, 
                             NEW_VALUES,
                             COD_TABLE,
                             USER_NAME,
                             USER_APP,
                             IP,
                             COLUMM,
                             LOG_MESSAGE,
                             HOST,
                             OS_USER,
                             MODULE)
                      VALUES           
                            (
                            LOG_REGISTRO_SEQ.NEXTVAL,    
                            SYSTIMESTAMP,
                            P_TABLE_NAME, 
                            P_ACTION, 
                            P_OLD_VALUES, 
                            P_NEW_VALUES,
                            P_ID,
                            USER,
                            V('APP_USER'),
                            NVL('IP PUBLICO: '||OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR'),'IP INTERNO:'||SYS_CONTEXT('USERENV', 'IP_ADDRESS')),
                            P_COLUMM,
                            V_LOG_MESSAGE,
                             SYS_CONTEXT('USERENV', 'HOST'),
                             SYS_CONTEXT('USERENV', 'OS_USER'),
                             SYS_CONTEXT('USERENV', 'MODULE')
                             );


END PRC_INSERT_LOG;

END "PCK_LOG";
/
create or replace PACKAGE BODY PCK_NOTIFICACAO AS 
--
 FUNCTION F_EMAIL_PARAMETRO(P_ID_EMAIL IN NUMBER) RETURN TAB_EMAIL_PARAMETRO PIPELINED IS
--
 V_PARAMETRO EMAIL.PARAMETROS%TYPE;
 V_VALOR     REC_EMAIL_PARAMETRO;
--
 CURSOR CUR_PARAMETRO (P_PARAMETRO IN VARCHAR2) IS 
 SELECT COLUMN_VALUE PARAMETRO
   FROM (PCK_UTIL.F_STRING_TO_ROWS (P_STRING   => P_PARAMETRO
                                   ,P_CARACTER => ','));
--
 BEGIN
   --
    SELECT PARAMETROS
      INTO V_PARAMETRO
      FROM EMAIL
     WHERE ID = P_ID_EMAIL;
   --
    FOR X IN CUR_PARAMETRO(V_PARAMETRO) LOOP
     --
      V_VALOR.PARAMETRO := X.PARAMETRO;
      V_VALOR.SEQUENCIA := NVL(V_VALOR.SEQUENCIA, 0) + 1;
     --
      PIPE ROW (V_VALOR);
     --
    END LOOP;
   --
    RETURN;
   --
 END F_EMAIL_PARAMETRO;
--
 PROCEDURE PROC_ENVIA_EMAIL (P_ID_EMAIL                IN NUMBER
                            ,P_DESTINATARIO            IN VARCHAR2
                            ,P_PARAMETROS              IN VARCHAR2
                            ,P_SPLIT                   IN VARCHAR2
                            ,P_PARAMETRO_ASSUNTO       IN VARCHAR2) IS
--
 V_BODY              CLOB;
 V_BODY_2            CLOB;
 V_ASSUNTO           EMAIL.ASSUNTO%TYPE;
 V_EMAIL_REMETENTE   CONFIGURACAO.VALOR%TYPE;
--
 CURSOR CUR_VALOR_PARAMETRO IS
   WITH PARAMETROS AS (
               SELECT SEQUENCIA, PARAMETRO
                 FROM F_EMAIL_PARAMETRO(P_ID_EMAIL => P_ID_EMAIL)),
        VALORES    AS (
               SELECT ROWNUM AS SEQUENCIA, COLUMN_VALUE AS PARAMETRO
                 FROM TABLE(PCK_UTIL.F_STRING_TO_ROWS(P_STRING   => P_PARAMETROS
                                                     ,P_CARACTER => P_SPLIT)))
 SELECT P.PARAMETRO, V.PARAMETRO VALOR 
   FROM PARAMETROS P
     ,  VALORES V
  WHERE P.SEQUENCIA = V.SEQUENCIA;
--
 BEGIN
   --
    SELECT CORPO
        ,  ASSUNTO
      INTO V_BODY
        ,  V_ASSUNTO
      FROM EMAIL
     WHERE ID = P_ID_EMAIL;
   --
    V_ASSUNTO := REPLACE(V_ASSUNTO
                        ,REGEXP_SUBSTR(P_PARAMETRO_ASSUNTO,'[^;]+', 1, 1)
                        ,REGEXP_SUBSTR(P_PARAMETRO_ASSUNTO,'[^;]+', 1, 2));
   -- 
    FOR X IN CUR_VALOR_PARAMETRO LOOP
     --
      V_BODY := REPLACE(V_BODY, X.PARAMETRO, X.VALOR);
     --
    END LOOP;
   --

    SELECT VALOR INTO V_EMAIL_REMETENTE FROM CONFIGURACAO WHERE PARAMETRO = 'EMAIL_REMETENTE';

    APEX_MAIL.SEND(P_TO        => P_DESTINATARIO
                  ,P_FROM      => V_EMAIL_REMETENTE
                  ,P_BODY      => V_BODY_2
                  ,P_BODY_HTML => V_BODY
                  ,P_SUBJ      => V_ASSUNTO);

    APEX_MAIL.PUSH_QUEUE(); -- PRIORIZA O ENVIO DO E-MAIL NA FILA
   --
    /*DBMS_OUTPUT.PUT_LINE ('DE: ' || C_EMAIL_REMETENTE);
    DBMS_OUTPUT.PUT_LINE ('DEST: ' || P_DESTINATARIO);
    DBMS_OUTPUT.PUT_LINE ('ASSU: ' || V_ASSUNTO );
    DBMS_OUTPUT.PUT_LINE (V_BODY );*/
   --
 EXCEPTION
   --
    WHEN OTHERS THEN
      --
       APEX_DEBUG_MESSAGE.LOG_MESSAGE(P_MESSAGE => SQLERRM
                                     ,P_LEVEL   => 1 );
   --
 END PROC_ENVIA_EMAIL;

/*
  Quando inicar um novo mês então sistema deverá enviar automaticamente o E-mail-05 conforme a RNG-139
  NOME              : ENV_EMAIL_RNG_139
  DATA_CRIACAO      : 18/10/2024
  CRIADO_POR        : ADSON LIMA
  ULTIMA_ATUALIZACAO: 18/10/2024 12:02
*/

PROCEDURE ENV_EMAIL_RNG_139  IS
--
 V_PARAMETROS    VARCHAR2(32767);
 V_LISTA_TABLE   VARCHAR2(32767);

BEGIN

  -- Entrando no primeiro for para pegar as uorg, responsavel e email
  FOR f_uorg IN ( SELECT u.COD,
                         u.SIGLA_UORG,
                         u.NOME_UORG, 
                         S.EMAIL_SERVIDOR,
                         S.NOME_PESSOA_FISICA
                    FROM BAR_UORG U, VW_BAR_SERVIDOR S 
                   WHERE S.CODIGO_SERVIDOR = U.COD_SERVIDOR_RESPONSAVEL_FK 
                     AND S.EMAIL_SERVIDOR IS NOT NULL) LOOP

         -- Entrando no segundo for para pegar os usuarios relacionados as uorgs
         V_LISTA_TABLE := '<table class="table_list">
                            <caption>Lista de usuários</caption>
                            <thead>
                                <tr>
                                    <th>NOME</th>
                                    <th>PERFIL</th>
                                </tr>
                            </thead>
                            <tbody>';

        FOR f_servidor IN (SELECT 
                                  U.NOME
                               ,  P.NOME_PERFIL
                            FROM PERFIL_GERENCIA_ACESSO PGA,
                                   USUARIO U,
                                   BAR_UORG B,
                                   PERFIL P,
                                   VW_BAR_SERVIDOR S
                            WHERE P.IND_ATIVO = 'A'
                            AND PGA.COD_USUARIO_FK = U.ID
                            AND PGA.COD_PERFIL_FK = P.COD_PERFIL
                            AND PGA.COD_UORG_FK =  f_uorg.COD 
                            GROUP BY U.NOME, P.NOME_PERFIL
                            ORDER BY U.NOME
                        ) LOOP
            V_LISTA_TABLE := V_LISTA_TABLE || '<tr>' ||
                             '<td>' || f_servidor.NOME || '</td>' ||
                             '<td>' || f_servidor.NOME_PERFIL || '</td>' ||
                             '</tr>';
        END LOOP;

         V_LISTA_TABLE := V_LISTA_TABLE || '</table></body></html>';

          -- REALIZANDO O TRATAMENTO DOS PARAMETROS PARA ENVIO DE EMAIL.

          V_PARAMETROS := INITCAP(REGEXP_SUBSTR(f_uorg.NOME_PESSOA_FISICA,'[^ ]+', 1, 1)); -- Passando parametro e-mail @NOME@
          V_PARAMETROS := V_PARAMETROS || '|' || PCK_NOTIFICACAO.C_URL_BASE || 'ords/r/hefesto/hefesto/home/'; -- Passando parametro e-mail @LINK@
          V_PARAMETROS := V_PARAMETROS || '|'||f_uorg.SIGLA_UORG||' - '||f_uorg.nome_uorg; -- Passando parametro e-mail @UORG@
          V_PARAMETROS := V_PARAMETROS || '|'||V_LISTA_TABLE; -- Passando parametro e-mail @V_LISTA_TABLE@
         -- ENVIANDO O EMAIL AO DESTINATARIO
          PCK_NOTIFICACAO.PROC_ENVIA_EMAIL (P_ID_EMAIL                => 10
                                           ,P_DESTINATARIO            => LOWER(nvl(PCK_NOTIFICACAO.F_EMAIL_DESTINATARIO_TESTE,f_uorg.EMAIL_SERVIDOR))
                                           ,P_PARAMETROS              => V_PARAMETROS
                                           ,P_SPLIT                   => '|'
                                           ,P_PARAMETRO_ASSUNTO       => '');     

    END LOOP;
 EXCEPTION
   --
    WHEN OTHERS THEN
      --
       APEX_DEBUG_MESSAGE.LOG_MESSAGE(P_MESSAGE => SQLERRM
                                     ,P_LEVEL   => 1 );
   --
 END ENV_EMAIL_RNG_139;

-- 
 FUNCTION F_EMAIL_DESTINATARIO_TESTE RETURN VARCHAR2 IS 
-- 
 V_EMAIL_DESTINATARIO_TESTE   CONFIGURACAO.VALOR%TYPE;
-- 
 BEGIN 
   --
    BEGIN 
    SELECT VALOR INTO V_EMAIL_DESTINATARIO_TESTE FROM CONFIGURACAO WHERE PARAMETRO = 'EMAIL_DESTINATARIO_TESTE';
    EXCEPTION 
    WHEN OTHERS THEN
    V_EMAIL_DESTINATARIO_TESTE := NULL;
    END;
   -- 
    RETURN V_EMAIL_DESTINATARIO_TESTE; 
   -- 
 END F_EMAIL_DESTINATARIO_TESTE; 
-- 

END;
/
create or replace package body PCK_PLANO_ENTREGA as

    --
    FUNCTION F_CALCULAR_PERCENTUAL_DIAS_UTEIS (
          p_cod_projeto_tarefa  IN NUMBER
        , p_data_inicio         IN DATE
        , p_data_fim            IN DATE
    ) RETURN NUMBER IS
        v_data_inicio_projeto       DATE;
        v_data_fim_projeto          DATE;
        v_total_dias_uteis_projeto  NUMBER;
        v_dias_uteis_informados     NUMBER;
        v_percentual                NUMBER;
    BEGIN
        -- Busca a menor data de início e a maior data de fim para o projeto
        SELECT MIN(DATA_INICIO_TAREFA)
             , MAX(DATA_FIM_TAREFA)
          INTO v_data_inicio_projeto
             , v_data_fim_projeto
          FROM PROJETO_TAREFA
         WHERE COD_PROJETO_TAREFA = p_cod_projeto_tarefa;

        -- Verifica se as datas informadas estão dentro do intervalo do projeto
        IF p_data_inicio < v_data_inicio_projeto OR p_data_fim > v_data_fim_projeto THEN
            RETURN NULL;
        END IF;
       
        -- Calcula o total de dias úteis do projeto
        v_total_dias_uteis_projeto := PCK_UTIL.F_CALCULAR_DIAS_UTEIS(v_data_inicio_projeto, v_data_fim_projeto);
       
        -- Calcula os dias úteis informados entre p_data_inicio e p_data_fim
        v_dias_uteis_informados := PCK_UTIL.F_CALCULAR_DIAS_UTEIS(p_data_inicio, p_data_fim);

        -- Calcula o percentual com base nos dias úteis
        v_percentual := CEIL((v_dias_uteis_informados / v_total_dias_uteis_projeto) * 100);
       
        -- Retorna o percentual
        RETURN v_percentual;

    END F_CALCULAR_PERCENTUAL_DIAS_UTEIS;
    --

end PCK_PLANO_ENTREGA;
/
create or replace PACKAGE BODY PCK_PLANO_TRABALHO IS
--
--
 FUNCTION F_CALCULA_HORAS_SITUACAO (P_COD_PLANO_TRABALHO IN NUMBER
                                   ,P_COD_SITUACAO       IN VARCHAR2)
   RETURN NUMBER IS
--
 /*
    P_COD_SITUACAO: P: ATIVIDADES EM PLANEJAMENTO
                    T: TOTAL DE ESFORÇO INFORMADO PARA TODAS AS ATIVIDADES, SEM CONSIDERAR A EXECUCAO
                    E: ATIVIDADES EM EXECUCAO
                    A: TOTAL DE ESFORÇO EXECUTADO AGUARDANDO AVALIACAO
                    F: TOTAL DE ESFORÇO EXECUTADO AVALIADO
                   SE: SALDO DE HORAS EM EXECUCAO.
                   TE: TOTAL DE ESFORÇO EXECUTADO, SEM CONSIDERAR A SITUACAO DA ATIVIDADE
    
 */
 V_QTD_HORA NUMBER;
--
 BEGIN
   --
   /*SE A SITUACAO FOR "PLANEJAMENTO" OU EM "EXECUCAO", CONSIDERAR OS VALORES DA TABELA PLANO_TRABALHO_ATIVIDADE*/
    IF P_COD_SITUACAO IN ('P', 'E')
     THEN
       --
        SELECT SUM(IND_ESFORCO)
          INTO V_QTD_HORA
          FROM PLANO_TRABALHO_ATIVIDADE
         WHERE COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO
           AND IND_SITUACAO       = P_COD_SITUACAO;
       --
    END IF;
   --
   /*USAR "T" PARA BUSCAR O VALOR TOTAL INDICADO PARA PLANEJAMENTO*/
    IF P_COD_SITUACAO = 'T'
     THEN
       --
        SELECT SUM(IND_ESFORCO)
          INTO V_QTD_HORA
          FROM PLANO_TRABALHO_ATIVIDADE
         WHERE COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO;
       --
    END IF;
   --
   /*USAR "SE" PARA CALCULAR O SALDO DE HORAS EM EXECUCAO: PRIMEIRO SOMA-SE AS HORAS EM PLANO_TRABALHO_ATIVIDADE, DEPOIS SUBITRAI AS HORAS EXECUTADAS*/
    IF P_COD_SITUACAO = 'SE'
     THEN
       --
       /*1. SOMA AS HORAS*/
        SELECT SUM(IND_ESFORCO)
          INTO V_QTD_HORA
          FROM PLANO_TRABALHO_ATIVIDADE
         WHERE COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO;
       --
       /*2. SUBTRAI A EXECUCAO*/
        SELECT V_QTD_HORA - NVL(SUM(PTE.IND_ESFORCO), 0)
          INTO V_QTD_HORA
          FROM PLANO_TRABALHO_ATIVIDADE_EXECUCAO PTE
         WHERE EXISTS (SELECT 1 
                         FROM PLANO_TRABALHO_ATIVIDADE PTA
                        WHERE PTA.COD_ATIVIDADE      = PTE.COD_PLANO_TRABALHO_ATIVIDADE
                          AND PTA.COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO
                          AND PTA.IND_SITUACAO       IN ('A', 'F'));
       --
    END IF;
   --
   /*USAR "EX" PARA CALCULAR O SALDO DE HORAS EXCEDENTES: PRIMEIRO SOMA-SE AS HORAS EM PLANO_TRABALHO_ATIVIDADE, DEPOIS SUBITRAI AS HORAS EXECUTADAS*/
    IF P_COD_SITUACAO = 'EX'
     THEN
       --
       /*1. SOMA AS HORAS*/
        SELECT SUM(IND_ESFORCO)
          INTO V_QTD_HORA
          FROM PLANO_TRABALHO_ATIVIDADE
         WHERE COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO;
       --
       /*2. SUBTRAI A EXECUCAO*/
        SELECT NVL(SUM(PTE.IND_ESFORCO), 0) - V_QTD_HORA
          INTO V_QTD_HORA
          FROM PLANO_TRABALHO_ATIVIDADE_EXECUCAO PTE
         WHERE EXISTS (SELECT 1 
                         FROM PLANO_TRABALHO_ATIVIDADE PTA
                        WHERE PTA.COD_ATIVIDADE      = PTE.COD_PLANO_TRABALHO_ATIVIDADE
                          AND PTA.COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO
                          AND PTA.IND_SITUACAO       IN ('A', 'F'));
       --
    END IF;
   /*PARA AS SITUACOES "AG AVALIACAO" E "AVALIADAS", CONSIDERAR TODAS AS HORAS EXECUTADAS*/
    IF P_COD_SITUACAO IN ('A', 'F')
     THEN
       --
        SELECT SUM(PTE.IND_ESFORCO)
          INTO V_QTD_HORA
          FROM PLANO_TRABALHO_ATIVIDADE_EXECUCAO PTE
         WHERE EXISTS (SELECT 1 
                         FROM PLANO_TRABALHO_ATIVIDADE PTA
                        WHERE PTA.COD_ATIVIDADE = PTE.COD_PLANO_TRABALHO_ATIVIDADE
                          AND PTA.COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO
                          AND IND_SITUACAO           = P_COD_SITUACAO);
       --
    END IF;
   --
    /*INFORMAR "TE" PARA RETORNAR TODAS AS HORAS EXECUTADAS*/
    IF P_COD_SITUACAO = 'TE'
     THEN
       --
        SELECT SUM(PTE.IND_ESFORCO)
          INTO V_QTD_HORA
          FROM PLANO_TRABALHO_ATIVIDADE_EXECUCAO PTE
         WHERE EXISTS (SELECT 1 
                         FROM PLANO_TRABALHO_ATIVIDADE PTA
                        WHERE PTA.COD_ATIVIDADE = PTE.COD_PLANO_TRABALHO_ATIVIDADE
                          AND PTA.COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO
                          AND PTA.IND_SITUACAO       IN ('A', 'F'));
       --
    END IF;
   --
   /*CRIA O TRATAMENTO PARA NÃO TRAZER NUMEROS NEGATIVOS, EM CASO DE HORAS EXEDENTES*/
    IF V_QTD_HORA < 0
     THEN
       --
        V_QTD_HORA := 0;
       --
    END IF;
   --
    RETURN ROUND(NVL(V_QTD_HORA, 0), 4);
   --
 END F_CALCULA_HORAS_SITUACAO;
--
 FUNCTION F_RETORNA_CARGA_HORARIA_MIN (P_COD_PLANO_TRABALHO IN NUMBER)
   RETURN NUMBER IS
--
 V_CARGA_HORARIA NUMBER;
--
 BEGIN
   --
    SELECT IND_CARGA_HORARIA_MINIMA
      INTO V_CARGA_HORARIA
      FROM PLANO_TRABALHO
     WHERE COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO;
   --
    RETURN NVL(V_CARGA_HORARIA,0);
   --
 END F_RETORNA_CARGA_HORARIA_MIN;
--
 FUNCTION F_RETORNA_CARGA_HORARIA_MAX (P_COD_PLANO_TRABALHO IN NUMBER)
   RETURN NUMBER IS
--
 V_CARGA_HORARIA NUMBER;
--
 BEGIN
   --
    SELECT IND_CARGA_HORARIA_MAXIMA
      INTO V_CARGA_HORARIA
      FROM PLANO_TRABALHO
     WHERE COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO;
   --
    RETURN NVL(V_CARGA_HORARIA,0);
   --
 END F_RETORNA_CARGA_HORARIA_MAX;
--
 PROCEDURE PRC_CALCULA_CARGA_HORARIA_DISPONIVEL(P_COD_SERVIDOR       IN NUMBER
                                               ,P_DATA_INICIO        IN DATE
                                               ,P_DATA_FIM           IN DATE
                                               ,PO_COD_UORG         OUT NUMBER
                                               ,PO_CARGA_HORARIA    OUT NUMBER
                                               ,PO_DIAS_UTEIS       OUT NUMBER
                                               ,PO_DIAS_AFASTAMENTO OUT NUMBER
                                               ,PO_CARGA_HORARIA_DEVIDA OUT NUMBER) IS
--
 V_SERVIDOR VW_BAR_SERVIDOR%ROWTYPE;
--
 V_INTERVALO                NUMBER;
 V_DIAS_AFASTAMENTO         NUMBER := 0;
 V_CARGA_HORARIA_DIARIA     NUMBER;
 V_CARGA_HORARIA_DISPONIVEL NUMBER;
 V_DIAS_DISPONIVEL          NUMBER;
 V_TOTAL_HORAS_FERIADO      NUMBER;
 V_TOTAL_HORAS_FERIADO_DESCONSIDERAR NUMBER := 0;
 V_TOTAL_HORAS_DEVIDAS      NUMBER := 0;
 V_TOTAL_HORAS_AFT_DESCONSIDERAR NUMBER := 0;
 
--
 CURSOR C_AFASTAMENTO IS
 SELECT DISTINCT CODIGO_SERVIDOR
      , NOME_PESSOA_FISICA
      , DESCR_TIPO_AFASTAMENTO
      , CASE 
         WHEN DATA_INICIO_AFASTAMENTO < P_DATA_INICIO
          THEN P_DATA_INICIO
         ELSE DATA_INICIO_AFASTAMENTO 
        END AS "DATA_INICIO_AFASTAMENTO"
      , CASE 
         WHEN DATA_FIM_AFASTAMENTO > P_DATA_FIM
          THEN P_DATA_FIM
         ELSE DATA_FIM_AFASTAMENTO 
        END AS "DATA_FIM_AFASTAMENTO"
	  , BAR.IND_DURACAO_HORAS
   FROM VW_BAR_SERVIDOR_AFASTAMENTO BAR
  WHERE BAR.CODIGO_SERVIDOR = P_COD_SERVIDOR
    AND (
          P_DATA_INICIO BETWEEN TRUNC(DATA_INICIO_AFASTAMENTO) AND TRUNC(DATA_FIM_AFASTAMENTO)
        OR
          P_DATA_FIM BETWEEN TRUNC(DATA_INICIO_AFASTAMENTO) AND TRUNC(DATA_FIM_AFASTAMENTO)
        OR
          (TRUNC(DATA_INICIO_AFASTAMENTO) BETWEEN P_DATA_INICIO AND P_DATA_FIM) );
--
 BEGIN
   --
   /*FAZ A CONSULTA DO SERVIDOR AO BARRAMENTO*/
    SELECT *
      INTO V_SERVIDOR
      FROM VW_BAR_SERVIDOR
     WHERE CODIGO_SERVIDOR = P_COD_SERVIDOR;
   --
    /*FAZ O CALCULO DOS DIAS UTEIS DE ACORDO COM O INTERVALO INFORMADO*/
    V_INTERVALO := PCK_UTIL.F_CALCULAR_DIAS_UTEIS(DATA_INICIO => P_DATA_INICIO
                                                 ,DATA_FIM    => P_DATA_FIM);
   --
    /*ARMAZENA A CARGA HORARIA DISPONIVEL PELO BARRAMENTO (SEMANAL) DIVIDIDO POR 5 DIAS TRABALHADOS*/
    V_CARGA_HORARIA_DIARIA := (V_SERVIDOR.CARGA_HORARIA_DISPONIVEL/5);
   --
   /*FAZ A BUSCA DOS DIAS DE AFASTAMENTO VIA BARRAMENTO*/
    FOR AFT IN C_AFASTAMENTO LOOP
     --
      V_DIAS_AFASTAMENTO := V_DIAS_AFASTAMENTO + PCK_UTIL.F_CALCULAR_DIAS_UTEIS(DATA_INICIO => AFT.DATA_INICIO_AFASTAMENTO
                                                                               ,DATA_FIM    => AFT.DATA_FIM_AFASTAMENTO );
		
	  V_TOTAL_HORAS_AFT_DESCONSIDERAR := V_TOTAL_HORAS_AFT_DESCONSIDERAR + (CASE WHEN PCK_UTIL.F_CALCULAR_DIAS_UTEIS(DATA_INICIO => AFT.DATA_INICIO_AFASTAMENTO, DATA_FIM => AFT.DATA_FIM_AFASTAMENTO) = 1 
													                             THEN 8 - AFT.IND_DURACAO_HORAS ELSE 0 END);

      -- RETORNANDO TOTAL DE HORAS A SEREM DESCONSIDERADAS DA SUBTRAÇÃO POR COINCIDIREM COM FERIADOS
     
     
          BEGIN
                SELECT NVL(SUM(qry.horas),0) + V_TOTAL_HORAS_FERIADO_DESCONSIDERAR
                  INTO V_TOTAL_HORAS_FERIADO_DESCONSIDERAR
                FROM(
                    SELECT DECODE(MEIO_PERIODO,'Y',4,'',8) as horas
                    FROM FERIADO
                    WHERE
                    V_SERVIDOR.COD_UORG IN (select column_value from table(apex_string.split((COD_UORG_FK), ':')))
                    -- FERIADO DENTRO DE UMA OCORRENCIA:
                    AND DECODE(TIPO_FERIADO,'M',DATA_MOVEL,'F',TO_DATE(TO_CHAR(DATA_FIXA,'DD/MM') || TO_CHAR(TO_DATE(P_DATA_INICIO,'DD/MM/YYYY'), '/YYYY'),'DD/MM/YYYY')) BETWEEN TO_DATE(AFT.DATA_INICIO_AFASTAMENTO, 'DD/MM/YYYY') AND TO_DATE(AFT.DATA_FIM_AFASTAMENTO, 'DD/MM/YYYY') 
                    AND IND_ATIVO = 'A'
                ) qry;
            EXCEPTION 
            WHEN OTHERS THEN
                V_TOTAL_HORAS_FERIADO_DESCONSIDERAR := V_TOTAL_HORAS_FERIADO_DESCONSIDERAR + 0;
            END;
       
     --
    END LOOP;

    -- CALCULANDO HORAS DEVIDAS
    BEGIN

     SELECT NVL(SUM(OC.IND_DURACAO_HORAS),0)
       INTO V_TOTAL_HORAS_DEVIDAS
       FROM OCORRENCIA OC
      WHERE OC.COD_SERVIDOR_FK = P_COD_SERVIDOR
        AND OC.TIPO_DEBITO = '2'
        AND (((TO_DATE('01/'||LPAD(OC.MES_LIMITE_COMPENSACAO,2,'0')||'/'||to_char(OC.DATA_FIM,'YYYY'),'DD/MM/YYYY') >= TO_DATE(P_DATA_INICIO,'DD/MM/YYYY')) AND TO_NUMBER(TO_CHAR(OC.DATA_FIM,'MM')) <= OC.MES_LIMITE_COMPENSACAO)
                OR
             ((ADD_MONTHS(TO_DATE('01/'||LPAD(OC.MES_LIMITE_COMPENSACAO,2,'0')||'/'||TO_NUMBER(to_char(OC.DATA_FIM,'YYYY')),'DD/MM/YYYY'),12) >= TO_DATE(P_DATA_INICIO,'DD/MM/YYYY')) AND TO_NUMBER(TO_CHAR(OC.DATA_FIM,'MM')) > OC.MES_LIMITE_COMPENSACAO)
            );

    EXCEPTION WHEN OTHERS THEN
        V_TOTAL_HORAS_DEVIDAS := 0;

    END;

    --
    -- RETORNANDO TOTAL DE HORAS DA TABELA FERIADOS
    --
        BEGIN


            SELECT NVL(SUM(QRY.horas),0)
                   INTO
                   V_TOTAL_HORAS_FERIADO
            FROM(
                 SELECT 
                 DECODE(PCK_UTIL.F_VALIDA_DIA_UTIL(DECODE(TIPO_FERIADO,'M',DATA_MOVEL,'F',TO_DATE(TO_CHAR(DATA_FIXA,'DD/MM') || TO_CHAR(TO_DATE(P_DATA_INICIO,'DD/MM/YYYY'), '/YYYY'),'DD/MM/YYYY'))),'S',DECODE(MEIO_PERIODO,'Y',4,'',8),'N',0)  as horas 
                 FROM FERIADO 
                 WHERE 
                 DECODE(TIPO_FERIADO,'M',DATA_MOVEL,'F',TO_DATE(TO_CHAR(DATA_FIXA,'DD/MM') || TO_CHAR(TO_DATE(P_DATA_INICIO,'DD/MM/YYYY'), '/YYYY'),'DD/MM/YYYY')) BETWEEN TO_DATE(P_DATA_INICIO, 'DD/MM/YYYY') AND TO_DATE(P_DATA_FIM, 'DD/MM/YYYY') 
                 AND V_SERVIDOR.COD_UORG IN (select column_value from table(apex_string.split((COD_UORG_FK), ':')))
                 AND IND_ATIVO = 'A'
                 GROUP BY 
                 DECODE(TIPO_FERIADO,'M',DATA_MOVEL,'F',TO_DATE(TO_CHAR(DATA_FIXA,'DD/MM') || TO_CHAR(TO_DATE(P_DATA_INICIO,'DD/MM/YYYY'), '/YYYY'),'DD/MM/YYYY')),
                 DECODE(PCK_UTIL.F_VALIDA_DIA_UTIL(DECODE(TIPO_FERIADO,'M',DATA_MOVEL,'F',TO_DATE(TO_CHAR(DATA_FIXA,'DD/MM') || TO_CHAR(TO_DATE(P_DATA_INICIO,'DD/MM/YYYY'), '/YYYY'),'DD/MM/YYYY'))),'S',DECODE(MEIO_PERIODO,'Y',4,'',8),'N',0)
                ) QRY;



        EXCEPTION 
        WHEN OTHERS THEN
            V_TOTAL_HORAS_FERIADO := 0;
        END;


    --
   --
    /*CALCULA DOS DIAS DISPONIVEIS SUBTRAINDO OS DIAS DO AFASTAMENTO DO INTERVALO*/
    V_DIAS_DISPONIVEL := V_INTERVALO - V_DIAS_AFASTAMENTO;
   --
    /*CALCULA A CARGA HORARIA TOTAL DISPONIVEL*/
    V_CARGA_HORARIA_DISPONIVEL := (V_CARGA_HORARIA_DIARIA * V_DIAS_DISPONIVEL)  - (V_TOTAL_HORAS_FERIADO - V_TOTAL_HORAS_FERIADO_DESCONSIDERAR) - (V_TOTAL_HORAS_AFT_DESCONSIDERAR);
    
   --
    PO_COD_UORG         := V_SERVIDOR.COD_UORG;
    PO_CARGA_HORARIA    := V_CARGA_HORARIA_DISPONIVEL;
    PO_DIAS_UTEIS       := V_DIAS_DISPONIVEL;
    PO_DIAS_AFASTAMENTO := V_DIAS_AFASTAMENTO;
    PO_CARGA_HORARIA_DEVIDA := V_TOTAL_HORAS_DEVIDAS;
   --
 END PRC_CALCULA_CARGA_HORARIA_DISPONIVEL;
--
 PROCEDURE PRC_REGISTRA_OCORRENCIA (P_COD_OCORRENCIA  IN  NUMBER DEFAULT NULL
                                   ,P_COD_SERVIDOR    IN  NUMBER
                                   ,P_TIPO_OCORRENCIA IN  NUMBER
                                   ,P_TIPO_DEBITO     IN  NUMBER
                                   ,P_DESCRICAO       IN  VARCHAR2
                                   ,P_DATA_INICIO     IN  DATE
                                   ,P_DATA_FIM        IN  DATE
                                   ,PO_COD_OCORRENCIA OUT NUMBER
                                   ,P_MES_LIMITE_COMPENSACAO IN NUMBER DEFAULT NULL
								   ,P_HORA_DURACAO IN NUMBER DEFAULT NULL) IS
--
 V_DURACAO NUMBER;
--
 BEGIN
   --
    V_DURACAO := PCK_UTIL.F_CALCULAR_DIAS_UTEIS(DATA_INICIO => P_DATA_INICIO
                                               ,DATA_FIM    => P_DATA_FIM);
   --
	-- QUANDO OCORRENCIA FOR DE APENAS 1 DIA, A HORA CALCULADA É A INFORMADA PELO USUARIO, NAO SENDO FIXA 8H
	IF V_DURACAO = 1 THEN 
		V_DURACAO := V_DURACAO * P_HORA_DURACAO;
	ELSE
		V_DURACAO := V_DURACAO * 8;
	END IF;
   --
    IF P_COD_OCORRENCIA IS NULL
     THEN
       --
        INSERT INTO OCORRENCIA (COD_SERVIDOR_FK
                               ,COD_TIPO_OCORRENCIA_FK
                               ,DATA_INICIO
                               ,DATA_FIM
                               ,IND_DURACAO_HORAS
                               ,TIPO_DEBITO
                               ,DESCRICAO
                               ,COD_USUARIO_FK
                               ,MES_LIMITE_COMPENSACAO)
                        VALUES (P_COD_SERVIDOR
                               ,P_TIPO_OCORRENCIA
                               ,P_DATA_INICIO
                               ,P_DATA_FIM
                               ,V_DURACAO
                               ,P_TIPO_DEBITO
                               ,P_DESCRICAO
                               ,PCK_AUTENTICACAO.F_USUARIO
                               ,P_MES_LIMITE_COMPENSACAO)
                     RETURNING COD INTO PO_COD_OCORRENCIA;
       --
    END IF;
   --
    IF P_COD_OCORRENCIA IS NOT NULL
     THEN
       --
        UPDATE OCORRENCIA
           SET COD_TIPO_OCORRENCIA_FK = P_TIPO_OCORRENCIA
            ,  DATA_INICIO            = P_DATA_INICIO
            ,  DATA_FIM               = P_DATA_FIM
            ,  IND_DURACAO_HORAS      = V_DURACAO
            ,  TIPO_DEBITO            = P_TIPO_DEBITO
            ,  DESCRICAO              = P_DESCRICAO
            ,  COD_USUARIO_FK         = PCK_AUTENTICACAO.F_USUARIO
            ,  DATA_CRIACAO           = LOCALTIMESTAMP
            ,  MES_LIMITE_COMPENSACAO = P_MES_LIMITE_COMPENSACAO
         WHERE COD = P_COD_OCORRENCIA
     RETURNING COD INTO PO_COD_OCORRENCIA;
       --
    END IF;
   --
 END PRC_REGISTRA_OCORRENCIA;
--
 PROCEDURE PRC_RECALCULAR_HORAS_SERVIDOR (P_COD_SERVIDOR IN NUMBER) IS
--
 V_DIAS_UTEIS       NUMBER;
 V_CARGA_HORARIA    NUMBER;
 V_DIAS_AFASTAMENTO NUMBER;
 V_COD_UORG         NUMBER;
 V_CARGA_HORARIA_DEVIDA NUMBER;
 V_DEBITO_VENC_MES  NUMBER := 0;
 V_CH_MAXIMA        NUMBER;
--
 CURSOR C_PLANO_TRABALHO IS
 SELECT *
   FROM PLANO_TRABALHO
  WHERE COD_SERVIDOR = P_COD_SERVIDOR;
--
 BEGIN
  --
   FOR X IN C_PLANO_TRABALHO LOOP
    --
     PCK_PLANO_TRABALHO.PRC_CALCULA_CARGA_HORARIA_DISPONIVEL(P_COD_SERVIDOR      => X.COD_SERVIDOR
                                                            ,P_DATA_INICIO       => X.DATA_INICIO
                                                            ,P_DATA_FIM          => X.DATA_FIM
                                                            ,PO_COD_UORG         => V_COD_UORG
                                                            ,PO_CARGA_HORARIA    => V_CARGA_HORARIA
                                                            ,PO_DIAS_UTEIS       => V_DIAS_UTEIS
                                                            ,PO_DIAS_AFASTAMENTO => V_DIAS_AFASTAMENTO
                                                            ,PO_CARGA_HORARIA_DEVIDA => V_CARGA_HORARIA_DEVIDA);

    -- CALCULANDO DEBITO VENCIMENTO MES
    BEGIN

     SELECT NVL(SUM(OC.IND_DURACAO_HORAS),0)
       INTO V_DEBITO_VENC_MES
       FROM OCORRENCIA OC
      WHERE OC.COD_SERVIDOR_FK = P_COD_SERVIDOR
        AND OC.TIPO_DEBITO = '3'
        AND OC.DATA_INICIO BETWEEN X.DATA_INICIO AND X.DATA_FIM;

    EXCEPTION WHEN OTHERS THEN
        V_DEBITO_VENC_MES := 0;

    END;

    -- VARIAVEL AUXILIAR PARA CALCULAR A CARGA HORARIA MAXIMA CONVERTIDA CORRETAMENTE EM HORAS E MINUTOS
    V_CH_MAXIMA := V_CARGA_HORARIA + (V_CARGA_HORARIA * 25 / 100);
    
    --
     UPDATE PLANO_TRABALHO
        SET IND_CARGA_HORARIA_MINIMA = V_CARGA_HORARIA
         ,  IND_CARGA_HORARIA_MAXIMA = floor(V_CH_MAXIMA) + ((round(((V_CH_MAXIMA) - floor(V_CH_MAXIMA)) * 60)) * 0.01)
         ,  IND_CARGA_HORARIA_DEVIDA = V_CARGA_HORARIA_DEVIDA
         ,  IND_DEBITO_VENC_MES      = V_DEBITO_VENC_MES
      WHERE COD_PLANO_TRABALHO       = X.COD_PLANO_TRABALHO;
    --
   END LOOP;
  --
 END PRC_RECALCULAR_HORAS_SERVIDOR;
--

 /*ENVIA EMAIL DE NOTIFICAÇÃO PARA OS SERVIDORES E REPONSAVEIS*/
 PROCEDURE PRC_ENVIA_EMAIL_PLANO_CONCLUIDO (P_COD_PLANO_TRABALHO IN NUMBER) IS
--

 V_EXISTE               NUMBER;
 V_PARAMETROS           VARCHAR2(32767);

 V_NOME_PESSOA_FISICA   VW_BAR_SERVIDOR.NOME_PESSOA_FISICA%TYPE;
 V_EMAIL_SERVIDOR       VW_BAR_SERVIDOR.EMAIL_SERVIDOR%TYPE;
 V_DATA_INICIO          PLANO_TRABALHO.DATA_INICIO%TYPE;
 V_DATA_FIM             PLANO_TRABALHO.DATA_FIM%TYPE;
 V_QT_COM_PENSACAO      NUMBER;


--
 BEGIN
  --
    BEGIN
        SELECT 
            S.NOME_PESSOA_FISICA
         ,  S.EMAIL_SERVIDOR
         ,  PT.DATA_INICIO
         ,  PT.DATA_FIM
         ,  (SELECT COUNT(*) FROM PLANO_TRABALHO_ATIVIDADE WHERE COD_PLANO_TRABALHO = PT.COD_PLANO_TRABALHO AND AVALIACAO_COMPENSACAO = 1) AS QT_COM_PENSACAO
        INTO
            V_NOME_PESSOA_FISICA
         ,  V_EMAIL_SERVIDOR
         ,  V_DATA_INICIO
         ,  V_DATA_FIM
         ,  V_QT_COM_PENSACAO
        FROM 
        PLANO_TRABALHO PT,
        VW_BAR_SERVIDOR S
        WHERE 
        PT.COD_SERVIDOR = S.CODIGO_SERVIDOR
        AND PT.COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO
        AND PT.IND_PLANO_SITUACAO = 'AV';
    EXCEPTION 
    WHEN OTHERS THEN
        V_NOME_PESSOA_FISICA := NULL;
        V_EMAIL_SERVIDOR := NULL;
        V_DATA_INICIO := NULL;
        V_DATA_FIM := NULL;
        V_QT_COM_PENSACAO := NULL;
    END;

    -- ENVIAR EMAIL O SERVIDOR CONFORME A REGRA ENVIA EMAIL-07
    IF V_QT_COM_PENSACAO = 0 AND V_EMAIL_SERVIDOR IS NOT NULL THEN

        -- REALIZANDO O TRATAMENTO DOS PARAMETROS PARA ENVIO DE EMAIL.
          V_PARAMETROS := INITCAP(V_NOME_PESSOA_FISICA); -- PARAMETRO @NOME@
          V_PARAMETROS := V_PARAMETROS || '|' || PCK_NOTIFICACAO.C_URL_BASE || 'ords/r/'||LOWER('hefesto')||'/'||LOWER('hefesto')||'/home/'; -- PARAMETRO @LINK@
          V_PARAMETROS := V_PARAMETROS || '|' || TO_CHAR(V_DATA_INICIO,'DD/MM/YYYY'); -- PARAMETRO @DATA_INICIO@
          V_PARAMETROS := V_PARAMETROS || '|' || TO_CHAR(V_DATA_FIM,'DD/MM/YYYY'); -- PARAMETRO @DATA_FIM@

         -- ENVIANDO O EMAIL AO DESTINATARIO
          PCK_NOTIFICACAO.PROC_ENVIA_EMAIL (P_ID_EMAIL                => 11
                                           ,P_DESTINATARIO            => LOWER(nvl(PCK_NOTIFICACAO.F_EMAIL_DESTINATARIO_TESTE,V_EMAIL_SERVIDOR)) -- LOWER(V_EMAIL_SERVIDOR)
                                           ,P_PARAMETROS              => V_PARAMETROS
                                           ,P_SPLIT                   => '|'
                                           ,P_PARAMETRO_ASSUNTO       => ''); 

     ELSE IF  V_QT_COM_PENSACAO = 1 AND V_EMAIL_SERVIDOR IS NOT NULL THEN

         -- REALIZANDO O TRATAMENTO DOS PARAMETROS PARA ENVIO DE EMAIL.
          V_PARAMETROS := INITCAP(V_NOME_PESSOA_FISICA); -- PARAMETRO @NOME@
          V_PARAMETROS := V_PARAMETROS || '|' || PCK_NOTIFICACAO.C_URL_BASE || 'ords/r/'||LOWER('hefesto')||'/'||LOWER('hefesto')||'/home/'; -- PARAMETRO @LINK@
          V_PARAMETROS := V_PARAMETROS || '|' || TO_CHAR(V_DATA_INICIO,'DD/MM/YYYY'); -- PARAMETRO @DATA_INICIO@
          V_PARAMETROS := V_PARAMETROS || '|' || TO_CHAR(V_DATA_FIM,'DD/MM/YYYY'); -- PARAMETRO @DATA_FIM@
         -- ENVIANDO O EMAIL AO DESTINATARIO
          PCK_NOTIFICACAO.PROC_ENVIA_EMAIL (P_ID_EMAIL                => 12
                                           ,P_DESTINATARIO            => LOWER(nvl(PCK_NOTIFICACAO.F_EMAIL_DESTINATARIO_TESTE,V_EMAIL_SERVIDOR))  -- LOWER(V_EMAIL_SERVIDOR)
                                           ,P_PARAMETROS              => V_PARAMETROS
                                           ,P_SPLIT                   => '|'
                                           ,P_PARAMETRO_ASSUNTO       => ''); 
                                           
     END IF; 
     END IF;    
  --
 END PRC_ENVIA_EMAIL_PLANO_CONCLUIDO;
 --
 /*ENVIA EMAIL DE NOTIFICAÇÃO PARA OS SERVIDORES E REPONSAVEIS*/
 PROCEDURE PRC_ENVIA_EMAIL_PLANO_CADASTRADO (P_COD_PLANO_TRABALHO IN NUMBER) IS
--

 V_PARAMETROS           VARCHAR2(32767);

 V_NOME_PARTICIPANTE     VW_BAR_SERVIDOR.NOME_PESSOA_FISICA%TYPE;
 V_EMAIL_PARTICIPANTE    VW_BAR_SERVIDOR.EMAIL_SERVIDOR%TYPE;
 V_DATA_INICIO           PLANO_TRABALHO.DATA_INICIO%TYPE;
 V_DATA_FIM              PLANO_TRABALHO.DATA_FIM%TYPE;
 V_COD_CHEFIA_IMEDIATA   VW_BAR_SERVIDOR.COD_SERVIDOR_RESPONSAVEL_UORG%TYPE;
 
 V_EMAIL_CHEFIA_IMEDIATA VW_BAR_SERVIDOR.EMAIL_SERVIDOR%TYPE;
 
 V_COD_UORG_SUP_PARTICIPANTE VW_BAR_SERVIDOR.COD_UORG_SUPERIOR%TYPE;
 V_COD_SERVIDOR_PARTICIPANTE VW_BAR_SERVIDOR.CODIGO_SERVIDOR%TYPE;
 V_TIPO_AMBIENTE CONFIGURACAO.VALOR%TYPE;
 V_URL VARCHAR2(2000);


--
 BEGIN
  --
	-- DADOS PARTICIPANTE
    BEGIN
	
        SELECT 
            S.NOME_PESSOA_FISICA
         ,  S.EMAIL_SERVIDOR
         ,  PT.DATA_INICIO
         ,  PT.DATA_FIM
		 ,  S.COD_SERVIDOR_RESPONSAVEL_UORG
		 ,  S.COD_UORG_SUPERIOR
		 ,  S.CODIGO_SERVIDOR
        INTO
            V_NOME_PARTICIPANTE
         ,  V_EMAIL_PARTICIPANTE
         ,  V_DATA_INICIO
         ,  V_DATA_FIM
		 ,  V_COD_CHEFIA_IMEDIATA
		 ,  V_COD_UORG_SUP_PARTICIPANTE
		 ,  V_COD_SERVIDOR_PARTICIPANTE
        FROM 
			PLANO_TRABALHO PT,
			VW_BAR_SERVIDOR S
        WHERE 
			PT.COD_SERVIDOR = S.CODIGO_SERVIDOR
        AND PT.COD_PLANO_TRABALHO = P_COD_PLANO_TRABALHO;
		
    EXCEPTION WHEN OTHERS THEN
        V_NOME_PARTICIPANTE := NULL;
        V_EMAIL_PARTICIPANTE := NULL;
        V_DATA_INICIO := NULL;
        V_DATA_FIM := NULL;
    END;
	
	-- DADOS CHEFIA IMEDIATA
    BEGIN
	
        SELECT S.EMAIL_SERVIDOR
          INTO V_EMAIL_CHEFIA_IMEDIATA
          FROM VW_BAR_SERVIDOR S
         WHERE 
			( -- CASO CHEFIA IMEDIATA NAO FOR O PROPRIO PARTICIPANTE, CONSIDERO O SERVIDOR SUPERIOR IMEDIATO DA PROPRIA UORG
			  (V_COD_CHEFIA_IMEDIATA <> V_COD_SERVIDOR_PARTICIPANTE AND S.CODIGO_SERVIDOR = V_COD_CHEFIA_IMEDIATA)
			  OR
              -- CASO CHEFIA IMEDIATA FOR O PROPRIO PARTICIPANTE, CONSIDERO O SERVIDOR SUPERIOR IMEDIATO DA UORG SUPERIOR A DELE
			  (V_COD_CHEFIA_IMEDIATA = V_COD_SERVIDOR_PARTICIPANTE AND S.COD_UORG = V_COD_UORG_SUP_PARTICIPANTE AND S.COD_SERVIDOR_RESPONSAVEL_UORG	= S.CODIGO_SERVIDOR)
			);
		
    EXCEPTION WHEN OTHERS THEN
        V_EMAIL_CHEFIA_IMEDIATA := NULL;
    END;

    V_TIPO_AMBIENTE := PCK_UTIL.F_GET_PARAMETRO_CONFIGURACAO('TIPO_AMBIENTE');

    IF V_TIPO_AMBIENTE <> 'PRODUCAO' THEN
        V_TIPO_AMBIENTE := '[AMBIENTE DE '||V_TIPO_AMBIENTE||']';
    ELSE 
        V_TIPO_AMBIENTE := '';
    END IF;

    V_URL := APEX_PAGE.GET_URL(
        P_APPLICATION => PCK_UTIL.F_GET_PARAMETRO_CONFIGURACAO('APP_ID'),
        P_PAGE        => 7,
        P_ITEMS       => 'P7_ITEM_NAMES,P7_ITEM_VALUES,P7_PAGE_NUMBER',
        P_VALUES      => 'P69_COD_PLANO_TRABALHO,'||P_COD_PLANO_TRABALHO||',69',
        P_CLEAR_CACHE => 7
    );

    IF V_EMAIL_PARTICIPANTE IS NOT NULL THEN

        -- REALIZANDO O TRATAMENTO DOS PARAMETROS PARA ENVIO DE EMAIL.
        V_PARAMETROS := INITCAP(V_NOME_PARTICIPANTE); -- PARAMETRO @NOME@
        V_PARAMETROS := V_PARAMETROS || '|' || RTRIM(PCK_NOTIFICACAO.C_URL_BASE,'/') || V_URL; -- PARAMETRO @LINK@
        V_PARAMETROS := V_PARAMETROS || '|' || TO_CHAR(V_DATA_INICIO,'DD/MM/YYYY'); -- PARAMETRO @DATA_INICIO@
        V_PARAMETROS := V_PARAMETROS || '|' || TO_CHAR(V_DATA_FIM,'DD/MM/YYYY'); -- PARAMETRO @DATA_FIM@
        V_PARAMETROS := V_PARAMETROS || '|' || V_TIPO_AMBIENTE; -- PARAMETRO @TIPO_AMBIENTE@

        -- ENVIANDO O EMAIL AO DESTINATARIO PARTICIPANTE
        PCK_NOTIFICACAO.PROC_ENVIA_EMAIL (P_ID_EMAIL                => 14
                                         ,P_DESTINATARIO            => LOWER(NVL(PCK_NOTIFICACAO.F_EMAIL_DESTINATARIO_TESTE,V_EMAIL_PARTICIPANTE)) -- LOWER(V_EMAIL_PARTICIPANTE)
                                         ,P_PARAMETROS              => V_PARAMETROS
                                         ,P_SPLIT                   => '|'
                                         ,P_PARAMETRO_ASSUNTO       => ''); 
	
	END IF;

    IF V_EMAIL_CHEFIA_IMEDIATA IS NOT NULL THEN

        -- REALIZANDO O TRATAMENTO DOS PARAMETROS PARA ENVIO DE EMAIL.
        V_PARAMETROS := INITCAP(V_NOME_PARTICIPANTE); -- PARAMETRO @NOME@
        V_PARAMETROS := V_PARAMETROS || '|' || RTRIM(PCK_NOTIFICACAO.C_URL_BASE,'/') || V_URL; -- PARAMETRO @LINK@
        V_PARAMETROS := V_PARAMETROS || '|' || TO_CHAR(V_DATA_INICIO,'DD/MM/YYYY'); -- PARAMETRO @DATA_INICIO@
        V_PARAMETROS := V_PARAMETROS || '|' || TO_CHAR(V_DATA_FIM,'DD/MM/YYYY'); -- PARAMETRO @DATA_FIM@
        V_PARAMETROS := V_PARAMETROS || '|' || V_TIPO_AMBIENTE; -- PARAMETRO @TIPO_AMBIENTE@
        -- ENVIANDO O EMAIL AO DESTINATARIO CHEFIA IMEDIATA
        PCK_NOTIFICACAO.PROC_ENVIA_EMAIL (P_ID_EMAIL                => 14
                                         ,P_DESTINATARIO            => LOWER(NVL(PCK_NOTIFICACAO.F_EMAIL_DESTINATARIO_TESTE,V_EMAIL_CHEFIA_IMEDIATA))  -- LOWER(V_EMAIL_PARTICIPANTE)
                                         ,P_PARAMETROS              => V_PARAMETROS
                                         ,P_SPLIT                   => '|'
                                         ,P_PARAMETRO_ASSUNTO       => ''); 
                                           
    END IF;    
  --
 END PRC_ENVIA_EMAIL_PLANO_CADASTRADO;
--
END;
/
create or replace PACKAGE BODY "PCK_PROJETO" AS
--  
    -- Calcular dias úteis, considerando finais de semana, feriados e UORG.
    FUNCTION F_DIAS_UTEIS_FIM_SEMANA_FERIADO (
        DATA_INICIO IN DATE,
        DATA_FIM IN DATE,
        COD_UORG_FK IN VARCHAR2
    ) RETURN NUMBER IS 

        -- Variáveis
        V_CONTADOR NUMBER := 0;  -- Contador de dias úteis
        V_DATA_ATUAL DATE;       -- Data atual usada no loop de dias

        -- Tipo de registro para armazenar as informações dos feriados
        TYPE T_FERIADO_REC IS RECORD (
            DATA_FERIADO DATE,
            CATEGORIA VARCHAR2(1),
            MEIO_PERIODO VARCHAR2(1),
            COD_UORG VARCHAR2(4000)
        );
        
        -- Tipo de tabela para armazenar a lista de feriados
        TYPE T_FERIADO_TABLE IS TABLE OF T_FERIADO_REC;
        V_FERIADOS T_FERIADO_TABLE := T_FERIADO_TABLE();

        V_IS_FERIADO BOOLEAN;
        V_TEM_PONTO_FACULTATIVO BOOLEAN;
        V_UORG_PERTENCE BOOLEAN;

        -- Cursor para buscar feriados no intervalo entre DATA_INICIO e DATA_FIM
        CURSOR C_FERIADOS IS
            SELECT TIPO_FERIADO, 
                   CASE 
                        WHEN TIPO_FERIADO = 'F' THEN 
                            TO_DATE(TO_CHAR(DATA_FIXA, 'DD/MM') || '/' || TO_CHAR(SYSDATE, 'YYYY'), 'DD/MM/YYYY')
                        ELSE 
                            DATA_MOVEL
                   END AS DATA_FERIADO,
                   CATEGORIA,
                   MEIO_PERIODO,
                   COD_UORG_FK
            FROM FERIADO
            WHERE IND_ATIVO = 'A'
            AND (DATA_MOVEL BETWEEN DATA_INICIO AND DATA_FIM OR TIPO_FERIADO = 'F');
        
    BEGIN

        -- Carrega os feriados para memória, populando a tabela temporária V_FERIADOS
        FOR FERIADO_REC IN C_FERIADOS LOOP
            V_FERIADOS.EXTEND;  -- Adiciona uma nova linha na tabela temporária
            V_FERIADOS(V_FERIADOS.COUNT).DATA_FERIADO := FERIADO_REC.DATA_FERIADO;
            V_FERIADOS(V_FERIADOS.COUNT).CATEGORIA := FERIADO_REC.CATEGORIA;
            V_FERIADOS(V_FERIADOS.COUNT).MEIO_PERIODO := FERIADO_REC.MEIO_PERIODO;
            V_FERIADOS(V_FERIADOS.COUNT).COD_UORG := FERIADO_REC.COD_UORG_FK;
        END LOOP;

        -- Loop para contar os dias úteis entre DATA_INICIO e DATA_FIM
        FOR I IN 0 .. ABS(DATA_FIM - DATA_INICIO) LOOP
            V_DATA_ATUAL := DATA_INICIO + I;  -- Define a data atual no loop
            
            -- Verifica se a data atual é um dia útil (segunda a sexta-feira)
            IF TO_CHAR(DATA_INICIO + I, 'D') BETWEEN 2 AND 6 THEN 

                V_IS_FERIADO := FALSE;
                V_TEM_PONTO_FACULTATIVO := FALSE;
                
                -- Verifica se a data atual é um feriado ou ponto facultativo
                FOR J IN 1 .. V_FERIADOS.COUNT LOOP
                    -- Verifica se o código da UORG fornecido está nos códigos de UORG do feriado
                    V_UORG_PERTENCE := REGEXP_LIKE(V_FERIADOS(J).COD_UORG, '(^|:)' || COD_UORG_FK || '(:|$)');

                    -- Se a UORG for aplicável ao feriado, realiza as verificações
                    IF V_UORG_PERTENCE AND TRUNC(V_DATA_ATUAL) = TRUNC(V_FERIADOS(J).DATA_FERIADO) THEN
                        -- Feriado completo ('F') prevalece e define o dia como não útil
                        IF V_FERIADOS(J).CATEGORIA = 'F' THEN
                            V_IS_FERIADO := TRUE;
                            EXIT;  -- Sai do loop, pois o feriado prevalece em relação ao ponto facultativo
                        END IF;

                        IF V_FERIADOS(J).CATEGORIA = 'P' THEN
                            -- Se for ponto facultativo de meio período, será considerado útil
                            IF V_FERIADOS(J).MEIO_PERIODO = 'Y' THEN
                                V_TEM_PONTO_FACULTATIVO := TRUE;
                            ELSE
                                -- Ponto facultativo completo é tratado como feriado (não útil)
                                V_IS_FERIADO := TRUE;
                            END IF;
                        END IF;
                    END IF;
                END LOOP;
                
                -- Se não for feriado completo, conta o dia como útil
                IF NOT V_IS_FERIADO THEN
                    V_CONTADOR := V_CONTADOR + 1;
                END IF;
            END IF;
        END LOOP;

        -- Retorna o número total de dias úteis
        RETURN V_CONTADOR;

    EXCEPTION
        WHEN OTHERS THEN
            APEX_ERROR.ADD_ERROR (
              P_MESSAGE => 'Erro:  ' || SQLERRM
            , P_DISPLAY_LOCATION => APEX_ERROR.C_INLINE_IN_NOTIFICATION
        );
    END F_DIAS_UTEIS_FIM_SEMANA_FERIADO;

    
END "PCK_PROJETO";
/
create or replace PACKAGE BODY PCK_TCR AS

    PROCEDURE PRC_ENVIA_EMAIL_TCR_CADASTRADO(P_COD_TERMO_CIENCIA IN NUMBER) IS
		V_NOME_PARTICIPANTE  VW_BAR_SERVIDOR.NOME_PESSOA_FISICA%TYPE;
		V_EMAIL_PARTICIPANTE VW_BAR_SERVIDOR.EMAIL_SERVIDOR%TYPE;
		V_TIPO_AMBIENTE      CONFIGURACAO.VALOR%TYPE;
		V_URL                VARCHAR2(2000);
		V_PARAMETROS         VARCHAR2(32767);
        V_COD_CHEFIA_IMEDIATA   VW_BAR_SERVIDOR.COD_SERVIDOR_RESPONSAVEL_UORG%TYPE;
        V_EMAIL_CHEFIA_IMEDIATA VW_BAR_SERVIDOR.EMAIL_SERVIDOR%TYPE;
        V_COD_UORG_SUP_PARTICIPANTE VW_BAR_SERVIDOR.COD_UORG_SUPERIOR%TYPE;
        V_COD_SERVIDOR_PARTICIPANTE VW_BAR_SERVIDOR.CODIGO_SERVIDOR%TYPE;
    BEGIN

        -- DADOS PARTICIPANTE
		BEGIN
		
			SELECT 
				S.NOME_PESSOA_FISICA
			 ,  S.EMAIL_SERVIDOR
             ,  S.COD_SERVIDOR_RESPONSAVEL_UORG
		     ,  S.COD_UORG_SUPERIOR
		     ,  S.CODIGO_SERVIDOR
			INTO
				V_NOME_PARTICIPANTE
			 ,  V_EMAIL_PARTICIPANTE
             ,  V_COD_CHEFIA_IMEDIATA
		     ,  V_COD_UORG_SUP_PARTICIPANTE
		     ,  V_COD_SERVIDOR_PARTICIPANTE
			FROM 
				TERMO_CIENCIA TCR,
				VW_BAR_SERVIDOR S
			WHERE 
				TCR.COD_SERVIDOR_FK = S.CODIGO_SERVIDOR
			AND TCR.COD_TERMO_CIENCIA = P_COD_TERMO_CIENCIA;
			
		EXCEPTION WHEN OTHERS THEN
			V_NOME_PARTICIPANTE := NULL;
			V_EMAIL_PARTICIPANTE := NULL;
		END;
		
		-- COLETO VARIAVEIS DE AMBIENTE		
		V_TIPO_AMBIENTE := PCK_UTIL.F_GET_PARAMETRO_CONFIGURACAO('TIPO_AMBIENTE');

		IF V_TIPO_AMBIENTE <> 'PRODUCAO' THEN
			V_TIPO_AMBIENTE := '[AMBIENTE DE '||V_TIPO_AMBIENTE||']';
		ELSE 
			V_TIPO_AMBIENTE := '';
		END IF;

        -- PREPARO URL DE REDIRECIONAMENTO DO EMAIL
		V_URL := APEX_PAGE.GET_URL(
			P_APPLICATION => PCK_UTIL.F_GET_PARAMETRO_CONFIGURACAO('APP_ID'),
			P_PAGE        => 7,
			P_ITEMS       => 'P7_PAGE_NUMBER',
            P_VALUES      => '63',
			P_CLEAR_CACHE => 7
		);

		IF V_EMAIL_PARTICIPANTE IS NOT NULL THEN

			-- REALIZANDO O TRATAMENTO DOS PARAMETROS PARA ENVIO DE EMAIL
			V_PARAMETROS := INITCAP(V_NOME_PARTICIPANTE); -- PARAMETRO @NOME@
			V_PARAMETROS := V_PARAMETROS || '|' || RTRIM(PCK_NOTIFICACAO.C_URL_BASE,'/') || V_URL; -- PARAMETRO @LINK@
			V_PARAMETROS := V_PARAMETROS || '|' || V_TIPO_AMBIENTE; -- PARAMETRO @TIPO_AMBIENTE@

			-- ENVIANDO O EMAIL AO DESTINATARIO PARTICIPANTE
			PCK_NOTIFICACAO.PROC_ENVIA_EMAIL (P_ID_EMAIL                => 17
											 ,P_DESTINATARIO            => LOWER(NVL(PCK_NOTIFICACAO.F_EMAIL_DESTINATARIO_TESTE,V_EMAIL_PARTICIPANTE))
											 ,P_PARAMETROS              => V_PARAMETROS
											 ,P_SPLIT                   => '|'
											 ,P_PARAMETRO_ASSUNTO       => ''); 
		
		END IF;

        -- DADOS CHEFIA IMEDIATA
        BEGIN
    	
            SELECT S.EMAIL_SERVIDOR
              INTO V_EMAIL_CHEFIA_IMEDIATA
              FROM VW_BAR_SERVIDOR S
             WHERE 
    			( -- CASO CHEFIA IMEDIATA NAO FOR O PROPRIO PARTICIPANTE, CONSIDERO O SERVIDOR SUPERIOR IMEDIATO DA PROPRIA UORG
    			  (V_COD_CHEFIA_IMEDIATA <> V_COD_SERVIDOR_PARTICIPANTE AND S.CODIGO_SERVIDOR = V_COD_CHEFIA_IMEDIATA)
    			  OR
                  -- CASO CHEFIA IMEDIATA FOR O PROPRIO PARTICIPANTE, CONSIDERO O SERVIDOR SUPERIOR IMEDIATO DA UORG SUPERIOR A DELE
    			  (V_COD_CHEFIA_IMEDIATA = V_COD_SERVIDOR_PARTICIPANTE AND S.COD_UORG = V_COD_UORG_SUP_PARTICIPANTE AND S.COD_SERVIDOR_RESPONSAVEL_UORG	= S.CODIGO_SERVIDOR)
    			);
    		
        EXCEPTION WHEN OTHERS THEN
            V_EMAIL_CHEFIA_IMEDIATA := NULL;
        END;

        IF V_EMAIL_CHEFIA_IMEDIATA IS NOT NULL THEN

			-- REALIZANDO O TRATAMENTO DOS PARAMETROS PARA ENVIO DE EMAIL
			V_PARAMETROS := INITCAP(V_NOME_PARTICIPANTE); -- PARAMETRO @NOME@
			V_PARAMETROS := V_PARAMETROS || '|' || RTRIM(PCK_NOTIFICACAO.C_URL_BASE,'/') || V_URL; -- PARAMETRO @LINK@
			V_PARAMETROS := V_PARAMETROS || '|' || V_TIPO_AMBIENTE; -- PARAMETRO @TIPO_AMBIENTE@

			-- ENVIANDO O EMAIL AO DESTINATARIO PARTICIPANTE
			PCK_NOTIFICACAO.PROC_ENVIA_EMAIL (P_ID_EMAIL                => 17
											 ,P_DESTINATARIO            => LOWER(NVL(PCK_NOTIFICACAO.F_EMAIL_DESTINATARIO_TESTE,V_EMAIL_CHEFIA_IMEDIATA))
											 ,P_PARAMETROS              => V_PARAMETROS
											 ,P_SPLIT                   => '|'
											 ,P_PARAMETRO_ASSUNTO       => ''); 
		
		END IF;
    
    END PRC_ENVIA_EMAIL_TCR_CADASTRADO;

END PCK_TCR;
/
create or replace package body "PCK_UORG" as


-- ENVIA EMAIL QUANDO ALTERAR A UORG
PROCEDURE UORG_ENVIA_EMAIL_DIF_UORG AS

    V_PARAMETROS                         VARCHAR2(4000);

    V_NOME_PESSOA_FISICA_NEW_UORG        VW_BAR_SERVIDOR.NOME_PESSOA_FISICA%TYPE;
    V_EMAIL_PESSOA_FISICA_NEW_UORG       VW_BAR_SERVIDOR.EMAIL_PESSOA_FISICA%TYPE;

    V_NOME_PESSOA_FISICA_OLD_UORG        VW_BAR_SERVIDOR.NOME_PESSOA_FISICA%TYPE;
    V_EMAIL_PESSOA_FISICA_OLD_UORG       VW_BAR_SERVIDOR.EMAIL_PESSOA_FISICA%TYPE;

    V_UORG_ANT                           BAR_UORG.NOME_UORG%TYPE;
    V_NOVA_UORG                          BAR_UORG.NOME_UORG%TYPE; 

    V_NOME_USUARIO                       VW_BAR_SERVIDOR.NOME_PESSOA_FISICA%TYPE;
    V_EMAIL_USUARIO                      VW_BAR_SERVIDOR.EMAIL_PESSOA_FISICA%TYPE;

    V_TIPO_AMBIENTE                      CONFIGURACAO.VALOR%TYPE;
    V_URL                                VARCHAR2(2000);

BEGIN

         -- PEGANDO O AMBIENTE

        V_TIPO_AMBIENTE := PCK_UTIL.F_GET_PARAMETRO_CONFIGURACAO('TIPO_AMBIENTE');

        IF V_TIPO_AMBIENTE <> 'PRODUCAO' THEN
            V_TIPO_AMBIENTE := '[AMBIENTE DE '||V_TIPO_AMBIENTE||']';
        ELSE 
            V_TIPO_AMBIENTE := '';
        END IF;

       
       V_URL := 'ords/r/'||LOWER('hefesto')||'/'||LOWER('hefesto')||'/home/';
       
      /*  V_URL := APEX_PAGE.GET_URL(
            P_APPLICATION => PCK_UTIL.F_GET_PARAMETRO_CONFIGURACAO('APP_ID'),
            P_PAGE        => 1,
            P_ITEMS       => 'P7_ITEM_NAMES,P7_ITEM_VALUES,P7_PAGE_NUMBER',
            P_VALUES      => ',,1',
            P_CLEAR_CACHE => 1
        );*/

         -- 1. Inserir novos registros que estão em VW_BAR_SERVIDOR_PESSOA_UORG mas não estão em UORG_SYNC_EXERCICIO_HISTORICO
        FOR reg IN (
            SELECT COD_SERVIDOR, COD_UORG_EXERCICIO
            FROM VW_BAR_SERVIDOR_PESSOA_UORG
            WHERE COD_SERVIDOR NOT IN (SELECT COD_SERVIDOR FROM UORG_SYNC_EXERCICIO_HISTORICO)
        ) LOOP
            INSERT INTO UORG_SYNC_EXERCICIO_HISTORICO (COD_SERVIDOR, COD_UORG_EXERCICIO, DATA_INSERT,DATA_UPDATE)
            VALUES (reg.COD_SERVIDOR, reg.COD_UORG_EXERCICIO, PCK_UTIL.GET_SYSDATE, PCK_UTIL.GET_SYSDATE);
        END LOOP;

        -- 2. Atualizar registros que estão em ambas as tabelas, mas possuem dados diferentes e envia os email.
        FOR reg IN (
            SELECT B.COD_SERVIDOR, B.COD_UORG_EXERCICIO as COD_UORG_EXERCICIO_NEW, H.COD_UORG_EXERCICIO as COD_UORG_EXERCICIO_OLD
            FROM VW_BAR_SERVIDOR_PESSOA_UORG B
            JOIN UORG_SYNC_EXERCICIO_HISTORICO H ON B.COD_SERVIDOR = H.COD_SERVIDOR
            WHERE B.COD_UORG_EXERCICIO <> H.COD_UORG_EXERCICIO 
        ) LOOP


        -- GET DADOS DO USUÁRIO
        BEGIN
        SELECT 
            NOME_PESSOA_FISICA,
            EMAIL_SERVIDOR 
        INTO 
            V_NOME_USUARIO,
            V_EMAIL_USUARIO  
        FROM VW_BAR_SERVIDOR WHERE CODIGO_SERVIDOR = reg.COD_SERVIDOR;
        EXCEPTION 
        WHEN OTHERS THEN
        V_EMAIL_USUARIO := NULL;
        END;


        -- GET DADOS DA UORG ANTERIOR
        BEGIN
        SELECT SIGLA_UORG ||' - '|| NOME_UORG 
        INTO   V_UORG_ANT
        FROM BAR_UORG WHERE COD = reg.COD_UORG_EXERCICIO_OLD;
        EXCEPTION 
        WHEN OTHERS THEN
        V_UORG_ANT := NULL;
        END;


        -- GET DADOS DA NOVA UORG 
        BEGIN
        SELECT SIGLA_UORG ||' - '|| NOME_UORG 
        INTO   V_NOVA_UORG
        FROM BAR_UORG WHERE COD = reg.COD_UORG_EXERCICIO_NEW;
        EXCEPTION 
        WHEN OTHERS THEN
        V_NOVA_UORG := NULL;
        END;

        -- GET DADOS DA RESPONSAVEL DA ANTIGA UORG
        BEGIN
            SELECT 
                S.NOME_PESSOA_FISICA,
                S.EMAIL_SERVIDOR 
            INTO 
                V_NOME_PESSOA_FISICA_NEW_UORG,
                V_EMAIL_PESSOA_FISICA_NEW_UORG
            FROM VW_BAR_SERVIDOR S,
            BAR_UORG U
            WHERE U.COD_SERVIDOR_RESPONSAVEL_FK = S.CODIGO_SERVIDOR
            AND U.COD = reg.COD_UORG_EXERCICIO_NEW;
        EXCEPTION 
        WHEN OTHERS THEN
        V_EMAIL_PESSOA_FISICA_NEW_UORG := NULL;
        END;


        -- ENVIANDO O EMAIL AO DESTINATARIO DA NOVA UORG
        IF V_EMAIL_PESSOA_FISICA_NEW_UORG IS NOT NULL THEN

             -- REALIZANDO O TRATAMENTO DOS PARAMETROS PARA ENVIO DE EMAIL.
            
              V_PARAMETROS := INITCAP(REGEXP_SUBSTR(V_NOME_PESSOA_FISICA_NEW_UORG,'[^ ]+', 1, 1));
              V_PARAMETROS := V_PARAMETROS || '|' || RTRIM(PCK_NOTIFICACAO.C_URL_BASE,'/') || V_URL; -- PARAMETRO @LINK@
              V_PARAMETROS := V_PARAMETROS || '|' || V_TIPO_AMBIENTE;
              V_PARAMETROS := V_PARAMETROS || '|' || V_NOME_USUARIO;              
              V_PARAMETROS := V_PARAMETROS || '|' || V_UORG_ANT;
              V_PARAMETROS := V_PARAMETROS || '|' || V_NOVA_UORG;

              PCK_NOTIFICACAO.PROC_ENVIA_EMAIL (P_ID_EMAIL                => 20 -- PROJETO_DEVOLVIDO_PARA_ANALISE_11 [HEFESTO] - [ANTAQ+] - AVISO! Alteração de UORG
                                               ,P_DESTINATARIO            => LOWER(nvl(PCK_NOTIFICACAO.F_EMAIL_DESTINATARIO_TESTE,V_EMAIL_PESSOA_FISICA_NEW_UORG)) 
                                               ,P_PARAMETROS              => V_PARAMETROS
                                               ,P_SPLIT                   => '|'
                                               ,P_PARAMETRO_ASSUNTO       => '');   
        END IF;


        -- GET DADOS DA RESPONSAVEL DA ANTIGA UORG
        BEGIN
            SELECT 
                S.NOME_PESSOA_FISICA,
                S.EMAIL_SERVIDOR 
            INTO 
                V_NOME_PESSOA_FISICA_OLD_UORG,
                V_EMAIL_PESSOA_FISICA_OLD_UORG
            FROM VW_BAR_SERVIDOR S,
            BAR_UORG U
            WHERE U.COD_SERVIDOR_RESPONSAVEL_FK = S.CODIGO_SERVIDOR
            AND U.COD = reg.COD_UORG_EXERCICIO_OLD;
        EXCEPTION 
        WHEN OTHERS THEN
        V_EMAIL_PESSOA_FISICA_OLD_UORG := NULL;
        END;

        
         -- ENVIANDO O EMAIL AO DESTINATARIO DA UORG ANTERIOR
        IF V_EMAIL_PESSOA_FISICA_OLD_UORG IS NOT NULL THEN

             -- REALIZANDO O TRATAMENTO DOS PARAMETROS PARA ENVIO DE EMAIL.
            
              V_PARAMETROS := INITCAP(REGEXP_SUBSTR(V_NOME_PESSOA_FISICA_OLD_UORG,'[^ ]+', 1, 1));
              V_PARAMETROS := V_PARAMETROS || '|' || RTRIM(PCK_NOTIFICACAO.C_URL_BASE,'/') || V_URL; -- PARAMETRO @LINK@
              V_PARAMETROS := V_PARAMETROS || '|' || V_TIPO_AMBIENTE;
              V_PARAMETROS := V_PARAMETROS || '|' || V_NOME_USUARIO;              
              V_PARAMETROS := V_PARAMETROS || '|' || V_UORG_ANT;
              V_PARAMETROS := V_PARAMETROS || '|' || V_NOVA_UORG;

              PCK_NOTIFICACAO.PROC_ENVIA_EMAIL (P_ID_EMAIL                => 20 -- PROJETO_DEVOLVIDO_PARA_ANALISE_11 [HEFESTO] - [ANTAQ+] - AVISO! Alteração de UORG
                                               ,P_DESTINATARIO            => LOWER(nvl(PCK_NOTIFICACAO.F_EMAIL_DESTINATARIO_TESTE,V_EMAIL_PESSOA_FISICA_OLD_UORG)) 
                                               ,P_PARAMETROS              => V_PARAMETROS
                                               ,P_SPLIT                   => '|'
                                               ,P_PARAMETRO_ASSUNTO       => '');   
        END IF;


        UPDATE UORG_SYNC_EXERCICIO_HISTORICO
        SET COD_UORG_EXERCICIO = reg.COD_UORG_EXERCICIO_NEW,
            DATA_UPDATE = PCK_UTIL.GET_SYSDATE
        WHERE COD_SERVIDOR = reg.COD_SERVIDOR;



    END LOOP;

    -- 3. Excluir registros que estão em UORG_SYNC_EXERCICIO_HISTORICO, mas não estão mais em VW_BAR_SERVIDOR_PESSOA_UORG
    FOR reg IN (
        SELECT COD_SERVIDOR
        FROM UORG_SYNC_EXERCICIO_HISTORICO
        WHERE COD_SERVIDOR NOT IN (SELECT COD_SERVIDOR FROM VW_BAR_SERVIDOR_PESSOA_UORG)
    ) LOOP
        DELETE FROM UORG_SYNC_EXERCICIO_HISTORICO
        WHERE COD_SERVIDOR = reg.COD_SERVIDOR;
    END LOOP;

 
END UORG_ENVIA_EMAIL_DIF_UORG;


end "PCK_UORG";
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
 FUNCTION F_URL_APLICACAO RETURN VARCHAR2 IS 
-- 
 V_URL_APLICACAO   CONFIGURACAO.VALOR%TYPE;
-- 
 BEGIN 
   -- 
    BEGIN
    SELECT VALOR INTO V_URL_APLICACAO FROM CONFIGURACAO WHERE PARAMETRO = 'URL_APLICACAO';
    EXCEPTION 
    WHEN OTHERS THEN
    V_URL_APLICACAO := NULL;
    END;
   -- 
     RETURN V_URL_APLICACAO; 
   -- 
 END F_URL_APLICACAO; 
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

 --
 -- A FUNCAO VALIDA DIA UTIL
 FUNCTION F_VALIDA_DIA_UTIL(P_DATA IN DATE) RETURN VARCHAR2 IS
    BEGIN
        -- Verifica se é sábado ou domingo
        IF TO_CHAR(P_DATA, 'D') BETWEEN 2 AND 6 THEN
            RETURN 'S';
        ELSE
            RETURN 'N';
        END IF;
 END;

 --

 -- 
FUNCTION F_CALCULAR_HORAS_UTEIS(DATA_INICIO IN DATE, DATA_FIM IN DATE, HORA_UTIL IN NUMBER) RETURN NUMBER IS 
    V_CONTADOR NUMBER := 0; 
     
BEGIN 
 
    -- Loop para calcular os dias úteis 
    FOR I IN 0 .. ABS(DATA_FIM - DATA_INICIO) LOOP 
        -- Verifica se o dia é útil (de segunda a sexta-feira) 
        IF TO_CHAR(DATA_INICIO + I, 'D') BETWEEN 2 AND 6 THEN 
            V_CONTADOR := V_CONTADOR + 1; 
        END IF; 
    END LOOP; 
 
    -- Retorna o total de horas úteis (8 horas por dia útil) 
    RETURN V_CONTADOR * HORA_UTIL; 
 
END F_CALCULAR_HORAS_UTEIS; 
 
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
 
 FUNCTION MASCARA_CPF( 
  p_nro_cpf    IN VARCHAR2 
) RETURN VARCHAR2 AS 
  -- 
  v_str VARCHAR2(32); 
  v_nro_cpf VARCHAR2(32); 
  -- 
BEGIN 
  -- 
  IF p_nro_cpf IS NULL THEN 
    RETURN NULL; 
  END IF; 
  -- 
  v_nro_cpf := regexp_replace(LPAD(p_nro_cpf,11,0),'([0-9]{3})([0-9]{3})([0-9]{3})','\1.\2.\3-'); 
 
  v_str := LPAD(REPLACE(v_nro_cpf, ' '), 14, '0'); 
  -- 
  RETURN '***.' || SUBSTR(v_str, 5, 7) || '-**'; 
  -- 
EXCEPTION WHEN OTHERS THEN 
  RETURN v_nro_cpf; 
END; 
 
-- 
FUNCTION F_CALCULAR_PERCENTUAL_DIAS_UTEIS( 
   p_data_inicio IN DATE, 
   p_data_fim IN DATE, 
   p_percentual IN NUMBER 
) RETURN DATE IS 
   v_nova_data_fim DATE;          -- Variável para a nova data de fim 
   v_total_dias_uteis NUMBER;     -- Total de dias úteis entre data início e fim 
   v_dias_ajustados NUMBER;       -- Dias ajustados com base no percentual 
   v_dia_corrente DATE;           -- Variável para controlar a contagem do dia útil 
   v_contador NUMBER := 0;        -- Contador para calcular dias úteis 
BEGIN 
    -- Lógica para calcular dias úteis entre a data de início e a data de fim 
    FOR i IN 0 .. ABS(p_data_fim - p_data_inicio) LOOP 
       -- Considera os dias da semana entre segunda (2) e sexta-feira (6) 
       IF TO_CHAR(p_data_inicio + i, 'D') BETWEEN 2 AND 6 THEN 
          v_contador := v_contador + 1; 
       END IF; 
    END LOOP; 
 
    -- Calcula o total de dias úteis entre as duas datas 
    v_total_dias_uteis := v_contador; 
 
    -- Se o percentual for 100%, retorna a data de fim original 
    IF p_percentual = 100 THEN 
       RETURN p_data_fim; 
    END IF; 
    
    -- Calcula os dias ajustados com base no percentual fornecido, arredondando para cima 
    v_dias_ajustados := CEIL(v_total_dias_uteis * (p_percentual / 100)); 
    
    -- Inicializa a data corrente como a data de início 
    v_dia_corrente := p_data_inicio; 
    v_nova_data_fim := p_data_inicio; -- Inicialmente a nova data de fim é igual à data de início 
 
    -- Loop para ajustar a nova data de fim, considerando apenas dias úteis 
    v_contador := 0;  -- Resetando o contador para contar os dias úteis ajustados 
    WHILE v_contador < v_dias_ajustados LOOP 
        -- Apenas avança a nova data de fim se for um dia útil 
        IF TO_CHAR(v_dia_corrente, 'D') BETWEEN 2 AND 6 THEN 
            v_nova_data_fim := v_dia_corrente; 
            v_contador := v_contador + 1; 
        END IF; 
          
        -- Avança para o próximo dia 
        v_dia_corrente := v_dia_corrente + 1; 
    END LOOP; 
 
    -- Retorna a nova data de fim ajustada 
    RETURN v_nova_data_fim; 
END F_CALCULAR_PERCENTUAL_DIAS_UTEIS; 
-- 

FUNCTION F_GET_PARAMETRO_CONFIGURACAO(P_PARAMETRO IN VARCHAR2) RETURN VARCHAR2
IS
    V_VALOR_PARAMETRO CONFIGURACAO.VALOR%TYPE;
BEGIN

    SELECT VALOR
      INTO V_VALOR_PARAMETRO
      FROM CONFIGURACAO
     WHERE PARAMETRO = P_PARAMETRO;

    RETURN V_VALOR_PARAMETRO;

EXCEPTION WHEN OTHERS THEN
    RETURN '';
END F_GET_PARAMETRO_CONFIGURACAO;
 
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