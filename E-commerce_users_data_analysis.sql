/*

Tasks to be performed

Create new schema as ecommerce
Import .csv file users_data into MySQL(right click on ecommerce schema -> Table Data import Wizard -> Give path of the file -> Next -> choose options : Create a new table , select delete if exist -> next -> next)
Run SQL command to see the structure of table
Run SQL command to select first 100 rows of the database
How many distinct values exist in table for field country and language
Check whether male users are having maximum followers or female users.
Calculate the total users those
Uses Profile Picture in their Profile
Uses Application for Ecommerce platform
Uses Android app
Uses ios app
Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers. (Hint: consider only those users having at least 1 product bought.)
Calculate the total number of sellers for each country and sort the result in ascending order of total number of sellers. (Hint: consider only those users having at least 1 product sold.)
Display name of top 10 countries having maximum products pass rate.
Calculate the number of users on an ecommerce platform for different language choices.
Check the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform. (Hint: use UNION to answer this question.)
Check the choice of male users about being seller or buyer. (Hint: use UNION to solve this question.)
Which country is having maximum number of buyers?
List the name of 10 countries having zero number of sellers.
Display record of top 110 users who have used ecommerce platform recently.
Calculate the number of female users those who have not logged in since last 100 days.
Display the number of female users of each country at ecommerce platform.
Display the number of male users of each country at ecommerce platform.
Calculate the average number of products sold and bought on ecommerce platform by male users for each country.

*/
USE p1_user_data; -- To use the database imported 

DESC users_data; -- To find the structure of the table 

SELECT * FROM users_data LIMIT 100;  -- Viewing the table limiting rows to 100

SELECT COUNT(DISTINCT(country)) distinct_countries, COUNT(DISTINCT(language)) distinct_language FROM users_data; -- finding distinct countries and languages.

SELECT gender, COUNT(socialNbFollowers) Total_followers FROM users_data
GROUP bY gender
ORDER BY gender Desc;  -- The gender female have more followers than the gender Male


SELECT
    COUNT(*) total_users,
    SUM(CASE WHEN hasProfilePicture = 'TRUE' THEN 1 ELSE 0 END) AS users_with_profile_picture,
    SUM(CASE WHEN hasAnyApp = 'TRUE' THEN 1 ELSE 0 END ) users_using_an_app,
    SUM(CASE WHEN hasAndroidApp= 'TRUE' THEN 1 ELSE 0 END ) android_app_users,
    SUM(CASE WHEN hasIosApp = 'TRUE' THEN 1 ELSE 0 END) ios_app_users
FROM users_data; -- Total users in certain parameters



SELECT 
    country,
    COUNT(CASE WHEN productsBought > 0 THEN identifierHash END) AS number_of_buyers
FROM users_data
GROUP BY country
ORDER BY number_of_buyers DESC; -- Total number of buyers for each country


SELECT 
    country,
    COUNT(CASE WHEN productsSold != 0 THEN identifierHash END) AS number_of_sellers
FROM users_data
GROUP BY country
ORDER BY number_of_sellers ASC;

SELECT 
    country,
    productsPassRate 
FROM users_data
ORDER BY productsPassRate DESC
LIMIT 10; -- TOP 10 Countries with maximum product passrate 


SELECT  
    language,
    COUNT(identifierHash) number_of_users
FROM users_data
GROUP BY language; -- Total number of users per language 


SELECT 
    COUNT(productsListed) AS products_listed,
    COUNT(CASE WHEN gender = 'F' AND productsWished > 1 THEN 1 END) AS female_whislisting,
    COUNT(CASE WHEN gender = 'F' AND socialProductsLiked > 1 THEN 1 END) AS female_social_liking,
    COUNT(CASE WHEN gender = 'F' THEN productsBought END) AS products_bought_female,
    COUNT(CASE WHEN gender = 'M' AND productsWished > 1 THEN 1 END) AS male_whislisting,
    COUNT(CASE WHEN gender = 'M' AND socialProductsLiked > 1 THEN 1 END) AS male_social_liking,
    COUNT(CASE WHEN gender = 'M' THEN productsBought END) AS products_bought_male
