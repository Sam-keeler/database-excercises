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
CREATE TEMPORARY TABLE Alpha AS
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

SELECT *
FROM Alpha;

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
GROUP BY decade_group
