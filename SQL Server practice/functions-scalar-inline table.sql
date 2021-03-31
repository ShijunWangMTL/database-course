------- Functions ------------

-- scalar --
/*

CREATE FUNCTION [dbo].[FunctionName]
(
    @param1 int,
	@param2 int
)
RETURNS INT
AS
BEGIN

    RETURN @param1 + @param2

END

*/

create function AmountPlusOne(@amount smallmoney)
returns smallmoney
as
begin
	return @amount + 1
end
go

select DateOfTransaction, EmployeeNumber, Amount, dbo.AmountPlusOne(Amount) as AmountPlusOne
from tblTransaction

declare @myValue smallmoney
execute @myValue = AmountPlusOne 345.67   -- or dbo.AmountPlusOne
select @myValue
go

-- inline Table-Valued --
/*
CREATE FUNCTION [dbo].[FunctionName]
(
    @param1 int,
    @param2 char(5)
)
RETURNS TABLE AS RETURN
(
    SELECT @param1 AS c1,
	       @param2 AS c2
)
*/

CREATE FUNCTION TransactionList(@EmployeeNumber int)
RETURNS TABLE AS RETURN
(
    SELECT * from tblTransaction
	where EmployeeNumber = @EmployeeNumber
)
go

select *
from dbo.TransactionList(123)

select *
from tblEmployee
where exists(select * 
			from TransactionList(EmployeeNumber))


-- Multi-Statement Table-Valued --

CREATE FUNCTION [dbo].[FunctionName]
(
    @param1 int,
    @param2 char(5)
)
RETURNS @returntable TABLE 
(
	[c1] int,
	[c2] char(5)
)
AS
BEGIN
    INSERT @returntable
    SELECT @param1, @param2
    RETURN 
END
