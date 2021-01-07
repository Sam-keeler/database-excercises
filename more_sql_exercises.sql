# How much do the current managers of each department get paid,
# relative to the average salary for the department?
# Is there any department where the department manager gets
# paid less than the average salary?
SELECT salary, CONCAT(first_name, ' ', last_name) AS 'Manager Name', dept_name
FROM salaries
JOIN employees_with_departments USING(emp_no)
WHERE salaries.emp_no IN (SELECT emp_no
                 FROM dept_manager
                 WHERE to_date > CURDATE())            
AND to_date > CURDATE()
UNION
SELECT dept_name, AVG(salary)
FROM salaries
JOIN employees_with_departments USING(emp_no)
WHERE to_date > CURDATE()





