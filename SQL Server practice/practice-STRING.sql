-- var(n), varchar(n)
-- in NCHAR(n) and NVARCHAR(n) the n defines the string length in byte-pairs (0-4,000). n never defines numbers of characters that can be stored. This is similar to the definition of CHAR(n) and VARCHAR(n).
/*
https://docs.microsoft.com/en-us/sql/t-sql/data-types/nchar-and-nvarchar-transact-sql?view=sql-server-ver15
*/

-- When n isn't specified in a data definition or variable declaration statement, the default length is 1. 
DECLARE @myVariable AS VARCHAR = 'abc';
DECLARE @myNextVariable AS CHAR = 'abc';
--The following returns 1
SELECT DATALENGTH(@myVariable), DATALENGTH(@myNextVariable);
select @myVariable, @myNextVariable 
-- a,  a                          
GO

declare @oneVar as char(1) = 'abc';
declare @oneVarchar as varchar(1) = 'abc';
select @oneVar, @oneVarchar; 
-- a,  a 
GO

-- If n isn't specified when using the CAST and CONVERT functions, the default length is 30.
DECLARE @myVariable AS VARCHAR(40);
SET @myVariable = 'This string is longer than thirty characters';
SELECT CAST(@myVariable AS VARCHAR);
SELECT DATALENGTH(CAST(@myVariable AS VARCHAR)) AS 'VarcharDefaultLength';
SELECT CONVERT(CHAR, @myVariable);
SELECT DATALENGTH(CONVERT(CHAR, @myVariable)) AS 'VarcharDefaultLength';
go

declare @myvar as varchar(40) = 'chⱥos';  -- ch?os
declare @myvar2 as varchar(40) = N'chⱥos';  -- ch?os
declare @myvar3 as nvarchar(2) = N'chⱥos';  -- chⱥos
-- N must be uppercase!!!
select @myvar, @myvar2, @myvar3;
go

-- return the variable type-------------
declare @var1 as varchar(40) = 'ch', @var2 as nvarchar(40) = N'ⱥos';
SELECT SQL_VARIANT_PROPERTY(@var1,'BaseType'), SQL_VARIANT_PROPERTY(@var2,'BaseType'), SQL_VARIANT_PROPERTY(@var1 + @var2,'BaseType')
go
-- *** @var1 + @var2 is type of nvarchar



-----------example: SQL_VARIANT_PROPERTY() -------------
CREATE   TABLE tableA(colA sql_variant, colB int)  
INSERT INTO tableA values ( cast (46279.1 as decimal(8,2)), 1689)  
SELECT   SQL_VARIANT_PROPERTY(colA,'BaseType') AS 'Base Type',   -- decimal
         SQL_VARIANT_PROPERTY(colA,'Precision') AS 'Precision',  -- 8
         SQL_VARIANT_PROPERTY(colA,'Scale') AS 'Scale'           -- 2
FROM      tableA  
WHERE      colB = 1689
go