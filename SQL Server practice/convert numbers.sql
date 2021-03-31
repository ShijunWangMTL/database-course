-- converting between number and types
select 3/2; -- 1
select 3.0/2; -- 1.500000

declare @myvar as int = 3.0;
select @myvar / 2; -- 1
select @myvar / 2.0; -- 1.500000
go

-- implicit ---
declare @myvar as decimal(5,2) = 3;
select @myvar; -- 3.00
go

-- explicit ---
select convert(decimal(5,2),3) / 2; --1.500000
select convert(decimal(5,2),3); --3.00
select convert(decimal(5,2),3) / 1; --3.000000

select cast(3 as decimal(5,2)); -- 3.00
select cast(3 as decimal(5,2)) / 2;  --1.500000

select convert(decimal(5,2),1000); -- arithmetic overflow error

select convert(int, 12.345),  convert(int, 12.745); -- 12, 12
select cast(12.345 as int), cast(12.745 as int); -- 12, 12
select convert(int, 12.345) + convert(int, 12.745); -- 24
select cast(12.345+12.745 as int); -- 25

select convert(decimal(5,2),112.238); -- 112.24

