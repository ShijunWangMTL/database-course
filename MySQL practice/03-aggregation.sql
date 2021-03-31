##########################################################
##########################################################

-- SECTION: MySQL Aggregate Functions

##########################################################
##########################################################


--  COUNT()
######################################
SELECT 
    *
FROM
    salaries
ORDER BY salary DESC;

SELECT 
    COUNT(salary)
FROM
    salaries;

SELECT 
    COUNT(from_date)
FROM
    salaries;

SELECT 
    COUNT(DISTINCT from_date)
FROM
    salaries;
    
SELECT 
    COUNT(*)
FROM
    salaries;
    
-- EXERCISE 1: COUNT()
# How many departments are there in the “employees” database? 
# Use the ‘dept_emp’ table to answer the question.
SELECT 
    COUNT(DISTINCT dept_no)
FROM
    dept_emp;



--  SUM()
######################################

SELECT 
    SUM(salary)
FROM
    salaries;
    
/*
SELECT 
    SUM(*)
FROM
    salaries;
*/
-- SUM() - exercise  
# What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997?
SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';



--  MIN() and MAX()
SELECT 
    MAX(salary)
FROM
    salaries;

SELECT 
    MIN(salary)
FROM
    salaries;
    
-- EXERCISE 1: MIN()
# Which is the lowest employee number in the database?  
SELECT 
    MIN(emp_no)
FROM
    employees;

-- EXERCISE 2: MAX()
# Which is the highest employee number in the database?
SELECT 
    MAX(emp_no)
FROM
    employees;



--  AVG()
######################################

SELECT 
    AVG(salary)
FROM
    salaries;

-- EXERCISE 1: AVG()
# What is the average annual salary paid to employees who started after the 1st of January 1997?
SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';



--  ROUND()
  #####################################
SELECT 
    ROUND(AVG(salary))
FROM
    salaries;

# How to define the number of digits after the decimal point
SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries;
    
-- EXERCISE 1: ROUND()
# Round the average amount of money spent on salaries for all contracts that 
# started after the 1st of January 1997 to a precision of cents.
SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries
WHERE
    from_date > '1997-01-01'; 
    


--  COALESCE() - Preamble
######################################
# COALESCE is more adavanced version of IFNULL 
# It can replace a NULL with number of options; first with col1 and if it was NULL then with col2 and if it was NULL col3
# Look at step 7

# CREATE A DUPLICATED VERSION OF departments TABLE
######################################
# 1- dept_name is NOT NULL
DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup (
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

SELECT 
    *
FROM
    departments_dup;

# COPY departments TO departments_dup
######################################
INSERT INTO departments_dup
(
    dept_no,
    dept_name
)
SELECT 
	*
FROM 
	departments;


SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;
######################################





######################################
# 2- Alter table to allow dept_name  to be NULL
ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;
 
 # 3- Insert two new dept_no without dept_name which is going to be NULL
INSERT INTO departments_dup(dept_no) VALUES ('d011'), ('d012');

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no ASC; 

# 4- ADD A COLUMN to  departments_dup
# PAY ATTENTION can't be run more than one time. 
# This new column will have some NULL values
ALTER TABLE employees.departments_dup 
ADD COLUMN dept_manager VARCHAR(255) NULL AFTER dept_name;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

COMMIT;



--  IFNULL() and COALESCE()
# How to replace all NULL in dept_name column with "Department name not provided" by using IFNULL function
# The problem with below query is the column name which will be: 
# IFNULL(dept_name,
SELECT 
	# IF dept_name IS NULL assign 'Department name not provided' to it
    # So d011 and d012 will have new values
    dept_no,
    IFNULL(dept_name, 'Department name not provided')
FROM 
    departments_dup;


# How to change the column name when we are using IFNULL function
SELECT 
    dept_no,
    IFNULL(dept_name, 'Department name not provided') AS dept_name
FROM
    departments_dup;

# 5- COALESCE is more adavanced version of IFNULL 
# It can replace a NULL value from number of different columns with pre defined values
SELECT 
    dept_no,
    COALESCE(dept_name, 'Department name not provided') AS dept_name
FROM
    departments_dup;

# 6- PAY ATTENTION IT IS ONLY FOR PRESENTATION
# AS CAN BE SEEN THE ORIGINAL TABLE IS NOT CHANGED AND 
# d011, d012 ARE STILL NULL
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;


# 7- If dept_manager is NULL replace it with dept_name and 
# when you want to replace dept_manager with dept_name, if dept_name was NULL replace dept_name with 'N/A'
SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_manager, dept_name, 'N/A') AS dept_manager
FROM
    departments_dup
ORDER BY dept_no ASC; 

ROLLBACK;



# How to create a new column (fake column) with the value "deparment manager name"
# Pay attention in the COALESCE method we just have one value
# That is how a new column will be created
SELECT 
    dept_no,
    dept_name,
    COALESCE('deparment manager name') AS fake_col
FROM
    departments_dup;
    
/*
SELECT 
    dept_no,
    dept_name,
    IFNULL('deparment manager name') AS fake_col
FROM
    departments_dup;
*/
