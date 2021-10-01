CREATE TABLE users (
    first_name  VARCHAR (30),
    middle_name VARCHAR (30),
    last_name   VARCHAR (30),
    snils       VARCHAR (14) PRIMARY KEY
);





DROP TRIGGER IF EXISTS snils_trigger;
CREATE TRIGGER snils_trigger BEFORE INSERT ON users
FOR EACH ROW
BEGIN

SELECT CASE

WHEN NEW.snils NOT GLOB '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9] [0-9][0-9]' THEN RAISE (ABORT, 'Invalid format of SNILS. Correct format is XXX-XXX-XXX YY')


WHEN (SUBSTR(NEW.snils, 1, 1) = SUBSTR(NEW.snils, 2, 1) AND SUBSTR(NEW.snils, 2, 1) = SUBSTR(NEW.snils, 3, 1)) OR 
	 (SUBSTR(NEW.snils, 2, 1) = SUBSTR(NEW.snils, 3, 1) AND SUBSTR(NEW.snils, 3, 1) = SUBSTR(NEW.snils, 5, 1)) OR
	 (SUBSTR(NEW.snils, 3, 1) = SUBSTR(NEW.snils, 5, 1) AND SUBSTR(NEW.snils, 5, 1) = SUBSTR(NEW.snils, 6, 1)) OR
	 (SUBSTR(NEW.snils, 5, 1) = SUBSTR(NEW.snils, 6, 1) AND SUBSTR(NEW.snils, 6, 1) = SUBSTR(NEW.snils, 7, 1)) OR
	 (SUBSTR(NEW.snils, 6, 1) = SUBSTR(NEW.snils, 7, 1) AND SUBSTR(NEW.snils, 7, 1) = SUBSTR(NEW.snils, 9, 1)) OR
	 (SUBSTR(NEW.snils, 7, 1) = SUBSTR(NEW.snils, 9, 1) AND SUBSTR(NEW.snils, 9, 1) = SUBSTR(NEW.snils, 10, 1)) OR
	 (SUBSTR(NEW.snils, 9, 1) = SUBSTR(NEW.snils, 10, 1) AND SUBSTR(NEW.snils, 10, 1) = SUBSTR(NEW.snils, 11, 1)) THEN RAISE (ABORT, 'One char is repeated 3 times')

WHEN (CAST(SUBSTR(NEW.snils, 1, 1) AS INT) * 9 +
	 CAST(SUBSTR(NEW.snils, 2, 1) AS INT) * 8 +
	 CAST(SUBSTR(NEW.snils, 3, 1) AS INT) * 7 +
	 CAST(SUBSTR(NEW.snils, 5, 1) AS INT) * 6 +
	 CAST(SUBSTR(NEW.snils, 6, 1) AS INT) * 5 +
	 CAST(SUBSTR(NEW.snils, 7, 1) AS INT) * 4 +
	 CAST(SUBSTR(NEW.snils, 9, 1) AS INT) * 3 +
	 CAST(SUBSTR(NEW.snils, 10, 1) AS INT) * 2 +
	 CAST(SUBSTR(NEW.snils, 11, 1) AS INT)) < 100 AND
	 (CAST(SUBSTR(NEW.snils, 1, 1) AS INT) * 9 +
	 CAST(SUBSTR(NEW.snils, 2, 1) AS INT) * 8 +
	 CAST(SUBSTR(NEW.snils, 3, 1) AS INT) * 7 +
	 CAST(SUBSTR(NEW.snils, 5, 1) AS INT) * 6 +
	 CAST(SUBSTR(NEW.snils, 6, 1) AS INT) * 5 +
	 CAST(SUBSTR(NEW.snils, 7, 1) AS INT) * 4 +
	 CAST(SUBSTR(NEW.snils, 9, 1) AS INT) * 3 +
	 CAST(SUBSTR(NEW.snils, 10, 1) AS INT) * 2 +
	 CAST(SUBSTR(NEW.snils, 11, 1) AS INT)) != CAST(SUBSTR(NEW.snils, 13, 2) AS INT) THEN RAISE (ABORT, 'Incorrect control sum of SNILS (< 100)')

