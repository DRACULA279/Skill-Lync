-- Active: 1767506199827@@127.0.0.1@3306@testdb
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

-- stored procedures 
-- The structure would be as follows
/*

DROP PROCEDURE IF EXISTS;

CREATE PROCEDURE overpaid_employees AS 

BEGIN 

SELECT * FROM data_base.table
WHERE salary > 100000

END

EXEC overpaid_employees;

*/

CALL rewards_report();

SELECT DATEDIFF(CURRENT_DATE,"2026-05-16");

-- asssignmet 
CREATE TABLE sakila.product(

product_id INT PRIMARY KEY,

name VARCHAR(50) NOT NULL

category VARCHAR(50) NOT NULL,

price DECIMAL(10,2) NOT NULL

);

-- 2. Write query to insert rows in table product, values can be taken from below shown Figure 2. (schema – sakila). 

INSERT INTO sakila.product (product_id, name, category, price)

VALUES 

    (1, 'chair', 'furniture', 5000.02),

    (2, 'table', 'furniture', 12000.50),

    (3, 'lamp', 'decor', 1500.00)

;

-- 3. Write query to select result set from table product as shown in Figure 3. (schema – sakila). 

SELECT * FROM product 
WHERE price > 10000;

-- 4. Write query to select result set from table product as shown in Figure 4. (schema – sakila).

SELECT *

FROM (

    SELECT product_id,

           name,

           DENSE_RANK() OVER (PARTITION BY category ORDER BY price) AS luxury_rank

    FROM products

) AS ranked_products

WHERE luxury_rank < 10;    --- assuming there are hundreds of products

 

-- 5. Write query to select result set from table product as shown in Figure 5. (schema – sakila). 

-- It would be better if I write a query to show all the concepts I've learned so far. 

CREATE VIEW sakila.product_summary AS

SELECT 

    product_id,

    name,

    category,

    price

FROM sakila.product;


WITH category_stats AS (

    SELECT 

        category,

        COUNT(*) AS total_products,

        AVG(price) AS avg_price,

        MAX(price) AS max_price,

        MIN(price) AS min_price

    FROM sakila.product_summary

    GROUP BY category

)

SELECT 

    p.product_id,

    p.name,

    p.category,

    p.price,

    -- Aggregate values from CTE

    cs.total_products,

    cs.avg_price,

    cs.max_price,

    cs.min_price,

    -- Window Functions

    ROW_NUMBER() OVER (PARTITION BY p.category ORDER BY p.price DESC) AS row_num,

    RANK() OVER (PARTITION BY p.category ORDER BY p.price DESC) AS rank_num,

    DENSE_RANK() OVER (PARTITION BY p.category ORDER BY p.price DESC) AS dense_rank_num,

    -- Analytical Window Functions

    LAG(p.price) OVER (PARTITION BY p.category ORDER BY p.price) AS prev_price,

    LEAD(p.price) OVER (PARTITION BY p.category ORDER BY p.price) AS next_price,

    -- Aggregate Window Function

    SUM(p.price) OVER (PARTITION BY p.category) AS total_category_value

FROM sakila.product_summary p

JOIN category_stats cs 

ON p.category = cs.category;

-- HAcker Rank -12032026

--Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA. The CITY table is described as follows:
--https://www.hackerrank.com/challenges/revising-the-select-query/problem?isFullScreen=true

SELECT * FROM  city 
WHERE CountryCode = 'USA' AND 
population > 100000;

--- Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.

SELECT name FROM city 
WHERE population > 120000 AND 
CountryCode = 'USA';

--Query all columns (attributes) for every row in the CITY table.
SELECT * FROM city;

--Query all columns for a city in CITY with the ID 1661.

SELECT * FROM city 
WHERE id = 1661;

--Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.

SELECT * FROM city 
WHERE CountryCode = 'JPN';

--Query a list of CITY and STATE from the STATION table.

SELECT city , state from station;

--Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.

USE testdb;
SELECT DISTINCT(CITY_WITH_EVEN_CODE) FROM 
(SELECT 
CASE WHEN (city_id % 2 = 0) THEN city END AS CITY_WITH_EVEN_CODE 
FROM testdb.city) AS ref
ORDER BY 1 ASC;

-- Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
SELECT (COUNT(CITY)) - (COUNT(DISTINCT(CITY))) AS DIFF FROM STATION;

--Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.

SELECT DISTINCT(CITY) FROM STATION 
WHERE CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%';

-- Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.

SELECT DISTINCT(CITY) FROM STATION 
WHERE CITY LIKE '%A' OR CITY LIKE '%E' OR CITY LIKE '%I' OR CITY LIKE '%O' OR CITY LIKE '%U';

--Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.

SELECT DISTINCT(CITY) FROM STATION 
WHERE (CITY LIKE '%A' OR CITY LIKE '%E' OR CITY LIKE '%I' OR CITY LIKE '%O' OR CITY LIKE '%U' ) AND (CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%')
;

--Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.

SELECT DISTINCT(city) FROM station 
WHERE CITY NOT LIKE 'A%' AND CITY NOT LIKE 'E%' AND CITY NOT LIKE 'I%' AND CITY NOT LIKE 'O%' AND CITY NOT LIKE 'U%';

--Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates. 

SELECT DISTINCT(city) FROM station 
WHERE city NOT LIKE '%a'
AND city NOT LIKE '%e'
AND city NOT LIKE '%i'
AND city NOT LIKE '%o'
AND city NOT LIKE '%u';

--Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.

SELECT DISTINCT(city) FROM station 
WHERE 
(city NOT LIKE '%a' AND city NOT LIKE '%e' AND city NOT LIKE '%i' AND city NOT LIKE '%o' AND city NOT LIKE '%u') OR 
(city NOT LIKE 'a%' AND city NOT LIKE 'e%' AND city NOT LIKE 'i%' AND city NOT LIKE 'O%' AND city NOT LIKE 'u%' );

--Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.

SELECT DISTINCT(city) 
FROM station 
WHERE 
(city NOT LIKE '%a' AND city NOT LIKE '%e' AND city NOT LIKE '%i' AND city NOT LIKE '%o' AND city NOT LIKE '%u') AND
(city NOT LIKE 'a%' AND city NOT LIKE 'e%' AND city NOT LIKE 'i%' AND city NOT LIKE 'O%' AND city NOT LIKE 'u%' );


-- Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.

SELECT name FROM STUDENTS 
WHERE marks  > 75 
ORDER BY RIGHT(name, 3) , id ASC;

--Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.

SELECT name FROM employee 
ORDER BY 1 ASC;

--Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than $2000 per month who have been employees for less than 10 months. Sort your result by ascending employee_id.

SELECT name FROM employee
WHERE salary > 2000 AND
months < 10
ORDER BY employee_id;

/*Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

Equilateral: It's a triangle with  sides of equal length.
Isosceles: It's a triangle with  sides of equal length.
Scalene: It's a triangle with  sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.*/

SELECT 
CASE
    WHEN A = B AND B = C THEN 'Equilateral'
    WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
    WHEN A = B OR B = C OR A = C THEN 'Isosceles'
    ELSE 'Scalene'
END
FROM TRIANGLES;

--Query the total population of all cities in CITY where District is California.

SELECT SUM(population) Total_population 
FROM city 
WHERE district = 'california';

--Query the average population of all cities in CITY where District is California.

SELECT AVG(population) FROM city
WHERE district = 'california';

--Query the average population for all cities in CITY, rounded down to the nearest integer.

SELECT FLOOR(AVG(population)) FROM city;


--Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.

SELECT SUM(population) FROM city 
WHERE countrycode = 'jpn';

--Query the difference between the maximum and minimum populations in CITY.

SELECT (MAX(population) - MIN(population)) FROM city;

--Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's  key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.
--Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.

SELECT CEIL(AVG(salary) - AVG(REPLACE(salary, '0',''))) FROM EMPLOYEES;

--We define an employee's total earnings to be their monthly  worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as  space-separated integers.

SELECT CONCAT(AVG(salary * months), '  ', COUNT(*)) 
FROM employee
WHERE (salary * months ) = MAX(salary * months);
/*Query the following two values from the STATION table:

The sum of all values in LAT_N rounded to a scale of  decimal places.
The sum of all values in LONG_W rounded to a scale of  decimal places.*/

SELECT ROUND(SUM(lat_n),2),ROUND(SUM(long_w),2) FROM station;

---Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than  and less than . Truncate your answer to  decimal places.

SELECT ROUND(SUM(lat_n),4) FROM station 
WHERE 
lat_n BETWEEN 38.7880 AND 137.2345;

---Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than . Truncate your answer to  decimal places.

SELECT ROUND(MAX(lat_n),4)
FROM station 
WHERE lat_n < 137.2345;

--Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than . Round your answer to  decimal places.
SELECT ROUND(long_w, 4)
FROM station
WHERE lat_n = (
    SELECT MAX(lat_n)
    FROM station
    WHERE lat_n < 137.2345
);

--Query the smallest Northern Latitude (LAT_N) from STATION that is greater than . Round your answer to  decimal places.

SELECT ROUND(lat_n,4) FROM 
station 
WHERE 
lat_n = 
(SELECT MIN(lat_n) FROM station 
WHERE lat_n > 38.7780
);

-- Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than . Round your answer to  decimal places.

SELECT ROUND(long_w,4) FROM station
WHERE lat_n = (
    SELECT MIN(lat_n) FROM station 
    WHERE lat_n > 38.7780
);

--Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
--Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

SELECT SUM(c.population) from city c 
JOIN country cn 
ON c.countrycode = cn.code 
WHERE continent = 'asia' ;

---Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.

SELECT CITY.NAME FROM CITY JOIN 
COUNTRY 
ON CITY.COUNTRYCODE = COUNTRY.CODE 
WHERE CONTINENT = 'AFRICA';

--Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.

SELECT COUNTRY.CONTINENT, FLOOR(AVG(CITY.POPULATION)) FROM CITY JOIN
COUNTRY 
ON CITY.COUNTRYCODE = COUNTRY.CODE 
GROUP BY CONTINENT;


/*	Discussions
You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.



Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.*/

SELECT N,
    CASE
        WHEN P IS NULL THEN 'Root'
        WHEN N NOT IN (SELECT P FROM bst WHERE P IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END AS 'Node_Type'
FROM bst
ORDER BY N;



/*
TABLE USERS
user_id  
signup_date  
country  
device  

TABLE EVENTS
user_id  
event_type  -- ('visit', 'add_to_cart', 'purchase')  
event_time  

Write SQL to answer:

1. Funnel Metrics

For last 30 days, calculate:

total visitors
users who added to cart
users who purchased
conversion rates:
visit → cart
cart → purchase
2. Segment the Funnel

Break the same metrics by:

device
country
3. Identify the Problem Area

Answer (based on your query results):

Which segment (device/country) has the biggest drop in conversion?|


*/

# Total Visitors

SELECT COUNT(user_id) FROM table_events
WHERE 
event_type = 'visit' 
# but i think purchase,add_to_cart should be done Only by visiting the page, in such case -- remove event_type or add add_to_cart and purchase to where clause if the these attributes does not create a record of visit  
DATEDIFF(CURRENT_DATE - event_time) <= 30;


# users who added to cart
SELECT DISTINCT(user_id) from events
WHERE event_type = 'add_to_cart'
;
#OR 
SELECT user_id from events
WHERE event_type = 'add_to_cart'
GROUP BY user_id;

#users who purchased
SELECT user_id from events
WHERE event_type = 'purchased'
GROUP BY user_id;

#conversion rates:

WITH ref AS ( 
COUNT(CASE WHEN event = 'visit' THEN user_id END) AS vist_counts,
COUNT(CASE WHEN event = 'add_to_cart' THEN user_id END) AS cart_count,
COUNT(CASE WHEN event = 'purchase' THEN user_id END) AS purchase_count 

FROM events) 

SELECT (visit_count (visit_count - cart_count)) AS visit_to_cart,
(cart_count - (cart_count - purchse_count))) AS 
cart_to_purchase_funnel,
(visit_count-(visit_count - purchase_count)) AS visit_to_purchase_funnel
FROM ref;

/*2. Segment the Funnel

Break the same metrics by:

device
country*/

WITH ref AS ( 
COUNT(CASE WHEN event = 'e.visit' THEN user_id END) AS vist_counts,
COUNT(CASE WHEN event = 'e.add_to_cart' THEN user_id END) AS cart_count,
COUNT(CASE WHEN event = 'e.purchase' THEN user_id END) AS purchase_count 

FROM events e 
JOIN  users u
ON u.user_id = e.user_id
GROUP BY device,country) 

/*3. Identify the Problem Area

Answer (based on your query results):

Which segment (device/country) has the biggest drop in conversion?|*/
WITH ref AS ( 
COUNT(CASE WHEN event = 'e.visit' THEN user_id END) AS vist_counts,
COUNT(CASE WHEN event = 'e.add_to_cart' THEN user_id END) AS cart_count,
COUNT(CASE WHEN event = 'e.purchase' THEN user_id END) AS purchase_count 

SELECT (visit_count (visit_count - cart_count)) AS visit_to_cart,
(cart_count - (cart_count - purchse_count))) AS 
cart_to_purchase_funnel,
(visit_count-(visit_count - purchase_count)) AS visit_to_purchase_funnel
FROM ref
ORDER BY visit_to_purchase_funnel DESC 
;


/*Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy: 

Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.

Note:

The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2.
Input Format

The following tables contain company data:

Company: The company_code is the code of the company and founder is the founder of the company. 

Lead_Manager: The lead_manager_code is the code of the lead manager, and the company_code is the code of the working company. 

Senior_Manager: The senior_manager_code is the code of the senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company. 

Manager: The manager_code is the code of the manager, the senior_manager_code is the code of its senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company. 

Employee: The employee_code is the code of the employee, the manager_code is the code of its manager, the senior_manager_code is the code of its senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company.*/

SELECT company.company_code,
company.founder, 
COUNT(DISTINCT(lead_manager.lead_manager_code)) Total_num_of_lead_managers, 
COUNT(DISTINCT(senior_manager.senior_manager_code)) Total_count_of_senior_managers, 
COUNT(DISTINCT(manager.manager_code)) Total_count_of_managers, 
COUNT(DISTINCT(employee.employee_code))Total_count_of_employees

FROM 

company 
LEFT JOIN 
lead_manager
ON company.company_code = lead_manager.company_code 
LEFT JOIN 
senior_manager
ON lead_manager.company_code = senior_manager.company_code
LEFT JOIN 
manager 
ON lead_manager.company_code = manager.company_code
LEFT JOIN
employee 
ON employee.company_code = manager.company_code

GROUP BY company.company_code,company.founder
ORDER BY company.company_code;

----

## Second highest salary 

-- first record after max salary 

SELECT * FROM records 
WHERE SALARY < (SELECT MAX(salary) FROM records)
LIMIT 1;

--Removing duplicates
(SELECT 
ROW NUMBER() (PARTITION BY customer_id,department ORDER BY customer_id)
FROM customeR;

SHOW TABLES;

WITH helper AS (SELECT *,
ROW_NUMBER() OVER(PARTITION BY actor_id ORDER BY last_update) AS row_id
FROM actor)
SELECT * FROM helper 
WHERE row_id > 1;

