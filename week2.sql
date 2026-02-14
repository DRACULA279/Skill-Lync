CREATE DATABASE testdb;
use testdb;

# Query to create table actor. 
CREATE TABLE testdb.actor(
    actor_id SMALLINT UNSIGNED PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL
);

# Query to create table Country. 
CREATE TABLE country(
    country_id SMALLINT UNSIGNED PRIMARY KEY,
    country VARCHAR(50) NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

# Query to create table City. 

CREATE TABLE city(
    city_id SMALLINT UNSIGNED PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    country_id SMALLINT UNSIGNED NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

# Query to create table Address. 

CREATE TABLE address(
    address_id SMALLINT UNSIGNED PRIMARY KEY,
    address VARCHAR(50) NOT NULL,
    address2 VARCHAR(50) DEFAULT NULL,
    district VARCHAR(20) NOT NULL,
    city_id SMALLINT UNSIGNED,
    postal_code VARCHAR(10) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(city_id) REFERENCES city(city_id)

);


# Query to insert values in table customer.

INSERT INTO sakila.address(address_id,address, address2, district, city_id, postal_code, phone,location,last_update)
    VALUES (606, '123 Main St', 'Ambedkar Statue', 'Gadabavalasa', 101, '532127', '+91-837-438-5131', ST_GeomFromText('POINT(-81.9495397 26.5628558)'), NOW()); 

INSERT INTO sakila.customer (customer_id, store_id, first_name, last_name, email, address_id, active, create_date)
VALUES (600, 1, 'Vikram', 'Reddy', 'vikram.reddy@gmail.com', 606, 1, NOW());


SELECT * from sakila.customer
WHERE address_id = 606;

# Query to insert values in table rental.

SELECT * FROM RENTAL;

DESC RENTAL;

SELECT * FROM sakila.inventory;

INSERT INTO inventory(inventory_id, film_id, store_id, last_update)
VALUES (4582, 1000, 1, NOW());

INSERT INTO RENTAL(rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (16050, NOW(), 100, 600, NULL, 1, NOW());