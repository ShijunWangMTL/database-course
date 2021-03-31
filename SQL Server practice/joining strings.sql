---------joining the strings----------------
declare @firstname as nvarchar(20);
declare @middlename as nvarchar(20);
declare @lastname as nvarchar(20);

set @firstname = 'Sarah';
set @middlename = 'Jane';
set @lastname = 'Milligan';

select @firstname + ' ' + @middlename + ' ' + @lastname as FullName;
--result: Sarah Jane Milligan
go

declare @firstname as nvarchar(20);
declare @middlename as nvarchar(20);
declare @lastname as nvarchar(20);

set @firstname = 'Sarah';
-- @middlename not initialized --
set @lastname = 'Milligan';

select @firstname + ' ' + @middlename + ' ' + @lastname as FullName;
--result: NULL, because @middlename is not initialized.
select @firstname + iif(@middlename is null, '', ' ' + @middlename) + ' ' + @lastname as FullName;
--result: Sarah Milligan. 
-- @middle, if it's null, print nothing '', otherwise, print ' ' + @middlename
