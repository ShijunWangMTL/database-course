
--  Types of MySQL Variables - Local Variables
######################################

# We have 3 type of variables

# Local:			DECLARE		Only defined by user
# Session:		@						Can be defined by user and system
# Global:			@@					Only defined by system

-- v_avg_salary
DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no integer) RETURNS decimal(10,2)
READS SQL DATA
BEGIN

# Define a local variable
DECLARE v_avg_salary DECIMAL(10,2);

SELECT 
    AVG(s.salary)
INTO v_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;

RETURN v_avg_salary;
END$$

DELIMITER ;

# v_avg_salary is a local variable defined inside the function, so it is not visible outside of this function
# Error Code: 1054. Unknown column.
SELECT v_avg_salary;




-- v_avg_salary_2 (ERROR)
# Erroe Code: 1327. Undeclared variable.
DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no integer) RETURNS decimal(10,2)
READS SQL DATA
BEGIN

# Define a local variable inside Function
DECLARE v_avg_salary decimal(10,2);


# Define a nested scope ------------------------
BEGIN
	# Define a local variable inside Function in a nested scope
	DECLARE v_avg_salary_2 decimal(10,2);
END;
-- ------------------------------------------------------

SELECT 
    AVG(s.salary)
# Use defined local variable
# v_avg_salary_2 is not visible to function. Erroe Code: 1327.
INTO v_avg_salary_2 FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
# RETURN v_avg_salary_2    ERROR Code 1327
# v_avg_salary_2 is not visible to function and we can not return it
# v_avg_salary      can be returned
RETURN v_avg_salary_2;
END$$

DELIMITER ;








--  Session Variables
######################################

set @s_var1 = 3;
select @s_var1;
# Open a new tab and run: select @s_var1; 
# to see it is valid becaue new tab also use the same session


# Press Home icon and connect to MySQL with a new connection request
# run: select @s_var1; 
# to see it is not valid and will return NULL



--  Global Variables
######################################

# Approach 1: Assigning value to a global variable
SET GLOBAL max_connections = 1000;
/*
SET @@global.max_connections = 1000;
*/

# Approach 2: Assigning value to a global variable
SET @@global.max_connections = 1;
/*
SET GLOBAL max_connections = 1;
*/


--  User-Defined vs System Variables
######################################
-- ERROR we can not use pre defined System Variables names to define a SESSION variable
SET SESSION max_connections = 1000;

SET SESSION sql_mode='STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
SET GLOBAL sql_mode='STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

# Set property of the syntaxes and data validation perform by MySQL
SET @@session.sql_mode='STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

