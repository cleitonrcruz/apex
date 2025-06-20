create or replace TRIGGER AIDU_LOG_VESSEL_EMBARCACAO
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
create or replace TRIGGER "AIDU_USUARIO" 
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
create or replace TRIGGER "AIDU_USUARIO_SOLUCAO_PERMISSAO" 
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
create or replace trigger TRGL_LOG_DDL 
after ddl on schema 
  
DECLARE 
  V_OPERACAO     VARCHAR2(50); 
  V_OWNER        VARCHAR2(255); 
  V_OBJETO       VARCHAR2(255); 
  V_COMANDO      CLOB; 
  V_SQL_TEXT     ORA_NAME_LIST_T; 
-- 
BEGIN 
  SELECT ora_sysevent 
  INTO   V_OPERACAO 
  FROM   DUAL; 
  -- 
    SELECT ora_dict_obj_owner 
         , ora_dict_obj_name 
      INTO V_OWNER, V_OBJETO 
      FROM dual; 
  -- 
   FOR X IN 1 .. ORA_SQL_TXT(V_SQL_TEXT) LOOP 
     -- 
      V_COMANDO := V_COMANDO || V_SQL_TEXT(X); 
     -- 
   END LOOP; 
  --  
   INSERT INTO LOG_DDL (USUARIO, DATA, MAQUINA, IP, OPERACAO, OWNER, OBJETO, USUARIO_APLICACAO, COMANDO) 
        VALUES (USER 
               ,SYSDATE-3/24 
               ,sys_context('USERENV','HOST') 
               ,sys_context('USERENV','IP_ADDRESS') 
               ,V_OPERACAO 
               ,V_OWNER 
               ,V_OBJETO 
               ,V('APP_USER') 
               ,V_COMANDO); 
  
END TRGL_LOG_DDL; 
/