USE employees;

# To be sure below employees do not exist, because we ant to insert them in the next lines
DELETE FROM employees 
WHERE
    emp_no IN (999901, 999902, 999903);


SELECT 
    *
FROM
    employees
LIMIT 10;


SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

DESCRIBE employees;
INSERT INTO employees
(
	emp_no,
	birth_date,
	first_name,
	last_name,
	gender,
	hire_date
) VALUES 
(
	999901,
    '1986-04-21',
    'John',
    'Smith',
    'M',
    '2011-01-01'
);

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;



/*
# Remove one of the column and see the result
DESCRIBE employees;
INSERT INTO employees
(
	emp_no,
	birth_date,
	first_name,
	last_name,
	gender,
	hire_date
) VALUES 
(
	999904,
    '1941-09-09',
    'Dennis',
    'Ritchie ',
    'M',
    '1961-09-09'
);
DELETE FROM employees 
WHERE
    emp_no = 999904;
*/ 

--  The INSERT Statement
######################################
# The order of columns can be changed
# If we enter emp_no as a string like '999902' 
# MySQL transparently convert string to int, but it is not the best practice
# Moreover, you can remove some columns if NULL is acceptable for them
DESCRIBE employees;
INSERT INTO employees
(
	birth_date,
    emp_no,
	first_name,
	last_name,
	gender,
	hire_date
) VALUES 
(
	'1973-3-26',
    '999902',
    'Patricia',
    'Lawrence',
    'F',
    '2005-01-01'
);


# You can ignore the column names, but you have to provide data for "all columns" 
# in the "same order" with table's columns
DESCRIBE employees;
INSERT INTO employees
VALUES
(
	999903,
    '1977-09-14',
    'Johnathan',
    'Creek',
    'M',
    '1999-01-01'
);

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;





-- EXERCISE:
######################################
# Select ten records from the “titles” table to get a better idea about its content.
# Then, in the same table, insert information about employee number 999903. State that he/she is a “Senior Engineer”, who has started 
# working in this position on October 1st, 1997.
# At the end, sort the records from the “titles” table in descending order to check if you have successfully inserted the new record.
#
# Hint: To solve this exercise, you’ll need to insert data in only 3 columns!
#
# Don’t forget, we assume that, apart from the code related to the exercises, you always execute all code provided in the lectures. 
# This is particularly important for this exercise. 
# If you have not run the code from the previous lecture, called ‘The INSERT Statement – Part II’, 
# where you have to insert information about employee 999903, you might have trouble solving this exercise!
SELECT 
    *
FROM
    titles
LIMIT 10; 


DELETE FROM
    titles
WHERE
    emp_no = 999903;

insert into titles
(
	emp_no,
    title,
    from_date
)
values
(
	999903,
    'Senior Engineer',
    '1997-10-01'
);

 
SELECT
    *
FROM
    titles
ORDER BY emp_no DESC;
######################################











-- EXERCISE: 
# The INSERT Statement
#
# Insert information about the individual with employee number 999903 into the “dept_emp” table. 
# He/She is working for department number 5, and has started on October 1st, 1997; 
# her/his contract is for an indefinite period of time.
# 
# Hint: Use the date ‘9999-01-01’ to designate the contract is for an indefinite period
SELECT 
    *
FROM
    dept_emp
ORDER BY emp_no DESC
LIMIT 10;
 
 
 # Clean if it is necessary 
DELETE FROM
    dept_emp
WHERE
    emp_no = 999903;
 
 
SELECT 
    *
FROM
    dept_emp
WHERE
    emp_no = 999903;
 
 
 
INSERT INTO dept_emp
(
	emp_no,
    dept_no,
    from_date,
    to_date
)
VALUES
(
	999903,
    'd005',
    '1997-10-01',
    '9999-01-01'
);



SELECT 
    *
FROM
    dept_emp
WHERE
    emp_no = 999903;


# Clean if it is necessary 
DELETE FROM
    dept_emp
WHERE
    emp_no = 999903;






-- EXERCISE: 
# Inserting Data INTO a New Table
# Create a new department called “Business Analysis”. Register it under number ‘d010’.
# Hint: To solve this exercise, use the “departments” table.

