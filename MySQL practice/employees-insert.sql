-- DELETE, INSERT INTO,

USE employees;
DESCRIBE employees;

# to be sure below employees do not exist, because we ant to insert them in the next lines
DELETE FROM employees
WHERE emp_no IN(999901, 999902, 999903);

SELECT *
FROM employees
LIMIT 10;

SELECT *
FROM employees
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

# if we enter emo_no as a string like '999902',
# MySQL transparently covert string to int, but not the best practice
# you can remove some colomns if NULL is acceptable for them
# can change the order of the colomns when inserting
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
    '1973-3-21',
	'999902',
    'Patricia',
    'Lawrence',
    'F',
    '2005-01-01'
);

# you can ignore the column names, but you have to provide data for all columns
# in the same order with table's columns
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

SELECT *
FROM employees
ORDER BY emp_no DESC
LIMIT 10;

#################################
DESCRIBE titles;

SELECT *
FROM titles
LIMIT 10;

DELETE FROM titles
WHERE emp_no = 999903;

INSERT INTO titles
(
	emp_no,
    title,
    from_date,
    to_date
)VALUES
(
	999903,
    'Senior Engineer',
    '1997-10-01',
    '9999-01-01'
);

SELECT *
FROM titles
ORDER BY emp_no DESC
LIMIT 10;

USE departments;
DESCRIBE departments;

DELETE FROM departments
WHERE dept_no='d010';

SELECT *
FROM departments
ORDER BY dept_no;

INSERT INTO departments
VALUES
(
	'd010',
    'Business Analysis'
);

SELECT *
FROM departments
ORDER BY dept_no;

###################################
DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup (
	dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

SELECT *
FROM departments_dup;

######################################
# COPY departments TO departments_dup
INSERT INTO departments_dup
(
	dept_no,
    dept_name
)
SELECT *
FROM departments;
########################################

SELECT *
FROM departments_dup
ORDER BY dept_no;

USE employees;

SELECT *
FROM employees
WHERE emp_no=999901;

UPDATE employees
SET
	first_name='Stella',
    last_name='Parkinson',
    birth_date='1990-12-31',
    gender='F'
WHERE emp_no=999901;

# no data updated! 0 matched
UPDATE employees
SET
	first_name='Stella',
    last_name='Parkinson',
    birth_date='1990-12-31',
    gender='F'
WHERE emp_no=999909;

SELECT *
FROM employees
ORDER BY emp_no DESC
LIMIT 10;

################################################
################################################
# very important
# Preferences > SQL Editor > Safe update: must be disabled to see the effect of COMMIT command
# important: exit and login again
SET autocommit=0;
START TRANSACTION;
################################################
################################################

COMMIT;

SELECT *
FROM departments_dup
ORDER BY dept_no;

# ERROR code : 1175. You are using safe update mode and you tried to update a table
# without a WHERE that uses a KEY column,
# to disable safe mode, toggle the option in Preferences,
# This means that you cannot update or delete records without specifying a key(ex. primary key) in the WHERE clause.

SET SQL_SAFE_UPDATES=0;
#SET SQL_SAFE_UPDATES=1;
################################################

# d010 business analysis
UPDATE departments_dup
SET dept_name='Quality Control'
WHERE dept_no='d010';

SELECT *
FROM departments_dup
ORDER BY dept_no;

# ROLLBACK to previous commit
ROLLBACK;

SELECT *
FROM departments_dup
ORDER BY dept_no;

DESCRIBE departments;

UPDATE departments
SET dept_name='Data Analysis'
WHERE dept_no='d010';

SELECT *
FROM departments
ORDER BY dept_no DESC;

ROLLBACK;

SELECT *
FROM departments
ORDER BY dept_no DESC;

-- DELETE
#######################################
USE employees;

COMMIT;

SELECT *
FROM employees
WHERE emp_no=999901;

DELETE FROM employees
WHERE emp_no=999901;

SELECT *
FROM employees
WHERE emp_no=999901;

##############################################
# show emp_no 999903 in two tables for demo delete cascade
SELECT * 
FROM employees
WHERE emp_no=999903;

# in title table
SELECT *
FROM titles
WHERE emp_no=999903;

# delete cascade #############
DELETE FROM employees
WHERE emp_no=999903;

# check both tables
SELECT * 
FROM employees
WHERE emp_no=999903;

SELECT *
FROM titles
WHERE emp_no=999903;

ROLLBACK;

# check both tables
SELECT * 
FROM employees
WHERE emp_no=999903;

SELECT *
FROM titles
WHERE emp_no=999903;

SELECT *
FROM departments_dup
ORDER BY dept_no;

# delete all
DELETE FROM departments_dup;

SELECT *
FROM departments_dup
ORDER BY dept_no;

ROLLBACK;

SELECT *
FROM departments_dup
ORDER BY dept_no;

