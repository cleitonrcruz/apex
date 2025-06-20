create or replace TRIGGER TRG_INTEGRACAO_API_PLANO_ENTREGA
AFTER INSERT OR UPDATE ON PLANO_ENTREGA
FOR EACH ROW
DECLARE
--
BEGIN
  --
   PCK_API_MGI.PRC_REGISTRO_INTEGRACAO (P_API         => 'PCK_API_MGI'
                                       ,P_PROCESSO    => 'PLANO_ENTREGA'
                                       ,P_CHAVE       => NVL(:NEW.COD_PLANO, :OLD.COD_PLANO));
  --
END;
/
create or replace TRIGGER TRG_INTEGRACAO_API_PLANO_TRABALHO
AFTER INSERT OR UPDATE ON PLANO_TRABALHO_ATIVIDADE
FOR EACH ROW
DECLARE
--
 CURSOR C_PARTICIPANTE IS
 SELECT TC.COD_TERMO_CIENCIA
   FROM PLANO_TRABALHO PT
     ,  TERMO_CIENCIA TC
  WHERE PT.COD_SERVIDOR       = TC.COD_SERVIDOR_FK
    AND PT.COD_PLANO_TRABALHO = NVL(:NEW.COD_PLANO_TRABALHO, :OLD.COD_PLANO_TRABALHO)
    AND TC.DATA_ASSINATURA    IS NOT NULL;
--
 CURSOR C_PLANO_ENTREGA IS
 SELECT DISTINCT PE.COD_PLANO
   FROM PLANO_ENTREGA PE
  WHERE PE.COD_PLANO_ENTREGA = NVL(:NEW.COD_PLANO_ENTREGA, :OLD.COD_PLANO_ENTREGA);
--
BEGIN
  --
   FOR X IN C_PARTICIPANTE LOOP
    --
     PCK_API_MGI.PRC_REGISTRO_INTEGRACAO (P_API         => 'PCK_API_MGI'
                                         ,P_PROCESSO    => 'TERMO_CIENCIA'
                                         ,P_CHAVE       => X.COD_TERMO_CIENCIA);
    --
   END LOOP;
  --
   FOR Y IN C_PLANO_ENTREGA LOOP
    --
     PCK_API_MGI.PRC_REGISTRO_INTEGRACAO (P_API         => 'PCK_API_MGI'
                                         ,P_PROCESSO    => 'PLANO_ENTREGA'
                                         ,P_CHAVE       => Y.COD_PLANO);
    --
   END LOOP;
  --
   PCK_API_MGI.PRC_REGISTRO_INTEGRACAO (P_API         => 'PCK_API_MGI'
                                       ,P_PROCESSO    => 'PLANO_TRABALHO'
                                       ,P_CHAVE       => NVL(:NEW.COD_PLANO_TRABALHO, :OLD.COD_PLANO_TRABALHO));
  --
END;
/
create or replace TRIGGER TRG_INTEGRACAO_API_TERMO_CIENCIA
AFTER INSERT OR UPDATE ON TERMO_CIENCIA
FOR EACH ROW
DECLARE
--
BEGIN
  --
   IF INSERTING AND :NEW.DATA_ASSINATURA IS NOT NULL
    THEN
      --
       PCK_API_MGI.PRC_REGISTRO_INTEGRACAO (P_API         => 'PCK_API_MGI'
                                           ,P_PROCESSO    => 'TERMO_CIENCIA'
                                           ,P_CHAVE       => :NEW.COD_TERMO_CIENCIA);
      --
   END IF;
  --
   IF UPDATING AND ((:NEW.DATA_ASSINATURA IS NOT NULL) OR :OLD.DATA_ASSINATURA IS NOT NULL)
    THEN
      --
       PCK_API_MGI.PRC_REGISTRO_INTEGRACAO (P_API         => 'PCK_API_MGI'
                                           ,P_PROCESSO    => 'TERMO_CIENCIA'
                                           ,P_CHAVE       => :OLD.COD_TERMO_CIENCIA);
      --
   END IF;

  --
END;
/
create or replace trigger TRGL_LOG_DDL
after ddl on schema
 
DECLARE
  V_OPERACAO     VARCHAR2(50);
  V_OWNER        VARCHAR2(255);
  V_OBJETO       VARCHAR2(255);
  V_TIPO         VARCHAR2(50);
  V_COMANDO      CLOB;
  V_SQL_TEXT     ORA_NAME_LIST_T;
