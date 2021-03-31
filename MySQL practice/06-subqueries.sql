##########################################################
##########################################################

-- SECTION: Subqueries

##########################################################
##########################################################    


--  Subqueries with IN nested inside WHERE
# Subqueries allow for better structuring
# The SQL engine starts by running the inner query
# Then it uses its return output, which is intermediate, to execute the outer query
######################################
USE employees;

# How to find first_name and last_name of all managers
SELECT 
    *
FROM
    dept_manager;
 # Select the first_name and last_name from "employees" table 
 # if that employee is in dept_manager
SELECT 
    e.first_name, 
    e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);

            
SELECT 
    dm.emp_no
FROM
    dept_manager dm;

    
-- EXERCISE: Subqueries with IN nested inside WHERE
# Extract the information about all department managers 
# who were hired between the 1st of January 1990 and the 1st of January 1995.

SELECT *
FROM employees e
WHERE e.hire_date BETWEEN '1990-01-01' AND '1995-01-01'
	AND e.emp_no IN(SELECT dm.emp_no
				FROM dept_manager dm);

SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');



--  Subqueries with EXISTS-NOT EXISTS nested inside WHERE
# EXISTS checks whether certain row values are found within a subquery
# It returns a boolean and check the nested query result row by row
# If it returns TRUE the corresponding record of the outher query is extracted
# If it returns FALSE the corresponding record of the outher query is NOT extracted
#
# EXISTS 
# Tests row values for existence
# Quicker in retrieving large amount of data
#
# IN
# Search amoung values
# Faster with smaller datasets
######################################
#  first_name, last_name from employee table of that employee exists in dept_manager
SELECT 
    e.first_name, 
    e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no);
       
    
    
    
    
    
-- add ORDER BY emp_no
######################################
# It is more professional to put ORDER BY in outher query
# Because it is more acceptable to sort the final version of dataset
# Compare two versions of below query
SELECT 
    e.first_name, 
    e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no
        ORDER BY emp_no);



# It is more professional to put ORDER BY in outher query
SELECT 
    e.first_name, 
    e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no)
ORDER BY emp_no;
######################################




# Some nested queries can be written using joins especially for inner queries using the WHERE clause
# Subquieries can be bad for performance compare to join but, professional use it because:
# 		1- Readability and better structure
# 		2- Easy to improve the process
# 		3- JOIN and UNION can be very complex



-- EXERCISE: Subqueries with IN nested inside WHERE
# Select the entire information for all employees whose job title is “Assistant Engineer”

DESCRIBE titles;
SELECT *
FROM employees e
WHERE e.emp_no IN(SELECT t.emp_no
				FROM titles t 
                WHERE title = 'Assistant Engineer');
SELECT *
FROM employees e
WHERE EXISTS(SELECT *
				FROM titles t 
                WHERE t.emp_no = e.emp_no
                AND t.title = 'Assistant Engineer');


SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.emp_no = e.emp_no
                AND title = 'Assistant Engineer');



--  Subqueries nested in SELECT and FROM
######################################
# How to assign two managers to two group of employees
# employee 110022 as manager for group of employees from 10001 to 10020, and 
# employee 110039 as manager for group of employees from 10021 to 10040


-- 1) How to select an employee with a specific emp_no as manager
SELECT 
    emp_no
FROM
    dept_manager
WHERE
    emp_no = 110022;

-- 2) Define the outputs we want
# The output we want:
#   |  employee_ID	|	dept_code	|	manager_ID  |
describe dept_emp;
describe dept_manager;
SELECT 
	# |  employee_ID  |
	# Select emp_no
    e.emp_no AS employee_ID,
    
    # |	dept_code    |
    # One employee can be associated with more than one departments that is why we choose to consider
    # the MIN dept_no as employee departments
    MIN(de.dept_no) AS department_code,
    # Use step 1 query as subquery to select the manager
    # This is our manager and we name the output as  manager_ID
    
    # |	manager_ID  | use previous step query
    (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            emp_no = 110022) AS manager_ID
            
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
WHERE
    e.emp_no <= 10020
GROUP BY e.emp_no
ORDER BY e.emp_no;


-- 3) 
SELECT 
	# Use previous step query as subset "a"
    # and select everything from it
    a.*
FROM
	######################################
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a;
    ######################################
    
    
-- 4) 
# Repeat the same process for other group and name it b
# UNION a and b
SELECT 
    b.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b;
    
SELECT 
    a.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a 
UNION SELECT 
    b.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b;
