alter table tblEmployee
add constraint PK_tblEmployee PRIMARY KEY(employeenumber)

-- to check the duplicated rows
/*
select employeenumber, count(employeenumber)
from tblemployee
group by employeenumber
having count(employeenumber) > 1;

delete top 1
from tblemployee
where employeenumber = 131;
*/

insert into tblEmployee
values(2004, 'FirstName', 'MiddleName', 'LastName', 'AB12345FI', '2014-01-01', 'Accounting');

select * from tblEmployee
where EmployeeNumber = 2004;

delete from tblEmployee
where EmployeeNumber = 2004;

---- drop constraint ----
alter table tblemployee
drop constraint PK_tblemployee;


-----****[unqGovernmentID] non-clustered: no sorting on this column
-----****[PK_tblEmployee] clustered: table will be sorted based on this column