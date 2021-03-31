use [70-461]
--- join/inner join --- only matching rows retrieved
--- left join --- all the rows in left table and matching rows in right table
--- right join --- all the rows in right table and matching rows in left table
--- cross join ---NOT RECOMMENDED--- every single combination

--- create second table ---
create table tblTransaction
(
Amount smallmoney not null,
DateOfTransaction smalldatetime null,
EmployeeNumber int not null
)

select EmployeeNumber, sum(amount) as totalAmount
from tblTransaction
group by EmployeeNumber

--- join/inner join --- 
select tblemployee.EmployeeNumber, EmployeeFirstName, EmployeeLastName, sum(amount) as SumOfAmount
from tblEmployee
join tblTransaction
on tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber
group by tblemployee.EmployeeNumber,EmployeeFirstName, EmployeeLastName
order by EmployeeNumber
