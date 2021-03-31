##########################################################
##########################################################

-- SECTION: SQL Views

##########################################################
########################################################## 
USE employees;


--  Using SQL Views
# SQL View is a virtual table whos contents are obtained from an existing table or tables, called base table
# View doesn't contain any real data. Remember it is not real and we can't insert or delete data from it
# View doesn't use extra memory
# View save a lot of coding time
######################################
# dept_emp show employee departments so every time an employee change his department
# we will have a new row with same emp_no but different dept_no and date
# so we have a lot of emp_no duplication
SELECT 
    *
FROM
    dept_emp;


# Error Code 1055: GROUP BY is incompatible with sql_mode=only_full_group_by
# Depending on your operating system and version of MySQL, you will be working with different SQL settings.
#set @@global.sql_mode := replace(@@suglobal.sql_mode, 'ONLY_FULL_GROUP_BY', '');

# In order to view the current value:
# of this variable in your case, you have to execute the following command.
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


# Show the employees GROUP BY emp_no if it is more than 1
# it shows employees that worked in more than one department
SELECT 
    emp_no, 
    from_date, 
    to_date, 
    COUNT(emp_no) AS Num
FROM
    dept_emp
GROUP BY emp_no
HAVING Num > 1;

# How to create a VIEW that only shows the last duplicate emp_no from dept_emp table 
# Using "OR REPLACE" is optional. If an older view with the same name exists will replace it
CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no, 
        MAX(from_date) AS from_date, 
        MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;


# We can use a view as a vitrual table
SELECT 
    *
FROM
    v_dept_emp_latest_date;

        
-- The SELECT statement 
# This select statement is the content of our view
SELECT 
    emp_no, 
    MAX(from_date) AS from_date,
    MAX(to_date) AS to_date
FROM
    dept_emp
GROUP BY emp_no;





-- EXERCISE: Using SQL Views
# Create a view that will extract the average salary of all managers registered in the database. Round this value to the nearest cent.
# If you have worked correctly, after executing the view from the “Schemas” section in Workbench, you should obtain the value of 66924.27.

/*
# average salary for each manager
describe salaries;
CREATE OR REPLACE VIEW v_manager_avg_salaries AS
	SELECT emp_no, ROUND(AVG(salary), 2)
    FROM salaries
    WHERE emp_no IN(SELECT dept_manager.emp_no FROM dept_manager)
    GROUP BY emp_no;
select * from v_manager_avg_salaries;
*/

CREATE OR REPLACE VIEW v_manager_avg_salary AS
	SELECT ROUND(AVG(salary), 2)
    FROM salaries s 
		Join
        dept_manager dm
        ON s.emp_no = dm.emp_no;
select * from v_manager_avg_salary;


CREATE OR REPLACE VIEW v_manager_avg_salary AS
    SELECT 
        ROUND(AVG(salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager m ON s.emp_no = m.emp_no;