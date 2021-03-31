-- Using aggregate functions with JOINS
###############################################
# get male and female average salary
# use of aggregate dunctions means output must be grouped by field of interest

describe employees;
describe salaries;

SELECT e.gender, AVG(s.salary) AS average_salary  # cannot show e.emp_no when GROUP BY gender
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
GROUP BY gender;

-- Join more than one table
###############################################
# join 3 tables
# join table 1 and 2 on emp_no
# join table 2 and 3 on dept_no
# order can be changed
##############################################
describe dept_manager;
describe departments;

SELECT e.first_name, e.last_name, e.hire_date, m.from_date, d.dept_name
FROM employees e
JOIN dept_manager m ON e.emp_no = m.emp_no
JOIN departments d ON m.dept_no = d.dept_no;

SELECT e.first_name, e.last_name, e.hire_date, m.from_date, d.dept_name
FROM dept_manager m
JOIN employees e ON e.emp_no = m.emp_no
JOIN departments d ON m.dept_no = d.dept_no;

SELECT e.first_name, e.last_name, e.hire_date, m.from_date, d.dept_name
FROM departments d
JOIN dept_manager m ON m.dept_no = d.dept_no
JOIN employees e ON e.emp_no = m.emp_no;

--  RIGHT JOIN with JOIN 
SELECT e.first_name, e.last_name, e.hire_date, m.from_date, d.dept_name
FROM departments d
RIGHT JOIN dept_manager m ON m.dept_no = d.dept_no
JOIN employees e ON e.emp_no = m.emp_no;

-- JOIN with RIGHT JOIN
SELECT e.first_name, e.last_name, e.hire_date, m.from_date, d.dept_name
FROM departments d
JOIN dept_manager m ON m.dept_no = d.dept_no
RIGHT JOIN employees e ON e.emp_no = m.emp_no;

describe titles;
select * from titles where title = 'Manager';
describe dept_manager;
describe departments;
SELECT e.first_name, e.last_name, e.hire_date, t.title, t.from_date, dm.from_date, d.dept_name
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
JOIN departments d ON d.dept_no = dm.dept_no
JOIN titles t ON t.emp_no = e.emp_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;

select dm.emp_no, t.title
from dept_manager dm
join titles t
ON dm.emp_no = t.emp_no;

SELECT d.dept_name, AVG(s.salary) AS average_salary_manager
FROM departments d 
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN salaries s ON s.emp_no = dm.emp_no
GROUP BY d.dept_no
ORDER BY AVG(s.salary);

########################################
### SELF JOIN