-- Nota: para cada exercício,produza duas soluções:uma que utilize apenas IF 
--e suas variações e outra que use apenas CASE e suas variações.

--Nota: para cada exercício,gere valores aleatórios conforme a necessidade.
--Use a função do Bloco de Código 1.1.

--Função do Bloco de Código 1.1:

CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior
INT) RETURNS INT AS 
$$
BEGIN
    RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
END;
$$ LANGUAGE plpgsql;

--1.1 Faça um programa que exibe se um número inteiro é múltiplo de 3.

--Utilizando apenas IF

DO $$
DECLARE
	n INTEGER := valor_aleatorio_entre(0,5);
	m INTEGER := valor_aleatorio_entre(0,5);
	k INTEGER;
BEGIN
	RAISE NOTICE 'Os valores gerados de m e n são : %, % respectivamente', m, n;
	k := m * n;
	RAISE NOTICE 'A multiplicação entre % e % é = %', m, n, k;
	
	IF (k/m) <> 0 THEN
		-- Se (k / m) = n dizemos que o valor é multiplo 
		IF (k/m) = 3 THEN
			RAISE NOTICE 'Multiplo de 3';
		ELSE
			RAISE NOTICE 'Não é multiplo de 3';
		END IF;
	END IF;
END; $$

--Utilizando apenas CASE

DO $$
DECLARE
	n INTEGER := valor_aleatorio_entre(0,5);
	m INTEGER := valor_aleatorio_entre(0,5);
	k INTEGER;
	
	valor INTEGER;
	mensagem VARCHAR(200);
BEGIN
	RAISE NOTICE 'Os valores de m e n gerados são: % e % ', m, n;
	k := m * n;
	RAISE NOTICE 'A multiplicação entre % e % é = %', m, n, k;
	
	valor := k / m;
		
	CASE valor 
		WHEN 3 THEN
			mensagem := 'Multiplo de 3';
		
		ELSE 
			mensagem := 'Não é multiplo de 3';
	END CASE;
		RAISE NOTICE '%', mensagem;
END; $$

--1.2 Faça um programa que exibe se um número inteiro é múltiplo de 3 ou de 5.

--Utilizando apenas IF

DO $$
DECLARE
	n INTEGER := valor_aleatorio_entre(0,5);
	m INTEGER := valor_aleatorio_entre(0,5);
	k INTEGER;
BEGIN
	RAISE NOTICE 'Os valores gerados de m e n são : %, % respectivamente', m, n;
	k := m * n;
	RAISE NOTICE 'A multiplicação entre % e % é = %', m, n, k;
	
	IF (k/m) <> 0 THEN
		-- Se (k / m) = n dizemos que o valor é multiplo 
		IF (k/m) = 3 OR (k/m) = 5 THEN
			RAISE NOTICE 'Multiplo de 3 ou 5';
		ELSE
			RAISE NOTICE 'Não é multiplo de 3 ou de 5';
		END IF;
	END IF;
END; $$

-- Utilizando apenas CASE

DO $$
DECLARE
	n INTEGER := valor_aleatorio_entre(0,5);
	m INTEGER := valor_aleatorio_entre(0,5);
	k INTEGER;
	
	valor INTEGER;
	mensagem VARCHAR(200);
BEGIN
	RAISE NOTICE 'Os valores de m e n gerados são: % e % ', m, n;
	k := m * n;
	RAISE NOTICE 'A multiplicação entre % e % é = %', m, n, k;
	
	valor := k / m;
		
	CASE valor 
		WHEN 3 THEN
			mensagem := 'Multiplo de 3 ou de 5';
		
		ELSE 
			mensagem := 'Não é multiplo de 3 ou de 5';
	END CASE;
		RAISE NOTICE '%', mensagem;
END; $$

--1.3 Faça um programa que opera de acordo com o seguinte menu.
