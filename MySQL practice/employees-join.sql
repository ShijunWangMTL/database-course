USE employees;

# preparing some sample tables for join
######################################
SELECT *
FROM departments
ORDER BY dept_no;

SELECT *
FROM departments_dup
ORDER BY dept_no;

/* # IF you currently HAVE 'departments_dup' set up:
ALTER TABLE departments_dup
DROP COLUMN dept_manager;
*/

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

SET SQL_SAFE_UPDATES=0;

DELETE FROM departments_dup
WHERE dept_no IN ('d010', 'd011', 'd012');

SELECT *
FROM departments_dup
ORDER BY dept_no;

# IF you DON'T currently HAVE 'departments_dup' set up
###########################################
DROP TABLE IF EXISTS departments_dup;
CREATE TABLE departments_dup
(
	dept_no CHAR(4) NULL,
    dept_name VARCHAR(40) NULL
);

INSERT INTO departments_dup
(
	dept_no,
    dept_name
) SELECT *
FROM departments;

# check if dept_name = Public Relations doesn't exist, insert it
# Pay attention Public Relation doesn't have dept_no
SELECT *
FROM departments_dup
ORDER BY dept_no;

INSERT INTO departments_dup (dept_name)
VALUES ('Public Relations');

/*
DELETE FROM departments_dup
WHERE dept_no IN ('d010', 'd011', 'd012');
*/

INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

# if delete dosen't work due to safe update mode
# SET SQL_SAFE_UPDATES=0;
DELETE FROM departments_dup
WHERE dept_no='d002';

SET SQL_SAFE_UPDATES=1;

# till now, departments_dup has 1 NULL value in dept_no for Public Relation, 2 NULL values in dept_name for d010, d011
# d002 does not exist
#################################

-- create dept_manager_dup
#  this is another table           dept_manager_dup
DROP TABLE IF EXISTS dept_manager_dup;
CREATE TABLE dept_manager_dup
(
	emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
);

SELECT * FROM dept_manager_dup;
SELECT * FROM dept_manager;

INSERT INTO dept_manager_dup
SELECT * FROM dept_manager;

# dept_manager_dup (emp_no, dept_no, from_date, to_date)
INSERT INTO dept_manager_dup
	(emp_no, from_date)
VALUES
	(999904, '2017-01-01'),
    (999905, '2017-01-01'),
    (999906, '2017-01-01'),
    (999907, '2017-01-01');

# CHANGE SAFE MODE FOR DELETE
SET SQL_SAFE_UPDATES = 0;
DELETE FROM dept_manager_dup
WHERE dept_no='d001';
SET SQL_SAFE_UPDATES = 1;

# check tables to join
SELECT * FROM dept_manager_dup;
SELECT * FROM departments_dup ORDER BY dept_no;

-- JOIN equals to INNER JOIN
####################
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m                        # define dept_manager_dup as m
INNER JOIN departments_dup d                   # define departments_dup as d
ON m.dept_no = d.dept_no                       
ORDER BY m.dept_no;
# dept_no d001. d002, d010, d011, NULL are not in the output 
# inner join extract only records in which the value in the related columns match 
# NULL values or values appearing in just one of the 2 tables and not appearing in the other, will not appear in the join result

SELECT * FROM dept_manager;
describe employees;
describe dept_manager;
# use inner join
SELECT e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM employees e
INNER JOIN dept_manager m
on e.emp_no = m.emp_no
ORDER BY m.dept_no;

# use join = inner join above
SELECT e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM employees e
JOIN dept_manager m
on e.emp_no = m.emp_no
ORDER BY m.dept_no;

SELECT m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM dept_manager_dup m 
JOIN departments_dup d 
ON d.dept_no = m.dept_no
ORDER BY m.dept_no;

SELECT m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM dept_manager_dup m 
JOIN departments_dup d 
ON d.dept_no = m.dept_no
ORDER BY d.dept_no;

-- create duplicate records in both tables
DESCRIBE dept_manager_dup;
INSERT INTO dept_manager_dup
VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');

describe departments_dup;
INSERT INTO departments_dup
VALUES ('d009', 'Customer Service');

SELECT * FROM dept_manager_dup ORDER BY dept_no ASC;

SELECT * FROM departments_dup ORDER BY dept_no ASC;

# how to go back to original setting
set @@global.sql_mode:=concat('ONLY_FULL_GROUP_BY,', @@global.sql_mode);
select @@global.sql_mode;

USE employees;

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
JOIN departments_dup d ON m.dept_no = d.dept_no
ORDER BY dept_no;

####################################
-- LEFT JOIN
# LEFT JOIN and RIGHT JOIN are perfect examples for one to many relation, like all customers and their orders
# prepare the tables for LEFT JOIN
-- remove duplicates created before
SET SQL_SAFE_UPDATES = 0;
DELETE FROM dept_manager_dup
WHERE emp_no='110228';

DELETE FROM departments_dup
WHERE dept_no='d009';
SET SQL_SAFE_UPDATES = 1;

SELECT * FROM dept_manager_dup ORDER BY emp_no;

-- add back the original records
INSERT INTO dept_manager_dup
VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');

SELECT * FROM departments_dup ORDER BY dept_no;
INSERT INTO departments_dup 
VALUES ('d009', 'Customer Service');

