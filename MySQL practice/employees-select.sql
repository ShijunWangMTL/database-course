# employees is database name
USE employees;

SELECT *
FROM employees;

SELECT first_name, last_name
FROM employees;

SELECT *
FROM departments;

SELECT dept_no
FROM departments;

SELECT *
FROM employees
WHERE first_name = 'Denis';

SELECT *
FROM employees
WHERE first_name = 'Elvis';

SELECT *
FROM employees
WHERE first_name='Denis' AND gender='M';

SELECT *
FROM employees
WHERE first_name='kellie' AND gender='F';

SELECT *
FROM employees
WHERE first_name='Denis' OR first_name='Elvis';

# first name is exactly two defined words
SELECT *
FROM employees
WHERE first_name='Denis' AND first_name='Elvis';

SELECT *
FROM employees
WHERE first_name='Kellie' OR first_name='Aruna';

-- Operator Precedence
########################################
# SQL will always start by reading the conditions around the AND operator
# last_name='denis' AND gender='M' OR gender='F';
# (last_name='denis' AND gender='M') OR gender='F';
# select all DENIS and all FEMALES
SELECT *
FROM employees
WHERE last_name='Denis' AND gender='M' OR gender='F';

SELECT *
FROM employees
WHERE last_name='Denis' AND gender='M' OR gender='F';

SELECT *
FROM employees
WHERE last_name='Denis' AND (gender='M' OR gender='F');

SELECT *
FROM employees
WHERE gender='F' AND (first_name='Kellie' OR first_name='Aruna');

SELECT *
FROM employees
WHERE first_name='cathie' OR first_name='mark' OR first_name='nathan';

SELECT *
FROM employees
WHERE first_name IN ('cathie', 'mark', 'nathan');

SELECT *
FROM employees
WHERE first_name NOT IN ('cathie', 'mark', 'nathan');

SELECT *
FROM employees
WHERE first_name IN ('Denis', 'Elvis');

SELECT *
FROM employees
WHERE first_name NOT IN ('John', 'Mark', 'Jacob');

-- LIKE
# % means any number of characters
SELECT *
FROM employees
WHERE first_name LIKE('Mar%');

SELECT *
FROM employees
WHERE first_name LIKE('ar%');

SELECT *
FROM employees
WHERE first_name LIKE('%ar');

SELECT *
FROM employees
WHERE first_name LIKE('%ar%');

# _ means only one character
SELECT *
FROM employees
WHERE first_name LIKE ('Mar_');

SELECT *
FROM employees
WHERE first_name LIKE ('_en');

SELECT *
FROM employees
WHERE first_name LIKE ('_m_');

SELECT *
FROM employees
WHERE first_name LIKE ('%jack%');

SELECT *
FROM employees
WHERE first_name LIKE ('%JACK%');

SELECT *
FROM employees
WHERE first_name NOT LIKE ('%JAC%');

SELECT *
FROM employees
WHERE first_name NOT LIKE ('%Mar%');

SELECT *
FROM employees
WHERE first_name NOT LIKE ('%Mark%');

SELECT *
FROM employees
WHERE hire_date LIKE ('%2000%');

SELECT *
FROM employees
WHERE hire_date LIKE ('2000%');

SELECT *
FROM employees
WHERE emp_no LIKE ('1000_');

SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT *
FROM employees
WHERE hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';

SELECT *
FROM salaries;

SELECT *
FROM salaries
WHERE salary BETWEEN 66000 AND 70000;

SELECT *
FROM employees
WHERE emp_no NOT BETWEEN '10004' AND '10012';

SELECT dept_no, dept_name
FROM departments;

SELECT dept_no, dept_name
FROM departments
WHERE dept_no BETWEEN 'd003' AND 'd006';

-- IS NOT NULL / IS NULL
SELECT *
FROM employees
WHERE first_name IS NOT NULL;

SELECT *
FROM employees
WHERE first_name IS NULL;

SELECT *
FROM departments
WHERE dept_no IS NOT NULL;

-- COMPARISON operators
SELECT *
FROM employees
WHERE first_name='Mark';

SELECT *
FROM employees
WHERE first_name <> 'Mark';

SELECT *
FROM employees
WHERE first_name!='Mark';

SELECT *
FROM employees
WHERE hire_date > '2000-01-01';

SELECT *
FROM employees
WHERE hire_date >= '2000-01-01';

SELECT *
FROM employees
WHERE hire_date < '1985-02-01';

SELECT *
FROM employees
WHERE hire_date <= '1985-02-01';

SELECT *
FROM employees
WHERE hire_date>='2000-01-01' AND gender = 'F';

SELECT *
FROM salaries
WHERE salary > 150000;

-- SELECT DISTINCT
# select all distinct, different values
SELECT gender
FROM employees;

SELECT DISTINCT gender
FROM employees;

SELECT DISTINCT hire_date
FROM employees;

