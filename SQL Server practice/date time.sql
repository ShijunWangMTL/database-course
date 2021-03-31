-------date and time--------
select current_timestamp as RightNow;  -- 2020-10-30 17:27:35.093
select getdate() as RightNow;  -- 2020-10-30 17:27:35.093
select sysdatetime() as RightNow;  -- 2020-10-30 17:27:35.0948525, current machine

select dateadd(year,1,'2018-01-02 03:04:05') as myYear; -- 2019-01-02 03:04:05.000
select dateadd(month,1,'2018-01-02 03:04:05') as myYear; -- 2018-02-02 03:04:05.000
select dateadd(DAY,6,'2018-01-02 03:04:05') as myYear; -- 2018-01-08 03:04:05.000
select dateadd(WEEKDAY,6,'2018-01-02 03:04:05') as myYear; -- 2018-01-08 03:04:05.000

select datepart(HOUR, '2018-01-22 03:04:05') as myHour;  -- 3
select datepart(MINUTE, '2018-01-22') as myMinute;  -- 0
select datepart(second, '03:04:05') as mySecond;  -- 5
select datepart(DAY, '2018-01-22 03:04:05') as myDay;  -- 22
select datepart(WEEK, '2018-01-22 03:04:05') as myWeek;  -- 4
select datepart(DAYOFYEAR, '2018-02-22 03:04:05') as myDay;  -- 53
select datepart(day, '03:04:05') as myDay;  -- 1
select datepart(MONTH, '03:04:05') as myMonth;  -- 1
select datepart(year, '03:04:05') as myYear;  -- 1900

select datename(weekday, getdate()) as myAnswer;  -- Friday
select datename(weekday, '2020-10-30 03:04:05') as myAnswer;  -- Friday
select datename(weekday, '2020-10-30') as myAnswer;  -- Friday
select datename(weekday, '03:04:05') as myAnswer;  -- Monday

select datename(YEAR, '2020-10-30 03:04:05') as myAnswer;  -- 2020
select datename(MONTH, '2020-10-30 03:04:05') as myAnswer;  -- October
select datename(DAY, '2020-10-30 03:04:05') as myAnswer;  -- 30
select datename(DAYOFYEAR, '2020-10-30 03:04:05') as myAnswer;  -- 304
select datename(WEEK, '2020-12-30 03:04:05') as myAnswer;  -- 53

select datediff(second, '2018-01-22 03:04:05', getdate()) as TimeElaspsed;
select datediff(DAY, '2018-01-22 03:04:05', getdate()) as TimeElaspsed;  -- 1012
select datediff(YEAR, '2018-01-22 03:04:05', getdate()) as TimeElaspsed;  -- 2
select datediff(WEEK, '2018-01-22 03:04:05', getdate()) as TimeElaspsed;  -- 144