####################################
# INNER JOIN vs. LEFT JOIN
# INNER JOIN: only matching records that exist in both tables
# LEFT JOIN: all records from left table even if they don't have any matching record in the right table, plus matched records in right table
### matching records will be displayed depending on selectors... 
### (if ON condition is met, but selector's value is NULL, the record won't show)

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m         
JOIN departments_dup d     
ON m.dept_no = d.dept_no
# group by is imcompatible with sql_mode=only_full_group_by
ORDER BY m.dept_no;

-- m left join d
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m          # this is the LEFT table, all records will be output
LEFT JOIN departments_dup d      # right table which is gonna be extract, only matching records
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;    # different orders with m.dept_no and d.dept_no ???

-- d left join m
## switch the 2 tables besides LEFT JOIN(change the order)
SELECT m.dept_no, m.emp_no, d.dept_name
FROM  departments_dup d        # this is the LEFT table, all records will be output
LEFT JOIN  dept_manager_dup m      # right table which is gonna be extract, only matching records
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;  
## d010, d011 don't show, because m.dept_no was selected to show, but in m table, d010, d001 don't exist. 

-- d left join m
## select from d table for d.dept_no, d010, d011 will show
SELECT d.dept_no, m.dept_no, m.emp_no, d.dept_name
FROM  departments_dup d        # this is the LEFT table, all records will be output
LEFT JOIN  dept_manager_dup m      # right table which is gonna be extract, only matching records
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;  

-- -- m left join d
SELECT d.dept_no, m.emp_no, d.dept_name
FROM  dept_manager_dup m         # this is the LEFT table, all records will be output
LEFT JOIN  departments_dup d     # right table which is gonna be extract, only matching records
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;  

-- LEFT OUTER JOIN = LEFT JOIN
SELECT d.dept_no, m.emp_no, d.dept_name
FROM  departments_dup d        
LEFT OUTER JOIN  dept_manager_dup m    
ON m.dept_no = d.dept_no
ORDER BY m.dept_no; 

-- d left join m
SELECT m.dept_no, m.emp_no, d.dept_name
FROM  departments_dup d        # this is the LEFT table, all records will be output
LEFT JOIN  dept_manager_dup m      # right table which is gonna be extract, only matching records
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;  
## d010, d011 don't show, because m.dept_no was selected to show, but in m table, d010, d001 don't exist. 

# use where to find NULL values in the right (d) table
# 999904, 05, 06, 07, d002 in m table don't have any match in d table
-- m left join d
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m        
LEFT JOIN departments_dup d     
ON m.dept_no = d.dept_no
WHERE dept_name IS NULL
ORDER BY m.dept_no;  

describe dept_manager;

SELECT e.emp_no, e.first_name, e.last_name, m.dept_no, from_date
FROM employees e
LEFT JOIN dept_manager m
on e.emp_no = m.emp_no
WHERE e.last_name = 'Markovitch'
ORDER BY m.dept_no DESC, e.emp_no;

SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date
FROM employees e
LEFT JOIN dept_manager dm
on e.emp_no = dm.emp_no
WHERE e.hire_date < '1985-01-31'
ORDER BY e.emp_no;

-- RIGHT JOIN
-- m left join d
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m          # this is the LEFT table, all records will be output
LEFT JOIN departments_dup d      # right table which is gonna be extract, only matching records
ON m.dept_no = d.dept_no
ORDER BY m.dept_no; 

-- d right join m
SELECT m.dept_no, m.emp_no, d.dept_name
FROM departments_dup d       # this is the LEFT table, only matching records
RIGHT JOIN dept_manager_dup m     # right table which is gonna be extract, all records will be output
ON m.dept_no = d.dept_no
ORDER BY m.dept_no; 

### JOIN VS. WHERE
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m         
JOIN departments_dup d     
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

## Using WHERE is more time consuming vs. JOIN
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m, departments_dup d     
WHERE m.dept_no = d.dept_no
ORDER BY m.dept_no;

describe employees;

SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM employees e, dept_manager dm
WHERE e.emp_no = dm.emp_no
ORDER BY e.emp_no;

SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM employees e
JOIN dept_manager dm
ON e.emp_no = dm.emp_no
ORDER BY e.emp_no;

-- JOIN and WHERE used together
SELECT e.emp_no, e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
WHERE s.salary > 145000;

describe titles;
SELECT  e.first_name, e.last_name, e.hire_date, t.title 
FROM employees e
JOIN titles t
ON e.emp_no = t.emp_no
WHERE e.first_name = 'mARGARETA' AND e.last_name = 'Markovitch';

#########################################
-- CROSS JOIN
-- return a list with all possible combinations
-- table A has 10 rows, table B has 10 rows
-- cross join will make 10 * 10 = 100 rows

SELECT * FROM departments ORDER BY dept_no;
SELECT * FROM dept_manager;
SELECT dm.*, d.*
FROM dept_manager dm
CROSS JOIN departments d
ORDER BY dm.emp_no, d.dept_no;

## INNER JOIN without condition (on) = CROSS JOIN
SELECT * FROM dept_manager;
SELECT dm.*, d.*
FROM dept_manager dm
JOIN departments d
ORDER BY dm.emp_no, d.dept_no;