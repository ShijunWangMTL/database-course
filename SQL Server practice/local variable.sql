-- creating temp variables
-- declare a variable, with a data type, initialize it
DECLARE @myvar as int = 2

SET @myvar = @myvar + 1

select @myvar
select @myvar as myVariable		-- column name "myVariable"