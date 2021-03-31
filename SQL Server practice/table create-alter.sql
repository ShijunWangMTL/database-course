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

--error
insert into [dbo].[tblEmployee]
values
(123,'Jane','Zwilling','AB123456G','1985-01-01','HR')


