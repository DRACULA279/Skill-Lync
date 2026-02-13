SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    TABLE_SCHEMA = "SAKILA"
    AND REFERENCED_TABLE_NAME IS NOT NULL;

/*
 Types of attributes:

Key Attribute - Uniquely identifies an entity. eg: EMP_ID

Simple Attributes - Connot be divided further. eg: name, age

composite Attributes - Can be split into two smaller parts. eg: full_name --> first_name & last_name

Derived Attributes - Derived from other attributes. eg: age from DOB

Single-value Attributes - Holds only one value. eg: DOB

Multi-value Attribute - Can hold multiple values. eg: phone_number

 

Atomicity (All or nothing) - Either every operation in the transaction is completed or none are.

Consistency (Consistent throughout the transaction) - A transaction brings database from one valid state to another, maintaining all rules, constraints, and integrity. 

Isolation (Independent) - Transactions are executed independently of each other. 

Durability (Commitment) - Once a transaction is committed, the changes are permanent, even if the system crashes afterwards.

Data Definition Language:

CREATE - To create a table

Drop - To drop a table

Alter - To Modify the structure of the table

Truncate - To Delete all the rows from the table

Transaction Control Language

Commit - To Permanently save the transaction/s.

Rollback - Undoing after last commit

Savepoint - Used to roll back to a particular point.

The default tables in the schema - SAKILA are as follows:

active_customer

actor

actor_info

address

category

city

country

customer

customer_list

film

film_actor

film_category

film_lis

film_text

inventory

language

nicer_but_slower_film_list

payment

rental

sales_by_film_category

sales_by_store

staff

staff_list

store

 Primary key in Table - Customers --> customer_id

Foreign keys used in the table customer --> address_id

Indexes used in table film_actor --> PRIMARY on (actor_id, film_id) and idx_fk_film_id on film_id.

Stored procedures used in the sakila database --> film_in_stock, film_not_in_stock, rewards_report

Views used in the sakila database --> active_customer, actor_info, customer_list, film_list, nicer_but_slower_film_list, sales_by_film_category, sales_by_store, staff_list

Keyboard shortcut for executing all statements in MySQL. --> Ctrl + Shift + Enter

Keyboard shortcut for opening new tab in MySQL. --> Ctrl + T

Created a new schema -- TestDb

Created a new SQL tab in MySQL for running queries and saved the file.
*/