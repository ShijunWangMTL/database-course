# employees is database name
USE employees;

--   SELECT
######################################
SELECT 
    *
FROM
    employees;
    

SELECT 
    first_name, last_name
FROM
    employees;
    

-- EXERCISE 1: SELECT - FROM
SELECT 
    *
FROM
    departments;
    
    
-- EXERCISE 2: SELECT - FROM
SELECT 
    dept_no
FROM
    departments;




--  WHERE
######################################
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';
    
-- EXERCISE 1: WHERE
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';
    

--  AND
######################################
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND gender = 'M';
    
-- EXERCISE 1: AND
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' AND gender = 'F'; 


--  OR
######################################
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' OR first_name = 'Elvis';


# First name is exactly two defined words
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis'
        AND first_name = 'Elvis';
    
-- EXERCISE 1: OR
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie'
        OR first_name = 'Aruna'; 
    


--  Operator Precedence
######################################
# Regardless of the order in which you use these operators, 
# SQL will always start by reading the conditions around the AND operator
# last_name = 'Denis' AND gender = 'M' OR gender = 'F';
# (last_name = 'Denis' AND gender = 'M') OR gender = 'F';
# Select all Mail Denis and all Femails
SELECT 
    *
FROM
    employees
WHERE
    # Deneis, Mail and all Femails
    last_name = 'Denis' AND gender = 'M' OR gender = 'F';

SELECT 
    *
FROM
    employees
WHERE
    # Denis Mail or Femail
    last_name = 'Denis' AND (gender = 'M' OR gender = 'F');
    

-- EXERCISE 1: Operator Precedence
SELECT 
    *
FROM
    employees
WHERE
    gender = 'F' AND (first_name = 'Kellie' OR first_name = 'Aruna');



--  IN / NOT IN
######################################

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Cathie'
        OR first_name = 'Mark'
        OR first_name = 'Nathan';

SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Cathie' , 'Mark', 'Nathan');

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('Cathie' , 'Mark', 'Nathan');
    
-- EXERCISE 1: IN / NOT IN    
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis' , 'Elvis');
    
-- EXERCISE 2: IN / NOT IN 
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');



--  LIKE
######################################
# % means any number of characters
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE('Mar%');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE('ar%');

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE('%ar');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE('%ar%');

# _ mean only one character
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mar_');
 
 

-- EXERCISE 1: Wildcard Characters
 ######################################
 
 
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%JACK%');
    

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%jack%');
    

SELECT
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%Jac%'); 
    


 -- EXERCISE 1: LIKE / NOT LIKE 
 ######################################
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%Mar%');


SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE('Mark%');

SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('%2000%');

SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');
    
    

-- BETWEEN - AND
-- BETWEEN can be used for DATE, STRING and Numbers
-- BETWEEN is inclusive
 ######################################
   
SELECT 
    *
FROM
    employees
WHERE
    hire_date BETWEEN '1990-01-01' AND '2000-01-01';
    
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';    

-- EXERCISE 1: BETWEEN - AND
SELECT 
    *
FROM
    salaries;

SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;
    
SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';

SELECT 
    dept_no, dept_name
FROM
    departments;
    
SELECT 
    dept_no, dept_name
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';

    

--  IS NOT NULL / IS NULL
 ######################################
    
SELECT 
    *
FROM
    employees
WHERE
    first_name IS NOT NULL;
    
SELECT 
    *
FROM
    employees
WHERE
    first_name IS NULL;

-- EXERCISE 1: IS NOT NULL / IS NULL
SELECT 
    *
FROM
    departments
WHERE
    dept_no IS NOT NULL;


--  Other Comparison Operators
######################################
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Mark';
    
SELECT 
	*
FROM 
	employees
WHERE
	first_name <> 'Mark';
    
SELECT 
	*
FROM 
	employees
WHERE
	first_name != 'Mark';
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date >= '2000-01-01';

SELECT 
    *
FROM
    employees
WHERE
    hire_date < '1985-02-01';
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date <= '1985-02-01';

-- EXERCISE 1: Other Comparison Operators
######################################
SELECT 
    *
FROM
    employees
WHERE
    hire_date >= '2000-01-01'
        AND gender = 'F';
        
        
SELECT 
    *
FROM
    salaries
WHERE
    salary > 150000;


--  SELECT DISTINCT
# SELECT DISTINCT selects all distinct, different data values
######################################
SELECT 
    gender
FROM
    employees;
    
SELECT DISTINCT
    gender
FROM
    employees;
    
-- EXERCISE 1: SELECT DISTINCT
SELECT DISTINCT
    hire_date
FROM
    employees;
    


--  Introduction to Aggregate Functions
############################################################################    
SELECT 
    *
FROM
    employees;
    
SELECT 
    COUNT(emp_no)
FROM
    employees;

    
SELECT 
    COUNT(first_name)
FROM
    employees;


SELECT 
    COUNT(DISTINCT first_name)
FROM
    employees;


-- EXERCISE 1: Introduction to Aggregate Functions
# How many people have salary more than 100,000
SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 100000;
    
SELECT 
    COUNT(*)
FROM
    dept_manager;



--  ORDER BY
######################################
SELECT 
    *
FROM
    employees
ORDER BY first_name;