-- introduction to aggregate functions
#################################################################################
SELECT *
FROM employees;

SELECT COUNT(emp_no)
FROM employees;

SELECT COUNT(first_name)
FROM employees;

SELECT COUNT(DISTINCT first_name)
FROM employees;

SELECT *
FROM salaries;

SELECT salary
FROM salaries;

SELECT salary
FROM salaries
WHERE salary > 100000;

SELECT COUNT(salary)
FROM salaries
WHERE salary >= 100000;

SELECT count(*)
FROM salaries 
WHERE salary >= 100000;

-- ORDER BY
###########################
SELECT *
FROM employees
ORDER BY first_name;

SELECT *
FROM employees
ORDER BY first_name ASC;

SELECT *
FROM employees
ORDER BY first_name DESC;

SELECT *
FROM employees
ORDER BY emp_no DESC;

SELECT *
FROM employees
ORDER BY emp_no ASC;

-- GROUP BY
############################################
SELECT first_name
FROM employees;

SELECT first_name
FROM employees
GROUP BY first_name;

SELECT DISTINCT first_name
FROM employees;

SELECT COUNT(first_name)
FROM employees;

SELECT COUNT(first_name)
FROM employees
GROUP BY first_name;

SELECT first_name, COUNT(first_name)
FROM employees
GROUP BY first_name;

SELECT first_name, COUNT(first_name)
FROM employees
GROUP BY first_name
ORDER BY first_name DESC;

-- AS aliases: to name the output column (eg: default: count(first_name) )
SELECT first_name, COUNT(first_name) AS names_count
FROM employees
GROUP BY first_name
ORDER BY first_name DESC;

SELECT salary, COUNT(salary) AS emps_with_same_salary
FROM salaries
WHERE salary > 80000
GROUP BY salary
ORDER BY salary;

-- HAVING vs. WHERE
###############################
# WHERE: use before re-organizing the output into groups
SELECT *
FROM employees
WHERE hire_date >= '2000-01-01';

# HAVING and WHERE generate same result here
SELECT *
FROM employees
HAVING hire_date >= '2000-01-01';

# WHERE cannot be used in below code, because aggregate function COUNT inside WHERE clause
SELECT first_name, COUNT(first_name) AS names_count
FROM employees
GROUP BY first_name
HAVING COUNT(first_name)>250
ORDER BY first_name;

DESCRIBE salaries;

Select salary, count(salary) AS emps_with_same_salary 
from employees 
Where salary > 80000
Order by salary;


SELECT * 
FROM salaries;
# 967,330

SELECT COUNT(emp_no)
FROM salaries;
# 967,330

# number of employees/emp_no
SELECT DISTINCT emp_no
FROM salaries;
# 101.796

# number of employees/emp_no
SELECT emp_no, AVG(salary)
FROM salaries
GROUP BY emp_no
ORDER BY emp_no;
# 101.796

SELECT emp_no, salary
FROM salaries
WHERE salary > 120000
GROUP BY emp_no
ORDER BY emp_no;
# 807 rows

SELECT emp_no, AVG(salary)
FROM salaries
WHERE salary > 120000
GROUP BY emp_no
ORDER BY emp_no;
# 807 rows

SELECT  emp_no, AVG(salary)
FROM salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;
# 101 rows

# Extract a list of all names that are encountered less than 200 times for people hired after 1st of January 1999.
# names that are encountered less than 200 times: AGRREGATE FUNCTION - HAVING
# people hired after 1st of January 1999: all rows - WHERE
SELECT first_name, COUNT(first_name) AS names_count
FROM employees
WHERE hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name;

# cannot use aggregated function and non-aggregated function at the same time in HAVING clause
SELECT first_name, COUNT(first_name) AS names_count
FROM employees
GROUP BY first_name
# ERROR
HAVING COUNT9first_name) < 200 AND hire_date > '1999-01-01'
ORDER BY first_name DESC;

# SELECT list is not in GROUP BY 
# contains non-aggregated column: 'dept_emp. from_date'
# which is not functionally dependent on columns in GROUP BY clause;
# this is incompatible with sql_mode=only_full——group_by
SELECT emp_no, from_date
FROM dept_emp
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;
# error code 1055.

# Fix
SELECT emp_no
FROM dept_emp
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

-- LIMIT
##############################
SELECT *
FROM salaries;

# how to find 10 highest paid employees
SELECT *
FROM salaries
ORDER BY salary DESC;

SELECT *
FROM salaries
ORDER BY salary DESC
LIMIT 10;

SELECT first_name, COUNT(first_name) AS names_count
FROM employees
WHERE hire_date>'1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name)<200
ORDER BY first_name
LIMIT 100;

SELECT *
FROM dept_emp
LIMIT 100;

# in SQL, NULL value is never true in comparison to any other value
##########################
SELECT *
FROM employees
WHERE first_name IS NULL;

SELECT *
FROM employees
WHERE first_name='';  # two single quotation