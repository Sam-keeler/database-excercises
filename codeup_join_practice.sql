USE employees;

# Write a query that shows each department along with the
# name of the current manager for that department.
SELECT dept_name, CONCAT(employees.first_name, " ", employees.last_name) AS 'Department Manager'
FROM departments 
JOIN dept_manager ON (departments.dept_no = dept_manager.dept_no)
JOIN employees ON (dept_manager.emp_no = employees.emp_no)
WHERE to_date > curdate();

# Find the name of all departments currently managed by women.
SELECT dept_name, CONCAT(employees.first_name, " ", employees.last_name) AS 'Department Manager'
FROM departments 
JOIN dept_manager ON (departments.dept_no = dept_manager.dept_no)
JOIN employees ON (dept_manager.emp_no = employees.emp_no)
WHERE to_date > curdate()
AND gender = 'f';

# Find the current titles of employees currently working in the Customer Service department.
SELECT title, count(*)
FROM employees_with_departments
JOIN titles ON (employees_with_departments.emp_no = titles.emp_no)
WHERE dept_name = 'Customer Service'
AND to_date > curdate()
GROUP BY title;

# Find the current salary of all current managers.
SELECT dept_name, CONCAT(employees.first_name, " ", employees.last_name) AS 'Department Manager', salary
FROM departments 
JOIN dept_manager ON (departments.dept_no = dept_manager.dept_no)
JOIN employees ON (dept_manager.emp_no = employees.emp_no)
JOIN salaries ON (employees.emp_no = salaries.emp_no)
WHERE dept_manager.to_date > curdate()
AND salaries.to_date > curdate();

# Find the number of current employees in each department.
SELECT departments.dept_no, dept_name, COUNT(*) AS '# of employees'
FROM departments
JOIN dept_emp ON (departments.dept_no = dept_emp.dept_n)
WHERE to_date > curdate()
GROUP BY departments.dept_no;

# Which department has the highest average salary? Hint: Use current not historic information.
SELECT dept_name, (SUM(salary)/COUNT(*)) AS 'Average Salary'
FROM departments
JOIN dept_emp ON (departments.dept_no = dept_emp.dept_no)
JOIN salaries ON (dept_emp.emp_no = salaries.emp_no)
WHERE salaries.to_date > curdate()
GROUP BY dept_name
ORDER BY (SUM(salary)/COUNT(*)) DESC
LIMIT 1;

# Who is the highest paid employee in the Marketing department?
SELECT first_name, last_name
FROM employees_with_departments
JOIN salaries ON (employees_with_departments.emp_no = salaries.emp_no)
WHERE dept_name = 'Marketing'
ORDER BY salary DESC
LIMIT 1;

# Which current department manager has the highest salary?
SELECT first_name, last_name, salary, employees_with_departments.dept_name
FROM employees_with_departments
JOIN salaries ON (employees_with_departments.emp_no = salaries.emp_no)
JOIN dept_manager ON (salaries.emp_no = dept_manager.emp_no)
WHERE dept_manager.to_date > curdate()
ORDER BY salary DESC
LIMIT 1;

# Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS 'Employee Name', dept_name,  AS 'Manager'
FROM employees 
JOIN dept_emp ON (employees.emp_no = dept_emp.emp_no)
JOIN departments ON (dept_emp.dept_no = departments.dept_no)
RIGHT dept_manager ON (departments.dept_no = dept_manager.dept_no)
JOIN titles ON (dept_manager.emp_no = titles.emp_no)
WHERE dept_emp.to_date > curdate()
AND dept_manager.to_date > curdate();



