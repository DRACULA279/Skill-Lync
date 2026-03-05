USE testdb;

SELECT HEX(country) hex , UNHEX(HEX(country)) unhex FROM country;


SELECT FIND_IN_SET('backup', 'backup,restore,commit,rollback'); -- TO FIND OUT THTE INDEX VALUE OF THE STRING IN A SET OF STRINGS

SELECT FORMAT(123456789, 3); -- THIS IS TO SELECT NUMBER OF DECIMALS AFTER THE POINT

SELECT HEX('DRACULA');-- THIS IS TO CONVERT THE DECIMAL NUMBER TO HEXADECIMAL

SELECT UNHEX('44524143554C41'); -- THIS IS TO CONVERT THE HEXADECIMAL NUMBER TO 

SELECT INSERT('Skill-Lync', 3, 0, 'DRACULA'); -- THIS IS TO INSERT A STRING INTO ANOTHER STRING AT A SPECIFIED POSITION

SELECT INSERT('Skill-Lync', 3, 4, 'DRACULA'); -- THIS IS TO INSERT A STRING INTO ANOTHER STRING AT A SPECIFIED POSITION

SELECT INSERT('VIKRAM', 4, 0,  'A');

SELECT LOCATE('_', 'skill_lync'); --  TO LOCATE A SPECIFIC STRING VALUE IN A STRING

SELECT INSTR('skill_lync', '_'); -- SAME AS LOCATE BUT THE SYNTAX IS SLIGHTLY CHANGED 

SELECT LEFT('skill_lync', 5); -- THIS IS TO EXTRACT A SUBSTRING FROM THE LEFT SIDE OF THE STRING

SELECT RIGHT('skill_lync', 3);  -- THIS IS TO EXTRACT A SUBSTRING FROM THE RIGHT SIDE OF THE STRING

SELECT LPAD('SKILL', 10 , 'MAHASHAKTHI'); -- THIS IS TO PAD THE LEFT SIDE OF THE STRING WITH ANOTHER STRING TILL THE LENGTH OF THE STRING BECOMES 10

SELECT RPAD('skill',25,'Mahalacto'); -- THIS IS TO PAD THE RIGHT SIDE OF THE STRING WITH ANOTHER STRING TILL THE LENGTH OF THE STRING BECOMES 5

SELECT SUBSTRING('skill_lync',3,4);

SELECT actor_id, COALESCE(actor_id) from testdb.actor;

-- Group Concat, stddev, stddev_pop, stddev_samp, sum, var_pop, var_samp, variance

SELECT STDDEV(actor_id), STDDEV_SAMP(actor_id), STDDEV_POP(actor_id), VARIANCE(actor_id), VARIANCE_SAMP(actor_id), VARIANCE_POP(actor_id) FROM actor;

-- Sub query

SELECT * FROM actor
WHERE first_name LIKE 'P%E';

SELECT * FROM (SELECT * FROM actor WHERE first_name LIKE 'P%E') AS p_e;

WITH p_e AS (SELECT * FROM actor WHERE first_name LIKE 'p%e')
SELECT * FROM p_e;

SELECT CASE WHEN first_name LIKE 'p%e' THEN 'YES' ELSE 'NO' END AS p_e FROM actor;

SELECT * FROM city;

SELECT * FROM country;

SELECT * FROM city WHERE country_id = ANY (SELECT country_id FROM country WHERE city.country_id = country.country_id);

WITH cc AS (SELECT c.city_id, c.city, c.last_update city_last_update, co.country_id, co.country, co.last_update FROM city c JOIN country co ON c.country_id = co.country_id)
SELECT * FROM cc;

SELECT * FROM city WHERE country_id = ANY (SELECT country_id from country WHERE city.country_id = country.country_id);