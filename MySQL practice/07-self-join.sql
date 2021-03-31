##########################################################
##########################################################

-- SECTION: SQL Self Join

##########################################################
########################################################## 


--  Self Join
######################################
# If you want to combine certain rows of a table with other rows of the same table
# you need a self-join

#  All columns from emp_manager. This table shows different emp_no under 
# supervision of different manager_no
SELECT 
   *
FROM
    emp_manager
ORDER BY emp_no;




# All columns from e1 
SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 
    ON e1.emp_no = e2.manager_no;
    
    
    
# All columns from e2
SELECT 
    e2.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 
    ON e1.emp_no = e2.manager_no;
    
    

    
# All columns from e1 
SELECT DISTINCT
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 
    ON e1.emp_no = e2.manager_no;
  
  
  
  
# All columns from e2 
SELECT DISTINCT
    e2.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 
    ON e1.emp_no = e2.manager_no;




# Value in emp_no column repeated to manager_no column 
# because one employee may have several managing position
# Pay attention to changing output table in select statement
# here is from e2 and in the next one it is from e1    
#  All columns from e1 which is emp_manager
SELECT 
    e1.emp_no,
    e2.manager_no
FROM
	# Join a table with itself so all column will be in inner join
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;




SELECT 
    e2.emp_no,
    e1.manager_no
FROM
	# Join a table with itself so all column will be in inner join
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;




# From emp_manager find employees who are manager
SELECT DISTINCT
    e1.emp_no,
    e1.dept_no,
    e2.manager_no
FROM
	# Join a table with itself so all column will be in inner join
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
    


-- SELECT e1.emp_no, e1.dept_no, e2.manager_no
SELECT DISTINCT
    e1.emp_no, 
    e1.dept_no, 
    e2.manager_no
FROM
    emp_manager e1
        JOIN
    emp_manager e2 
    
    ON e1.emp_no = e2.manager_no;
    

    

 # From emp_manager find employees who are manager with different manager_no
SELECT 
    e1.emp_no, 
    e1.dept_no, 
    e2.manager_no
FROM
    emp_manager e1
        JOIN
    emp_manager e2 
    
    ON e1.emp_no = e2.manager_no
WHERE
    e2.emp_no IN (SELECT 
            manager_no
        FROM
            emp_manager);
      
      
      
-- GROUP BY
SELECT 
    manager_no
FROM
    emp_manager
GROUP BY manager_no;