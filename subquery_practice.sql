USE employees;

# Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT *
FROM employees
WHERE hire_date like (SELECT hire_date
                      FROM employees
                      WHERE emp_no = 101010);
                      
# Find all the titles ever held by all current employees with the first name Aamod.
SELECT title
FROM titles
JOIN employees USING(emp_no)
JOIN dept_emp USING(emp_no)
WHERE first_name = 'Aamod'
AND dept_emp.to_date > CURDATE();

# How many people in the employees table are no longer working for the company?
# Give the answer in a comment in your code.
SELECT COUNT(*)
FROM dept_emp
WHERE to_date < CURDATE()
AND emp_no IN (SELECT emp_no
               FROM employees);
# 91,479

# Find all the current department managers that are female.
# List their names in a comment in your code.
SELECT CONCAT(first_name, ' ', last_name) AS 'Name'
FROM employees 
WHERE gender = 'F'
AND emp_no IN (SELECT emp_no
               FROM dept_manager
               WHERE to_date > CURDATE());
#Isamu Legleitner
#Karsten Sigstam
#Leon DasSarma
#Hilary Kambil

# Find all the employees who currently have a higher salary than
# the companies overall, historical average salary.
SELECT CONCAT(first_name, ' ', last_name) AS 'Name', salary
FROM employees
JOIN salaries USING(emp_no)
WHERE salaries.to_date > CURDATE()
AND salary > (SELECT AVG(salary)
              FROM salaries);

# How many current salaries are within 1 standard deviation of the current highest salary? 
SELECT COUNT(*)
FROM salaries
WHERE salary > (SELECT (MAX(salary) - STDDEV(salary))
                FROM salaries)
AND to_date > CURDATE();
#78

# What percentage of all salaries is this?
SELECT (78 / COUNT(*))
FROM salaries
WHERE to_date > CURDATE();
# 0.03%

# Find all the department names that currently have female managers.
SELECT dept_name
FROM departments
JOIN dept_manager USING(dept_no)
JOIN employees USING(emp_no)
WHERE employees.emp_no IN (SELECT emp_no
                           FROM dept_manager
                           WHERE gender = 'F'
                           AND to_date > CURDATE());
                           
# Find the first and last name of the employee with the highest salary.
SELECT CONCAT(first_name, ' ', last_name)
FROM employees
JOIN salaries USING (emp_no)
WHERE salary = (SELECT MAX(salary)
                FROM salaries);
                
# Find the department name that the employee with the highest salary works in.
SELECT dept_name
FROM employees_with_departments
JOIN salaries USING (emp_no)
WHERE salary = (SELECT MAX(salary)
                FROM salaries);


