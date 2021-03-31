-------- Stored Procedures --------
-----------------------------------
-- check all the tables, views, procedures --
select * from sys.tables;
select * from sys.views;
select * from sys.procedures;
go
-- 2 ways to check and then drop a procedure --
/*
CREATE PROCEDURE dbo.Sample_Procedure 
    @param1 int = 0,
    @param2 int  
AS
    SELECT @param1,@param2 
RETURN 0 
*/
/*
CREATE PROCEDURE dbo.Sample_Procedure 
    @param1 int = 0,
    @param2 int OUTPUT 
AS
    SELECT @param2 = @param2 + @param1 
RETURN 0 
*/
-- #1 --
if exists (select * from sys.procedures where name = 'NameEmployees')
drop procedure NameEmployees
go
-- #2 --
if OBJECT_ID('NameEmployees','P') is not null
drop procedure NameEmployees
go

-- create a procedure --
create proc NameEmployees as  -- create procedure/proc
begin
	select EmployeeNumber, EmployeeFirstName, EmployeeLastName
	from tblEmployee
end
go

-- 3 ways to execute a defined procedure --
NameEmployees;
execute NameEmployees;
exec NameEmployees;
go

-- create a procedure with one parameter --
create procedure NameEmployees(@EmployeeNumber int) as
begin
	select EmployeeNumber, EmployeeFirstName, EmployeeLastName
	from tblEmployee
	where EmployeeNumber = @EmployeeNumber

END
GO
NameEmployees 4;  -- shows empty row
execute NameEmployees 223;
exec NameEmployees 325;
go

-- -- create a procedure with parameters, check existence first --
create procedure NameEmployees(@EmployeeNumber int) as
begin
	if exists (select * from tblEmployee where EmployeeNumber = @EmployeeNumber)
	begin
		select EmployeeNumber, EmployeeFirstName, EmployeeLastName
		from tblEmployee
		where EmployeeNumber = @EmployeeNumber
	end
END
GO
NameEmployees 4;  -- no value, doesn't show this line in the result
execute NameEmployees 223;
exec NameEmployees 325;
go

-- create a procedure with two parameters to show a range of data --
create procedure NameEmployees(@EmployeeNumberFrom int, @EmployeeNumberTo int) as
begin
	if exists (select * from tblEmployee where EmployeeNumber between @EmployeeNumberFrom and @EmployeeNumberTo)
	begin
		select EmployeeNumber, EmployeeFirstName, EmployeeLastName
		from tblEmployee
		where EmployeeNumber between @EmployeeNumberFrom and @EmployeeNumberTo
	end
END
GO
NameEmployees 4,5; -- no value, doesn't show this line in the result
execute NameEmployees 223,232;  -- shows results from 223 to 232 inclusive
--exec NameEmployees 325;  -- ERROR: expects parameter '@EmployeeNumberTo'
exec NameEmployees @EmployeeNumberFrom = 323, @EmployeeNumberTo = 327;   -- shows results from 323 to 327 inclusive

-----------------------------------------------------------------
-------------PRACTICE--------------------------------------------
USE master;  
GO  
SELECT OBJECT_ID(N'AdventureWorks2012.Production.WorkOrder') AS 'Object ID';  
GO

/*
-- Syntax
OBJECT_ID ( '[ database_name . [ schema_name ] . | schema_name . ]   
  object_name' [ ,'object_type' ] )
-- object_name is either varchar or nvarchar. If object_name is varchar, it is implicitly converted to nvarchar. Specifying the database and schema names is optional.
--  object_type is the schema-scoped object type. object_type is either varchar or nvarchar. If object_type is varchar, it is implicitly converted to nvarchar. 
-- type list: https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-objects-transact-sql?view=sql-server-ver15
-- return type: int. For a spatial index, OBJECT_ID returns NULL.(对于空间索引，OBJECT_ID 返回 NULL。) Returns NULL on error.
*/