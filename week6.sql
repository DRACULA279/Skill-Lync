-- Write query to display result set shown in figure 1 using inner join (schema - sakila) 

USE sakila;

SELECT * FROM city c
INNER JOIN country co
ON c.country_id = co.country_id;


-- Write query to join tables film, film_category and category using inner join. Result set should be like shown in figure 2 (schema - sakila) 

SELECT * FROM film f
INNER JOIN 
film_category fc
ON f.film_id = fc.film_id
INNER JOIN 
category c 
ON fc.category_id = c.category_id;

--- Write query to join tables film, inventory and film_text using left join. Result set should be like shown in figure 3 (schema - sakila) 


SELECT * FROM film f
LEFT JOIN 
inventory i
ON f.film_id = i.film_id
LEFT JOIN 
film_text ft
ON ft.film_id = i.film_id;


--Write query to display the staff_id, first_name, last_name, amount, payment_date, rental_date and return_date from tables staff, payment and rental using inner join (schema - sakila)"

SELECT s.staff_id, s.first_name, s.last_name, p.amount, p.payment_date, r.rental_date, r.return_date FROM 
staff s
INNER JOIN 
payment p
ON s.staff_id = p.staff_id
INNER JOIN
rental r
ON r.staff_id = p.staff_id;

