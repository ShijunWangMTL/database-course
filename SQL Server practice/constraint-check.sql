---- CONSTRAINTS: CHECK ----
ALTER TABLE tblTransaction
ADD CONSTRAINT chkAmount CHECK (Amount > -1000 and Amount < 1000)
-- values between -1000 and 1000 can be accepted

-- test constraint --
insert into tblTransaction
values (-1000, '2014-01-01', 1, '2020-01-01')  -- error

alter table tblEmployee with nocheck
add constraint chkMiddleName check
(replace(EmployeeMiddleName, '.', '') = EmployeeMiddleName or EmployeeMiddleName is null)
-- if R = R, true
-- if R != R., false, check not accept

-- test --
begin tran
	insert into tblEmployee
	values (2003, 'A', 'B.', 'C', 'D', '2014-01-01', 'Accounts')
	select * from tblEmployee where EmployeeNumber = 2003
rollback tran -- ERROR

begin tran
	insert into tblEmployee
	values (2003, 'A', 'B', 'C', 'D', '2014-01-01', 'Accounts')
	select * from tblEmployee where EmployeeNumber = 2003
rollback tran -- CORRECT

begin tran
	insert into tblEmployee
	values (2003, 'A', null, 'C', 'D', '2014-01-01', 'Accounts')
	select * from tblEmployee where EmployeeNumber = 2003
rollback tran -- CORRECT
