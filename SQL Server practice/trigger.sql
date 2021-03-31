----------- triggers -----------------
/* 3 TYPES:
	DML TRIGGERS: insert, update, delete
	DDL TRIGGERS: create, alter, drop
	LOGON TRIGGERS 
	https://docs.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql?view=sql-server-ver15
*/

CREATE TRIGGER TriggerName
    ON [dbo].[TableName]
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
    SET NOCOUNT ON
    END

drop TRIGGER TR_tblTransaction
go
CREATE TRIGGER TR_tblTransaction
    ON tblTransaction
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		SET NOCOUNT on
    END
go

insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber)
values (999, '2015-07-10', 999)

select * from tblTransaction order by EmployeeNumber;
set nocount off;
set nocount on;


go
DECLARE @NOCOUNT VARCHAR(3) = 'OFF';  
IF ( (512 & @@OPTIONS) = 512 ) SET @NOCOUNT = 'ON';  
SELECT @NOCOUNT AS NOCOUNT;

go

create trigger tr_tblTransaction2
on tblTransaction
after delete, insert, update
as
begin
	select *, 'Inserted' from Inserted
	select *, 'Deleted' from Deleted
end
go

begin transaction
insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber)
values (999, '2015-07-10', 999)
update tblTransaction
set amount = 321 where EmployeeNumber = 123 and DateOfTransaction = '2015-07-10'
delete tblTransaction
where EmployeeNumber = 999 and DateOfTransaction = '2015-07-10'
rollback transaction
go

-- enable and disable triggers --
alter table tblTransaction disable trigger tr_tblTransaction
go
alter table tblTransaction enable trigger tr_tblTransaction
go
disable trigger tr_tblTransaction2 on tblTransaction
go
enable trigger tr_tblTransaction2 on tblTransaction
go

/*
插入操作（Insert）:Inserted表有数据，Deleted表无数据
删除操作（Delete）:Inserted表无数据，Deleted表有数据
更新操作（Update）:Inserted表有数据（新数据），Deleted表有数据（旧数据）
*/

/*
FOR or AFTER specifies that the DML trigger fires only when all operations specified in the triggering SQL statement have launched successfully. All referential cascade actions and constraint checks must also succeed before this trigger fires.
You can't define AFTER triggers on views.

INSTEAD OF
Specifies that the DML trigger launches instead of the triggering SQL statement, thus, overriding the actions of the triggering statements. You can't specify INSTEAD OF for DDL or logon triggers.
At most, you can define one INSTEAD OF trigger per INSERT, UPDATE, or DELETE statement on a table or view. You can also define views on views where each view has its own INSTEAD OF trigger.
You can't define INSTEAD OF triggers on updatable views that use WITH CHECK OPTION. Doing so results in an error when an INSTEAD OF trigger is added to an updatable view WITH CHECK OPTION specified. You remove that option by using ALTER VIEW before defining the INSTEAD OF trigger.
*/

select * from tblSecond;
create trigger safetest
on database
after drop_table, alter_table
as
begin
	raiserror('table alteration is not allowed',16,2)
rollback
end
go
drop table tblSecond;
go
-- drop DDL triggers : ON database --
drop trigger safetest on database;
go

CREATE TRIGGER ddl_trig_database   
ON ALL SERVER   
FOR CREATE_DATABASE   
AS   
    PRINT 'Database Created.'  
    SELECT EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)')  
GO  
create database testbase;

DROP TRIGGER ddl_trig_database  
ON ALL SERVER;  
GO

--------------------------nocount----------------------
/*
 The SET NOCOUNT ON works at the session-level. We need to specify it with each session. In the stored procedures, we specify the code itself. Therefore, it does not require specifying explicitly in the session.
We can use the sp_configure configuration option to use it at the instance level. The following query sets the behavior of SET NOCOUNT ON at the instance level. 
	
		EXEC sys.sp_configure 'user options', '512'; 
		  RECONFIGURE

If we specify the NOCOUNT ON/OFF in the individual session, we can override the behavior configured at the instance level. 
*/

