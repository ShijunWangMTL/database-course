-- MySQL Aggregate Functions

-- COUNT()
#########################################
SELECT *
FROM salaries
ORDER BY salary DESC;

SELECT COUNT(salary)
FROM salaries;

SELECT COUNT(from_date)
FROM salaries;

SELECT COUNT(DISTINCT from_date)
FROM salaries;

SELECT COUNT(*)
FROM salaries;

DESCRIBE dept_emp;
SELECT COUNT(DISTINCT dept_no)
FROM dept_emp;

-- SUM()
#########################################
SELECT SUM(salary)
FROM salaries;

/*
SELECT SUM(*)
FROM SALARIES;
*/

describe salaries;
SELECT * FROM salaries;
SELECT SUM(salary)
FROM salaries
WHERE from_date > '1997-01-01';

-- MIN() MAX()
SELECT MAX(salary)
FROM salaries;

SELECT MIN(salary)
FROM salaries;

SELECT MAX(emp_no)
FROM employees;

SELECT MIN(emp_no)
FROM employees;

-- AVG()
SELECT AVG(salary)
FROM salaries;

describe salaries;
SELECT AVG(salary)
FROM salaries
WHERE from_date > '1997-01-01';

-- ROUND()
SELECT ROUND(AVG(salary))
FROM salaries;

SELECT ROUND(AVG(salary), 2)
FROM salaries;

SELECT ROUND(AVG(salary), 2)
FROM salaries
WHERE from_date > '1997-01-01';

-- COALESCE() - preamle
###########################################
# COALESCE is more advanced version of 
#
#
#
DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup (
     dept_no CHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL
 );

SELECT *
FROM departments_dup;

# copy a table
INSERT INTO departments_dup
(
	dept_no,
    dept_name
)
SELECT *
FROM departments;

SELECT *
FROM departments_dup
ORDER BY dept_no;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

INSERT INTO departments_dup(dept_no) 
VALUES('D011'), ('D012');

SELECT *
FROM departments_dup
ORDER BY dept_no ASC;

ALTER TABLE employees.departments_dup
ADD COLUMN dept_manager VARCHAR(255) NULL AFTER dept_name;

SELECT *
FROM departments_dup
ORDER BY dept_no;

COMMIT;

-- IFNULL() and COALESCE()
# how to replace all NULL in dept_name column with 
#
#
#
SELECT dept_no, IFNULL(dept_name, 'Department name not provided')
FROM departments_dup;

SELECT *
FROM departments_dup
ORDER BY dept_no;

# below two blocks of lines display same results, IFNULL vs. COALESCE
SELECT dept_no, IFNULL(dept_name, 'Department name not provided') AS dept_name
FROM departments_dup;

SELECT dept_no, coalesce(dept_name, 'Department name not provided') AS dept_name
FROM departments_dup;

SELECT dept_no, coalesce(dept_name, 'Department name not provided') AS dept_name, dept_manager
FROM departments_dup;

-- 7 
SELECT dept_no, dept_name, COALESCE(dept_manager, dept_name, 'N/A') AS dept_manager  ## AS can be omitted
FROM departments_dup
ORDER BY dept_no ASC;

ROLLBACK;

select * from departments_dup;

SELECT dept_no, dept_name, COALESCE('department manager name') AS fake_col
FROM departments_dup;
