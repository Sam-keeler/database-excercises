# How much do the current managers of each department get paid,
# relative to the average salary for the department?
# Is there any department where the department manager gets
# paid less than the average salary?
SELECT ROUND(AVG(salaries.salary), 0) AS 'Average Salary', dept_name, msalaries.salary AS 'Manager Salary'
FROM salaries
JOIN employees USING(emp_no)
JOIN employees_with_departments USING(emp_no)
JOIN dept_manager ON employees_with_departments.emp_no = dept_manager.emp_no
   AND dept_manager.to_date > CURDATE()
JOIN employees AS managers ON managers.emp_no = dept_manager.emp_no
JOIN salaries AS msalaries ON managers.emp_no = msalaries.emp_no
   AND msalaries.to_date > CURDATE()
GROUP BY dept_name, msalaries.salary;

# How many different countries are in each region?
SELECT region, COUNT(*) AS 'Countries'
FROM country
GROUP BY region
ORDER BY COUNT(*) ASC;

# What is the population for each region?
SELECT region, SUM(population) AS 'Population'
FROM country
GROUP BY region
ORDER BY SUM(population) DESC;

# What is the population for each continent?
SELECT continent, SUM(population)
FROM country
GROUP BY continent
ORDER BY SUM(population) DESC;

# What is the average life expectancy globally?
SELECT AVG(LifeExpectancy)
FROM country;

# What is the average life expectancy for each region, each continent? 
# Sort the results from shortest to longest
SELECT continent, AVG(LifeExpectancy)
FROM country
GROUP BY continent
ORDER BY AVG(LifeExpectancy) ASC;

SELECT region, AVG(LifeExpectancy)
FROM country
GROUP BY region
ORDER BY AVG(LifeExpectancy) ASC;

# Find all the countries whose local name is different from the official name
SELECT `Name`, `LocalName`
FROM country
WHERE `Name` != `LocalName`;

# How many countries have a life expectancy less than x?
SELECT COUNT(*) AS 'Number of countries where life expectancy less than 60'
FROM `country`
WHERE LifeExpectancy < 60;

# What state is city x located in?
SELECT district
FROM city
WHERE `Name` = 'San Antonio';

# What region of the world is city x located in?
SELECT region
FROM country
JOIN city ON (CountryCode = `Code`)
WHERE city.name = 'San Antonio';

# What country (use the human readable name) city x located in?
SELECT country.name
FROM country 
JOIN city ON (CountryCode = country.Code)
WHERE city.name = 'San Antonio';

# What is the life expectancy in city x?
SELECT LifeExpectancy
FROM country 
JOIN city ON (CountryCode = country.Code)
WHERE city.name = 'San Antonio';

# Display the first and last names in all lowercase of all the actors.
SELECT LOWER(first_name), LOWER(last_name)
FROM actor;

# You need to find the ID number, first name, and last name of an actor,
# of whom you know only the first name, "Joe." What is one query would you
# could use to obtain this information?
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

# Find all actors whose last name contain the letters "gen":
SELECT CONCAT(first_name, ' ', last_name)
FROM actor
WHERE last_name LIKE '%gen%';

# Find all actors whose last names contain the letters "li".
# This time, order the rows by last name and first name, in that order.
SELECT CONCAT(first_name, ' ', last_name)
FROM actor
WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name;

# Using IN, display the country_id and country columns for the following
# countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

# List the last names of all the actors, as well as how many actors have that last name.
SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name;

# List last names of actors and the number of actors who have that last name,
# but only for names that are shared by at least two actors
SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name
HAVING COUNT(*) > 1;

# You cannot locate the schema of the address table.
# Which query would you use to re-create it?
DESCRIBE sakila.address;

# Use JOIN to display the first and last names, as well as the address, of each staff member.
SELECT first_name, last_name, address
FROM actor 
JOIN address ON (address_id = actor_id);

# Use JOIN to display the total amount rung up by each staff member in August of 2005.
SELECT staff_id, CONCAT(first_name, ' ', last_name) AS 'Full Name', SUM(amount) AS 'Sales'
FROM staff
JOIN payment USING(staff_id)
GROUP BY staff_id;

# List each film and the number of actors who are listed for that film.
SELECT title, COUNT(actor_id)
FROM film
JOIN film_actor USING(film_id)
GROUP BY film_id;

# How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT title, COUNT(inventory_id) AS 'In Stock'
FROM film
JOIN inventory USING(film_id)
WHERE title = 'Hunchback Impossible'
GROUP BY film_id;

# The music of Queen and Kris Kristofferson have seen an unlikely resurgence.
# As an unintended consequence, films starting with the letters K and Q have also
# soared in popularity. Use subqueries to display the titles of movies starting with
# the letters K and Q whose language is English.
SELECT title
FROM film
WHERE SUBSTRING(film.title, 1, 1) IN ('K', 'Q')
AND language_id = 1;

# Use subqueries to display all actors who appear in the film Alone Trip.
SELECT CONCAT(first_name, ' ', last_name)
FROM actor
WHERE actor_id IN (SELECT actor_id
                   FROM film_actor
                   JOIN film USING(film_id)
                   WHERE title = 'Alone Trip');
                   
# You want to run an email marketing campaign in Canada,
# for which you will need the names and email addresses of all Canadian customers.
SELECT CONCAT(customer.first_name, ' ', customer.last_name), customer.email
FROM customer
JOIN address USING(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id)
WHERE country_id = 20;

# Sales have been lagging among young families, and you wish to target all
# family movies for a promotion. Identify all movies categorized as famiy films.
SELECT title
FROM film
JOIN film_category USING(film_id)
JOIN category USING(category_id)
WHERE category.name = 'Family';

# Write a query to display how much business, in dollars, each store brought in.
SELECT store_id, SUM(amount)
FROM payment
JOIN staff USING(staff_id)
JOIN store USING(store_id)
GROUP BY store_id;

# Write a query to display for each store its store ID, city, and country.
SELECT store_id, city.city, country.country
FROM store
JOIN address USING(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id);

# List the top five genres in gross revenue in descending order.
SELECT category.name, SUM(payment.amount) AS 'Gross Revenue'
FROM payment
JOIN rental USING(rental_id)
JOIN inventory USING(inventory_id)
JOIN film_category USING(film_id)
JOIN category USING(category_id)
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

# Select all columns from the actor table.
SELECT *
FROM actor;

# Select only the last_name column from the actor table.
SELECT last_name
FROM actor;

# Select all distinct (different) last names from the actor table.
SELECT DISTINCT last_name
FROM actor;

# Select all distinct (different) postal codes from the address table.
SELECT DISTINCT postal_code
FROM address;



