#  Query to select all record from table customer (schema - sakila)

use sakila;
SELECT * FROM customer;

# Query to select record from table customer for fields customer_id (Alias - ID), first_name (FName), last_name (LName), email (EmailID) (schema - sakila).

SELECT customer_id ID, first_name FName, last_name LName, email EmailID FROM customer;

# Query to display film title starting with alphabet ‘A’ and ending with alphabet ‘r’ from table film (schema - sakila).

SELECT title FROM film
WHERE title LIKE 'A%r';

# Query to display first 100 records from table customer 

SELECT * FROM customer 
LIMIT 100;

# Query to display payment_id, amount, rounded off value of amount and square root of amount from table payment (schema - sakila) in single statement.

SELECT payment_id, amount, ROUND(amount) ,SQRT(amount) FROM payment;

# Create a backup of Schema - Sakila. 

/*

RUN CMD as ADMINISTRATOR.

SET PATH to MySQL bin folder. eg: c:\program files\mysql\mysql server 8.0\bin

Use below command to backup the database.
mysqldump -u root -p sakila > sakila_backup.sql

ENTER password(MySQL SERVER) when prompted.

To RESTORE the database, use the commands below in MySQL COMMAND LINE CLIENT.

ENTER PASSWORD(MySQL SERVER) when prompted.

USE sakila;

SOURCE sakila_backup.sql;

*/