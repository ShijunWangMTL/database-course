use [70-461]
select department, count(*) as NumberPerDepartment
from tblEmployee
group by department

-- to display how many departments --
-- #1
--** derived table **--
--** outer select **--
select count(department) as NoOfDepartments
from
(select department, count(*) as NumberPerDepartment
from tblEmployee
group by department) as newTable
-- #2
--** distinct **--
select distinct department
from tblEmployee;
--result: 4 rows for department names

select count(distinct department) as NoOfDept
from tblEmployee;
--result: 4 (one row)

select distinct department
into tblDepartment
from tblEmployee;
--**** create a new table tblDepartment
/*
select 
into
from
*/