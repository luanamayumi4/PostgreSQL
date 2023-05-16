-- Um cursor é uma estrutura que encapsula uma consulta e viabiliza a leitura do resultado linha a linha.

CREATE TABLE tb_top_youtubers(
	cod_top_youtubers SERIAL PRIMARY KEY,
	rank INT,
	youtuber VARCHAR(200),
	subscribers INT,
	video_views VARCHAR(200),
	video_count INT,
	category VARCHAR(200),
	started INT
);

SELECT * FROM tb_top_youtubers

--09.05

UPDATE 
	tb_top_youtubers 
SET 
	subscribers = REPLACE(subscribers, ',', '');
	
ALTER TABLE tb_top_youtubers ALTER COLUMN
	subscribers TYPE INTEGER USING subscribers::INT;
SELECT * FROM tb_top_youtubers;
-- parâmetros com nome
-- e pela ordem
DO $$
DECLARE
	v_ano INT := 2010;
	v_inscritos INT := 60_000_000;
	-- 1 declarar o cursor
	cur_ano_inscritos CURSOR(
		ano INT, 
		inscritos INT
	) FOR SELECT youtuber FROM tb_top_youtubers
		WHERE started >= ano 
						AND subscribers >= inscritos;
	v_youtuber VARCHAR(200);
BEGIN
	--2 abrir o cursor
	-- passando parâmetros pela ordem
	OPEN cur_ano_inscritos(v_ano, v_inscritos);
	-- passando parâmetros pelo nome
	OPEN cur_ano_inscritos(
		inscritos := v_inscritos,
		ano := v_ano
	);
END;
$$

--FOUND -> variável booleana
--FETCH -> percorre a tupla, pode ser até mesmo alguma que já tenha passado anteriormente

--15.05
