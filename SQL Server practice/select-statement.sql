-- select works like print in queries
select 1+1 as Result	-- comment: AS is optional
GO	-- GO is a batch terminator. It creates a batch including the code before itself. After the go, it is another batch
-- what does a batch do? when and why we use it?
select 1*1 as Result
GO
select 1/0 as Result
GO
select 1/1 as Result
