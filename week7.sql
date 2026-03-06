-- 1. Write query to make summary of table payment (calculate Total amount, average amount, minimum amount, maximum amount, variance of amount). Result set should give output as shown in figure 1 (schema - sakila). 

SELECT  
    'Total_amount' AS Summary,
    SUM(amount) Amount
FROM payment

UNION 

SELECT 
    'Average_amount',
    AVG(amount)
FROM payment

UNION

SELECT 
    'Minimum_amount',
    MIN(amount)
FROM payment

UNION

SELECT 
    'Maximum_amount',
    MAX(amount)
FROM payment

UNION

SELECT 
    'Variance_amount',
    VARIANCE(amount)
FROM payment;

-- 2. Write query to calculate Total amount, average amount, minimum amount of amount from table payment for customer group using window function. (schema - sakila). Output for result set is shown in figure 2.


SELECT 
    DISTINCT customer_id,
    SUM(amount) OVER(PARTITION BY customer_id) AS Total_amount,
    AVG(amount) OVER(PARTITION BY customer_id) AS Average_amount,
    MIN(amount) OVER(PARTITION BY customer_id) AS Minimum_amount
FROM payment;


-- 3. Write column name/s for below written tables in which null values are allowed (schema – sakila). (Hint: Run DESCRIBE command for all the mentioned tables and check Null fields)

SELECT 
    table_name,
    column_name 
FROM information_schema.columns
WHERE table_schema = 'sakila'
AND IS_NULLABLE = 'YES'
ORDER BY 1,2;

-- 4.Write query to calculate the incline/decline for number of payments made on each date. (schema – sakila, table – payment). Output for result set is shown in figure 

SELECT * FROM payment;

SELECT 
    DISTINCT DATE(payment_date) Date,
    COUNT(payment_id) OVER (PARTITION BY payment_date) AS no_of_payments
FROM payment;  --  2006-02-14 is the day on which around 182 payments were made 