-- Lab | SQL Intro
USE sakila;

-- Show tables in the database.
SHOW TABLES FROM sakila;

-- Explore tables. (select everything from each table)
SHOW FULL TABLES;

SELECT * FROM sakila.actor;
SELECT * FROM address;
SELECT * FROM category;
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM customer;
SELECT * FROM film;
SELECT * FROM film_actor;
SELECT * FROM film_category;
SELECT * FROM film_text;
SELECT * FROM inventory;
SELECT * FROM language;
SELECT * FROM payment;
SELECT * FROM rental;
SELECT * FROM staff;
SELECT * FROM store;

-- Select one column from a table. Get film titles.
SELECT title AS Film_Titles FROM sakila.film;

-- Select one column from a table and alias it. Get languages.
SELECT name AS Film_Language FROM sakila.language;

-- How many stores does the company have? How many employees? which are their names?
SELECT Count(*) store FROM sakila.store;
SELECT Count(*) staff FROM sakila.staff;
SELECT first_name AS First_Name, last_name AS Last_Name FROM sakila.staff;

-- Lab | SQL Queries 2

-- Select all the actors with the first name ‘Scarlett’.
SELECT *, first_name AS First_Name FROM sakila.actor
WHERE first_name IN ('Scarlett');

-- Select all the actors with the last name ‘Johansson’.
SELECT *, last_name AS Last_Name FROM sakila.actor
WHERE last_name IN ('Johansson');

-- How many films (movies) are available for rent?
SELECT count(distinct(inventory_id)) AS Available FROM sakila.rental;

-- How many films have been rented?
SELECT count(rental_date) AS Rented_count FROM sakila.rental;

-- What is the shortest and longest rental period?
SELECT max(DATEDIFF(last_update, rental_date)) AS Rental_period, last_update AS Last_Update, rental_date AS Rental_date FROM sakila.rental;

-- What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT max(length) AS max_duration, min(length) AS min_duration FROM sakila.film;

-- What's the average movie duration?
SELECT avg(length) AS Average_duration FROM sakila.film;

-- What's the average movie duration expressed in format (hours, minutes)?
SELECT TIME_FORMAT(avg(length), '%T') AS Duration FROM sakila.film;

-- How many movies longer than 3 hours?
SELECT count(length) AS Long_movies FROM sakila.film
WHERE length > 180;

-- Get the name and email formatted. Example: Mary SMITH - mary.smith@sakilacustomer.org.
SELECT first_name, last_name, email, concat((left(first_name,1)), substr(lower(first_name),2),' ', last_name, ' - ', LOWER(email)) AS Formated FROM sakila.customer;

-- What's the length of the longest film title?
SELECT max(CHAR_LENGTH(TRIM(title))) AS Title_Length, title AS Title FROM sakila.film
ORDER BY title DESC;

-- Lab | SQL Queries 3

-- How many distinct (different) actors' last names are there?
SELECT count(distinct last_name) AS Surnames FROM sakila.actor;
 
-- In how many different languages where the films originally produced?
SELECT count(distinct original_language_id) AS Languages FROM sakila.film;

-- How many movies were not originally filmed in English?
SELECT count(distinct original_language_id) AS Languages FROM sakila.film
WHERE original_language_id NOT IN ('English');

-- Get 10 the longest movies from 2006.
SELECT length AS Movie_duration, title AS Title FROM sakila.film
WHERE release_year IN ('2006')
ORDER BY length DESC
LIMIT 10;

-- How many days has been the company operating (check DATEDIFF() function)?
SELECT length AS Movie_duration, title AS Title FROM sakila.film
WHERE release_year IN ('2006')
ORDER BY length DESC
LIMIT 10;

-- Show rental info with additional columns month and weekday. Get 20.
SELECT rental_date AS Rental_Date, MONTHNAME(rental_date) AS Month, DAYNAME(rental_date) AS Weekday FROM sakila.rental
LIMIT 20;

-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *,
CASE
	WHEN (DAYNAME(rental_date) IN ('Sunday' OR 'Saturday')) THEN "weekend"
	ELSE "workday"
END AS 'day_type'
FROM sakila.rental;

-- Alternative approach:
SELECT *,
CASE
	WHEN (dayofweek(rental_date)=6 OR dayofweek(rental_date)=7) THEN "weekend"
	ELSE "workday"
END AS 'day_type'
FROM sakila.rental;

-- How many rentals were in the last month of activity?

SELECT count(*) FROM sakila.rental
WHERE rental_date > '2006-01-14 15:16:03';


-- Lab | SQL Queries 3

-- Get film ratings.
SELECT title, rating FROM sakila.film;

-- Get release years.
SELECT title, release_year FROM sakila.film;

-- Get all films with ARMAGEDDON in the title.
SELECT title FROM sakila.film
WHERE title LIKE '%ARMAGEDDON%';

-- Get all films with APOLLO in the title
SELECT title FROM sakila.film
WHERE title LIKE '%APOLLO%';

-- Get all films which title ends with APOLLO.
SELECT title FROM sakila.film
WHERE title regexp 'APOLLO$';

-- Get all films with word DATE in the title.
SELECT title FROM sakila.film
WHERE title regexp 'DATE';

-- Get 10 films with the longest title.
SELECT title, (CHAR_LENGTH(TRIM(title))) AS Title_Length FROM sakila.film
WHERE CHAR_LENGTH(TRIM(title))
ORDER BY Title_length DESC
LIMIT 10;

-- Get 10 the longest films.
SELECT title, length AS Movie_Length FROM sakila.film
ORDER BY length DESC
LIMIT 10;

-- How many films include Behind the Scenes content?
SELECT count(special_features) FROM sakila.film
WHERE special_features LIKE '%Behind_the_Scenes%';

-- List films ordered by release year and title in alphabetical order.
SELECT * FROM sakila.film
ORDER BY release_year AND title ASC;