WHEN (((CAST(SUBSTR(NEW.snils, 1, 1) AS INT) * 9 +
	 CAST(SUBSTR(NEW.snils, 2, 1) AS INT) * 8 +
	 CAST(SUBSTR(NEW.snils, 3, 1) AS INT) * 7 +
	 CAST(SUBSTR(NEW.snils, 5, 1) AS INT) * 6 +
	 CAST(SUBSTR(NEW.snils, 6, 1) AS INT) * 5 +
	 CAST(SUBSTR(NEW.snils, 7, 1) AS INT) * 4 +
	 CAST(SUBSTR(NEW.snils, 9, 1) AS INT) * 3 +
	 CAST(SUBSTR(NEW.snils, 10, 1) AS INT) * 2 +
	 CAST(SUBSTR(NEW.snils, 11, 1) AS INT)) = 100)
	 AND CAST(SUBSTR(NEW.snils, 13, 2) AS INT) != 0) THEN RAISE (ABORT, 'Incorrect control sum of SNILS (= 100)')


WHEN (((CAST(SUBSTR(NEW.snils, 1, 1) AS INT) * 9 +
	 CAST(SUBSTR(NEW.snils, 2, 1) AS INT) * 8 +
	 CAST(SUBSTR(NEW.snils, 3, 1) AS INT) * 7 +
	 CAST(SUBSTR(NEW.snils, 5, 1) AS INT) * 6 +
	 CAST(SUBSTR(NEW.snils, 6, 1) AS INT) * 5 +
	 CAST(SUBSTR(NEW.snils, 7, 1) AS INT) * 4 +
	 CAST(SUBSTR(NEW.snils, 9, 1) AS INT) * 3 +
	 CAST(SUBSTR(NEW.snils, 10, 1) AS INT) * 2 +
	 CAST(SUBSTR(NEW.snils, 11, 1) AS INT)) = 101)
	 AND CAST(SUBSTR(NEW.snils, 13, 2) AS INT) != 0) THEN RAISE (ABORT, 'Incorrect control sum of SNILS (= 101)')	 

WHEN ((CAST(SUBSTR(NEW.snils, 1, 1) AS INT) * 9 +
	 CAST(SUBSTR(NEW.snils, 2, 1) AS INT) * 8 +
	 CAST(SUBSTR(NEW.snils, 3, 1) AS INT) * 7 +
	 CAST(SUBSTR(NEW.snils, 5, 1) AS INT) * 6 +
	 CAST(SUBSTR(NEW.snils, 6, 1) AS INT) * 5 +
	 CAST(SUBSTR(NEW.snils, 7, 1) AS INT) * 4 +
	 CAST(SUBSTR(NEW.snils, 9, 1) AS INT) * 3 +
	 CAST(SUBSTR(NEW.snils, 10, 1) AS INT) * 2 +
	 CAST(SUBSTR(NEW.snils, 11, 1) AS INT)) > 101 AND
	 ((CAST(SUBSTR(NEW.snils, 1, 1) AS INT) * 9 +
	 CAST(SUBSTR(NEW.snils, 2, 1) AS INT) * 8 +
	 CAST(SUBSTR(NEW.snils, 3, 1) AS INT) * 7 +
	 CAST(SUBSTR(NEW.snils, 5, 1) AS INT) * 6 +
	 CAST(SUBSTR(NEW.snils, 6, 1) AS INT) * 5 +
	 CAST(SUBSTR(NEW.snils, 7, 1) AS INT) * 4 +
	 CAST(SUBSTR(NEW.snils, 9, 1) AS INT) * 3 +
	 CAST(SUBSTR(NEW.snils, 10, 1) AS INT) * 2 +
	 CAST(SUBSTR(NEW.snils, 11, 1) AS INT)) % 101) != CAST(SUBSTR(NEW.snils, 13, 2) AS INT)) THEN RAISE (ABORT, 'Incorrect control sum of SNILS (> 101)')
 
END;
END;