--
BEGIN
  SELECT ora_sysevent
    INTO V_OPERACAO
    FROM DUAL;
  --
   SELECT ora_dict_obj_owner
        , ora_dict_obj_name
        , ora_dict_obj_type
     INTO V_OWNER
        , V_OBJETO
        , V_TIPO
     FROM dual;
  --
   FOR X IN 1 .. ORA_SQL_TXT(V_SQL_TEXT) LOOP
     --
      V_COMANDO := V_COMANDO || V_SQL_TEXT(X);
     --
   END LOOP;
  -- 
   INSERT INTO LOG_DDL (USUARIO, DATA, MAQUINA, IP, OPERACAO, OWNER, OBJETO, USUARIO_APLICACAO, COMANDO, TIPO)
        VALUES (USER
               ,SYSDATE-3/24
               ,sys_context('USERENV','HOST')
               ,sys_context('USERENV','IP_ADDRESS')
               ,V_OPERACAO
               ,V_OWNER
               ,V_OBJETO
               ,V('APP_USER')
               ,V_COMANDO
               ,V_TIPO);
 
END TRGL_LOG_DDL;
/
create or replace TRIGGER TRG_LOG_CADEIA_VALOR
AFTER INSERT OR UPDATE OR DELETE ON CADEIA_VALOR
FOR EACH ROW
DECLARE
    V_ACTION VARCHAR2(100);
    V_COLUMN VARCHAR2(100);
    V_TABLE_NAME VARCHAR2(100);
BEGIN

    V_TABLE_NAME := 'CADEIA_VALOR';

    IF INSERTING THEN
        V_ACTION := 'INSERT';
    ELSIF UPDATING THEN
        V_ACTION := 'UPDATE';
    ELSIF DELETING THEN
        V_ACTION := 'DELETE';
    END IF;

     -- REGISTRA 
    IF V_ACTION in ('INSERT','DELETE') THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     '',
                        P_COLUMM_LABEL    =>     '',
                        P_OLD_VALUES      =>     '',
                        P_NEW_VALUES      =>     '',
                        P_ID              =>     :NEW.COD_CADEIA_VALOR);

    END IF;


    -- REGISTRA ALTERAÇÕES NO CAMPO MACROPROCESSO
    IF V_ACTION in ('UPDATE') AND NVL(:OLD.MACROPROCESSO,' ') <> NVL(:NEW.MACROPROCESSO,' ') THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'MACROPROCESSO',
                        P_COLUMM_LABEL    =>     'Macroprocesso:',
                        P_OLD_VALUES      =>     :OLD.MACROPROCESSO,
                        P_NEW_VALUES      =>     :NEW.MACROPROCESSO,
                        P_ID              =>     :NEW.COD_CADEIA_VALOR);

    END IF;


     -- REGISTRA ALTERAÇÕES NO CAMPO DESCRICAO
    IF V_ACTION in ('UPDATE') AND NVL(:OLD.DESCR_CADEIA_VALOR,' ') <> NVL(:NEW.DESCR_CADEIA_VALOR,' ') THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'DESCR_CADEIA_VALOR',
                        P_COLUMM_LABEL    =>     'Descrição:',
                        P_OLD_VALUES      =>     :OLD.DESCR_CADEIA_VALOR,
                        P_NEW_VALUES      =>     :NEW.DESCR_CADEIA_VALOR,
                        P_ID              =>     :NEW.COD_CADEIA_VALOR);

    END IF;

    -- REGISTRA ALTERAÇÕES NO CAMPO STATUS
    IF V_ACTION in ('UPDATE') AND :OLD.IND_ATIVO <> :NEW.IND_ATIVO THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'IND_ATIVO',
                        P_COLUMM_LABEL    =>     'Status:',
                        P_OLD_VALUES      =>     (CASE WHEN :OLD.IND_ATIVO = 'A' THEN 'ATIVO' ELSE 'INATIVO' END),
                        P_NEW_VALUES      =>     (CASE WHEN :NEW.IND_ATIVO = 'A' THEN 'ATIVO' ELSE 'INATIVO' END),
                        P_ID              =>     :NEW.COD_CADEIA_VALOR);

    END IF;


    -- REGISTRA ALTERAÇÕES NO CAMPO JUSTIFICATIVA
    IF V_ACTION in ('UPDATE') AND  NVL(:OLD.JUSTIFICATIVA, ' ') <> :NEW.JUSTIFICATIVA THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'JUSTIFICATIVA',
                        P_COLUMM_LABEL    =>     'Justificativa:',
                        P_OLD_VALUES      =>     :OLD.JUSTIFICATIVA,
                        P_NEW_VALUES      =>     :NEW.JUSTIFICATIVA,
                        P_ID              =>     :NEW.COD_CADEIA_VALOR);

    END IF;



