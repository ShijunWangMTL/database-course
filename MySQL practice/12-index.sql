# Index: Data is teaken from a column of a table and is stored in a certain order in a distinct place, called an index.
# Composite indexes can be aplied to multiple columns, not just a single one.
# Developers should carefully pick the colums that would optimize their search.

# Small dataset: The cost of having an index might be higher than the benefits
# Large datasets: A well-optimised index can make a positive impact on the search process

--  MySQL Indexes
DROP INDEX i_hire_date ON employees;


SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';


CREATE INDEX i_hire_date ON employees(hire_date);


SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';
    
-- Composite Indexes
DROP INDEX i_composite ON employees;


SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Georgi'
        AND last_name = 'Facello';
        
        
CREATE INDEX i_composite ON employees(first_name, last_name);
    
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Georgi'
        AND last_name = 'Facello';

-- SHOW INDEX
# First employees is table name and the second one is database name
SHOW INDEX FROM employees FROM employees;
SHOW INDEX FROM employees;

-- EXERCISE: MySQL Indexes
# Drop the ‘i_hire_date’ index
ALTER TABLE employees
DROP INDEX i_hire_date;

-- EXERCISE: MySQL Indexes
# Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.
# Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement.
SELECT 
    *
FROM
    salaries
WHERE
    salary > 89000;

CREATE INDEX i_salary ON salaries(salary);

SELECT 
    *
FROM
    salaries
WHERE
    salary > 89000;