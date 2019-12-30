/*------ stored routines Begin -------*/
use employees;
drop procedure if exists select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
	select * from employees
    LIMIT 1000;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS avg_salary

DELIMITER $$
CREATE PROCEDURE avg_salary()
BEGIN
SELECT 
	ROUND(AVG(s.salary),2)
FROM
	salaries s
JOIN
	employees e on e.emp_no = s.emp_no;
END$$
DELIMITER ;

call employees.avg_salary();

DROP PROCEDURE select_employees;

DROP PROCEDURE IF EXISTS avg_salary


/*-----Procedure with IN parameter-----*/
DELIMITER $$
CREATE PROCEDURE avg_salary_input(IN p_emp_no INTEGER)
BEGIN
SELECT 
	e.first_name, e.last_name, ROUND(AVG(s.salary),2)
FROM
	employees e
JOIN
	salaries s on e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no;
END$$
DELIMITER ;

/*-----Procedure with IN and OUT parameter-----*/
DELIMITER $$
CREATE PROCEDURE avg_salary_out(IN p_emp_no INTEGER,OUT p_avg_salary DECIMAL(10,2))
BEGIN
SELECT 
	ROUND(AVG(s.salary),2)
INTO
	p_avg_salary
FROM
	salaries s
JOIN
	employees e on e.emp_no = s.emp_no
WHERE
	e.emp_no = p_emp_no;
END$$
DELIMITER ;

SET @v_emp_no = 0;
call employees.emp_info('Aruna','Journel',@v_emp_no);
select @v_emp_no;

/*--------stored routines end----------*/