-- Mathematical functions

-- power, square, sqrt, floor

declare @myvar as int
set @myvar = 100
select power(@myvar, 3)
select square(@myvar)
select power(@myvar, 0.5) as p -- result equals sqrt(@myvar)
select sqrt(@myvar) as s
go
declare @myvar as numeric(7,2) = 12.345
select floor(@myvar) as floor
select ceiling(@myvar) as ceiling
select round(@myvar, 1)

select PI() as myPI
select exp(1) as e
select exp(2) as e
go

declare @myvar as numeric(7,2) = 456
select abs(@myvar) as myAB, sign(@myvar) as mySign

select sign(-322)
select sign(0)

select RAND(543433)