END;
/
create or replace TRIGGER TRG_LOG_CADEIA_VALOR_NIVEL2
AFTER INSERT OR UPDATE OR DELETE ON CADEIA_VALOR_NIVEL2
FOR EACH ROW
DECLARE
    V_ACTION VARCHAR2(100);
    V_COLUMN VARCHAR2(100);
    V_TABLE_NAME VARCHAR2(100);
BEGIN

    V_TABLE_NAME := 'CADEIA_VALOR_NIVEL2';

    IF INSERTING THEN
        V_ACTION := 'INSERT';
    ELSIF UPDATING THEN
        V_ACTION := 'UPDATE';
    ELSIF DELETING THEN
        V_ACTION := 'DELETE';
    END IF;

     -- REGISTRA 
    IF V_ACTION in ('INSERT','DELETE') THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     '',
                        P_COLUMM_LABEL    =>     '',
                        P_OLD_VALUES      =>     '',
                        P_NEW_VALUES      =>     '',
                        P_ID              =>     :NEW.COD_CADEIA_VALOR_NIVEL2);

    END IF;


    -- REGISTRA ALTERAÇÕES NO CAMPO NOME
    IF V_ACTION in ('UPDATE') AND nvl(:OLD.NOME,' ') <> nvl(:NEW.NOME,' ') THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'NOME',
                        P_COLUMM_LABEL    =>     'Nome:',
                        P_OLD_VALUES      =>     :OLD.NOME,
                        P_NEW_VALUES      =>     :NEW.NOME,
                        P_ID              =>     :NEW.COD_CADEIA_VALOR_NIVEL2);

    END IF;


     -- REGISTRA ALTERAÇÕES NO CAMPO VALOR
    IF V_ACTION in ('UPDATE') AND nvl(:OLD.VALOR,' ') <> nvl(:NEW.VALOR,' ') THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'VALOR',
                        P_COLUMM_LABEL    =>     'Valor:',
                        P_OLD_VALUES      =>     :OLD.VALOR,
                        P_NEW_VALUES      =>     :NEW.VALOR,
                        P_ID              =>     :NEW.COD_CADEIA_VALOR_NIVEL2);

    END IF;


         -- REGISTRA ALTERAÇÕES NO CAMPO DESCR
    IF V_ACTION in ('UPDATE') AND nvl(:OLD.DESCR,' ') <> nvl(:NEW.DESCR,' ') THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'DESCR',
                        P_COLUMM_LABEL    =>     'Descrição:',
                        P_OLD_VALUES      =>     :OLD.DESCR,
                        P_NEW_VALUES      =>     :NEW.DESCR,
                        P_ID              =>     :NEW.COD_CADEIA_VALOR_NIVEL2);

    END IF;

    -- REGISTRA ALTERAÇÕES NO CAMPO STATUS
    IF V_ACTION in ('UPDATE') AND :OLD.IND_ATIVO <> :NEW.IND_ATIVO THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'IND_ATIVO',
                        P_COLUMM_LABEL    =>     'Status:',
                        P_OLD_VALUES      =>     (CASE WHEN :OLD.IND_ATIVO = 'A' THEN 'ATIVO' ELSE 'INATIVO' END),
                        P_NEW_VALUES      =>     (CASE WHEN :NEW.IND_ATIVO = 'A' THEN 'ATIVO' ELSE 'INATIVO' END),
                        P_ID              =>     :NEW.COD_CADEIA_VALOR_NIVEL2);

    END IF;

        -- REGISTRA ALTERAÇÕES NO CAMPO JUSTIFICATIVA
    IF V_ACTION in ('UPDATE') AND  NVL(:OLD.JUSTIFICATIVA, ' ') <> :NEW.JUSTIFICATIVA THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'JUSTIFICATIVA',
                        P_COLUMM_LABEL    =>     'Justificativa: ',
                        P_OLD_VALUES      =>     :OLD.JUSTIFICATIVA,
                        P_NEW_VALUES      =>     :NEW.JUSTIFICATIVA,
                        P_ID              =>     :NEW.COD_CADEIA_VALOR_NIVEL2);

    END IF;




