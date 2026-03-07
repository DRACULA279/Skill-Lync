
-- 1. Write a query to create a view active_customer with all details of customer belonging to store id 1 and with active status = 1. (schema – sakila, table - customer ).
USE sakila;
SELECT * FROM customer;
CREATE VIEW active_customer AS(
    SELECT * FROM customer WHERE
    store_id = 1 AND active = 1
);

SELECT * FROM active_customer;

-- 2. Write query to create view customer_detail that list the customer detail including city name and address also. (schema – sakila)

SELECT * FROM address;

CREATE VIEW customer_detail AS
(
    SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name, 
        c.email,
        city.city,
        a.address,
        a.address2,
        a.district
    FROM customer c
    JOIN address a
    ON c.address_id = a.address_id
    JOIN 
    city 
    ON city.city_id = a.city_id
    ORDER BY customer_id
);

SELECT * FROM customer_detail; -- THIS VIEW PROVIDES ALL THE CUSTOMER DETAILS DERIVED FROM ALL THE THREE TABLES ---> CITY, CUSTOMER and ADDRESS

