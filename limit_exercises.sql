USE employees

# List the first 10 distinct last name sorted in descending order.
SELECT DISTINCT last_name 
FROM employees
ORDER BY last_name DESC;
#Zykh, Zyda, Zwicker, Zweizig, Zumaque, Zultner, Zucker, Zuberek, Zschoche, Zongker

#Find all previous or current employees hired in the 90s and born on Christmas.
# Find the first 5 employees hired in the 90's by sorting by hire date and limiting your 
# results to the first 5 records. Write a comment in your code that lists the five names of 
# the employees returned.
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25'
LIMIT 5;
# Mang Erie, Evgueni Srimani, Florina Garnier, Sorina Kermarrec, Chriss Binding

# Update the query to find the tenth page of results.
# LIMIT and OFFSET can be used to create multiple pages of data.
# What is the relationship between OFFSET (number of results to skip),
# LIMIT (number of results per page), and the page number?
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25'
LIMIT 5 OFFSET 45;
# (Page number) = [(OFFSET)/(LIMIT)] + 1
# or
# (OFFSET) = [(Page number) - 1] * (LIMIT)

