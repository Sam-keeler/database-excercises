# Write a query that returns all employees (emp_no), their department number,
# their start date, their end date, and a new column 'is_current_employee'
# that is a 1 if the employee is still with the company and 0 if not.
CREATE TEMPORARY TABLE workers AS
SELECT emp_no, dept_no, from_date, to_date, 
   IF(to_date > CURDATE(), true, false) AS 'is_employed'
FROM employees.dept_emp;

SELECT *
FROM workers;

# Write a query that returns all employee names (previous and current),
# and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z'
# depending on the first letter of their last name.
SELECT first_name, last_name,
   CASE
      WHEN SUBSTRING(last_name, 1, 1) IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H')
      THEN 'A-H'
      WHEN SUBSTRING(last_name, 1, 1) IN ('I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q')
      THEN 'I-Q'
      WHEN SUBSTRING(last_name, 1, 1) IN ('R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z')
      THEN 'R-Z'
      END AS 'alpha-group'
FROM employees.employees;

# How many employees (current or previous) were born in each decade?
CREATE TEMPORARY TABLE Decades AS
SELECT birth_date,
   CASE
      WHEN SUBSTRING(birth_date, 3, 1) = 5     
      THEN '50\'s'
      ELSE '60\'s'
      END AS 'decade_group'
FROM employees.employees;

DROP TABLE Decades;

SELECT *
FROM Decades;

SELECT COUNT(decade_group) AS 'Employee count', decade_group
FROM Decades
GROUP BY decade_group;

# What is the current average salary for each of the following department groups:
# R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
CREATE TEMPORARY TABLE d_averages(
customer_service INT);

INSERT INTO d_averages(customer_service)
SELECT salary
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
WHERE dept_no = 'd009'
AND salaries.to_date > CURDATE();

ALTER TABLE d_averages ADD finance_hr INT;

INSERT INTO d_averages(finance_hr)
SELECT salary
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
WHERE dept_no = 'd003'
OR dept_no = 'd002'
AND salaries.to_date > CURDATE();

ALTER TABLE d_averages ADD sales_marketing INT;

INSERT INTO d_averages(sales_marketing)
SELECT salary
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
WHERE dept_no = 'd001'
OR dept_no = 'd007'
AND salaries.to_date > CURDATE();

ALTER TABLE d_averages ADD prod_qm INT;

INSERT INTO d_averages(prod_qm)
SELECT salary
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
WHERE dept_no = 'd004'
OR dept_no = 'd006'
AND salaries.to_date > CURDATE();

ALTER TABLE d_averages ADD r_d INT;

INSERT INTO d_averages(r_d)
SELECT salary
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
WHERE dept_no = 'd005'
OR dept_no = 'd008'
AND salaries.to_date > CURDATE();

SELECT AVG(customer_service) AS 'CS Average', AVG(finance_hr) AS 'Finance and HR Average', 
AVG(sales_marketing) AS 'Sales and Mark Average', AVG(prod_qm) AS 'Prod and QM Average', 
AVG(r_d) AS 'R & D Average'
FROM d_averages;

SELECT *
FROM d_averages
