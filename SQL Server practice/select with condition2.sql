use [70-461];
select top 5 * from tblEmployee;
select top (5) * from tblEmployee;
/*
select
from
where
group by
order by
*/
------------- left() -------------
select left(employeelastname, 1) as Initial, count(*) as CountInitial
from tblEmployee
where 1=1
group by left(employeelastname, 1)
order by count(*) DESC;

select top 10 left(employeelastname, 1) as Initial, count(*) as CountInitial
from tblEmployee
where dateofbirth > '19860101'
group by left(employeelastname, 1)
having count(*) >= 10
order by Initial DESC;

select top 10 left(employeelastname, 1) as Initial, count(*) as CountInitial
from tblEmployee
where dateofbirth > '19860101'
group by left(employeelastname, 1)
having count(*) >= 10
order by CountInitial DESC; -- order by: deterministic

/*
Deterministic functions always return the same result any time they are called with a specific set of input values and given the same state of the database. Nondeterministic functions may return different results each time they are called with a specific set of input values even if the database state that they access remains the same. For example, the function AVG always returns the same result given the qualifications stated above, but the GETDATE function, which returns the current datetime value, always returns a different result.
*/