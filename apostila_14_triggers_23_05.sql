-- Exercícios da apostila 14

-- 1.1 Adicione uma coluna à tabela tb_pessoa chamada ativo. Ela indica se a pessoa 
-- está ativa no sistema ou não. Ela deve ser capaz de armazenar um valor booleano.Por padrão,
-- toda pessoa cadastrada no sistema está ativa. Se necessário, consulte o Link 1.1.1.

-- Cria a função que será executada pela trigger

CREATE OR REPLACE FUNCTION set_default_ativo() RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.ativo := true; 
    RETURN NEW;
END;
$$

-- Criação do trigger

CREATE TRIGGER set_ativo_default
BEFORE INSERT ON tb_pessoa
FOR EACH ROW
EXECUTE FUNCTION set_default_ativo();


-- 1.2 Associe um trigger de DELETE à tabela. Quando um DELETE for executado,
-- o trigger deve atribuir FALSE à coluna ativo das linhas envolvidas.Além disso,
-- o trigger não deve permitir que nenhuma pessoa seja removida.


CREATE OR REPLACE FUNCTION delete_trigger_function() RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
  IF OLD.tb_pessoa = 'pessoa' THEN
    RAISE EXCEPTION 'Ação não permitida';
  END IF;

  UPDATE tb_pessoa SET ativo = FALSE WHERE id = OLD.id;
  RETURN OLD;
END;
$$

-- Criação do trigger
CREATE TRIGGER delete_trigger
BEFORE DELETE ON tb_pessoa
FOR EACH ROW
EXECUTE FUNCTION delete_trigger_function();
