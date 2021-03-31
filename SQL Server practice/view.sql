----- view -----
select D.Department, T.EmployeeNumber, T.DateOfTransaction, T.Amount as TotalAmount
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber between 120 and 139
order by D.department, T.EmployeeNumber;

-- create view for the code above --
create view ViewByDepartment as
	select D.Department, T.EmployeeNumber, T.DateOfTransaction, T.Amount as TotalAmount
	from tblDepartment as D
	left join tblEmployee as E
	on D.Department = E.Department
	left join tblTransaction as T
	on E.EmployeeNumber = T.EmployeeNumber
	where T.EmployeeNumber between 120 and 139;
	--order by D.department, T.EmployeeNumber
GO
--*** The ORDER BY clause is invalid in views, inline functions, derived tables, subqueries, and common table expressions, unless TOP, OFFSET or FOR XML is also specified.
--*** use TOP() or delete ORDER BY to avoid error

select * from ViewByDepartment;

-- create view --
create view ViewSummary as
select D.Department, T.EmployeeNumber as EmpNum, sum(T.Amount) as TotalAmount
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
group by D.department, T.EmployeeNumber
--order by D.department, T.EmployeeNumber;
go

select * from ViewSummary;