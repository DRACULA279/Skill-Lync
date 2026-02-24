#  Write query to select film_id, title, length of title, description (to be displayed in upper case) from table film (schema - sakila).

USE sakila;

SELECT film_id, title, LENGTH(title) title_length, UPPER(description) 
FROM film;

# 2. Write query to display result set shown in figure 1 from table film (schema - sakila).

SELECT REVERSE(title) from film;

# 5. Write query to display number of days since the last update in table actor (schema - sakila).

SELECT actor_id, DATEDIFF(CURDATE(), last_update) AS days_since_last_update
FROM actor;