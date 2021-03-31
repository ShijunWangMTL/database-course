USE employees;

# PREPARING SOME SAMPLE TABLES FOR JOIN
######################################
SELECT 
    *
FROM
    departments
ORDER BY dept_no;
    
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

# IF you currently HAVE ‘departments_dup’ set up:
ALTER TABLE departments_dup
DROP COLUMN dept_manager;

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

DELETE FROM departments_dup
WHERE dept_no IN ('d010', 'd011', 'd012');

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;








# IF you DON’T currently HAVE ‘departments_dup’ set up
######################################
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
)SELECT 
	*
FROM 
	departments;

# Check if dept_name = Public Relations doesn't exist, insert it
# Pay attention Public Relation doesn't have dept_no
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;


INSERT INTO departments_dup (dept_name) 
VALUES 	('Public Relations');

DELETE FROM departments_dup
WHERE dept_no IN ('d010', 'd011', 'd012');

INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

# Delete doesn't work due to safe update mode
SET SQL_SAFE_UPDATES = 0;
DELETE FROM departments_dup 
WHERE
    dept_no = 'd002';  
SET SQL_SAFE_UPDATES = 1;


-- departments_dup
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;
# At the end in departments_dup we have 
# One NULL value in dept_no for: Public Relation
# Two NULL values in dept_nam for: d010, d011
# Moreover, d002 does not exist
######################################






-- CREATE dept_manager_dup 
# PAY ATTENTION THIS IS AN OTHER TABLE            dept_manager_dup 
######################################
DROP TABLE IF EXISTS dept_manager_dup;
CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
  );
SELECT * FROM dept_manager_dup;
SELECT * FROM dept_manager;


INSERT INTO dept_manager_dup
SELECT * FROM dept_manager;

SELECT * FROM dept_manager_dup;

# dept_manager_dup (emp_no, dept_no, from_date, to_date)
INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES  (999904, '2017-01-01'),
		(999905, '2017-01-01'),
        (999906, '2017-01-01'),
       	(999907, '2017-01-01');

SELECT * FROM dept_manager_dup;

# Delete doesn't work due to safe update mode
SET SQL_SAFE_UPDATES = 0;
DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001'; 
SET SQL_SAFE_UPDATES = 1;


-- dept_manager_dup
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no;
######################################
    
   
--  Final Result for Join lecture
######################################   
-- departments_dup
# d002 does not exist
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;    


-- dept_manager_dup
# d001 does not exist
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no;
######################################


##########################################################
##########################################################

-- SECTION: SQL Joins

##########################################################
##########################################################




--  INNER JOIN
######################################
SELECT 
    *
FROM
    dept_manager_dup;
    
    
    
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;


# PAY ATTENTION TO ALIAS NAMES AFTER TABLE NAMES 'm' and 'd': 
# FROM  dept_manager_dup m
# INNER JOIN departments_dup d 
#
# dept_manager_dup		                                          dept_no d001, d010, d011  NOT EXISTS
# (emp_no, dept_no, from_date, to_date)				  emp_no 999904 ,5, 6, 7   -->  dept_no 	 	IS NULL
#
# departments_dup                       			          		  dept_no d010, d011   	   -->  dept_name IS NULL , d002 NOT EXISTS
# (dept_no, dept_name) 

SELECT 
    m.dept_no, m.emp_no, 
    d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d 
        ON m.dept_no = d.dept_no
ORDER BY m.dept_no;
# dept_no d001, d002, d0010, d0011, NULL are not in the output because
# Inner joins extract only records in which the value in the related columns match
# NULL values, OR values appearing in just one of the two tables and not appearing in the other, 
# will NOT appear in the join result



-- EXERCISE: INNER JOIN
# Show all managers (employees who are manager)’ 
# employee number, first and last name, department number, and hire date. 
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM
    employees e
        INNER JOIN
    dept_manager dm ON e.emp_no = dm.emp_no;



-- add m.to_date and d.dept_name
# JOIN is equal with INNER JOIN
######################################
SELECT 
    m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM
    dept_manager_dup m
		INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- JOIN
SELECT 
    m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM
    dept_manager_dup m
		JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;
######################################




# ORDER BY 
######################################
-- d.dept_no = m.dept_no
# ORDER BY dept_no from dept_manager_dup
SELECT 
    m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM
    dept_manager_dup m
		JOIN
    departments_dup d ON d.dept_no = m.dept_no
ORDER BY m.dept_no;

-- ORDER BY d.dept_no
# ORDER BY dept_no from departments_dup
SELECT 
    m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM
    dept_manager_dup m
		JOIN
    departments_dup d ON d.dept_no = m.dept_no
