-- create the table Invoices, delete first if exists --
drop table if exists Invoices;
create table Invoices
(InvoiceNumber INT PRIMARY KEY, InvoiceDate date, InvoiceTotal MONEY, CreditTotal MONEY, PaymentTotal MONEY);

-- display all rows from Invoices
select * from Invoices;

-- insert values into Invoices
insert into Invoices values
(10250, '20200401', 232.38, 168.22, 0),
(10249, '20200403', 11.61, 29.76, 3.1),
(10248, '20200406', 65.83, 17.68, 100),
(10251, '20200406', 41.34, 45.08, 8.63),
(10252, '20200406', 51.3, 6.27, 64.19),
(10253, '20200406', 58.17, 107.83, 162.33),
(10254, '20200407', 22.98, 63.79, 1.3),
(10255, '20200407', 148.33, 257.62, 360.63),
(10256, '20200407', 13.97, 7.56, 53.8),
(10257, '20200408', 81.91, 0.56, 41.95),
(10258, '20200408', 140.51, 0, 36.71),
(10259, '20200408', 53.25, 47.3, 34.88),
(10260, '20200409', 55.09, 17.52, 19.64),
(10261, '20200409', 83.05, 24.69, 288.43),
(10262, '20200409', 48.29, 40.26, 131.7),
(10263, '20200409', 146.06, 1.96, 183.17),
(10264, '20200410', 133.67, 74.16, 96.04),
(10265, '20200410', 55.28, 41.76, 30.54),
(10266, '20200410', 25.73, 150.15, 71.97),
(10267, '20200413', 208.58, 12.69, 22),
(10268, '20200413', 66.29, 4.73, 10.14),
(10269, '20200413', 34.56, 64.5, 13.55),
(10270, '20200414', 136.54, 34.57, 101.95),
(10271, '20200414', 664.54, 3.43, 195.68),
(10272, '20200414', 98.03, 0.4, 1.17),
(10273, '20200416', 76.07, 4.88, 0.45),
(10274, '20200416', 6.01, 214.27, 890.78),
(10275, '20200416', 26.93, 64.86, 124.12),
(10276, '20200417', 13.84, 77.92, 3.94),
(10277, '20200417', 125.77, 63.36, 20.12),
(10278, '20200417', 92.69, 87.03, 20.39),
(10279, '20200417', 25.83, 191.67, 22.21),
(10280, '20200420', 8.98, 12.75, 5.44),
(10281, '20200420', 72.94, 10.19, 45.03),
(10282, '20200420', 12.69, 52.84, 35.03),
(10283, '20200421', 84.81, 0.59, 7.99),
(10284, '20200421', 76.56, 8.56, 94.77),
(10285, '20200429', 76.83, 42.11, 34.24),
(10286, '20200429', 229.24, 15.51, 166.31),
(10287, '20200430', 12.76, 108.26, 26.78),
(10288, '20200430', 7.45, 0, 54.83),
(10289, '20200430', 22.77, 15.66, 110.37)
go

-- create a procedure spDateRange --
drop procedure if exists spDateRange;
go
create procedure spDateRange(@DateMin date = null, @DateMax date = null) as
begin
		-- check null parameters
	if @DateMin is null or @DateMax is null
	begin
		RAISERROR ('ERROR: Values must be specified for @DateMin and @DateMax.',16,1)
	end
		-- check if the period between @DateMin and @DateMax is valid
	if @DateMin > @DateMax
	begin
		RAISERROR ('ERROR: @DateMin must be no later than @DateMax.',16,1)
	end
		-- return a result set
	select InvoiceNumber, InvoiceDate, InvoiceTotal, InvoiceTotal-PaymentTotal-CreditTotal as Balance
	From Invoices
	where InvoiceDate between @DateMin and @DateMax
	order by InvoiceDate
end
go

-- test the procedure and call for date range between April 10 and April 20, 2020
execute spDateRange;
-- result: ERROR: Values must be specified for @DateMin and @DateMax..
GO

exec spDateRange '2020-04-10', '2020-04-09';
-- result: ERROR: @DateMin must be no later than or same as @DateMax.
GO

exec spDateRange '2020-04-10', '2020-04-20';
-- return 19 rows

exec spDateRange '2020-04-10', '2020-04-10';
-- return the rows for April 10th only