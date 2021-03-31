---- CONSTRAINTS: UNIQUE ----
alter table tblEmployee
ADD CONSTRAINT unqGovernmentID UNIQUE (EmployeeGovernmentID);

alter table tblEmployee
drop CONSTRAINT unqGovernmentID

-- if duplicates exist, find and remove the duplicates
/*
select EmployeeGovernmentID, count(EmployeeGovernmentID) as mycount from tblEmployee
group by EmployeeGovernmentID
having count(EmployeeGovernmentID) > 1;

select * from tblEmployee
where EmployeeGovernmentID = 'TX593671R';

begin transaction
	delete 
	from tblEmployee
	where EmployeeNumber = 2;
commit transaction
*/

-- combined set of constraint
alter table tblTransaction
add constraint unqTransaction UNIQUE(amount, dateoftransaction, employeenumber)
-- the combinations of the 3 fields must be unique
-- shows in "keys", "indexes"

-- test the constraint above
delete from tblTransaction
where EmployeeNumber = 133;
insert into tblTransaction
values (1, '2015-01-01', 131)
insert into tblTransaction
values (1, '2015-01-01', 131) -- the second duplicate value cannot be added. The statement has been terminated.

---- drop constraint ----
alter table tbltransaction
drop constraint unqTransaction
