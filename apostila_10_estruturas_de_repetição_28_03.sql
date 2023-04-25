--Estruturas de repetição 

CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior
INT) RETURNS INT AS
$$
BEGIN
	RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
END;
$$ LANGUAGE plpgsql;

--Testando a função

SELECT valor_aleatorio_entre (2, 10);

--Loop sem condição de continuidade especificada (loop infinito) -> não rodar para não travar

DO
$$
BEGIN
	LOOP
		RAISE NOTICE 'Teste loop simples...';
	END LOOP;
END;
$$

--Aqui controlamos o loop pelo número de repetições com um contador.
--Seu encerramento é feito combinando-se IF e EXIT.

-- Contando de 1 a 10 (saída com IF/EXIT)

DO
$$
DECLARE
	contador INT := 1; --:= é uma atribuição para a variável
BEGIN
	LOOP
		RAISE NOTICE '%', contador;
		contador := contador + 1;
		IF contador > 10 THEN
				EXIT;
		END IF;
	END LOOP;
END;
$$

-- Contando de 1 a 10 (saída com EXIT/WHEN, sem a necessidade de uso do bloco IF)

DO
$$
DECLARE
	contador INT := 1;
BEGIN
	LOOP
		RAISE NOTICE '%', contador;
		contador := contador + 1;
		EXIT WHEN contador > 10;
	END LOOP;
END;
$$

--continua na apostila

xxxxxxxxxxxxxxxxxxx

--iterando sobre as linhas de uma tabela com FOR, criando um bloco anônimo antes

DO $$
BEGIN
	FOR i IN 1..10 LOOP
		INSERT INTO tb_aluno (nota) VALUES (valor_aleatorio_entre(0,10));
	END LOOP;
END;
$$

CREATE TABLE tb_aluno(
	cod_aluno SERIAL PRIMARY KEY,
	nota INT
);

--

DO
$$
DECLARE 
	aluno RECORD;
	media NUMERIC(10,2) := 0;
	total INT;
	menor INT :=10;
	
--mostrar a menor nota 

BEGIN
	FOR aluno IN 
		SELECT * FROM tb_aluno
	LOOP
		RAISE NOTICE '%', aluno;
		RAISE NOTICE 'Código:% e a nota: %', aluno.cod_aluno, aluno,nota;
		media := media + aluno.nota;
	END LOOP;
	SELECT COUNT(*) FROM tb_aluno INTO total;
END;
$$

--mostrar a maior e menor nota 

10 e 0

--lista/array
