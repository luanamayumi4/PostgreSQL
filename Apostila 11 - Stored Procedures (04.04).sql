-- Stored procedures/blocos nomeados
Armazenados no banco

-- Bloco anônimo
Não fica armazenado, como por exemplo um SELECT

--criar o procedure/procedimento (com parâmetro)

CREATE PROCEDURE CONTA(NUMERO1 INT, NUMERO2 INT)
LANGUAGE plpgsql
AS $$
BEGIN
  SELECT NUMERO1 + NUMERO2 AS CONTA; --bloco de programação
END;
$$;

-- chamando procedure

CALL CONTA (100,50):

-- procedure no mundo real, como se fossemos adicionar em uma tabela "curso" já existente

CREATE PROCEDURE CAD_CURSO(P_NOME VARCHAR(30), P_HORAS INT(30),P_PRECO FLOAT(10,2))
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO CURSOS VALUES(NULL,P_NOME,P_HORAS,P_PRECO);
END;
$$;

-- chamando procedure

CALL CAD_CURSO('BI SQL', 34, 3.000.00)
CALL CAD_CURSO('POWER BI', 20, 3.000.00)

-- procedure de sql (geralmente para evitar sql injection)

adicionar exemplo depois

--exemplo criado em aula

CREATE OR REPLACE PROCEDURE sp_ola_usuario
(nome VARCHAR(200))
LANGUAGE plpgsql
AS $$
BEGIN

--continua...
