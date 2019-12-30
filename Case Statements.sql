/*-------CASE statement begin-------*/
SELECT
	e.emp_no, e.first_name, e.last_name, IF(e.emp_no = dm.emp_no, 'Manager', 'Employee') AS 'Level'
FROM 
	employees e
LEFT JOIN dept_manager dm ON dm.emp_no = e.emp_no
WHERE 
	e.emp_no > 109990;


SELECT 
	dm.emp_no, e.first_name, e.last_name, max(s.salary)-min(s.salary) AS salary_difference, 
    CASE
		WHEN max(s.salary)-min(s.salary) > 30000 THEN 'Salary was raised by more than $30000'
        ELSE 'Salary was NOT raised by more than $30000'
        END AS salary_raise
FROM 
	dept_manager dm
JOIN 
	employees e on e.emp_no = dm.emp_no
JOIN 
	salaries s ON s.emp_no = dm.emp_no
group by e.emp_no;


SELECT 
	e.emp_no, e.first_name, e.last_name, 
    CASE
    WHEN max(de.to_date) < sysdate() THEN 'Not an employee anymore'
    ELSE 'Is still employed'
    END AS current_employee
FROM
	employees e
JOIN
	dept_emp de ON de.emp_no = e.emp_no
group by de.emp_no
LIMIT 100;


/*--------CASE statement end--------*/