END;
/
create or replace TRIGGER TRG_LOG_CADEIA_VALOR_NIVEL3
AFTER INSERT OR UPDATE OR DELETE ON CADEIA_VALOR_NIVEL3
FOR EACH ROW
DECLARE
    V_ACTION VARCHAR2(100);
    V_COLUMN VARCHAR2(100);
    V_TABLE_NAME VARCHAR2(100);
BEGIN

    V_TABLE_NAME := 'CADEIA_VALOR_NIVEL3';

    IF INSERTING THEN
        V_ACTION := 'INSERT';
    ELSIF UPDATING THEN
        V_ACTION := 'UPDATE';
    ELSIF DELETING THEN
        V_ACTION := 'DELETE';
    END IF;

     -- REGISTRA 
    IF V_ACTION in ('INSERT','DELETE') THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     '',
                        P_COLUMM_LABEL    =>     '',
                        P_OLD_VALUES      =>     '',
                        P_NEW_VALUES      =>     '',
                        P_ID              =>     :NEW.COD_CADEIA_VALOR_NIVEL3);

    END IF;


    -- REGISTRA ALTERAÇÕES NO CAMPO NOME
    IF V_ACTION in ('UPDATE') AND nvl(:OLD.NOME,' ') <> nvl(:NEW.NOME,' ') THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'NOME',
                        P_COLUMM_LABEL    =>     'Nome:',
                        P_OLD_VALUES      =>     :OLD.NOME,
                        P_NEW_VALUES      =>     :NEW.NOME,
                        P_ID              =>     :NEW.COD_CADEIA_VALOR_NIVEL3);

    END IF;


         -- REGISTRA ALTERAÇÕES NO CAMPO DESCR
    IF V_ACTION in ('UPDATE') AND nvl(:OLD.DESCR,' ') <> nvl(:NEW.DESCR,' ') THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'DESCR',
                        P_COLUMM_LABEL    =>     'Descrição:',
                        P_OLD_VALUES      =>     :OLD.DESCR,
                        P_NEW_VALUES      =>     :NEW.DESCR,
                        P_ID              =>     :NEW.COD_CADEIA_VALOR_NIVEL3);

    END IF;

    -- REGISTRA ALTERAÇÕES NO CAMPO STATUS
    IF V_ACTION in ('UPDATE') AND :OLD.IND_ATIVO <> :NEW.IND_ATIVO THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'IND_ATIVO',
                        P_COLUMM_LABEL    =>     'Status:',
                        P_OLD_VALUES      =>     (CASE WHEN :OLD.IND_ATIVO = 'A' THEN 'ATIVO' ELSE 'INATIVO' END),
                        P_NEW_VALUES      =>     (CASE WHEN :NEW.IND_ATIVO = 'A' THEN 'ATIVO' ELSE 'INATIVO' END),
                        P_ID              =>     :NEW.COD_CADEIA_VALOR_NIVEL3);

    END IF;

    -- REGISTRA ALTERAÇÕES NO CAMPO JUSTIFICATIVA
    IF V_ACTION in ('UPDATE') AND  NVL(:OLD.JUSTIFICATIVA, ' ') <> :NEW.JUSTIFICATIVA THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'JUSTIFICATIVA',
                        P_COLUMM_LABEL    =>     'Justificativa:',
                        P_OLD_VALUES      =>     :OLD.JUSTIFICATIVA,
                        P_NEW_VALUES      =>     :NEW.JUSTIFICATIVA,
                        P_ID              =>     :NEW.COD_CADEIA_VALOR_NIVEL3);

    END IF;



END;
/
create or replace TRIGGER TRG_LOG_TERMO_CIENCIA
AFTER INSERT OR UPDATE OR DELETE ON TERMO_CIENCIA
FOR EACH ROW
DECLARE
    V_ACTION VARCHAR2(100);
    V_COLUMN VARCHAR2(100);
    V_TABLE_NAME VARCHAR2(100);
