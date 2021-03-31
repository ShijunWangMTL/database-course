select *
from tblDepartment
left join tblEmployee
on tblDepartment.department = tblemployee.department
left join tblTransaction
on tblemployee.employeenumber = tbltransaction.employeenumber;

select tblDepartment.department, tblDepartment.departmentHead, sum(amount) as SumOfAmount
from tblDepartment
left join tblEmployee
on tblDepartment.department = tblemployee.department
left join tblTransaction
on tblemployee.employeenumber = tbltransaction.employeenumber
group by tblDepartment.department, tblDepartment.departmentHead
order by departmentHead;

insert into tblDepartment(department, departmentHead)
values('Accounts', 'James');

delete from tblDepartment
where department = 'Accounts' and departmentHead = 'James';

select D.department, DepartmentHead, sum(amount) as SumOfAmount
from tblDepartment as D
left join tblEmployee as E
on D.department = E.department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
group by D.department, D.DepartmentHead
order by DepartmentHead;