ORDER BY d.dept_no;

-- ORDER BY dept_no
# ORDER BY dept_no without mentioning table name
SELECT 
    m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM
    dept_manager_dup m
		JOIN
    departments_dup d ON d.dept_no = m.dept_no
ORDER BY dept_no;
######################################





--  Duplicate Records
######################################
# In new, raw and uncontrolled data we may have duplicate records
-- Creat DUPLICATE records in both tables
DESCRIBE dept_manager_dup ;
INSERT INTO dept_manager_dup 
VALUES 	('110228', 'd003', '1992-03-21', '9999-01-01');

DESCRIBE departments_dup;        
INSERT INTO departments_dup 
VALUES	('d009', 'Customer Service');

-- dept_manager_dup
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no ASC;

-- departments_dup
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no ASC;
######################################




# Run the same join while we added some duplicates
SELECT 
    m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM
    dept_manager_dup m
		JOIN
    departments_dup d ON d.dept_no = m.dept_no
ORDER BY dept_no;
# Instead of 20 rows we will have 25 in the result





# How to remove duplicate records from the OUTPUT
######################################
# Grouped by the field that differs most among records in our case this will be the employee number column.
# This will stack all rows that have the same employee number. 
# This will return the initial output with no duplicate which is 20 rows.
#
# Error Code 1055: GROUP BY is incompatible with sql_mode=only_full_group_by
# Depending on your operating system and version of MySQL, you will be working with different SQL settings.
#set @@global.sql_mode := replace(@@suglobal.sql_mode, 'ONLY_FULL_GROUP_BY', '');

USE employees;
# In order to view the current value of this variable in your case, you have to execute the following command.
select @@global.sql_mode;

# REPLACE() is the function that will remove the “only_full_group_by” value from the expression here. 
# Thus, error 1055 will not show up in the future.
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');
# OR
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
select @@global.sql_mode;
# AFTER CHANGING GLOBAL VARIABLES YOU MUST       EXIT        THE WORKBENCH AND LOGIN AGAIN



# How to go back to original setting
set @@global.sql_mode := concat('ONLY_FULL_GROUP_BY,', @@global.sql_mode);
select @@global.sql_mode;

USE employees;

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY dept_no;
# Again we will have 20 rows in output










######################################
######################################

--  LEFT JOIN
# LEFT JOIN and RIGHT JOIN are perfect examples for one to many relation
# Like all customers and their orders

######################################
######################################


# Prepare the tables for Left Join
######################################
-- remove the duplicates we created from the two tables
SET SQL_SAFE_UPDATES = 0;
DELETE FROM dept_manager_dup 
WHERE emp_no = '110228';
        
DELETE FROM departments_dup 
WHERE dept_no = 'd009';
SET SQL_SAFE_UPDATES = 1;


SELECT 
    *
FROM
    dept_manager_dup;

-- add back the original records
# Because we removed all emp_no = '110228'
INSERT INTO dept_manager_dup 
VALUES 	('110228', 'd003', '1992-03-21', '9999-01-01');

SELECT 
    *
FROM
    dept_manager_dup
ORDER BY emp_no;
    
    
    
    
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;
 
 # Because we removed all dept_no = 'd009'
INSERT INTO departments_dup 
VALUES	('d009', 'Customer Service');

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;
######################################




######################################
# INNER JOIN vs LEFT JOIN
# INNER JOIN: 
# Only matching records that exist in both tables
#
# LEFT JOIN: 
# All records from left table even if they do not have any matching record in the right table 
# plus matched records in the right table

SELECT 
    m.dept_no, 
    m.emp_no, 
    d.dept_name
FROM
    dept_manager_dup m
        JOIN
    departments_dup d ON m.dept_no = d.dept_no
# GROUP BY is incompatible with sql_mode=only_full_group_by
GROUP BY m.emp_no
ORDER BY m.dept_no;



-- left join
# dept_manager_dup will be considered as LEFT table and it has 26 rows
SELECT 
    m.dept_no, 
    m.emp_no, 
    d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
# GROUP BY is incompatible with sql_mode=only_full_group_by
GROUP BY m.emp_no
ORDER BY m.dept_no;
# Although we do not have any record for 999904, 5, 6, 7 from dept_manager_dup in departments_dup
# Also we do not have any for d002 from dept_manager_dup in departments_dup
# basically 999904, 5, 6, 7 do not have any dept_no to be appear in departments_sup
# we still see all of these records in the output because they belong to the left table

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;