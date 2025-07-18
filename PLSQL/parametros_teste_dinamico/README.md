# Oracle PL/SQL - Parâmetros de Teste Dinâmico (CRM)

Este repositório contém um script completo de criação e preenchimento de uma tabela chamada `PARAMETROS_TESTE`, projetada para armazenar parâmetros configuráveis utilizados em testes de SQL e PL/SQL dinâmico em um contexto de CRM.

## 📄 Arquivo

- `parametros_teste_dinamico_crm.sql`  
  Contém:
  - Criação da tabela `PARAMETROS_TESTE`
  - Inserts de dados simulando diferentes módulos do sistema
  - Criação de uma package (`PKG_PARAMETROS_TESTE`) com funções de:
    - Inserção dinâmica (`INSERIR_PARAMETRO_DINAMICO`)
    - Consulta dinâmica (`CONSULTAR_PARAMETRO`)

## 🎯 Objetivo

Facilitar testes com SQL dinâmico e simulações realistas de uso de parâmetros em módulos típicos de um sistema CRM, como:

- VENDAS
- SUPORTE
- MARKETING
- FINANCEIRO
- RELACIONAMENTO