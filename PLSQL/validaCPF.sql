CREATE OR REPLACE FUNCTION validar_cpf(p_cpf IN VARCHAR2) RETURN NUMBER IS
  m_total  NUMBER := 0;
  m_digito NUMBER := 0;
  p_cpf2   VARCHAR2(11);
  l_first_digit VARCHAR2(1);
  l_count NUMBER := 0;
BEGIN
  -- Limpa a String para retirar pontos e hífen
  p_cpf2 := REPLACE(REPLACE(p_cpf,'.',''),'-','');

  -- Percorre a string e compara todos os dígitos com o primeiro dígito
  l_first_digit := SUBSTR(p_cpf2, 1, 1);
  FOR i IN 2..LENGTH(p_cpf2) LOOP
    IF SUBSTR(p_cpf2, i, 1) != l_first_digit THEN
      EXIT;
    END IF;
    l_count := i;
  END LOOP;

  -- Se todos os caracteres forem iguais ou o número de caracteres da string for diferente de 11, retorna 0
  IF LENGTH(p_cpf2) <> 11 OR l_count = 11 THEN
    RETURN 0;
  END IF;

  -- Validação do primeiro dígito
  m_total := 0;
  FOR i IN 1 .. 9 LOOP
    m_total := m_total + TO_NUMBER(SUBSTR(p_cpf2, i, 1)) * (11 - i);
  END LOOP;
  m_digito := 11 - MOD(m_total, 11);
  IF m_digito > 9 THEN
    m_digito := 0;
  END IF;
  IF m_digito != TO_NUMBER(SUBSTR(p_cpf2, 10, 1)) THEN
    RETURN 0;
  END IF;

  -- Validação do segundo dígito
  m_total  := 0;
  FOR i IN 1 .. 10 LOOP
    m_total := m_total + TO_NUMBER(SUBSTR(p_cpf2, i, 1)) * (12 - i);
  END LOOP;
  m_digito := 11 - MOD(m_total, 11);
  IF m_digito > 9 THEN
    m_digito := 0;
  END IF;
  IF m_digito != TO_NUMBER(SUBSTR(p_cpf2, 11, 1)) THEN
    RETURN 0;
  END IF;

  RETURN 1;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 0;
END;
/





-- TESTAR FUNÇÃO
DECLARE
  v_result NUMBER;
BEGIN
  v_result := validar_cpf('');
  IF v_result = 1 THEN
    DBMS_OUTPUT.PUT_LINE('CPF Válido');
  ELSE
    DBMS_OUTPUT.PUT_LINE('CPF Inválido');
  END IF;
END;
-- TESTAR FUNÇÃO




-- Testar por bloco plsql
DECLARE
  p_cpf VARCHAR2(14) := ''; -- CPF a ser validado
  m_total  NUMBER := 0;
  m_digito NUMBER := 0;
  p_cpf2 VARCHAR2(11);
  l_first_digit VARCHAR2(1);
  l_count NUMBER := 1; -- Ajustado para iniciar com 1
  v_valido NUMBER := 0; -- 0 para inválido, 1 para válido
BEGIN
  -- Limpa a String para retirar pontos e hífen
  p_cpf2 := REPLACE(REPLACE(p_cpf,'.',''),'-','');

  -- Percorre a string e compara todos os dígitos com o primeiro dígito
  l_first_digit := SUBSTR(p_cpf2, 1, 1);
  FOR i IN 2..11 LOOP    
    IF SUBSTR(p_cpf2, i, 1) != l_first_digit THEN
      EXIT;
    END IF;
    l_count := i;
  END LOOP;

  -- Se todos os caracteres forem iguais ou o número de caracteres da string for diferente de 11, considera inválido
  IF LENGTH(p_cpf2) <> 11 OR l_count = 11 THEN      
    v_valido := 0;
  ELSE
    -- Validação do primeiro dígito
    FOR i IN 1 .. 9 LOOP
      m_total := m_total + TO_NUMBER(SUBSTR(p_cpf2, i, 1)) * (11 - i);
    END LOOP;
    m_digito := 11 - MOD(m_total, 11);
    IF m_digito >= 10 THEN
      m_digito := 0;
    END IF;

    IF m_digito != TO_NUMBER(SUBSTR(p_cpf2, 10, 1)) THEN
      v_valido := 0;
    ELSE
      -- Validação do segundo dígito
      m_digito := 0;
      m_total  := 0;
      FOR i IN 1 .. 10 LOOP
        m_total := m_total + TO_NUMBER(SUBSTR(p_cpf2, i, 1)) * (12 - i);
      END LOOP;
      m_digito := 11 - MOD(m_total, 11);
      IF m_digito >= 10 THEN
        m_digito := 0;
      END IF;

      IF m_digito != TO_NUMBER(SUBSTR(p_cpf2, 11, 1)) THEN
        v_valido := 0;
      ELSE
        v_valido := 1;
      END IF;
    END IF;
  END IF;

  -- Exibe o resultado da validação
  IF v_valido = 1 THEN
    DBMS_OUTPUT.PUT_LINE('CPF Válido');
  ELSE
    DBMS_OUTPUT.PUT_LINE('CPF Inválido');
  END IF;
EXCEPTION 
  WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE('Erro durante a validação do CPF: ' || SQLERRM);
END;
-- Testar por bloco plsql