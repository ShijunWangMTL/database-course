-- Integer Numbers
-- bigint, int, smallint, tinyint
declare @myVar as smallint = 2000
select @myVar as Result

-- error example -------
declare @myVar1 as tinyint = 2000
select @myVar1 as Result
------------------------

-- error example -------
declare @myVar2 as tinyint = 200
set @myVar2 = @myVar2 * 10	--error
select @myVar2 as Result
------------------------
go
declare @myVar3 as numeric(7,2); -- entire length: 7; decimal part: 2.
set @myVar3 = 12345.67;
select @myVar3 as Result

-- error example -------
go
declare @myVar4 as numeric(7,2); 
set @myVar4 = 123456789.67; -- error
select @myVar4 as Result
------------------------