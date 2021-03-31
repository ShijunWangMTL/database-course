use northwind;
select * from customers;
select top 20 CustomerID, ContactName into customerDUP from customers;
select * from customerDUP;
drop table customerDUP;
go

create trigger tr_customer
on customerDUP
after insert, update, delete
as
begin
	select * from inserted
	select * from deleted
end;
go
drop trigger tr_customer;

insert into customerDUP
values ('ZZYYX', 'Tom Jerry');

insert into customerDUP
values ('ZZYYA', 'Tin Jerry');

select * from inserted; -- error

delete from customerDUP
where customerID = 'ZZYYA' and contactname = 'Tin Jerry' 
or customerID = 'ZZYYX' and contactname = 'Tom Jerry';
go

create trigger tri_inserted
on customerDUP
after insert
as
begin
	if not exists(select * from sysobjects where name = 'tblInserted')
	select * into tblInserted from inserted
	else
	insert into tblInserted select * from inserted
end;
go

select * from [dbo].[tblInserted];