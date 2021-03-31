-- The precision must be a value from 1 through the maximum precision of 38. 
-- The default precision is 18.
-- default scale is 0 
-- 0 <= s <= p
-- a constant with a decimal point is automatically converted into a numeric data value, using the minimum precision and scale necessary. 
-- constant 12.345 is converted into a numeric value with a precision of 5 and a scale of 3.

declare @var as decimal(3,2) = 1.23; -- 1.23, precision 3 and scale 2
select @var;
go
declare @var as decimal(2,2) = 1.22; -- error, overflow, precision should be 3
select @var;
go
declare @var as decimal(4,2) = 1.22; -- 1.22, 
select @var;
go
declare @var as decimal(4,3) = 1.22; -- 1.220
select @var;
go
declare @var as decimal(4,3) = 1; -- 1.000
select @var;
go
declare @var as decimal(4,2) = 1.224; -- 1.22, automatically round
select @var;
go
declare @var as decimal(4,2) = 1.22995; -- 1.23, automatically round
select @var;
go
declare @var as decimal(4) = 1.524; -- 2, automatically round
select @var;
go
declare @var as decimal(0) = 0; -- error, pricision 0 is invalid
select @var;
go
-------float---------
declare @var as float(4,2) = 1.22; -- error
select @var;
go
declare @var as float(4) = 11.22; -- 11.22
select @var;
go
declare @var as float(3) = 11.24445; -- 11.24445
select @var;
go
declare @var as float(1) = 1111.22; -- 1111.22
select @var;
go

