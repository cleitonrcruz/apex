  CREATE TABLE "EMBARCACAO_DOCUMENTO" 
   (	"COD_EMBARCACAO_DOCUMENTO" NUMBER NOT NULL ENABLE, 
	"COD_EMBARCACAO" NUMBER NOT NULL ENABLE, 
	"IND_TIPO_DOCUMENTO" VARCHAR2(2 CHAR) NOT NULL ENABLE, 
	"NOME_ARQUIVO" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"MIME_TYPE" VARCHAR2(25 CHAR) NOT NULL ENABLE, 
	"ARQUIVO" BLOB NOT NULL ENABLE, 
	"DATA_VALIDADE" DATE, 
	"TIPO" NUMBER, 
	"NUMERO" NUMBER, 
	 CONSTRAINT "EMBARCACAO_DOCUMENTO_PK" PRIMARY KEY ("COD_EMBARCACAO_DOCUMENTO")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "LOG_DDL" 
   (	"COD" NUMBER DEFAULT "WKSP_VESSEL"."LOG_DDL_SEQ"."NEXTVAL" NOT NULL ENABLE, 
	"USUARIO" VARCHAR2(100), 
	"MAQUINA" VARCHAR2(255), 
	"IP" VARCHAR2(50), 
	"DATA" DATE, 
	"OPERACAO" VARCHAR2(25), 
	"OWNER" VARCHAR2(255), 
	"OBJETO" VARCHAR2(255), 
	"USUARIO_APLICACAO" VARCHAR2(100), 
	"COMANDO" CLOB
   ) ;

  CREATE TABLE "LOG_VESSEL" 
   (	"CODIGO_LOG_VESSEL" NUMBER, 
	"DATA_EVENTO" DATE, 
	"NOME_TABELA" VARCHAR2(255), 
	"USUARIO_APLICACAO" VARCHAR2(255), 
	"IP" VARCHAR2(25), 
	"ACAO" VARCHAR2(20), 
	"NOME_COLUNA" VARCHAR2(255), 
	"VALOR_ANTERIOR" VARCHAR2(32762), 
	"NOVO_VALOR" VARCHAR2(32762), 
	"MENSAGEM" VARCHAR2(32762), 
	"APLICACAO" NUMBER, 
	"PAGINA" NUMBER, 
	"CHAVE_TABELA" NUMBER, 
	 CONSTRAINT "LOG_VESSEL_PK" PRIMARY KEY ("CODIGO_LOG_VESSEL")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "SOLUCAO" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"DESCR" VARCHAR2(255) NOT NULL ENABLE, 
	"SIGLA" VARCHAR2(10), 
	"DESCR_COMPLETA" VARCHAR2(32767), 
	"VERSAO" VARCHAR2(10), 
	"ID_SGBD" VARCHAR2(25), 
	"ID_LINGUAGEM" VARCHAR2(25), 
	"IMAGEM" BLOB, 
	"IMAGEM_MIME_TYPE" VARCHAR2(255), 
	"FRAMEWORK" VARCHAR2(25), 
	"ID_USUARIO" NUMBER, 
	"DATA_CRIACAO" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	 CONSTRAINT "SOLUCAO_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "SOLUCAO_UK" UNIQUE ("SIGLA")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "TEMP_EMBARCACAO_DOCUMENTO" 
   (	"COD_EMBARCACAO_DOCUMENTO" NUMBER NOT NULL ENABLE, 
	"COD_EMBARCACAO" NUMBER NOT NULL ENABLE, 
	"IND_TIPO_DOCUMENTO" VARCHAR2(2 CHAR) NOT NULL ENABLE, 
	"NOME_ARQUIVO" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"MIME_TYPE" VARCHAR2(25 CHAR) NOT NULL ENABLE, 
	"ARQUIVO" BLOB NOT NULL ENABLE, 
	"DATA_VALIDADE" DATE DEFAULT SYSDATE, 
	"TIPO" NUMBER, 
	"NUMERO" NUMBER, 
	 CONSTRAINT "TEMP_EMBARCACAO_DOCUMENTO_PK" PRIMARY KEY ("COD_EMBARCACAO_DOCUMENTO")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "AREA_NAVEGACAO" 
   (	"DESCR_AREA" VARCHAR2(50) NOT NULL ENABLE, 
	"COD_AREA_NAVEGACAO" NUMBER NOT NULL ENABLE
   ) ;

  CREATE TABLE "CLASSE_EMBARCACAO" 
   (	"DESCR_CLASSE" VARCHAR2(255) NOT NULL ENABLE, 
	"COD_CLASSE_EMBARCACAO" NUMBER NOT NULL ENABLE, 
	"COD_TIPO_EMBARCACAO" NUMBER
   ) ;

  CREATE TABLE "DEPT" 
   (	"DEPTNO" NUMBER(2,0), 
	"DNAME" VARCHAR2(14), 
	"LOC" VARCHAR2(13), 
	 PRIMARY KEY ("DEPTNO")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "EMBARCACAO" 
   (	"COD_EMBARCACAO" NUMBER NOT NULL ENABLE, 
	"NACIONALIDADE" VARCHAR2(1 CHAR), 
	"IND_ARQUEACAO_BRUTA" VARCHAR2(1 CHAR), 
	"NUM_INSCRICAO" NUMBER, 
	"NUM_IMO" NUMBER, 
	"NOME" VARCHAR2(255), 
	"BANDEIRA_ORIGEM" VARCHAR2(2), 
	"BANDEIRA_ATUAL" VARCHAR2(2), 
	"IND_NUM_IRIN" VARCHAR2(1), 
	"NUM_PRPM" VARCHAR2(20), 
	"NUM_TIE" VARCHAR2(20), 
	"NUM_DPP" VARCHAR2(20), 
	"NUM_PROTOCOLO_INSCRICAO" VARCHAR2(20), 
	"NUM_INSCRICAO_PROVISORIA" VARCHAR2(20), 
	"NUM_REB" VARCHAR2(20), 
	"TIPO_NAVEGACAO" VARCHAR2(25), 
	"AREA_NAVEGACAO" VARCHAR2(25), 
	"NATUREZA_TIPO_CARGA" VARCHAR2(25), 
	"TIPO_EMBARCACAO" VARCHAR2(2), 
	"CLASSE_EMBARCACAO" VARCHAR2(2), 
	"SITUACAO" VARCHAR2(2), 
	"ANO_EMBARCACAO" NUMBER, 
	"MATERIAL_CASCO" NUMBER, 
	"TIPO_PROPULSAO" NUMBER, 
	"NUM_BHP" NUMBER, 
	"QTD_MOTOR" NUMBER, 
	"VALOR_ARQUEACAO_BRUTA" NUMBER, 
	"VALOR_ARQUEACAO_LIQUIDA" NUMBER, 
	"VALOR_TPB" NUMBER, 
	"COMPRIMENTO_EMBARCACAO" NUMBER, 
	"COMPRIMENTO_BOCA" NUMBER, 
	"COMPRIMENTO_CALADO" NUMBER, 
	"VALOR_VELOCIDADE" NUMBER, 
	"VALOR_CAPACIDADE" NUMBER, 
	"IND_CAPACIDADE_CARGA" VARCHAR2(1), 
	"VALOR_CAPACIDADE_VEICULO" NUMBER, 
	"VALOR_CAPACIDADE_TEUS" NUMBER, 
	"VALOR_CAPACIDADE_PASSAGEIROS" NUMBER, 
	"SITUACAO_CADASTRAL" VARCHAR2(1) DEFAULT 'A', 
	"NUM_IRIN" VARCHAR2(50), 
	"DOCUMENTO_PROPRIEDADE" VARCHAR2(14), 
	"PROCESSADO" VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE, 
	"USUARIO" VARCHAR2(50) NOT NULL ENABLE, 
	"DATA_CADASTRO" DATE DEFAULT SYSDATE-3/24 NOT NULL ENABLE, 
	"DATA_ULTIMA_ATUALIZACAO" DATE, 
	"PAGINA_ETAPA" NUMBER, 
	"SITUACAO_REGISTRO" VARCHAR2(1) DEFAULT 'P', 
	"CODIGO_EMBARCACAO_ATIVO" NUMBER, 
	"NUM_CASCO" NUMBER, 
	"FINALIDADE_EMBARCACAO" VARCHAR2(1), 
	"CNPJ_ESTALEIRO" VARCHAR2(18), 
	"TIPO_SERVICO" VARCHAR2(1), 
	"QUAL_ONUS" VARCHAR2(50), 
	"RAZAO_SOCIAL_PROPRIETARIO" VARCHAR2(50), 
	"POSSUI_ONUS" VARCHAR2(1), 
	"DATA_ASSINATURA_CONTRATO" DATE, 
	"PREVISAO_CONCLUSAO_SERVICO" DATE, 
	"SITUACAO_SERVICO" NUMBER, 
	 CONSTRAINT "EMBARCACAO_PK" PRIMARY KEY ("COD_EMBARCACAO")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "EMBARCACAO_TIPO_CARGA" 
   (	"COD_EMBARCACAO_TIPO_CARGA" NUMBER, 
	"COD_EMBARCACAO" NUMBER, 
	"COD_TIPO_CARGA" NUMBER, 
	"CAPACIDADE" NUMBER, 
	 CONSTRAINT "EMBARCACAO_TIPO_CARGA" PRIMARY KEY ("COD_EMBARCACAO_TIPO_CARGA")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "EMBARCACAO_VISTORIA" 
   (	"COD_EMBARCACAO_VISTORIA" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"COD_EMBARCACAO" NUMBER, 
	"NUM_VISTORIA" NUMBER, 
	"DATA_LANCAMENTO" DATE, 
	"DATA_VENCIMENTO" DATE, 
	 CONSTRAINT "EMBARCACAO_VISTORIA_PK" PRIMARY KEY ("COD_EMBARCACAO_VISTORIA")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "LOG_USUARIO" 
   (	"ID" NUMBER DEFAULT "WKSP_VESSEL"."LOG_USUARIO_SEQ"."NEXTVAL", 
	"DATA_EVENTO" DATE, 
	"USUARIO_EVENTO" CHAR(255), 
	"OPERACAO" CHAR(1), 
	"ID_USUARIO" NUMBER, 
	"NOME" VARCHAR2(255), 
	"CPF" VARCHAR2(11), 
	"EMAIL" VARCHAR2(255), 
	"TELEFONE" VARCHAR2(11), 
	"CARGO" VARCHAR2(255), 
	"ID_SECAO" NUMBER, 
	"ID_SOLUCAO" NUMBER, 
	"PERFIL" NUMBER, 
	"IND_ATIVO" VARCHAR2(1), 
	"SENHA" VARCHAR2(32), 
	"JUSTIFICATIVA" VARCHAR2(255), 
	"IP_EVENTO" VARCHAR2(50), 
	"APLICACAO_EVENTO" NUMBER, 
	"PAGINA_EVENTO" NUMBER, 
	 CONSTRAINT "LOG_USUARIO_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "LOG_USUARIO_SOLUCAO_PERMISSAO" 
   (	"ID" NUMBER, 
	"DATA_EVENTO" DATE, 
	"USUARIO_EVENTO" CHAR(255), 
	"OPERACAO" CHAR(1), 
	"IP_EVENTO" CHAR(15), 
	"APLICACAO_EVENTO" NUMBER, 
	"PAGINA_EVENTO" NUMBER, 
	"ID_USUARIO_SOLUCAO_PERMISSAO" NUMBER, 
	"ID_USUARIO" NUMBER, 
	"ID_SOLUCAO" NUMBER, 
	"PAPEL" NUMBER, 
	 CONSTRAINT "LOG_USUARIO_SOLUCAO_PERMISSAO_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "MATERIAL_EMBARCACAO" 
   (	"DESCR_MATERIAL" VARCHAR2(50) NOT NULL ENABLE, 
	"COD_MATERIAL_EMBARCACAO" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "MATERIAL_EMBARCACAO_PK" PRIMARY KEY ("COD_MATERIAL_EMBARCACAO")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "NATUREZA_EMBARCACAO" 
   (	"DESCR_NATUREZA" VARCHAR2(50) NOT NULL ENABLE, 
	"COD_NATUREZA_EMBARCACAO" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "NATUREZA_EMBARCACAO_PK" PRIMARY KEY ("COD_NATUREZA_EMBARCACAO")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "PAIS" 
   (	"COD_PAIS" NUMBER NOT NULL ENABLE, 
	"SIGLA_PAIS" VARCHAR2(2 CHAR) NOT NULL ENABLE, 
	"NOME_PAIS" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "PAIS_PK" PRIMARY KEY ("COD_PAIS")
  USING INDEX  ENABLE, 
	 CONSTRAINT "PAIS_UNIQ" UNIQUE ("SIGLA_PAIS")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "PROPULSAO_EMBARCACAO" 
   (	"COD_PROPULSAO_EMBARCACAO" NUMBER, 
	"DESCR_PROPULSAO" VARCHAR2(32 CHAR), 
	 CONSTRAINT "PROPULSAO_EMBARCACAO_COD_PROPULSAO_EMBARCACAO_PK" PRIMARY KEY ("COD_PROPULSAO_EMBARCACAO")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "SITUACAO_EMBARCACAO" 
   (	"DESCR_SITUACAO" VARCHAR2(50) NOT NULL ENABLE, 
	"COD_SITUACAO_EMBARCACAO" NUMBER NOT NULL ENABLE
   ) ;

  CREATE TABLE "TEMP_EMBARCACAO" 
   (	"COD_EMBARCACAO" NUMBER NOT NULL ENABLE, 
	"NACIONALIDADE" VARCHAR2(1 CHAR), 
	"IND_ARQUEACAO_BRUTA" VARCHAR2(1 CHAR), 
	"NUM_INSCRICAO" NUMBER, 
	"NUM_IMO" NUMBER, 
	"NOME" VARCHAR2(255), 
	"BANDEIRA_ORIGEM" VARCHAR2(2), 
	"BANDEIRA_ATUAL" VARCHAR2(2), 
	"IND_NUM_IRIN" VARCHAR2(1), 
	"NUM_PRPM" VARCHAR2(20), 
	"NUM_TIE" VARCHAR2(20), 
	"NUM_DPP" VARCHAR2(20), 
	"NUM_PROTOCOLO_INSCRICAO" VARCHAR2(20), 
	"NUM_INSCRICAO_PROVISORIA" VARCHAR2(20), 
	"NUM_REB" VARCHAR2(20), 
	"TIPO_NAVEGACAO" VARCHAR2(25), 
	"AREA_NAVEGACAO" VARCHAR2(25), 
	"NATUREZA_TIPO_CARGA" VARCHAR2(25), 
	"TIPO_EMBARCACAO" VARCHAR2(2), 
	"CLASSE_EMBARCACAO" VARCHAR2(2), 
	"SITUACAO" VARCHAR2(2), 
	"ANO_EMBARCACAO" NUMBER, 
	"MATERIAL_CASCO" NUMBER, 
	"TIPO_PROPULSAO" NUMBER, 
	"NUM_BHP" NUMBER, 
	"QTD_MOTOR" NUMBER, 
	"VALOR_ARQUEACAO_BRUTA" NUMBER, 
	"VALOR_ARQUEACAO_LIQUIDA" NUMBER, 
	"VALOR_TPB" NUMBER, 
	"COMPRIMENTO_EMBARCACAO" NUMBER, 
	"COMPRIMENTO_BOCA" NUMBER, 
	"COMPRIMENTO_CALADO" NUMBER, 
	"VALOR_VELOCIDADE" NUMBER, 
	"VALOR_CAPACIDADE" NUMBER, 
	"IND_CAPACIDADE_CARGA" VARCHAR2(1), 
	"VALOR_CAPACIDADE_VEICULO" NUMBER, 
	"VALOR_CAPACIDADE_TEUS" NUMBER, 
	"VALOR_CAPACIDADE_PASSAGEIROS" NUMBER, 
	"SITUACAO_CADASTRAL" VARCHAR2(1), 
	"NUM_IRIN" VARCHAR2(50), 
	"PROCESSADO" VARCHAR2(1) DEFAULT 'N' NOT NULL ENABLE, 
	"USUARIO" VARCHAR2(50) NOT NULL ENABLE, 
	"DATA_CADASTRO" DATE DEFAULT SYSDATE-3/24 NOT NULL ENABLE, 
	"DATA_ULTIMA_ATUALIZACAO" DATE, 
	"PAGINA_ETAPA" NUMBER, 
	"SITUACAO_REGISTRO" VARCHAR2(1) DEFAULT 'P', 
	"DOCUMENTO_PROPRIEDADE" VARCHAR2(14), 
	"CODIGO_EMBARCACAO_ATIVO" NUMBER, 
	"NUM_CASCO" NUMBER, 
	"FINALIDADE_EMBARCACAO" VARCHAR2(1), 
	"CNPJ_ESTALEIRO" VARCHAR2(18), 
	"TIPO_SERVICO" VARCHAR2(1), 
	"POSSUI_ONUS" VARCHAR2(1), 
	"QUAL_ONUS" VARCHAR2(50), 
	"RAZAO_SOCIAL_PROPRIETARIO" VARCHAR2(50), 
	"DATA_ASSINATURA_CONTRATO" DATE, 
	"PREVISAO_CONCLUSAO_SERVICO" DATE, 
	"SITUACAO_SERVICO" NUMBER, 
	 CONSTRAINT "TEMP_EMBARCACAO_PK" PRIMARY KEY ("COD_EMBARCACAO")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "TEMP_EMBARCACAO_TIPO_CARGA" 
   (	"COD_EMBARCACAO_TIPO_CARGA" NUMBER, 
	"COD_TEMP_EMBARCACAO" NUMBER, 
	"COD_TIPO_CARGA" NUMBER, 
	"CAPACIDADE" NUMBER, 
	 CONSTRAINT "TEMP_EMBARCACAO_TIPO_CARGA_PK" PRIMARY KEY ("COD_EMBARCACAO_TIPO_CARGA")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "TEMP_EMBARCACAO_VISTORIA" 
   (	"COD_EMBARCACAO_VISTORIA" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  NOT NULL ENABLE, 
	"COD_EMBARCACAO" NUMBER, 
	"NUM_VISTORIA" NUMBER, 
	"DATA_LANCAMENTO" DATE, 
	"DATA_VENCIMENTO" DATE, 
	 CONSTRAINT "TEMP_EMBARCACAO_VISTORIA_PK" PRIMARY KEY ("COD_EMBARCACAO_VISTORIA")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "TIPO_DOCUMENTO_EMBARCACAO" 
   (	"COD_TIPO_DOC_EMBARCACAO" NUMBER NOT NULL ENABLE, 
	"DESC_TIPO_DOC_EMBARCACAO" VARCHAR2(255 CHAR) NOT NULL ENABLE, 
	"IND_TIPO_DOCUMENTO" VARCHAR2(2 CHAR) NOT NULL ENABLE, 
	 CONSTRAINT "TIPO_DOCUMENTO_EMBARCACAO_PK" PRIMARY KEY ("COD_TIPO_DOC_EMBARCACAO")
  USING INDEX  ENABLE, 
	 CONSTRAINT "TIPO_DOCUMENTO_EMBARCACAO_UNIQ" UNIQUE ("DESC_TIPO_DOC_EMBARCACAO", "IND_TIPO_DOCUMENTO")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "TIPO_EMBARCACAO" 
   (	"DESCR_TIPO" VARCHAR2(255), 
	"COD_TIPO_EMBARCACAO" NUMBER, 
	 CONSTRAINT "TIPO_EMBARCACAO_PK" PRIMARY KEY ("COD_TIPO_EMBARCACAO")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "TIPO_NAVEGACAO_EMBARCACAO" 
   (	"DESCR_TIPO_NAVEGACAO" VARCHAR2(255) NOT NULL ENABLE, 
	"COD_TIPO_NAVEGACAO_EMBARCACAO" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "TIPO_NAVEGACAO_EMBARCACAO_PK" PRIMARY KEY ("COD_TIPO_NAVEGACAO_EMBARCACAO")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "USUARIO" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"NOME" VARCHAR2(500) NOT NULL ENABLE, 
	"CPF" VARCHAR2(11), 
	"EMAIL" VARCHAR2(255) NOT NULL ENABLE, 
	"TELEFONE" VARCHAR2(11), 
	"CARGO" VARCHAR2(255), 
	"ID_SECAO" NUMBER, 
	"ID_SOLUCAO" NUMBER, 
	"PERFIL" NUMBER, 
	"IND_ATIVO" VARCHAR2(1) DEFAULT 'A' NOT NULL ENABLE, 
	"SENHA" VARCHAR2(32), 
	"COD_MATRICULA" VARCHAR2(100), 
	"JUSTIFICATIVA" VARCHAR2(255), 
	"COD_SERVIDOR" NUMBER, 
	 CONSTRAINT "USUARIO_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "USUARIO_UK_EMAIL" UNIQUE ("EMAIL")
  USING INDEX  ENABLE
   ) ;

  CREATE TABLE "USUARIO_SOLUCAO_PERMISSAO" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"ID_USUARIO" NUMBER NOT NULL ENABLE, 
	"ID_SOLUCAO" NUMBER NOT NULL ENABLE, 
	"PAPEL" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "USUARIO_SOLUCAO_PERMISSAO_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE, 
	 CONSTRAINT "USUARIO_SOLUCAO_PERMISSAO_UK" UNIQUE ("ID_USUARIO", "ID_SOLUCAO", "PAPEL")
  USING INDEX  ENABLE
   ) ;

   COMMENT ON TABLE "AREA_NAVEGACAO"  IS 'VESSEL';

  ALTER TABLE "CLASSE_EMBARCACAO" ADD CONSTRAINT "CLASSE_EMBARCACAO_FK_TIPO_EMBARCACAO" FOREIGN KEY ("COD_TIPO_EMBARCACAO")
	  REFERENCES "TIPO_EMBARCACAO" ("COD_TIPO_EMBARCACAO") ENABLE;

   COMMENT ON TABLE "CLASSE_EMBARCACAO"  IS 'VESSEL';

  CREATE OR REPLACE EDITIONABLE TRIGGER "DEPT_TRG1" 
              before insert on dept
              for each row
              begin
                  if :new.deptno is null then
                      select dept_seq.nextval into :new.deptno from sys.dual;
                 end if;
              end;
/
ALTER TRIGGER "DEPT_TRG1" ENABLE;

  ALTER TABLE "EMBARCACAO" ADD CONSTRAINT "EMBARCACAO_FK_MATERIAL_EMBARCACAO" FOREIGN KEY ("MATERIAL_CASCO")
	  REFERENCES "MATERIAL_EMBARCACAO" ("COD_MATERIAL_EMBARCACAO") ENABLE;

   COMMENT ON COLUMN "EMBARCACAO"."NUM_CASCO" IS 'Número do casco da embarcação';
   COMMENT ON COLUMN "EMBARCACAO"."FINALIDADE_EMBARCACAO" IS 'Finalidade da embarcação. Opções: Afretamento, Porto sem papel. Campo: "Qual a finalidade do cadastro"';
   COMMENT ON COLUMN "EMBARCACAO"."CNPJ_ESTALEIRO" IS 'Estaleiro responsável pela construção/reforma da embarcação. Campo: CNPJ do estaleiro.';
   COMMENT ON COLUMN "EMBARCACAO"."TIPO_SERVICO" IS 'Situação da embarcação - Em operação - Em construção - Em reforma';
   COMMENT ON COLUMN "EMBARCACAO"."QUAL_ONUS" IS 'Se a embarcação possui ônus. Item: Qual?';
   COMMENT ON COLUMN "EMBARCACAO"."POSSUI_ONUS" IS 'Se a embarcação possui ônus. Item: A embarcação possui ônus?';
   COMMENT ON COLUMN "EMBARCACAO"."DATA_ASSINATURA_CONTRATO" IS 'Data da assinatura do contrato.';
   COMMENT ON COLUMN "EMBARCACAO"."PREVISAO_CONCLUSAO_SERVICO" IS 'Data da previsão de conclusão do serviço.';
   COMMENT ON COLUMN "EMBARCACAO"."SITUACAO_SERVICO" IS 'Situação do serviço. Opções: Não iniciado, Em andamento.';
   COMMENT ON TABLE "EMBARCACAO"  IS 'VESSEL';

  CREATE OR REPLACE EDITIONABLE TRIGGER "AIDU_LOG_VESSEL_EMBARCACAO" 
AFTER INSERT OR UPDATE OR DELETE ON EMBARCACAO
FOR EACH ROW
DECLARE
--
 V_LOG      LOG_VESSEL%ROWTYPE;
 V_REGISTRO VARCHAR2(32762);
--
BEGIN
 --
  V_LOG.DATA_EVENTO       := SYSDATE-3/24;
  V_LOG.NOME_TABELA       := 'EMBARCACAO';
  V_LOG.USUARIO_APLICACAO := V('APP_USER');
  V_LOG.IP                := NVL( OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR') , '0.0.0.0');
  V_LOG.APLICACAO         := V('APP_ID');
  V_LOG.PAGINA            := V('APP_PAGE_ID');
 --
  IF INSERTING 
   THEN
     --
      V_LOG.CHAVE_TABELA := :NEW.COD_EMBARCACAO;
      V_LOG.ACAO         := 'Inserção';
      V_REGISTRO         := 'Registro inserido:'; 
     --
  ELSIF UPDATING 
   THEN
     --
      V_LOG.CHAVE_TABELA := :OLD.COD_EMBARCACAO;
      V_LOG.ACAO         := 'Atualização';
      V_REGISTRO         := 'Registro atualizado:';
     --
  ELSIF DELETING 
   THEN
     --
      V_LOG.CHAVE_TABELA := :OLD.COD_EMBARCACAO;
      V_LOG.ACAO         := 'Exclusão';
      V_REGISTRO         := 'Registro excluido:';
     --
  END IF; 
 --
  IF INSERTING OR DELETING
   THEN
     --
      INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                            ,DATA_EVENTO
                            ,NOME_TABELA
                            ,USUARIO_APLICACAO
                            ,IP
                            ,ACAO
                            ,APLICACAO
                            ,PAGINA
                            ,MENSAGEM
                            ,CHAVE_TABELA)
                     VALUES (LOG_VESSEL_SEQ.NEXTVAL
                            ,V_LOG.DATA_EVENTO
                            ,V_LOG.NOME_TABELA
                            ,V_LOG.USUARIO_APLICACAO
                            ,V_LOG.IP
                            ,V_LOG.ACAO
                            ,V_LOG.APLICACAO
                            ,V_LOG.PAGINA
                            ,V_REGISTRO || ' COD_EMBARCACAO: ' || :OLD.COD_EMBARCACAO || '  por: '
                                        || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                            ,V_LOG.CHAVE_TABELA);
     --
  END IF;
 --
  IF UPDATING
   THEN
     --
      IF NVL(:NEW.NACIONALIDADE, ' ') != NVL(:OLD.NACIONALIDADE, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'NACIONALIDADE';
          V_LOG.NOVO_VALOR     := :NEW.NACIONALIDADE;
          V_LOG.VALOR_ANTERIOR := :OLD.NACIONALIDADE;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.IND_ARQUEACAO_BRUTA, ' ') != NVL(:OLD.IND_ARQUEACAO_BRUTA, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'IND_ARQUEACAO_BRUTA';
          V_LOG.NOVO_VALOR     := :NEW.IND_ARQUEACAO_BRUTA;
          V_LOG.VALOR_ANTERIOR := :OLD.IND_ARQUEACAO_BRUTA;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.NUM_INSCRICAO, 0) != NVL(:OLD.NUM_INSCRICAO, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'NUM_INSCRICAO';
          V_LOG.NOVO_VALOR     := :NEW.NUM_INSCRICAO;
          V_LOG.VALOR_ANTERIOR := :OLD.NUM_INSCRICAO;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.NUM_IMO, 0) != NVL(:OLD.NUM_IMO, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'NUM_IMO';
          V_LOG.NOVO_VALOR     := :NEW.NUM_IMO;
          V_LOG.VALOR_ANTERIOR := :OLD.NUM_IMO;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.NOME, ' ') != NVL(:OLD.NOME, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'NOME';
          V_LOG.NOVO_VALOR     := :NEW.NOME;
          V_LOG.VALOR_ANTERIOR := :OLD.NOME;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.BANDEIRA_ORIGEM, ' ') != NVL(:OLD.BANDEIRA_ORIGEM, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'BANDEIRA_ORIGEM';
          V_LOG.NOVO_VALOR     := :NEW.BANDEIRA_ORIGEM;
          V_LOG.VALOR_ANTERIOR := :OLD.BANDEIRA_ORIGEM;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.BANDEIRA_ATUAL, ' ') != NVL(:OLD.BANDEIRA_ATUAL, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'BANDEIRA_ATUAL';
          V_LOG.NOVO_VALOR     := :NEW.BANDEIRA_ATUAL;
          V_LOG.VALOR_ANTERIOR := :OLD.BANDEIRA_ATUAL;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.IND_NUM_IRIN, ' ') != NVL(:OLD.IND_NUM_IRIN, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'IND_NUM_IRIN';
          V_LOG.NOVO_VALOR     := :NEW.IND_NUM_IRIN;
          V_LOG.VALOR_ANTERIOR := :OLD.IND_NUM_IRIN;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.NUM_PRPM, ' ') != NVL(:OLD.NUM_PRPM, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'NUM_PRPM';
          V_LOG.NOVO_VALOR     := :NEW.NUM_PRPM;
          V_LOG.VALOR_ANTERIOR := :OLD.NUM_PRPM;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.NUM_TIE, ' ') != NVL(:OLD.NUM_TIE, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'NUM_TIE';
          V_LOG.NOVO_VALOR     := :NEW.NUM_TIE;
          V_LOG.VALOR_ANTERIOR := :OLD.NUM_TIE;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.NUM_DPP, ' ') != NVL(:OLD.NUM_DPP, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'NUM_DPP';
          V_LOG.NOVO_VALOR     := :NEW.NUM_DPP;
          V_LOG.VALOR_ANTERIOR := :OLD.NUM_DPP;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.NUM_PROTOCOLO_INSCRICAO, ' ') != NVL(:OLD.NUM_PROTOCOLO_INSCRICAO, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'NUM_PROTOCOLO_INSCRICAO';
          V_LOG.NOVO_VALOR     := :NEW.NUM_PROTOCOLO_INSCRICAO;
          V_LOG.VALOR_ANTERIOR := :OLD.NUM_PROTOCOLO_INSCRICAO;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.NUM_INSCRICAO_PROVISORIA, ' ') != NVL(:OLD.NUM_INSCRICAO_PROVISORIA, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'NUM_INSCRICAO_PROVISORIA';
          V_LOG.NOVO_VALOR     := :NEW.NUM_INSCRICAO_PROVISORIA;
          V_LOG.VALOR_ANTERIOR := :OLD.NUM_INSCRICAO_PROVISORIA;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.NUM_REB, ' ') != NVL(:OLD.NUM_REB, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'NUM_REB';
          V_LOG.NOVO_VALOR     := :NEW.NUM_REB;
          V_LOG.VALOR_ANTERIOR := :OLD.NUM_REB;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.TIPO_NAVEGACAO, ' ') != NVL(:OLD.TIPO_NAVEGACAO, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'TIPO_NAVEGACAO';
          V_LOG.NOVO_VALOR     := :NEW.TIPO_NAVEGACAO;
          V_LOG.VALOR_ANTERIOR := :OLD.TIPO_NAVEGACAO;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.AREA_NAVEGACAO, ' ') != NVL(:OLD.AREA_NAVEGACAO, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'AREA_NAVEGACAO';
          V_LOG.NOVO_VALOR     := :NEW.AREA_NAVEGACAO;
          V_LOG.VALOR_ANTERIOR := :OLD.AREA_NAVEGACAO;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.NATUREZA_TIPO_CARGA, ' ') != NVL(:OLD.NATUREZA_TIPO_CARGA, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'NATUREZA_TIPO_CARGA';
          V_LOG.NOVO_VALOR     := :NEW.NATUREZA_TIPO_CARGA;
          V_LOG.VALOR_ANTERIOR := :OLD.NATUREZA_TIPO_CARGA;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.TIPO_EMBARCACAO, ' ') != NVL(:OLD.TIPO_EMBARCACAO, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'TIPO_EMBARCACAO';
          V_LOG.NOVO_VALOR     := :NEW.TIPO_EMBARCACAO;
          V_LOG.VALOR_ANTERIOR := :OLD.TIPO_EMBARCACAO;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.CLASSE_EMBARCACAO, ' ') != NVL(:OLD.CLASSE_EMBARCACAO, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'CLASSE_EMBARCACAO';
          V_LOG.NOVO_VALOR     := :NEW.CLASSE_EMBARCACAO;
          V_LOG.VALOR_ANTERIOR := :OLD.CLASSE_EMBARCACAO;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.SITUACAO, ' ') != NVL(:OLD.SITUACAO, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'SITUACAO';
          V_LOG.NOVO_VALOR     := :NEW.SITUACAO;
          V_LOG.VALOR_ANTERIOR := :OLD.SITUACAO;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.ANO_EMBARCACAO, 0) != NVL(:OLD.ANO_EMBARCACAO, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'ANO_EMBARCACAO';
          V_LOG.NOVO_VALOR     := :NEW.ANO_EMBARCACAO;
          V_LOG.VALOR_ANTERIOR := :OLD.ANO_EMBARCACAO;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.MATERIAL_CASCO, 0) != NVL(:OLD.MATERIAL_CASCO, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'MATERIAL_CASCO';
          V_LOG.NOVO_VALOR     := :NEW.MATERIAL_CASCO;
          V_LOG.VALOR_ANTERIOR := :OLD.MATERIAL_CASCO;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.TIPO_PROPULSAO, 0) != NVL(:OLD.TIPO_PROPULSAO, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'TIPO_PROPULSAO';
          V_LOG.NOVO_VALOR     := :NEW.TIPO_PROPULSAO;
          V_LOG.VALOR_ANTERIOR := :OLD.TIPO_PROPULSAO;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.NUM_BHP, 0) != NVL(:OLD.NUM_BHP, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'NUM_BHP';
          V_LOG.NOVO_VALOR     := :NEW.NUM_BHP;
          V_LOG.VALOR_ANTERIOR := :OLD.NUM_BHP;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.QTD_MOTOR, 0) != NVL(:OLD.QTD_MOTOR, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'QTD_MOTOR';
          V_LOG.NOVO_VALOR     := :NEW.QTD_MOTOR;
          V_LOG.VALOR_ANTERIOR := :OLD.QTD_MOTOR;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.VALOR_ARQUEACAO_BRUTA, 0) != NVL(:OLD.VALOR_ARQUEACAO_BRUTA, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'VALOR_ARQUEACAO_BRUTA';
          V_LOG.NOVO_VALOR     := :NEW.VALOR_ARQUEACAO_BRUTA;
          V_LOG.VALOR_ANTERIOR := :OLD.VALOR_ARQUEACAO_BRUTA;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.VALOR_ARQUEACAO_LIQUIDA, 0) != NVL(:OLD.VALOR_ARQUEACAO_LIQUIDA, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'VALOR_ARQUEACAO_LIQUIDA';
          V_LOG.NOVO_VALOR     := :NEW.VALOR_ARQUEACAO_LIQUIDA;
          V_LOG.VALOR_ANTERIOR := :OLD.VALOR_ARQUEACAO_LIQUIDA;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.VALOR_TPB, 0) != NVL(:OLD.VALOR_TPB, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'VALOR_TPB';
          V_LOG.NOVO_VALOR     := :NEW.VALOR_TPB;
          V_LOG.VALOR_ANTERIOR := :OLD.VALOR_TPB;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.COMPRIMENTO_EMBARCACAO, 0) != NVL(:OLD.COMPRIMENTO_EMBARCACAO, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'COMPRIMENTO_EMBARCACAO';
          V_LOG.NOVO_VALOR     := :NEW.COMPRIMENTO_EMBARCACAO;
          V_LOG.VALOR_ANTERIOR := :OLD.COMPRIMENTO_EMBARCACAO;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.COMPRIMENTO_BOCA, 0) != NVL(:OLD.COMPRIMENTO_BOCA, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'COMPRIMENTO_BOCA';
          V_LOG.NOVO_VALOR     := :NEW.COMPRIMENTO_BOCA;
          V_LOG.VALOR_ANTERIOR := :OLD.COMPRIMENTO_BOCA;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.COMPRIMENTO_CALADO, 0) != NVL(:OLD.COMPRIMENTO_CALADO, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'COMPRIMENTO_CALADO';
          V_LOG.NOVO_VALOR     := :NEW.COMPRIMENTO_CALADO;
          V_LOG.VALOR_ANTERIOR := :OLD.COMPRIMENTO_CALADO;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.VALOR_VELOCIDADE, 0) != NVL(:OLD.VALOR_VELOCIDADE, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'VALOR_VELOCIDADE';
          V_LOG.NOVO_VALOR     := :NEW.VALOR_VELOCIDADE;
          V_LOG.VALOR_ANTERIOR := :OLD.VALOR_VELOCIDADE;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.VALOR_CAPACIDADE, 0) != NVL(:OLD.VALOR_CAPACIDADE, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'VALOR_CAPACIDADE';
          V_LOG.NOVO_VALOR     := :NEW.VALOR_CAPACIDADE;
          V_LOG.VALOR_ANTERIOR := :OLD.VALOR_CAPACIDADE;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.IND_CAPACIDADE_CARGA, ' ') != NVL(:OLD.IND_CAPACIDADE_CARGA, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'IND_CAPACIDADE_CARGA';
          V_LOG.NOVO_VALOR     := :NEW.IND_CAPACIDADE_CARGA;
          V_LOG.VALOR_ANTERIOR := :OLD.IND_CAPACIDADE_CARGA;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.VALOR_CAPACIDADE_VEICULO, 0) != NVL(:OLD.VALOR_CAPACIDADE_VEICULO, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'VALOR_CAPACIDADE_VEICULO';
          V_LOG.NOVO_VALOR     := :NEW.VALOR_CAPACIDADE_VEICULO;
          V_LOG.VALOR_ANTERIOR := :OLD.VALOR_CAPACIDADE_VEICULO;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.VALOR_CAPACIDADE_TEUS, 0) != NVL(:OLD.VALOR_CAPACIDADE_TEUS, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'VALOR_CAPACIDADE_TEUS';
          V_LOG.NOVO_VALOR     := :NEW.VALOR_CAPACIDADE_TEUS;
          V_LOG.VALOR_ANTERIOR := :OLD.VALOR_CAPACIDADE_TEUS;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.VALOR_CAPACIDADE_PASSAGEIROS, 0) != NVL(:OLD.VALOR_CAPACIDADE_PASSAGEIROS, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'VALOR_CAPACIDADE_PASSAGEIROS';
          V_LOG.NOVO_VALOR     := :NEW.VALOR_CAPACIDADE_PASSAGEIROS;
          V_LOG.VALOR_ANTERIOR := :OLD.VALOR_CAPACIDADE_PASSAGEIROS;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.NUM_IRIN, ' ') != NVL(:OLD.NUM_IRIN, ' ')
       THEN
         --
          V_LOG.NOME_COLUNA    := 'NUM_IRIN';
          V_LOG.NOVO_VALOR     := :NEW.NUM_IRIN;
          V_LOG.VALOR_ANTERIOR := :OLD.NUM_IRIN;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
      IF NVL(:NEW.DOCUMENTO_PROPRIEDADE, 0) != NVL(:OLD.DOCUMENTO_PROPRIEDADE, 0)
       THEN
         --
          V_LOG.NOME_COLUNA    := 'DOCUMENTO_PROPRIEDADE';
          V_LOG.NOVO_VALOR     := :NEW.DOCUMENTO_PROPRIEDADE;
          V_LOG.VALOR_ANTERIOR := :OLD.DOCUMENTO_PROPRIEDADE;
         --
          INSERT INTO LOG_VESSEL(CODIGO_LOG_VESSEL
                                ,DATA_EVENTO
                                ,NOME_TABELA
                                ,USUARIO_APLICACAO
                                ,IP
                                ,ACAO
                                ,APLICACAO
                                ,PAGINA
                                ,MENSAGEM
                                ,NOME_COLUNA
                                ,VALOR_ANTERIOR
                                ,NOVO_VALOR
                                ,CHAVE_TABELA)
                         VALUES (LOG_VESSEL_SEQ.NEXTVAL
                                ,V_LOG.DATA_EVENTO
                                ,V_LOG.NOME_TABELA
                                ,V_LOG.USUARIO_APLICACAO
                                ,V_LOG.IP
                                ,V_LOG.ACAO
                                ,V_LOG.APLICACAO
                                ,V_LOG.PAGINA
                                ,V_REGISTRO || ' '|| V_LOG.NOME_COLUNA || ': de ' || V_LOG.VALOR_ANTERIOR || ' para: ' || V_LOG.NOVO_VALOR || '  POR: '
                                            || V_LOG.USUARIO_APLICACAO ||  ' as: ' || TO_CHAR(V_LOG.DATA_EVENTO, 'DD/MM/YYYY HH24:MI:SS')
                                ,V_LOG.NOME_COLUNA
                                ,V_LOG.VALOR_ANTERIOR
                                ,V_LOG.NOVO_VALOR
                                ,V_LOG.CHAVE_TABELA);
         --
      END IF;
     --
  END IF;
 --
END;
/
ALTER TRIGGER "AIDU_LOG_VESSEL_EMBARCACAO" ENABLE;

  ALTER TABLE "EMBARCACAO_DOCUMENTO" ADD CONSTRAINT "EMBARCACAO_DOCUMENTO_FK" FOREIGN KEY ("COD_EMBARCACAO")
	  REFERENCES "EMBARCACAO" ("COD_EMBARCACAO") ENABLE;

   COMMENT ON COLUMN "EMBARCACAO_DOCUMENTO"."IND_TIPO_DOCUMENTO" IS 'INDICA O TIPO DO DOCUMENTO NO SISTEMA, PROPRIEDADE OU SEGURANÇA (P,S)';
   COMMENT ON TABLE "EMBARCACAO_DOCUMENTO"  IS 'VESSEL';

  ALTER TABLE "EMBARCACAO_TIPO_CARGA" ADD CONSTRAINT "EMBARCACAO_TIPO_CARGA_FK_EMBARCACAO" FOREIGN KEY ("COD_EMBARCACAO")
	  REFERENCES "EMBARCACAO" ("COD_EMBARCACAO") ENABLE;

  ALTER TABLE "EMBARCACAO_VISTORIA" ADD CONSTRAINT "EMBARCACAO_VISTORIA_FK_EMBARCACAO" FOREIGN KEY ("COD_EMBARCACAO")
	  REFERENCES "EMBARCACAO" ("COD_EMBARCACAO") ENABLE;

   COMMENT ON TABLE "LOG_USUARIO"  IS 'CANTAQ';

   COMMENT ON TABLE "LOG_USUARIO_SOLUCAO_PERMISSAO"  IS 'CANTAQ';

   COMMENT ON TABLE "LOG_VESSEL"  IS 'VESSEL';

   COMMENT ON TABLE "MATERIAL_EMBARCACAO"  IS 'VESSEL';

   COMMENT ON TABLE "NATUREZA_EMBARCACAO"  IS 'VESSEL';

   COMMENT ON TABLE "PAIS"  IS 'VESSEL';

   COMMENT ON TABLE "SITUACAO_EMBARCACAO"  IS 'VESSEL';

  ALTER TABLE "SOLUCAO" ADD CONSTRAINT "SOLUCAO_FK_USUARIO" FOREIGN KEY ("ID_USUARIO")
	  REFERENCES "USUARIO" ("ID") ENABLE;

   COMMENT ON TABLE "SOLUCAO"  IS 'CANTAQ';

   COMMENT ON COLUMN "TEMP_EMBARCACAO"."NUM_CASCO" IS 'Número do casco da embarcação';
   COMMENT ON COLUMN "TEMP_EMBARCACAO"."FINALIDADE_EMBARCACAO" IS 'Finalidade da embarcação. Opções: Afretamento, Porto sem papel. Campo: "Qual a finalidade do cadastro"';
   COMMENT ON COLUMN "TEMP_EMBARCACAO"."CNPJ_ESTALEIRO" IS 'Estaleiro responsável pela construção/reforma da embarcação. Campo: CNPJ do estaleiro.';
   COMMENT ON COLUMN "TEMP_EMBARCACAO"."TIPO_SERVICO" IS 'Situação da embarcação - Em operação - Em construção - Em reforma';
   COMMENT ON COLUMN "TEMP_EMBARCACAO"."POSSUI_ONUS" IS 'Se a embarcação possui ônus. Item: A embarcação possui ônus?';
   COMMENT ON COLUMN "TEMP_EMBARCACAO"."QUAL_ONUS" IS 'Se a embarcação possui ônus. Item: Qual?';
   COMMENT ON COLUMN "TEMP_EMBARCACAO"."DATA_ASSINATURA_CONTRATO" IS 'Data da assinatura do contrato.';
   COMMENT ON COLUMN "TEMP_EMBARCACAO"."PREVISAO_CONCLUSAO_SERVICO" IS 'Data da previsão de conclusão do serviço.';
   COMMENT ON COLUMN "TEMP_EMBARCACAO"."SITUACAO_SERVICO" IS 'Situação do serviço. Opções: Não iniciado, Em andamento.';
   COMMENT ON TABLE "TEMP_EMBARCACAO"  IS 'VESSEL';

  ALTER TABLE "TEMP_EMBARCACAO_DOCUMENTO" ADD CONSTRAINT "TEMP_EMBARCACAO_DOCUMENTO_FK" FOREIGN KEY ("COD_EMBARCACAO")
	  REFERENCES "TEMP_EMBARCACAO" ("COD_EMBARCACAO") ENABLE;

   COMMENT ON COLUMN "TEMP_EMBARCACAO_DOCUMENTO"."NUMERO" IS 'Número da documentação de propriedade.';
   COMMENT ON TABLE "TEMP_EMBARCACAO_DOCUMENTO"  IS 'VESSEL';

  ALTER TABLE "TEMP_EMBARCACAO_TIPO_CARGA" ADD CONSTRAINT "TEMP_EMBARCACAO_TIPO_CARGA_FK_EMBARCACAO" FOREIGN KEY ("COD_TEMP_EMBARCACAO")
	  REFERENCES "TEMP_EMBARCACAO" ("COD_EMBARCACAO") ENABLE;

  ALTER TABLE "TEMP_EMBARCACAO_VISTORIA" ADD CONSTRAINT "TEMP_EMBARCACAO_VISTORIA_FK_EMBARCACAO" FOREIGN KEY ("COD_EMBARCACAO")
	  REFERENCES "TEMP_EMBARCACAO" ("COD_EMBARCACAO") ENABLE;

   COMMENT ON TABLE "TIPO_DOCUMENTO_EMBARCACAO"  IS 'VESSEL';

   COMMENT ON TABLE "TIPO_EMBARCACAO"  IS 'VESSEL';

   COMMENT ON TABLE "TIPO_NAVEGACAO_EMBARCACAO"  IS 'VESSEL';

  ALTER TABLE "USUARIO" ADD CONSTRAINT "USUARIO_FK_SOLUCAO" FOREIGN KEY ("ID_SOLUCAO")
	  REFERENCES "SOLUCAO" ("ID") ENABLE;

   COMMENT ON COLUMN "USUARIO"."IND_ATIVO" IS 'Campo booleano que indica se o usu�o est�tivo no sistema.';
   COMMENT ON TABLE "USUARIO"  IS 'CANTAQ, BIFROST, HEFESTO';

  CREATE OR REPLACE EDITIONABLE TRIGGER "AIDU_USUARIO" 
 AFTER INSERT OR DELETE OR UPDATE ON USUARIO
 FOR EACH ROW
--
DECLARE
 V_LOG LOG_USUARIO%ROWTYPE;
--
BEGIN
  -- OPERAÇÕES
   IF INSERTING
    THEN
      --
       V_LOG.OPERACAO := 'I';
      --
   ELSIF UPDATING
    THEN
      --
       V_LOG.OPERACAO := 'U';
      --
   ELSIF DELETING
    THEN
      --
       V_LOG.OPERACAO := 'D';
      --
   END IF;
  
  -- LOG
   V_LOG.ID               := LOG_USUARIO_SEQ.NEXTVAL;
   V_LOG.DATA_EVENTO      := SYSDATE -3/24;
   V_LOG.USUARIO_EVENTO   := LOWER(V('APP_USER'));
   V_LOG.APLICACAO_EVENTO := V('APP_ID');
   V_LOG.PAGINA_EVENTO    := V('APP_PAGE_ID');
  -- IP
   BEGIN
     --
      V_LOG.IP_EVENTO   := OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR');   
     --
   EXCEPTION
     WHEN OTHERS THEN
       --
        V_LOG.IP_EVENTO := 'SEM_IP';
       --
   END;
  --
   IF INSERTING OR UPDATING
    THEN
      --
       V_LOG.ID_USUARIO    := :NEW.ID;
       V_LOG.NOME          := :NEW.NOME;
       V_LOG.CPF           := :NEW.CPF;
       V_LOG.EMAIL         := :NEW.EMAIL;
       V_LOG.TELEFONE      := :NEW.TELEFONE;
       V_LOG.CARGO         := :NEW.CARGO;
       V_LOG.ID_SECAO      := :NEW.ID_SECAO;
       V_LOG.ID_SOLUCAO    := :NEW.ID_SOLUCAO;
       V_LOG.PERFIL        := :NEW.PERFIL;
       V_LOG.IND_ATIVO     := :NEW.IND_ATIVO;
       V_LOG.SENHA         := :NEW.SENHA;
       V_LOG.JUSTIFICATIVA := PCK_UTIL.V_USUARIO_VALIDACAO;
      --
    ELSE
      --
       V_LOG.ID_USUARIO    := :OLD.ID;
       V_LOG.NOME          := :OLD.NOME;
       V_LOG.CPF           := :OLD.CPF;
       V_LOG.EMAIL         := :OLD.EMAIL;
       V_LOG.TELEFONE      := :OLD.TELEFONE;
       V_LOG.CARGO         := :OLD.CARGO;
       V_LOG.ID_SECAO      := :OLD.ID_SECAO;
       V_LOG.ID_SOLUCAO    := :OLD.ID_SOLUCAO;
       V_LOG.PERFIL        := :OLD.PERFIL;
       V_LOG.IND_ATIVO     := :OLD.IND_ATIVO;
       V_LOG.SENHA         := :OLD.SENHA;
       V_LOG.JUSTIFICATIVA := PCK_UTIL.V_USUARIO_VALIDACAO;
      --
   END IF; 
  --
   INSERT INTO LOG_USUARIO
        VALUES V_LOG;
  --
END;
/
ALTER TRIGGER "AIDU_USUARIO" ENABLE;

  ALTER TABLE "USUARIO_SOLUCAO_PERMISSAO" ADD CONSTRAINT "USUARIO_SOLUCAO_PERMISSAO_FK_USUARIO" FOREIGN KEY ("ID_USUARIO")
	  REFERENCES "USUARIO" ("ID") DISABLE;
  ALTER TABLE "USUARIO_SOLUCAO_PERMISSAO" ADD CONSTRAINT "USUARIO_SOLUCAO_PERMISSAO_FK_SOLUCAO" FOREIGN KEY ("ID_SOLUCAO")
	  REFERENCES "SOLUCAO" ("ID") ENABLE;

   COMMENT ON TABLE "USUARIO_SOLUCAO_PERMISSAO"  IS 'CANTAQ';

  CREATE OR REPLACE EDITIONABLE TRIGGER "AIDU_USUARIO_SOLUCAO_PERMISSAO" 
 AFTER INSERT OR DELETE OR UPDATE ON USUARIO_SOLUCAO_PERMISSAO
 FOR EACH ROW
--
DECLARE
 V_LOG LOG_USUARIO_SOLUCAO_PERMISSAO%ROWTYPE;
--
BEGIN
  -- OPERAÇÕES
   IF INSERTING
    THEN
      --
       V_LOG.OPERACAO := 'I';
      --
   ELSIF UPDATING
    THEN
      --
       V_LOG.OPERACAO := 'U';
      --
   ELSIF DELETING
    THEN
      --
       V_LOG.OPERACAO := 'D';
      --
   END IF;
  
  -- LOG
   V_LOG.ID               := USUARIO_SOLUCAO_PERMISSAO_SEQ.NEXTVAL;
   V_LOG.DATA_EVENTO      := SYSDATE -3/24;
   V_LOG.USUARIO_EVENTO   := LOWER(V('APP_USER'));
   V_LOG.APLICACAO_EVENTO := V('APP_ID');
   V_LOG.PAGINA_EVENTO    := V('APP_PAGE_ID');
  
  -- IP
   BEGIN
     --
      V_LOG.IP_EVENTO   := OWA_UTIL.GET_CGI_ENV('REMOTE_ADDR');   
     --
   EXCEPTION
     WHEN OTHERS THEN
       --
        V_LOG.IP_EVENTO := 'SEM_IP';
       --
   END;
  
  --
   IF INSERTING OR UPDATING
    THEN
      --
       V_LOG.ID_USUARIO_SOLUCAO_PERMISSAO := :NEW.ID;
       V_LOG.ID_USUARIO                   := :NEW.ID_USUARIO;
       V_LOG.ID_SOLUCAO                   := :NEW.ID_SOLUCAO;
       V_LOG.PAPEL                        := :NEW.PAPEL;
      --
    ELSE
      --
       V_LOG.ID_USUARIO_SOLUCAO_PERMISSAO := :OLD.ID;
       V_LOG.ID_USUARIO                   := :OLD.ID_USUARIO;
       V_LOG.ID_SOLUCAO                   := :NEW.ID_SOLUCAO;
       V_LOG.PAPEL                        := :OLD.PAPEL;
      --
   END IF; 
  --
   INSERT INTO LOG_USUARIO_SOLUCAO_PERMISSAO
        VALUES V_LOG;
  --
END;
/
ALTER TRIGGER "AIDU_USUARIO_SOLUCAO_PERMISSAO" ENABLE;