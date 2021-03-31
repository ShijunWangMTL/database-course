-- create tblEmployee table
use [70-461];  -- [] mandatory
create table tblEmployee
(
EmployeeNumber int not null,
EmployeeFirstName varchar(50) not null,
EmployeeMiddleName varchar(50) null,
EmployeeLastName varchar(50) not null,
EmployeeGovernmentID char(10) null,
DateOfBirth date not null
)

-- add a new column 'department'
alter table tblEmployee
add department varchar(10);
-- change datatype
alter table [dbo].[tblEmployee]
alter column department varchar(30);  
-- or [department]
truncate table tblEmployee;
select * from tblEmployee;

-- add values
insert into [dbo].[tblEmployee]
values
(124,'Carolyn','Andrea','Zimmerman','AB234578H','19750601','Litigation');

insert into [dbo].[tblEmployee]
values
(127,'Terri','Lee','Yu','KW252122A','1976-08-18','HR');

------------------new section-----------------
select * from tblEmployee
where EmployeeLastName = 'word';

select * from tblEmployee
where EmployeeLastName <> 'word';

select * from tblEmployee
where EmployeeLastName like 'w%';

select * from tblEmployee
where EmployeeLastName like '_w%';

select * from tblEmployee
where EmployeeLastName like '[r-t]%'; -- from r to t

select * from tblEmployee
where EmployeeNumber <> 200; 
-- same result: EmployeeNumber != 200

select * from tblEmployee
where EmployeeNumber >= 200 and EmployeeNumber <= 209;

select * from tblEmployee
where EmployeeNumber <= 200 or EmployeeNumber >= 900;

select * from tblEmployee
where EmployeeNumber not between 200 and 900;

select year(dateofbirth) as YearBorn, count(*) as NumberBorn
from tblEmployee
group by year(dateofbirth);

--error------
-- Column 'tblEmployee.EmployeeNumber' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
select year(dateofbirth) as YearBorn, EmployeeNumber  
from tblEmployee
group by year(dateofbirth);

select * from tblEmployee
where year(dateofbirth) = 1967;

select year(dateofbirth) as YearBorn, count(*) as NumberBorn
from tblEmployee
where 1=1  -- to make the condition always true
group by year(dateofbirth)  -- can NOT use group by YearBorn
order by year(dateofbirth) DESC;   -- can use group by YearBorn
-- ***** SELECT is executed after GROUP BY, so YearBorn can NOT be used with GROUP BY.
-- ***** ORDER BY can work with YearBorn