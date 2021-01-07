USE easley_1258;

# Using the example from the lesson, re-create the employees_with_departments table.

# Add a column named full_name to this table.
# It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
# Update the table so that full name column contains the correct data
# Remove the first_name and last_name columns from the table.
CREATE TEMPORARY TABLE ewd(
   SELECT *
   FROM employees.employees_with_departments);

ALTER TABLE ewd ADD Full_Name VARCHAR(100);

UPDATE ewd 
SET Full_Name = CONCAT(first_name, ' ', last_name);

ALTER TABLE ewd DROP COLUMN first_name;
ALTER TABLE ewd DROP COLUMN last_name;

SELECT * 
FROM ewd;


# Create a temporary table based on the payment table from the sakila database.
# Write the SQL necessary to transform the amount column such that it is stored
# as an integer representing the number of cents of the payment.
# For example, 1.99 should become 199.
CREATE TEMPORARY TABLE cents(
   SELECT *
   FROM sakila.payment);
   
ALTER TABLE cents ADD amounts FLOAT(10, 0);

UPDATE cents
SET amounts = amount*100;

ALTER TABLE cents DROP COLUMN amount;

SELECT *
FROM cents;


# Find out how the current average pay in each department compares to the overall,
# historical average pay. In order to make the comparison easier,
# you should use the Z-score for salaries. In terms of salary,
# what is the best department right now to work for? The worst?
CREATE TEMPORARY TABLE Averages AS
SELECT emp_no, salary, dept_name
FROM employees.employees_with_departments
JOIN employees.salaries USING(emp_no)
WHERE to_date > CURDATE();

SELECT AVG(salary), dept_name
FROM Averages
GROUP BY dept_name;

SELECT AVG(salary)
FROM employees.salaries;

# BEST: Sales
# WORST: Human Resources