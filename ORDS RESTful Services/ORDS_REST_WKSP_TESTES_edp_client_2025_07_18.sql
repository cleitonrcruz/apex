
-- Generated by ORDS REST Data Services 25.2.0.r1651520
-- Schema: WKSP_TESTES  Date: Fri Jul 18 11:46:46 2025 
--
        
DECLARE
  l_roles     OWA.VC_ARR;
  l_modules   OWA.VC_ARR;
  l_patterns  OWA.VC_ARR;

BEGIN
  ORDS.ENABLE_SCHEMA(
      p_enabled             => TRUE,
      p_url_mapping_type    => 'BASE_PATH',
      p_url_mapping_pattern => 'testes',
      p_auto_rest_auth      => FALSE);

  ORDS.DEFINE_MODULE(
      p_module_name    => 'edp_client',
      p_base_path      => '/edp/',
      p_items_per_page => 25,
      p_status         => 'PUBLISHED',
      p_comments       => NULL);

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'edp_client',
      p_pattern        => 'client/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Insere um novo cliente na tabela EDP_CLIENT.');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'edp_client',
      p_pattern        => 'client/',
      p_method         => 'POST',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'/*
    Exemplo de chamada:
DECLARE
    l_url      VARCHAR2(4000) := ''https://g74c8e4a7648d90-dbna7n4.adb.sa-vinhedo-1.oraclecloudapps.com/ords/testes/edp/client/'';
    l_body     CLOB;
    l_response CLOB;
BEGIN
    apex_web_service.g_request_headers(1).name := ''Content-Type'';
    apex_web_service.g_request_headers(1).value := ''application/json'';
    
    l_body := ''{
      "name":"João",
      "last_name":"Silva",
      "language":"PT",
      "contact":"11999999999",
      "country":"BR",
      "address":"Rua Exemplo, 100",
      "document":"12345678900"
    }'';

    l_response := apex_web_service.make_rest_request(
        p_url            => l_url,
        p_http_method    => ''POST'',
        p_body           => l_body
    );


    dbms_output.put_line(''Resposta: '' || l_response);
    dbms_output.put_line(''l_body: '' || l_body);
END;    
*/
DECLARE
    v_id NUMBER;
