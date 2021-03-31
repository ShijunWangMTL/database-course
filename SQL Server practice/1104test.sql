DECLARE @myint AS tinyint = -4
SELECT @myint
go
select ROUND(748.56,0), CEILING(748.56)
select CEILING(748.56), FLOOR(748.56)
select ROUND(748.56,0), FLOOR(748.56) 
go
DECLARE @myvar VARCHAR(10) = 'HELLO' 
SELECT SUBSTRING(@myvar,3,2)
go
DECLARE @my AS nvarchar(10) = N'hello' -- N"hello" : error!!!
select @my
use [70-461]
select department as dept
from [dbo].[tblDepartment]
group by dept
go
select sign(333), sign(-423), sign(0)