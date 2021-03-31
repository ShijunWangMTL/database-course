--  Using Aggregate Functions with Joins
######################################
# How to get Mail and Femail average salary
# USE OF AGGREGAT FUNNCTIONS MEANS OUTPUT MUST BE GROUPED BY THE FIELD OF INTEREST
#
# 1- We want something based on gender so we will GROUP BY gender
# 2- Show the filed of intereset in select statement which is gender and AVG(s.salary)
# 3- Where does these information come from
SELECT 
    e.gender, 
    AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s 
    ON e.emp_no = s.emp_no
GROUP BY gender;    


-- SELECT e.emp_no
# Below query shows an error. While we group the data to only two Mail and Femail groups, 
# we aske MySQL to add e.emp_no which can be thousands in output
# How it is possible when we have only two rows in the output
#
# Based on MySQL configuration we may see:
#
# Error Code: 1055. 
# Expression #1 of SELECT list is not in GROUP BY clause and contains 
# nonaggregated column which is not functionally dependent on 
# columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
SELECT 
	# e.emp_no must be removed from SELECT statement
    e.emp_no, 
    e.gender, 
    AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s 
    ON e.emp_no = s.emp_no
GROUP BY gender; 
######################################







--  Join more than One Table
######################################
# An example of joining 3 tables
# Table 1 and 2 join is based on emp_no
# Table 2 and 3 join is based on dept_no
# Be carefull sometimes all joining tables don't have the same column for join


######################################
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no;

# If we CHANGE the ORDER of INNER JOIN tables the RESULT will be the SAME as before
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    employees e ON m.emp_no = e.emp_no;
######################################







######################################
-- RIGHT JOIN - JOIN
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    departments d
        RIGHT JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    employees e ON m.emp_no = e.emp_no;



-- JOIN - RIGHT JOIN
# RIGHT JOIN with employees at the end means show all rows in our employees table
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        RIGHT JOIN
    employees e 
    ON m.emp_no = e.emp_no;
######################################










-- EXERCISE: Join more than Two Tables in SQL
# Select all managers’ first and last name, hire date, job title, start date, and department name.
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;



-- or, alternatively:
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
        AND m.from_date = t.from_date
ORDER BY e.emp_no;


 
######################################
######################################

--  Tips and Tricks for Joins

######################################
######################################
-- EXERCISE: 
# Obtain the names of all departments and 
# calculate the average salary paid 
# to the managers in each of them.
#
# GROUP BY d.dept_name is missing, so we just have one row in the output which is 
# one of the departmens in departments table and the average of all salaries

# Error Code: 1140. In aggregated query without GROUP BY, expression #1 of SELECT list contains 
# nonaggregated column 'employees.d.dept_name'; this is incompatible with sql_mode=only_full_group_by
SELECT 
    d.dept_name, 
    AVG(salary)
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no;
    
    

-- add GROUP BY d.dept_name
SELECT 
    d.dept_name, 
    AVG(salary)
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name;



-- add ORDER BY d.dept_no
SELECT 
    d.dept_name, 
    AVG(salary)
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY d.dept_no;

# Remove table's alias
-- GROUP BY dept_name
SELECT 
    d.dept_name, 
    AVG(salary)
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
# d.dept_name can be changed to dept_name. We do not need "  because in all joining tables 
# we only have one dept_name in departments 
GROUP BY dept_name
ORDER BY d.dept_no;


# How to change the AVG(salary) column name to average_salary
-- AVG(salary) AS average_salary 
-- Change GROUP BY dept_name to GROUP BY d.dept_name
SELECT 
    d.dept_name, 
    AVG(salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY d.dept_no;


# How to order the output by average salary
-- ORDER BY AVG(salary) DESC
# If we use an alias like "AS average_salary" for AVG(salary) it is more professional to use
# ORDER BY AVG(salary). This clause will give us Average salary of each department ordered descending
# Pay attention to two different version of ORDER BY
######################################
SELECT 
    d.dept_name, 
    AVG(salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY AVG(salary) DESC;



-- ORDER BY average_salary DESC
SELECT 
    d.dept_name, 
    AVG(salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY average_salary DESC;



-- add HAVING for department with average_salary > 60000
SELECT 
    d.dept_name, 
    AVG(salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY dept_name
HAVING average_salary > 60000
# the alias of AVG(salary) is used in ORDER BY
ORDER BY average_salary DESC;
######################################






-- EXERCISE: Tips and Tricks for Joins
# How many male and how many female managers do we have in the ‘employees’ database?
SELECT 
    e.gender, 
    COUNT(dm.emp_no)
FROM
    employees e
        JOIN
    dept_manager dm 
    ON e.emp_no = dm.emp_no
GROUP BY gender;





--  UNION vs UNION ALL
######################################
# Create employees_dup table for union demo
DROP TABLE IF EXISTS employees_dup;
CREATE TABLE employees_dup (
   emp_no int(11),
   birth_date date,
   first_name varchar(14),
   last_name varchar(16),
   gender enum('M','F'),
   hire_date date
  );
  
INSERT INTO employees_dup 
SELECT 
    e.*
FROM
    employees e
LIMIT 20;

-- Check
SELECT 
    *
FROM
    employees_dup;

# Create a duplicate row from the first row
INSERT INTO employees_dup VALUES
('10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');

-- Check
SELECT 
    *
FROM
    employees_dup
ORDER BY emp_no;
######################################






-- UNION ALL
# UNION ALL is used to combine a few SELECT statements in a single output
#
# If we want to run UNION ALL in two tables we have to select 
# The same number of columns from each table,
# These columns should have 
# the same name, 
# be in the same order
# contain related data type 
#
# UNION ALL RETRIEVES the DUPLICATES as well
# UNION only displaysthe the DISTINCT values in the output and use more computational power
#
# For two tables with different number of columns 
# we will add some NULL columns in each table correspondent to missing column compare to other table
# It is like attaching and merging two tables
# Below example shows merging employees_dup table and dept_manager table
######################################


DESCRIBE employees_dup;
DESCRIBE dept_manager;

# UNION ALL will show the duplicate records
SELECT 
	# List of columns from 2 tables
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION ALL 
SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;
   
   
# UNION will not show the duplicate records
-- UNION
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION 
SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;



-- EXERCISE: UNION vs UNION ALL
# What do you think is the meaning of the minus sign before subset A in the last row (ORDER BY -a.emp_no DESC)? 
SELECT 
    *
FROM
    (SELECT 
            e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' 
        UNION 
        SELECT 
            NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) a
ORDER BY -a.emp_no DESC;