BEGIN
    IF :name IS NULL THEN
        owa_util.mime_header(''application/json'', TRUE)' || ';
        htp.prn(''{"erro":"Campo name obrigatório."}'');
        :status_code := 400;
        RETURN;
    ELSE
        INSERT INTO EDP_CLIENT (
            NAME, LAST_NAME, LANGUAGE, CONTACT, COUNTRY, ADDRESS, DOCUMENT
        ) VALUES (
            :name, :last_name, :language, :contact, :country, :address, :document
        )
        RETURNING ID_CLIENT INTO v_id;

        owa_util.mime_header(''application/json'', TRUE);
        htp.prn(''{"id_client":'' || v_id || ''}'');
        :status_code := 201;
        RETURN;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        owa_util.mime_header(''application/json'', TRUE);
        htp.prn(''{"erro":"Erro ao inserir cliente: '' || REPLACE(SQLERRM, ''"'', '''''''') || ''"}'');
        :status_code := 400;
        RETURN;
END;');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'edp_client',
      p_pattern        => 'client/:id_client',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Retorna um cliente específico pelo ID.');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'edp_client',
      p_pattern        => 'client/:id_client',
      p_method         => 'GET',
      p_source_type    => 'json/item',
      p_mimes_allowed  => NULL,
      p_comments       => 'Retorna todos os dados de um cliente, filtrando pelo ID_CLIENT informado na URL.',
      p_source         => 
'/*
    Exemplo
DECLARE
    l_response  CLOB;
    l_id_client VARCHAR2(20) := ''82''; -- ID desejado
    l_url       VARCHAR2(500);
BEGIN
    l_url := ''https://g74c8e4a7648d90-dbna7n4.adb.sa-vinhedo-1.oraclecloudapps.com/ords/testes/edp/client/'' || l_id_client;

    l_response := apex_web_service.make_rest_request(
        p_url         => l_url,
        p_http_method => ''GET''
    );

    dbms_output.put_line(l_response);
END;
    
*/
SELECT
    ID_CLIENT,
    NAME,
    LAST_NAME,
    LANGUAGE,
    CONTACT,
    COUNTRY,
    ADDRESS,
    DOCUMENT
FROM EDP_CLIENT
WHERE ID_CLIENT = :id_client');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'edp_client',
      p_pattern        => 'client/:id_client',
      p_method         => 'PUT',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'/*
    Exemplo
DECLARE
    l_response CLOB;
    l_url      VARCHAR2(4000);
    l_body     CLOB;
    l_id_client VARCHAR2(20) := ''94''; -- Altere para o ID do cliente que deseja atualizar
BEGIN
    l_url := ''https://g74c8e4a7648d90-dbna7n4.adb.sa-vinhedo-1.oraclecloudapps.com/ords/testes/edp/client/'' || l_id_client;

    apex_web_service.g_request_headers(1).name := ''Content-Type'';
    apex_web_service.g_request_headers(1).value := ''application/json'';

    l_body := ''{'' ||
              ''"name":"Pedro",'' ||
              ''"last_name":"Silva",'' ||
              ''"language":"PT",'' ||
              ''"contact":"11999999999",'' ||
              ''"country":"BR",'' ||
              ''"address":"Rua Exemplo, 100",'' ||
              ''"document":"12345678900"'' ||
              ''}'';


    l_response := APEX_WEB_SERVICE.MAKE_REST_REQUEST(
        p_url         => l_url,
        p_http_method => ''PUT'',
        p_body        => l_body,
        p_parm_name   => apex_util.string' || '_to_table(''Content-Type''),
        p_parm_value  => apex_util.string_to_table(''application/json'')
    );

    dbms_output.put_line(l_response);
END;

*/
DECLARE
    v_count NUMBER;
BEGIN
    -- Verifica se o ID existe
    SELECT COUNT(*)
      INTO v_count
      FROM EDP_CLIENT
     WHERE ID_CLIENT = :id_client;

    IF v_count = 0 THEN
        owa_util.mime_header(''application/json'', TRUE);
        htp.prn(''{"erro":"Cliente não encontrado."}'');
        :status_code := 404;
        RETURN;
    END IF;

    -- Tenta atualizar os dados
    UPDATE EDP_CLIENT
       SET NAME      = NVL(:name, NAME),
           LAST_NAME = NVL(:last_name, LAST_NAME),
           LANGUAGE  = NVL(:language, LANGUAGE),
           CONTACT   = NVL(:contact, CONTACT),
           COUNTRY   = NVL(:country, COUNTRY),
           ADDRESS   = NVL(:address, ADDRESS),
           DOCUMENT  = NVL(:document, DOCUMENT)
     WHERE ID_CLIENT = :id_client;

    owa_util.mime_header(''application' || '/json'', TRUE);
    htp.prn(''{"mensagem":"Cliente atualizado com sucesso."}'');
    :status_code := 200;
    RETURN;

EXCEPTION
    WHEN OTHERS THEN
        owa_util.mime_header(''application/json'', TRUE);
        htp.prn(''{"erro":"Erro ao atualizar cliente: '' || REPLACE(SQLERRM, ''"'', '''''''') || ''"}'');
        :status_code := 400;
        RETURN;
END;');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'edp_client',
      p_pattern        => 'client/:id_client',
      p_method         => 'DELETE',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'/*
    Exemplo
DECLARE
    l_response CLOB;
    l_url      VARCHAR2(500);
    l_id_client VARCHAR2(20) := ''82''; -- Altere para o ID do cliente que deseja deletar
BEGIN
    l_url := ''https://g74c8e4a7648d90-dbna7n4.adb.sa-vinhedo-1.oraclecloudapps.com/ords/testes/edp/client/'' || l_id_client;

    l_response := apex_web_service.make_rest_request(
        p_url         => l_url,
        p_http_method => ''DELETE''
        -- Não precisa informar body, nem Content-Type para DELETE!
    );

    dbms_output.put_line(l_response);
END;    
*/
DECLARE
    v_count NUMBER;
BEGIN
    -- Verifica se o cliente existe
    SELECT COUNT(*)
      INTO v_count
      FROM EDP_CLIENT
     WHERE ID_CLIENT = :id_client;

    IF v_count = 0 THEN
        owa_util.mime_header(''application/json'', TRUE);
        htp.prn(''{"erro":"Cliente não encontrado."}'');
        :status_code := 404;
        RETURN;
    END IF;

    -- Deleta o cliente
    DELETE FROM EDP_CLIENT WHERE ID_CLIENT' || ' = :id_client;

    owa_util.mime_header(''application/json'', TRUE);
    htp.prn(''{"mensagem":"Cliente removido com sucesso."}'');
    :status_code := 200;
    RETURN;

EXCEPTION
    WHEN OTHERS THEN
        owa_util.mime_header(''application/json'', TRUE);
        htp.prn(''{"erro":"Erro ao remover cliente: '' || REPLACE(SQLERRM, ''"'', '''''''') || ''"}'');
        :status_code := 400;
        RETURN;
END;');


COMMIT;

END;