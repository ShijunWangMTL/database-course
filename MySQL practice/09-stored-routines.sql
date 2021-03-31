##########################################################
##########################################################

-- SECTION: Stored Routines

##########################################################
########################################################## 



--  The MySQL Syntax for Stored Procedures
# We have 2 type of stored routine
# Stored Procedures: 		Has IN, OUT parameter as argument
# Functions: 					Does not have  IN, OUT argument, bur it has a RETURN statement with a RETURN TYPE
#
# If you use MySQL Workbench menu to create a procedure do not forget to press Apply button at the end
######################################
USE employees;

# When DROP a nonparameterized procedure, do not write () at the end
DROP procedure IF EXISTS select_employees;

# Define $$ as a temporary delimiter like ;
# We need to define a new delimiter to show end of stored procedure.
# ; shows end of each statement as usuall. We will have one or more statement nested inside the procedure
DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
          
			SELECT * FROM employees
			LIMIT 100;
            
END$$
# Go back to ususal delimiter
DELIMITER ;


# Different type of calling a procedure. It is better to use () for readability
call employees.select_employees();
call employees.select_employees;

call select_employees();
call select_employees;




-- EXERCISE: Stored Procedures
# Create a procedure that will provide the average salary of all employees.Then, call the procedure.

DELIMITER $$
CREATE PROCEDURE avg_salary()
BEGIN
	SELECT 
		AVG(salary)
	FROM
		salaries;
END$$
DELIMITER ;

CALL avg_salary;
CALL avg_salary();
CALL employees.avg_salary;
CALL employees.avg_salary();



--  Another Way to Create a Procedure in MySQL
######################################

--  INPUT PARAMETER
######################################
DROP PROCEDURE select_employees;
DROP procedure IF EXISTS emp_salary;

# Find a specific employee by PASSING employee number as an int
# and show the salary of that employee
# We have several rows in output because employee id is repeated in salaries table several times
# because employee had several contracts with different salaries in different times
DELIMITER $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
SELECT 
    e.first_name, 
    e.last_name, 
    s.salary, 
    s.from_date, 
    s.to_date
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
END$$
DELIMITER ;

CALL emp_salary(11300);



-- emp_avg_salary with SELECT e.first_name, e.last_name, avg(s.salary)
# What if we want to just have the AVERAGE salary of an employee by employee id
DROP procedure IF EXISTS emp_avg_salary;

DELIMITER $$
CREATE PROCEDURE emp_avg_salary (in p_emp_no integer)
BEGIN
SELECT 
    e.first_name, 
    e.last_name, 
    avg(s.salary)
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
END$$
DELIMITER ;

CALL emp_avg_salary(11300);



--  Stored Procedures with an Output Parameter
# How to define a return type
######################################
DROP procedure IF EXISTS emp_avg_salary_out;

DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER, OUT p_avg_salary DECIMAL(10,2))
BEGIN
SELECT 
	# ALWAYS WITH OUT PARAMETER WE HAVE TO USE
    # SELECT		INTO
    # This is how we save the result 	INTO 	out parameter (defined in the method signature)
    AVG(s.salary) INTO p_avg_salary 
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
END$$
DELIMITER ;



# How to call a procedure and pass a variable
# Define a session variable
SET @p_avg_salary = 0;
# Call procedure by passing IN and OUT parameters
CALL emp_avg_salary_out(11300, @p_avg_salary);
SELECT @p_avg_salary;
######################################







-- EXERCISE: Stored Procedures with an Output Parameter
######################################
# Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, and 
# returns their employee number.
DROP procedure IF EXISTS emp_info;

DELIMITER $$
CREATE PROCEDURE emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)
BEGIN
	SELECT e.emp_no INTO p_emp_no
	FROM employees e
	WHERE e.first_name = p_first_name
		AND e.last_name = p_last_name;
END$$
DELIMITER ;
select * from employees limit 10;
SET @p_emp_no = 0;
CALL emp_info('sumant', 'peac', @p_emp_no);
SELECT @p_emp_no;

DELIMITER $$
CREATE PROCEDURE emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)
BEGIN
	SELECT 
		e.emp_no INTO p_emp_no 
    FROM
		employees e
	WHERE
		e.first_name = p_first_name
			AND e.last_name = p_last_name;
END$$
DELIMITER ;



# PAY ATTENTION
# To call procedure first we created a variable with the initial value of 0 and then 
# when we called the procedure we passed it to procedure as OUT parameter
set @v_emp_no = 0;
call emp_info('Aruna', 'Journel', @v_emp_no);

# How to see the value of a variable
select @v_emp_no;
######################################






######################################
######################################

--  User-Defined Functions in MySQL

######################################
######################################

USE employees;

# In functions we will not use IN and OUT for parameters, because all parameters are IN
# Instead of OUT we have RETURN keyword


# In case of ERROR 1418: This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA 
# DETERMINISTIC: 		it means that the function will always return identical result given the same input
# NO SQL: 						it means that the code in our function does not contain SQL (rarely the case)
# READS SQL DATA: 		this is usually when a simple SELECT statement is present
#
# Run below line to fix it
SET @@global.log_bin_trust_function_creators := 1;

DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
# An other solution for Error 1418
# Uncomment below line
#DETERMINISTIC NO SQL READS SQL DATA
BEGIN
# Define a return variable the same type as defined type in function signature
DECLARE v_avg_salary DECIMAL(10,2);

SELECT 
    AVG(s.salary) INTO v_avg_salary 
    FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;

RETURN v_avg_salary;
END$$
DELIMITER ;


SELECT f_emp_avg_salary(11300);




drop function emp_info;
-- EXERCISE: User-Defined Functions in MySQL
# Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, 
# and returns the salary from the newest contract of that employee.
# Hint: In the BEGIN-END block of this program, you need to declare and use two variables –
#  v_max_from_date that will be of the DATE type, and
#  v_salary, that will be of the DECIMAL (10,2) type.
DELIMITER $$
CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)
BEGIN
	DECLARE v_max_from_date date;
    DECLARE v_salary decimal(10,2);

	SELECT 
    MAX(from_date)
INTO v_max_from_date FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;

	SELECT 
    s.salary
INTO v_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name
        AND s.from_date = v_max_from_date;
            
	RETURN v_salary;
END$$
DELIMITER ;

SELECT emp_info('Aruna', 'Journel');



# How to call a function as a column in a select statement
######################################
SET @v_emp_no = 11300; 

SELECT 
    emp_no,
    first_name,
    last_name,
    f_emp_avg_salary(@v_emp_no) AS avg_salary
FROM
    employees
WHERE
    emp_no = @v_emp_no;