BEGIN

    V_TABLE_NAME := 'TERMO_CIENCIA';

    IF INSERTING THEN
        V_ACTION := 'INSERT';
    ELSIF UPDATING THEN
        V_ACTION := 'UPDATE';
    ELSIF DELETING THEN
        V_ACTION := 'DELETE';
    END IF;

     -- REGISTRA 
    IF V_ACTION in ('INSERT','DELETE') THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     '',
                        P_COLUMM_LABEL    =>     '',
                        P_OLD_VALUES      =>     '',
                        P_NEW_VALUES      =>     '',
                        P_ID              =>     :NEW.COD_TERMO_CIENCIA);

    END IF;


    -- REGISTRA ALTERAÇÕES NO CAMPO COD_REGIME_EXECUCAO_FK
    IF V_ACTION in ('UPDATE') AND :OLD.COD_REGIME_EXECUCAO_FK <> :NEW.COD_REGIME_EXECUCAO_FK THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'COD_REGIME_EXECUCAO_FK',
                        P_COLUMM_LABEL    =>     'Regime de execução:',
                        P_OLD_VALUES      =>     :OLD.COD_REGIME_EXECUCAO_FK,
                        P_NEW_VALUES      =>     :NEW.COD_REGIME_EXECUCAO_FK,
                        P_ID              =>     :NEW.COD_TERMO_CIENCIA);

    END IF;


     -- REGISTRA ALTERAÇÕES NO CAMPO NOME_SERVIDOR
    IF V_ACTION in ('UPDATE') AND :OLD.COD_SERVIDOR_FK <> :NEW.COD_SERVIDOR_FK THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'NOME_SERVIDOR',
                        P_COLUMM_LABEL    =>     'Nome do servidor:',
                        P_OLD_VALUES      =>     :OLD.COD_SERVIDOR_FK,
                        P_NEW_VALUES      =>     :NEW.COD_SERVIDOR_FK,
                        P_ID              =>     :NEW.COD_TERMO_CIENCIA);

    END IF;

    -- REGISTRA ALTERAÇÕES NO CAMPO STATUS
    IF V_ACTION in ('UPDATE') AND :OLD.IND_ATIVO <> :NEW.IND_ATIVO THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'IND_ATIVO',
                        P_COLUMM_LABEL    =>     'Status:',
                        P_OLD_VALUES      =>     (CASE WHEN :OLD.IND_ATIVO = 'A' THEN 'ATIVO' ELSE 'INATIVO' END),
                        P_NEW_VALUES      =>     (CASE WHEN :NEW.IND_ATIVO = 'A' THEN 'ATIVO' ELSE 'INATIVO' END),
                        P_ID              =>     :NEW.COD_TERMO_CIENCIA);

    END IF;


    -- REGISTRA ALTERAÇÕES NO CAMPO JUSTIFICATIVA
    IF V_ACTION in ('UPDATE') AND  NVL(:OLD.JUSTIFICATIVA, ' ') <> :NEW.JUSTIFICATIVA THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'JUSTIFICATIVA',
                        P_COLUMM_LABEL    =>     'Justificativa:',
                        P_OLD_VALUES      =>     :OLD.JUSTIFICATIVA,
                        P_NEW_VALUES      =>     :NEW.JUSTIFICATIVA,
                        P_ID              =>     :NEW.COD_TERMO_CIENCIA);

    END IF;

    -- REGISTRA ALTERAÇÕES NO CAMPO CARGA_HORARIA_DIARIA
    IF V_ACTION in ('UPDATE') AND  NVL(:OLD.CARGA_HORARIA_DIARIA, '') <> :NEW.CARGA_HORARIA_DIARIA THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'CARGA_HORARIA_DIARIA',
                        P_COLUMM_LABEL    =>     'Carga horária diária:',
                        P_OLD_VALUES      =>     :OLD.CARGA_HORARIA_DIARIA,
                        P_NEW_VALUES      =>     :NEW.CARGA_HORARIA_DIARIA,
                        P_ID              =>     :NEW.COD_TERMO_CIENCIA);

    END IF;

    -- REGISTRA ALTERAÇÕES NO CAMPO TEMPO_PADRAO_PLANO_TRABALHO
    IF V_ACTION in ('UPDATE') AND  NVL(:OLD.TEMPO_PADRAO_PLANO_TRABALHO, ' ') <> :NEW.TEMPO_PADRAO_PLANO_TRABALHO THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'TEMPO_PADRAO_PLANO_TRABALHO',
                        P_COLUMM_LABEL    =>     'Tempo padrão do plano de trabalho:',
                        P_OLD_VALUES      =>     :OLD.TEMPO_PADRAO_PLANO_TRABALHO,
                        P_NEW_VALUES      =>     :NEW.TEMPO_PADRAO_PLANO_TRABALHO,
                        P_ID              =>     :NEW.COD_TERMO_CIENCIA);

    END IF;

    -- REGISTRA ALTERAÇÕES NO CAMPO PRAZO_CONVOCACAO
    IF V_ACTION in ('UPDATE') AND  :OLD.PRAZO_CONVOCACAO <> :NEW.PRAZO_CONVOCACAO THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'PRAZO_CONVOCACAO',
                        P_COLUMM_LABEL    =>     'Prazo de convocação:',
                        P_OLD_VALUES      =>     :OLD.PRAZO_CONVOCACAO,
                        P_NEW_VALUES      =>     :NEW.PRAZO_CONVOCACAO,
                        P_ID              =>     :NEW.COD_TERMO_CIENCIA);

    END IF;

    -- REGISTRA ALTERAÇÕES NO CAMPO DATA_INICIO
    IF V_ACTION in ('UPDATE') AND  NVL(:OLD.DATA_INICIO, '') <> :NEW.DATA_INICIO THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'DATA_INICIO',
                        P_COLUMM_LABEL    =>     'Data de ínicio:',
                        P_OLD_VALUES      =>     :OLD.DATA_INICIO,
                        P_NEW_VALUES      =>     :NEW.DATA_INICIO,
                        P_ID              =>     :NEW.COD_TERMO_CIENCIA);

    END IF;

    -- REGISTRA ALTERAÇÕES NO CAMPO DATA_FIM
    IF V_ACTION in ('UPDATE') AND  NVL(:OLD.DATA_FIM, '') <> :NEW.DATA_FIM THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'DATA_FIM',
                        P_COLUMM_LABEL    =>     'Data fim:',
                        P_OLD_VALUES      =>     :OLD.DATA_FIM,
                        P_NEW_VALUES      =>     :NEW.DATA_FIM,
                        P_ID              =>     :NEW.COD_TERMO_CIENCIA);

    END IF;

    -- REGISTRA ALTERAÇÕES NO CAMPO NUMERO_PROCESSO
    IF V_ACTION in ('UPDATE') AND  NVL(:OLD.NUMERO_PROCESSO, ' ') <> :NEW.NUMERO_PROCESSO THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'NUMERO_PROCESSO',
                        P_COLUMM_LABEL    =>     'Número do processo:',
                        P_OLD_VALUES      =>     :OLD.NUMERO_PROCESSO,
                        P_NEW_VALUES      =>     :NEW.NUMERO_PROCESSO,
                        P_ID              =>     :NEW.COD_TERMO_CIENCIA);

    END IF;


    -- REGISTRA ALTERAÇÕES NO CAMPO SITUACAO
    IF V_ACTION in ('UPDATE') AND  NVL(:OLD.SITUACAO, '') <> :NEW.SITUACAO THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'SITUACAO',
                        P_COLUMM_LABEL    =>     'Situação:',
                        P_OLD_VALUES      =>     (CASE WHEN :OLD.SITUACAO = 2 THEN 'Aguardando assinatura' ELSE 'Assinado' END),
                        P_NEW_VALUES      =>     (CASE WHEN :NEW.SITUACAO = 2 THEN 'Aguardando assinatura' ELSE 'Assinado' END),
                        P_ID              =>     :NEW.COD_TERMO_CIENCIA);

    END IF;

    -- REGISTRA ALTERAÇÕES NO CAMPO DE_ACORDO
    IF V_ACTION in ('UPDATE') AND  NVL(:OLD.DE_ACORDO, ' ') <> :NEW.DE_ACORDO THEN

        PCK_LOG.PRC_INSERT_LOG (
                        P_TABLE_NAME      =>     V_TABLE_NAME,
                        P_ACTION          =>     V_ACTION,
                        P_COLUMM          =>     'DE_ACORDO',
                        P_COLUMM_LABEL    =>     'De acordo:',
                        P_OLD_VALUES      =>     :OLD.DE_ACORDO,
                        P_NEW_VALUES      =>     :NEW.DE_ACORDO,
                        P_ID              =>     :NEW.COD_TERMO_CIENCIA);

    END IF;



END;
/