SELECT 
    *
FROM
    employees
ORDER BY first_name ASC;

SELECT 
    *
FROM
    employees
ORDER BY first_name DESC;

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC;

# First order by first_name and then last_name DESC
SELECT 
    *
FROM
    employees
ORDER BY first_name , last_name DESC;


SELECT 
    last_name, first_name
FROM
    employees
ORDER BY last_name, first_name ASC;  -- DESC

-- EXERCISE 1: ORDER BY
SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;


--  GROUP BY
######################################
SELECT 
    first_name
FROM
    employees;
    
SELECT 
    first_name
FROM
    employees
GROUP BY first_name;

SELECT DISTINCT
    first_name
FROM
    employees;

# How many time each name is repeated
SELECT 
    COUNT(first_name)
FROM
    employees
GROUP BY first_name;

SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name;

SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;


--  Using Aliases (AS)
######################################
# ALWAYS include the field you have grouped your results by in the select statement
# first_name: shows the names
# COUNT(first_name): shows the number of each name
SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;


# It is not professional to leave the function keyword in the output column name
# So we are going to use AS
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;

-- EXERCISE: Using Aliases (AS)
# Write a query that obtains two columns. The first column must contain annual salaries higher than 80,000 dollars. 
# The second column, renamed to “emps_with_same_salary”, must show the number of employees contracted to that salary. 
# Lastly, sort the output by the first column.
SELECT 
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary;



--  HAVING
######################################
# HAVING is like WHERE but applied to the GROUP BY block
# It is usually after GROUP BY and before ORDER BY
# It refines the output from records that do not satisfy a certain condition
# 
# WHERE vs. HAVING
# WHERE cannot use aggregate functions (like COUNT) within its conditions
# HAVING can have both an aggregated and a non-aggregated condition
#
# WHERE
# Allows us to set conditions that refer to subsets of individual rows
# Applied before re-organizing the output into groups
SELECT 
    *
FROM
    employees
WHERE
    hire_date >= '2000-01-01';

# Use HAVING like WHERE which generate the same result    
SELECT 
    *
FROM
    employees
HAVING
    hire_date >= '2000-01-01';












# Extract all first names that appear more than 250 times in the "employees" table
# First select statement does not work because we tried to use aggregate function inside WHERE clause
/*
SELECT 
    first_name, COUNT(first_name) as names_count
FROM
    employees
WHERE
	# ERROR because of aggregate function inside WHERE clause
    COUNT(first_name) > 250
GROUP BY first_name
ORDER BY first_name;
*/

SELECT 
    first_name, COUNT(first_name) as names_count
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) > 250
ORDER BY first_name;

-- EXERCISE: HAVING
# Select all employees whose average salary is higher than $120,000 per annum.
DESCRIBE salaries;

SELECT
	*
FROM
	salaries;
# 967,330
    
SELECT
	COUNT(emp_no)
FROM
	salaries;
# 967,330    

SELECT DISTINCT
	emp_no
FROM
    salaries;
# 101,796    it means each person has about 10 contracts

-- EXERCISE: HAVING
# Each person salary if it is more than 120,000

# When using WHERE instead of HAVING, the output is larger because 
# in the output we include all individual contracts higher than $120,000 per year. 
# One emp_no can have several contracts and some of them can be more than 120000
# By using WHERE instead of HAVING, the output does not show the average salary values.

# Using the star symbol instead of “emp_no” extracts a list that contains all columns 
# from the “salaries” table.

SELECT
    emp_no, AVG(salary)
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
ORDER BY emp_no;


SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;


--  WHERE vs HAVING - Part I
######################################
# Extract a list of all names that are encountered less than 200 times for people hired after 1st of January 1999.
#
# IMPORTANT:
# names that are encountered less than 200 times  ->  Agregate Function  -> HAVING
# people hired after 1st of January 1999  -> all rows  -> WHERE
#
SELECT 
	# COUNT(first_name) show in output
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name;



--  WHERE vs HAVING - Part II
######################################
# Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000

# ERROR 
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
# ERROR: You can NOT have aggregated function and non-aggregated function at the same time in HAVING clause
HAVING COUNT(first_name) < 200
    AND hire_date > '1999-01-01'
ORDER BY first_name DESC;

-- EXERCISE: WHERE vs HAVING - Part II
# ERROR
# SELECT list is not in GROUP BY clause and 
# contains nonaggregated column: 'dept_emp.from_date' 
# which is not functionally dependent on columns in GROUP BY clause; 
# this is incompatible with sql_mode=only_full_group_by 
SELECT 
    emp_no, from_date
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

# Fix
SELECT 
    emp_no
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;



--  LIMIT
######################################
SELECT 
    *
FROM
    salaries;

# How to find 10 highest paied employees    
SELECT 
    *
FROM
    salaries
ORDER BY salary DESC;

SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;




SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name
LIMIT 100;

-- EXERCISE: LIMIT
SELECT 
    *
FROM
    dept_emp
LIMIT 100;


# In SQL, the NULL value is never true in comparison to any other value
###################################### 
SELECT 
    *
FROM
    employees
WHERE
    first_name IS NULL;
    
    
SELECT 
    *
FROM
    employees
WHERE
    first_name =  '';  # Two single quotation
    