FROM users_data; 
/*
    -- The gender female tend to like most of the products posted socially on the ecommerce platform compared to male.
    -- same goes for whislisting and buying too.
    -- Female customers are more prone to liking, whishlisting or buying produts listed on the ecommerce platform than male customers.

*/

-- Alternative way using UNION

SELECT 
    'male_whishlisting' AS category,
     COUNT(*) AS total_products
FROM users_data
WHERE gender = 'M' AND `productsWished` > 1

UNION 

SELECT 
    'male_social_liking' AS category,
    COUNT(*) AS total_products
FROM users_data
WHERE gender = 'M' AND `socialProductsLiked` > 1

UNION 

SELECT 
    'female_whishlisting' AS category,
     COUNT(*) AS total_products
FROM users_data
WHERE gender = 'F' AND `productsWished` > 1

UNION 

SELECT 
    'female_social_liking' AS category,
    COUNT(*) AS total_products
FROM users_data
WHERE gender = 'F' AND `socialProductsLiked` > 1;

SELECT 
    'seller' AS Men_who_want_to_be_a,
    COUNT(*) AS total_count
FROM users_data
WHERE gender = 'M' AND `productsSold` > 1

UNION

SELECT 
    'buyer' AS Men_who_want_to_be_a,
    COUNT(*) AS total_count
FROM users_data
WHERE gender = 'M' AND `productsBought` > 1; -- More than 50% men want to be sellers than buyers

SELECT 
    country,
    COUNT(CASE WHEN productsBought > 1 THEN identifierHash END) AS no_of_buyers
FROM users_data
GROUP BY country
ORDER BY no_of_buyers DESC LIMIT 1; -- France has the maximum number of buyers


SELECT  
    country
FROM users_data
WHERE `productsBought` > 1 AND `productsListed` <= 0
GROUP BY country
LIMIT 10; -- zero number of sellers meaning either buyers or never listed a product to sell.

SELECT COUNT(identifierHash) FROM users_data
WHERE `productsBought` > 1 AND `productsSold` > 1 AND `productsListed` > 1; -- This confirms 227 records are both buyers and sellers out of which 130 records listed products on the ecommerce platform

SELECT COUNT(identifierHash) FROM users_data
WHERE `productsBought` > 1 ; -- Total buyer are 2122


SELECT MIN(`daysSinceLastLogin`) FROM users_data;

SELECT 
    identifierHash, 
    daysSinceLastLogin 
FROM users_data
ORDER BY daysSinceLastLogin ASC
LIMIT 110; --- list of recent 110 users of the ecommerce platform

SELECT
    COUNT(CASE WHEN gender = 'F' THEN identifierHash END) AS Total_female_users,
    COUNT(CASE WHEN gender = 'F' AND daysSinceLastLogin > 100 THEN identifierHash END) AS female_users_who_have_not_logged_in_since_last_100_days
FROM users_data; --- Most of them are not visiting except for the 5,932 who had logged in withing the 100 days period 

SELECT 
    country,
    COUNT(CASE WHEN gender = "F" THEN identifierHash END) AS female_users
FROM users_data
GROUP BY country; --- Female users in all the 200 country records

SELECT 
    country,
    COUNT(CASE WHEN gender = "M" THEN identifierHash END) AS male_users
FROM users_data
GROUP BY country; --- Male users in all the 200 country records


SELECT 
    AVG(CASE WHEN gender = 'M' THEN productsSold END) AS avg_number_of_products_sold_by_male_users,
    AVG(CASE WHEN gender = 'M' THEN productsBought END) AS avg_number_of_products_bought_by_male_users
FROM users_data; 

