SELECT * FROM tb_top_youtubers
WHERE video_count IS NULL;

DO $$
DECLARE
	--1. declarar o cursor
	--esse aqui é unbound (ou não vinculado)
	cur_delete REFCURSOR;
	tupla RECORD;
BEGIN
	--2. abrir o cursor
	OPEN cur_delete SCROLL FOR
		SELECT * FROM tb_top_youtubers;
	LOOP
		--3. recuperar dados do cursor
		FETCH FROM cur_delete INTO tupla;
		EXIT WHEN NOT FOUND;
		IF tupla.video_count IS NULL THEN
			DELETE FROM tb_top_youtubers
			WHERE CURRENT OF cur_delete;
		END IF;
	END LOOP;
	LOOP
		FETCH BACKWARD FROM cur_delete INTO tupla;
		EXIT WHEN NOT FOUND;
		RAISE NOTICE '%', tupla;
	END LOOP;
	--4. fechar o cursor
	CLOSE cur_delete;
END;
$$
	
DO $$
DECLARE
	cur_delete REFCURSOR;
BEGIN
	CLOSE cur_delete;
END;
$$

	
-- SELECT * FROM tb_top_youtubers;

-- ALTER TABLE tb_top_youtubers
-- ALTER COLUMN video_count TYPE INT
-- USING video_count::INT;

-- SELECT * FROM tb_top_youtubers
-- ORDER BY video_count DESC;

-- UPDATE tb_top_youtubers 
-- SET
-- 	video_count = REPLACE(video_count, ',', '');

-- ALTER TABLE tb_top_youtubers
-- 	ALTER COLUMN video_views
-- 	TYPE BIGINT USING video_views::BIGINT;
-- UPDATE 
-- 	tb_top_youtubers
-- SET
-- 	video_views =
-- 	REPLACE(video_views, ',', '');

-- UPDATE 
-- 	tb_top_youtubers 
-- SET 
-- 	subscribers = REPLACE(subscribers, ',', '');
	
-- ALTER TABLE tb_top_youtubers ALTER COLUMN
-- 	subscribers TYPE INTEGER USING subscribers::INT;
-- SELECT * FROM tb_top_youtubers;
-- -- parâmetros com nome


-- -- e pela ordem
-- DO $$
-- DECLARE
-- 	v_ano INT := 2010;
-- 	v_inscritos INT := 60000000;
-- 	-- 1 declarar o cursor
-- 	cur_ano_inscritos CURSOR(
-- 		ano INT, 
-- 		inscritos INT
-- 	) FOR SELECT youtuber FROM tb_top_youtubers
-- 		WHERE started >= ano 
-- 						AND subscribers >= inscritos;
-- 	v_youtuber VARCHAR(200);
-- BEGIN
-- 	--2 abrir o cursor
-- 	-- passando parâmetros pela ordem
-- 	--OPEN cur_ano_inscritos(v_ano, v_inscritos);
-- 	-- passando parâmetros pelo nome
-- 	OPEN cur_ano_inscritos(
-- 		inscritos := v_inscritos,
-- 		ano := v_ano
-- 	);
-- 	LOOP
-- 		--3. Recuperar dados
-- 		FETCH cur_ano_inscritos INTO v_youtuber;
-- 		EXIT WHEN NOT FOUND;
-- 		RAISE NOTICE '%', v_youtuber;
-- 	END LOOP;
-- 	--4. Fechar o cursor
-- 	CLOSE cur_ano_inscritos;
-- END;
-- $$

-- DO $$
-- DECLARE
-- 	--cursor bound (vinculado)
-- 	--1. declarar o cursor
-- 	cur_nomes_e_inscritos CURSOR FOR 
-- 	SELECT youtuber, subscribers FROM 				
-- 	tb_top_youtubers;
-- 	tupla RECORD;
-- 	resultado TEXT DEFAULT '';
-- BEGIN
-- 	--2. abrir o cursor
-- 	OPEN cur_nomes_e_inscritos;
-- 	--3. manipular o cursor
-- 	FETCH cur_nomes_e_inscritos INTO tupla;
-- 	WHILE FOUND LOOP
-- 		--qulaquer um: 150, outro: 200
-- 		resultado := resultado || tupla.youtuber 
-- 		|| ': ' || tupla.subscribers || E'\n';
-- 		FETCH cur_nomes_e_inscritos INTO tupla;
-- 	END LOOP;
-- 	--4. fechar
-- 	CLOSE cur_nomes_e_inscritos;
-- 	RAISE NOTICE '%', resultado;
-- END;
-- $$
-- DO $$
-- DECLARE
-- 	--1. Declaração (unbound)
-- 	cur_nomes_a_partir_de REFCURSOR;
-- 	v_youtuber VARCHAR(200);
-- 	v_ano INT := 2008;
-- 	v_nome_tabela VARCHAR(200) := 'tb_top_youtubers';
-- BEGIN
-- 	--2. abrir o cursor
-- 	OPEN cur_nomes_a_partir_de FOR EXECUTE(
-- 		format(
-- 			'
-- 				SELECT youtuber FROM %s
-- 				WHERE started >= $1
-- 			',
-- 			v_nome_tabela
-- 		)
-- 	)USING v_ano;
-- 	LOOP
-- 		--3. obtém os dados de interesse
-- 		FETCH cur_nomes_a_partir_de INTO v_youtuber;
-- 		EXIT WHEN NOT FOUND;
-- 		RAISE NOTICE '%', v_youtuber;
-- 	END LOOP;
-- 	--4. fechar o cursor
-- 	CLOSE cur_nomes_a_partir_de;
-- END;
-- $$

-- DO $$
-- DECLARE
-- 	--1. declaração do cursor
-- 	--esse cursor é unbound (não vinculado)
-- 	--ele foi declarado sem que um comando fosse associado a ele
-- 	cur_nomes_youtubers REFCURSOR;
-- 	v_youtuber VARCHAR(200);
-- BEGIN
-- 	--2. abertura do cursor
-- 	OPEN cur_nomes_youtubers FOR
-- 		SELECT youtuber FROM tb_top_youtubers;
-- 	LOOP
-- 		--3. recuperação dos dados de interesse
-- 		FETCH cur_nomes_youtubers INTO v_youtuber;		
-- 		EXIT WHEN NOT FOUND;
-- 		RAISE NOTICE '%', v_youtuber;
-- 		--4. Fechar o cursor
-- 		CLOSE cur_nomes_youtubers;
-- 	END LOOP;
	
-- END;
-- $$


-- DROP TABLE tb_top_youtubers;
-- CREATE TABLE tb_top_youtubers(
-- 	cod_top_youtubers SERIAL PRIMARY KEY,
-- 	rank INT,
-- 	youtuber VARCHAR(200),
-- 	subscribers VARCHAR(200),
-- 	video_views VARCHAR(200),
-- 	video_count VARCHAR(200),
-- 	category VARCHAR(200),
-- 	started INT
-- );