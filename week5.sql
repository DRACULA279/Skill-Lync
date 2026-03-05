-- Active: 1767506199827@@127.0.0.1@3306@sakila
/*
1. Write a single query to select payment_id, customer_id, staff_id, rental_id, amount from table payment (schema - sakila) which satisfies both below mentioned conditions.

Range for customer_id 10,20,30,40,50,60,70,80,90,100
staff_id is 2
*/

USE sakila;

SELECT * FROM payment;

SELECT payment_id, customer_id, staff_id, rental_id, amount FROM payment
        WHERE customer_id IN (10,20,30,40,50,60,70,80,90,100) AND staff_id = 2;


-- 2. Write query to display record of table film (schema - sakila) ordered by rating in descending order.

SELECT * FROM film 
    ORDER BY rating DESC;;


/*
3. Write a single query to display payment_id, amount and updated_amount from table payment (schema - sakila) which supports the result set with below mentioned criteria.

amount is greater than 5.0
updated_amount is double of amount and rounded off
*/

SELECT payment_id, amount, ROUND(amount*2) updated_amount FROM payment
WHERE amount > 5.0;

/* 
Write a single query to display below mentioned values from table payment for each customer (customer_id) (schema - sakila)

customer_id 
Total sum of the payment
Average of the payment
Standard deviation of the payment
Variance of the payment
*/

SELECT customer_id, sum(amount) Total_sum_of_payment, AVG(amount) AVERAGE_of_PAYMENT, STDDEV(amount) std_dev_of_amount, VARIANCE(amount) variance_of_payment FROM payment
GROUP BY customer_id;

/*Write a query to display city_id, city, country_id from table city for country name starting with A and B (schema - sakila) (Hint: Use subquery)*/
SELECT c.city_id, c.city, c.country_id FROM city c
WHERE c.country_id IN (SELECT co.country_id FROM country co WHERE country LIKE'A%' OR 'B%');

/*
6. What is the difference between ANY and ALL keywords with respect to subquery in SQL? (MCQ)

ALL – Comparison with every value ANY – Comparison with atleast one value -- CORRECT
ALL – Comparison with atleast one value ANY – Comparison with every value
ALL – Comparison with every value ANY – Comparison with atleast two value
ALL – Comparison with atleast two value ANY – Comparison with atleast one value
*/

--ANY 


SELECT * 
FROM city 
WHERE country_id = ANY (
    SELECT country_id 
    FROM country 
    WHERE country LIKE 'A%' OR country LIKE 'B%'
);

--ALL

SELECT * 
FROM city 
WHERE country_id = ALL (
    SELECT country_id 
    FROM country 
    WHERE country LIKE 'A%' OR country LIKE 'B%'
);

