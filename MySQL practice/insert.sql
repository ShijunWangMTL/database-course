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