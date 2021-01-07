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
GROUP BY dept_name, msalaries.salary




