/*Below TASKS use the employee mod database created 
using 'SQL bootcamp DB structure' file in git repository. */

use employees_mod;

/*Task 1: Provide a breakdown between the male and female 
employees working in the company each year, starting from 1990. */

/*Number of employees joined in a calendar year*/
SELECT
	YEAR(de.from_date) AS calendar_year, e.gender, count(e.emp_no) AS num_of_emolyees_Joined
FROM
	t_employees e
JOIN t_dept_emp de ON e.emp_no = de.emp_no
GROUP BY calendar_year, e.gender
HAVING calendar_year >= 1990
ORDER BY calendar_year asc;

/*Number of employees quit in a calendar year*/
SELECT 
	YEAR(de.to_date) as calendar_year, e.gender, count(e.emp_no) AS num_of_employees_Left
FROM
	t_employees e
JOIN
	t_dept_emp de ON de.emp_no = e. emp_no
GROUP BY calendar_year, e.gender
HAVING calendar_year >= 1990 AND calendar_year < 2010
ORDER BY calendar_year asc;


/*Task 2: Compare the number of male managers to the number of female managers from 
different departments for each year, starting from 1990.*/

SELECT d.dept_name, ee.gender, dm.from_date, dm.to_date, e.calendar_year,
CASE
	WHEN YEAR(to_date) >= calendar_year AND YEAR(from_date) <= calendar_year THEN 1
    ELSE 0
END AS active
FROM
	(SELECT 
		YEAR(hire_date) AS calendar_year
	FROM
		t_employees
	GROUP BY calendar_year) e
	CROSS JOIN
		t_dept_manager dm
	JOIN
		t_departments d ON d.dept_no = dm.dept_no
	JOIN
		t_employees ee ON ee.emp_no = dm.emp_no
	GROUP BY ee.emp_no, calendar_year;


/*Task 3: Compare the average salary of female versus male employees in the entire 
company until year 2002, and add a filter allowing you to see that per each department.*/

SELECT 
	e.gender, d.dept_name, ROUND(AVG(s.salary),2), YEAR(s.from_date) as calendar_year
FROM 
	t_salaries s
JOIN t_employees e ON e.emp_no = s.emp_no
JOIN t_dept_emp de ON de.emp_no = e.emp_no
JOIN t_departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_name, e.gender, calendar_year
HAVING calendar_year <= 2002
ORDER BY d.dept_name;
