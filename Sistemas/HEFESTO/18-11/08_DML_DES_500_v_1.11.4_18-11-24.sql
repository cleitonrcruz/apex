INSERT INTO EMAIL (ID, PROCESSO, ASSUNTO, CORPO, PARAMETROS) VALUES (20, 'AVISO_ALTERA_UORG_17', '[ANTAQ+] - AVISO! Alteração de UORG', '<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Comunicação da ANTAQ</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        table {
            max-width: 600px;
            width: 100%;
            margin: 20px auto;
            background-color: #ffffff;
            border-radius: 8px;
            overflow: hidden;
        }

        .header {
            background-color: #005b96;
            padding: 20px;
            text-align: center;
            color: white;
        }

        .header img {
            max-width: 150px;
        }

        .header h1 {
            margin: 0;
            font-size: 24px;
        }

        .content {
            padding: 20px;
            color: #333333;
            line-height: 1.6;
        }

        .content p {
            margin: 0 0 10px;
        }

        .content img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .button {
            text-align: center;
            margin: 20px 0;
        }

        .button a {
            background-color: #005b96;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            border-radius: 5px;
        }

        .footer {
            background-color: #f4f4f4;
            padding: 10px;
            text-align: center;
            color: #888888;
            font-size: 12px;
        }

        .footer a {
            color: #005b96;
            text-decoration: none;
        }

        @media only screen and (max-width: 600px) {
            .content, .header, .footer {
                padding: 15px;
            }

            .button a {
                padding: 10px 15px;
            }
        }
    </style>
</head>

<body>
    <table>
        <!-- Cabeçalho -->
        <tr>
            <td class="header">
                <!-- Logo da empresa -->
                <h1>HEFESTO</h1>
                <h1>[ANTAQ+] - AVISO! Alteração de UORG</h1>
            </td>
        </tr>

        <!-- Conteúdo -->
        <tr>
            <td class="content">
                
                <center><p><strong>@TIPO_AMBIENTE@</strong></p></center>
                
                
                <p>Prezado(a), @NOME@,</p>
                <p> Informamos que o usuário @USUARIO_UORG@ teve sua unidade organizacional alterada de <strong>@UORG_ANT@</strong> para <strong>@UORG_ATUAL@</strong>.</p>

                <p>Para sua conveniência, o acesso ao sistema pode ser feito através do botão Acessar.</p>
                
                <div class="button">
                    <a href="@LINK@">Acessar</a>
                </div>
                

          <p><strong>Agência Nacional de Transportes Aquaviários</strong></p>
          <p style="color: #999; font-size: 12px;"><strong>ATENÇÃO!</strong> Esta mensagem foi gerada e enviada automaticamente pelo sistema. Favor não responder.</p>

                <p></p>
                <p><strong></strong></p>
            </td>
        </tr>

        <!-- Rodapé -->
        <tr>
            <td class="footer">
                <p>Agência Nacional de Transportes Aquaviários (ANTAQ). Todos os direitos reservados.</p>
                <p><a href="https://www.antaq.gov.br/">Visite nosso site</a></p>
            </td>
        </tr>
    </table>
</body>

</html>
', '@NOME@,@LINK@,@TIPO_AMBIENTE@,@USUARIO_UORG@,@UORG_ANT@,@UORG_ATUAL@');

-- 14/11/2024 - Lemuel --
INSERT INTO PLANO_TRABALHO_ATVIVIDADE_MENCAO (COD_MENCAO, DESCRICAO_MENCAO, PONTUACAO, PONTUACAO_MEDIA_INICIO, PONTUACAO_MEDIA_FIM) VALUES ('E', 'Excepcional', 4, 3.1, 99);
INSERT INTO PLANO_TRABALHO_ATVIVIDADE_MENCAO (COD_MENCAO, DESCRICAO_MENCAO, PONTUACAO, PONTUACAO_MEDIA_INICIO, PONTUACAO_MEDIA_FIM) VALUES ('D', 'Alto desempenho', 3, 2.1, 3);
INSERT INTO PLANO_TRABALHO_ATVIVIDADE_MENCAO (COD_MENCAO, DESCRICAO_MENCAO, PONTUACAO, PONTUACAO_MEDIA_INICIO, PONTUACAO_MEDIA_FIM) VALUES ('A', 'Adequado', 2, 1.1, 2);
INSERT INTO PLANO_TRABALHO_ATVIVIDADE_MENCAO (COD_MENCAO, DESCRICAO_MENCAO, PONTUACAO, PONTUACAO_MEDIA_INICIO, PONTUACAO_MEDIA_FIM) VALUES ('I', 'Inadequado', 0, 0, 0);
INSERT INTO PLANO_TRABALHO_ATVIVIDADE_MENCAO (COD_MENCAO, DESCRICAO_MENCAO, PONTUACAO, PONTUACAO_MEDIA_INICIO, PONTUACAO_MEDIA_FIM) VALUES ('N', 'Não executado', 0, 0, 0);
-- 14/11/2024 - Lemuel --

insert into PERFIL_PAGINA (COD_PERFIL_PAGINA, NOME_PAGINA, COD_PERFIL_ACAO_FK) values (11, 'Relatórios', 'L:V');
-- 14/11/2024 - Lemuel --