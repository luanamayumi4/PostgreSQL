-- criando a tabela 

DROP TABLE IF EXISTS students
CREATE TABLE students(
	STUDENTID VARCHAR(100) PRIMARY KEY,
	AGE SMALLINT,
	GENDER SMALLINT,
	SALARY SMALLINT,
	GRADE SMALLINT,
	PREP_EXAM SMALLINT,
	NOTES SMALLINT
);

SELECT * FROM students

-- criando o procedure

DROP procedure estudantes_maiores_de_idade

CREATE OR REPLACE PROCEDURE estudantes_maiores_de_idade (OUT resultado SMALLINT, IN valor1 SMALLINT)
LANGUAGE plpgsql
AS $$
BEGIN
	CASE
		WHEN valor1 >= 18 THEN
			$1 = age;
		ELSE	
			resultado = valor2;
	END CASE;
END;
$$;

-- colocando em execução

DO $$
DECLARE
	resultado SMALLINT;
BEGIN
	CALL estudantes_maiores_de_idade(resultado,1,2);
	RAISE NOTICE 'Os estudantes maiores de idade são %', resultado;
END;
$$