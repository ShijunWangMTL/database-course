--  MySQL Triggers

# MySQL trigger is a type of stored program, associated with a table, 
# that will be automatically called once a specific event like NSERT, UPDATE, 
# or DELETE related to the table of association occurs.

# You can use a “before”, or an “after” trigger.

COMMIT;

# Pay attention to IF structure. It starts with an IF and ends with END IF.
# We have a boolean statement and THEN keyword
# NEW.salary is a reference to the new value your user wants to insert or update
/*
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF;
*/

DROP TRIGGER IF EXISTS before_salaries_insert;

# BEFORE INSERT
DELIMITER $$
CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN 
    IF NEW.salary < 0 THEN 
        SET NEW.salary = 0; 
    END IF; 
END $$
DELIMITER ;


# Let’s check the values of the “Salaries” table for employee 10001.
SELECT
    *
FROM
    salaries
WHERE
    emp_no = '10001';

# Now, let’s insert a new entry for employee 10001, whose salary will be a negative number.
DELETE FROM salaries WHERE emp_no = '10001';

INSERT INTO salaries VALUES ('10001', -92891, '2010-06-22', '9999-01-01');

# Let’s run the same SELECT query to see whether the newly created record has a salary of 0 dollars per year.
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';






# OLD.salary is a reference to old value in the table
DROP TRIGGER IF EXISTS trig_upd_salary;

# BEFORE UPDATE
DELIMITER $$
CREATE TRIGGER trig_upd_salary
BEFORE UPDATE ON salaries
FOR EACH ROW
BEGIN 
    IF NEW.salary < 0 THEN 
        SET NEW.salary = OLD.salary; 
    END IF; 
END $$
DELIMITER ;






######################################
UPDATE salaries 
SET 
    salary = 98765
WHERE
    emp_no = '10001'
    AND from_date = '2010-06-22';


SELECT
    *
FROM
    salaries
WHERE
    emp_no = '10001'
    AND from_date = '2010-06-22';


# modify the salary earned by 10001 with a negative value, minus 50,000.
UPDATE salaries 
SET 
    salary = - 50000
WHERE
    emp_no = '10001'
    AND from_date = '2010-06-22';


# Check if the salary value was adjusted.
SELECT
    *
FROM
    salaries
WHERE
    emp_no = '10001'
    AND from_date = '2010-06-22';
######################################        




# Exercise
# Create a trigger that checks if the hire date of an employee is higher than the current date. 
#If true, set this date to be the current date. Format the output appropriately (YY-MM-DD).
DROP TRIGGER IF EXISTS trig_hire_date;

DELIMITER $$
CREATE TRIGGER trig_hire_date  
BEFORE INSERT ON employees
FOR EACH ROW  
BEGIN  
                IF NEW.hire_date > date_format(sysdate(), '%Y-%m-%d') THEN     
                                SET NEW.hire_date = date_format(sysdate(), '%Y-%m-%d');     
                END IF;  
END $$  
DELIMITER ;  
  
DELETE FROM employees WHERE emp_no = '999904';
INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');  

SELECT  
    *  
FROM  
    employees
ORDER BY emp_no DESC;

# “Date Format”, assigns a specific format to a date.
SELECT DATE_FORMAT(SYSDATE(), '%y-%m-%d') as today;

ROLLBACK;