DELETE FROM
    departments
WHERE dept_no = 'd010';

SELECT 
    *
FROM
    departments
ORDER BY dept_no;

INSERT INTO departments VALUES ('d010', 'Business Analysis');

SELECT 
    *
FROM
    departments
ORDER BY dept_no;








# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# CREATE A DUPLICATED VERSION OF departments TABLE
##########################################################
DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup (
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

SELECT 
    *
FROM
    departments_dup;

######################################
# COPY departments TO departments_dup
INSERT INTO departments_dup	 
(
    dept_no,
    dept_name
)
SELECT 
	*
FROM 
	departments;
######################################


SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;
##########################################################










##########################################################
##########################################################

-- SECTION: The SQL UPDATE Statement

##########################################################
##########################################################



--  The UPDATE Statement
######################################

/*
INSERT INTO employees
(
	emp_no,
	birth_date,
	first_name,
	last_name,
	gender,
	hire_date
) VALUES 
(
	999901,
    '1986-04-21',
    'John',
    'Smith',
    'M',
    '2011-01-01'
);
*/

USE employees;

SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999901;

UPDATE employees 
SET 
    first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE
    emp_no = 999901;

SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999901;
  
# 0 row(s) affected Rows matched 0
UPDATE employees 
SET 
    first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE
    emp_no = 999909;

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;



##########################################################
##########################################################

# VERY IMPORTANT
# Preferences>  SQL Editor> Safe Update: Must be disabled to see the effect of COMMIT command 
# VERY IMPORTANT: EXIT and LOGIN AGAIN
SET autocommit=0;
START TRANSACTION; 

##########################################################
##########################################################


COMMIT;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

# Error Code: 1175. You are using safe update mode and you tried to update a table  
# without a WHERE that uses a KEY column.
# To disable safe mode, toggle the option in Preferences.
# This means that you can't update or delete records without specifying a key (ex. primary key) in the where clause.

SET SQL_SAFE_UPDATES = 0;
#SET SQL_SAFE_UPDATES = 1;
######################################

# d010 Business Analysis
UPDATE departments_dup 
SET 
    dept_name = 'Quality Control'
WHERE
        dept_no = 'd010';

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

# ROLLBACK to previous commit
ROLLBACK;


SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;



# Mnually go back if it is necessary; COMMIT does not work
UPDATE departments_dup 
SET 
    dept_name = 'Business Analysis'
WHERE
    dept_no = 'd010';



-- UPDATE departments
-- SET 
--     dept_name = 'Quality Control'
-- WHERE
--     dept_no = 'd010';
    
    
SELECT 
    *
FROM
    departments
ORDER BY dept_no;

DESCRIBE departments;


-- EXERCISE: 
# Change the “Business Analysis” department name to “Data Analysis”.
#
# Hint: To solve this exercise, use the “departments” table.
    
COMMIT;


UPDATE departments 
SET 
    dept_name = 'Data Analysis'
WHERE
    dept_no = 'd010';


SELECT 
    *
FROM
    departments
ORDER BY dept_no;


ROLLBACK;


SELECT 
    *
FROM
    departments
ORDER BY dept_no;















##########################################################
##########################################################

-- SECTION: The SQL DELETE Statement

##########################################################
##########################################################



--  The DELETE Statement
######################################

USE employees;

COMMIT;

SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999901;


DELETE FROM employees 
WHERE
    emp_no = 999901;


SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999901;
######################################





######################################
# Show emp_no 999903 in two tables for demo delete cascade
SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999903;
  
  
# In title table
SELECT 
    *
FROM
    titles
WHERE
    emp_no = 999903;


# Demo delete cascade ################
DELETE FROM employees 
WHERE
    emp_no = 999903;


# Check both tables
SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999903;
    
SELECT 
    *
FROM
    titles
WHERE
    emp_no = 999903;
######################################
    

ROLLBACK;

SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999903;
    
SELECT 
    *
FROM
    titles
WHERE
    emp_no = 999903;
######################################


    

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

# Delete all
DELETE FROM departments_dup;


SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

ROLLBACK;


SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;


-- EXERCISE: The DELETE Statement
DELETE FROM departments 
WHERE
    dept_no = 'd010';


