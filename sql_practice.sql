-- Active: 1767506199827@@127.0.0.1@3306@sakila
-- Active: 1767506199827@@127.0.0.1@3306@superstore
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

-- Window functions -- lead, lag , ntile, row_number, rank, dense_rank,percent_rank, cume_dist, first_value, last_value, nth_value

-- usually followed by over(partition by() or order by ())

SELECT category, SUM(quantity) OVER(PARTITION BY category) FROM orders;

/*
Finding outliers
MAX(Q3) - MAX(Q1) ---> Inter quartile range

IQR *1.5 ---> Idenfying outliers 

Lower limit/Threshhold --> Q1 - IQR*1.5

Upper limit/Threshhold --> Q3 + IQR*1.5

*/


SELECT
    column_name,
    table_name 
FROM information_schema.columns
WHERE
    tab_schema = 'sakila'
    AND
    `IS_NULLABLE` = 'YES'
; -- To find all the columns with ability to have null values 

--- Working with JSON format

DROP TABLE IF EXISTS user_feedback;
CREATE TABLE user_feedback
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(50),
    name VARCHAR(50),
    properties JSON,
    browser JSON
);

SELECT * FROM user_feedback;

INSERT INTO user_feedback
(
    event_name,
    name,
    properties,
    browser
)

VALUES
(
    'purchase',
    'VIKRAM',
    '{"ip_address": "192.108.1.1"}',
    '{
        "name": "chrome", 
        "version": "114.0.5735.199",
        "resolution" : {"x" : 1600, "y": 900}
    }'
),

(

    'dispose',
    'vikram',
    '{"ip_address": "192.108.55.1"}',
    '{
        "name": "chrome", 
        "version": "114.0.5735.199",
        "resolution" : {"x" : 1600, "y": 900}
    }'

)

;

SELECT id, event_name, name, browser -> '$.name' AS browser_name, browser -> '$.resolution' AS system_resolution, properties ->> '$.ip_address' AS Ip_address
FROM user_feedback;


CREATE TABLE sakila.user_feedback LIKE superstore.user_feedback;
INSERT INTO sakila.user_feedback
SELECT * FROM superstore.user_feedback;
DROP TABLE superstore.user_feedback;
SELECT * FROM sakila.user_feedback;


SELECT JSON_ARRAY('RAMESH', 5000, 'PAID'); -- array can be a tuple from python  but in json format --> inclusive of quotes  ''

SELECT JSON_OBJECT('browser_name ','safari', 'name', 'vikram', 'resolution', '1600 x 900'); -- the comma seperated values would be resulted in a correct JSON format like kw and kwargs from python 

SELECT JSON_VALID('null')--- To find whether everything is in the acceptable json format or not, 0 or 1.

SELECT JSON_MERGE_PRESERVE('[5000, "vikram" ]', '{"notepad" : "vscode" }' );--- TO MERGE two different data types 

