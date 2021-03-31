insert into tblSecond values (123), (234), (345), (567);

select * from tblSecond;

-- "Edit top 200 rows" to insert values

----------------------------------------------------

-- to view data, "Select to 1000 rows"
SELECT TOP (1000) [myNumbers]
  FROM [70-461].[dbo].[tblSecond]


select myNumbers from tblSecond;

select * from tblFirst;

----------------------------------------------------

delete from tblFirst;

truncate table tblSecond;

drop table tblFirst;

------------------------------------
--delete top() from 
begin tran
delete top (10) from Invoices
rollback tran