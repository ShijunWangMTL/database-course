DECLARE @Num money
SET @Num = 7856781234.56789
SELECT CONVERT(varchar(20), @Num, 0)  -- 7856781234.57
SELECT CONVERT(varchar(20), @Num, 1)  -- 7,856,781,234.57
SELECT CONVERT(varchar(20), @Num, 2)  -- 7856781234.5679
SELECT CONVERT(varchar(20), @Num, 126)  -- 7,856,781,234.5679
-- 126: Equivalent to style 2, when converting to char(n) or varchar(n)

 --> 字符串转换成时间
SELECT CAST('2018-06-02' AS datetime);  
SELECT CONVERT(datetime, '2018-06-02');
 
 --> 格式化日期
SELECT GETDATE()
SELECT CONVERT(datetime,GETDATE())
SELECT CONVERT(VARCHAR,GETDATE())
SELECT CONVERT(VARCHAR,GETDATE(),110) 
SELECT CONVERT(VARCHAR,GETDATE(),106)
SELECT CONVERT(VARCHAR,GETDATE(),113)

----example----
use [70-461]
select top 5 * from [dbo].[tblEmployee]

select 
top 5 
cast(dateofbirth as varchar)
from [dbo].[tblEmployee]

select 
top 5 
convert(varchar, dateofbirth, 103)
from [dbo].[tblEmployee]

/*
Format # 	Example query 	Sample result
0 	SELECT CONVERT(NVARCHAR, GETDATE(), 0) 	Aug 23 2019 1:39PM
1 	SELECT CONVERT(NVARCHAR, GETDATE(), 1) 	08/23/19
2 	SELECT CONVERT(NVARCHAR, GETDATE(), 2) 	19.08.23
3 	SELECT CONVERT(NVARCHAR, GETDATE(), 3) 	23/08/19
4 	SELECT CONVERT(NVARCHAR, GETDATE(), 4) 	23.08.19
5 	SELECT CONVERT(NVARCHAR, GETDATE(), 5) 	23-08-19
6 	SELECT CONVERT(NVARCHAR, GETDATE(), 6) 	23 Aug 19
7 	SELECT CONVERT(NVARCHAR, GETDATE(), 7) 	Aug 23, 19
8 or 24 or 108 	SELECT CONVERT(NVARCHAR, GETDATE(), 8) 	13:39:17
9 or 109 	SELECT CONVERT(NVARCHAR, GETDATE(), 9) 	Aug 23 2019 1:39:17:090PM
10 	SELECT CONVERT(NVARCHAR, GETDATE(), 10) 	08-23-19
11 	SELECT CONVERT(NVARCHAR, GETDATE(), 11) 	19/08/23
12 	SELECT CONVERT(NVARCHAR, GETDATE(), 12) 	190823
13 or 113 	SELECT CONVERT(NVARCHAR, GETDATE(), 13) 	23 Aug 2019 13:39:17:090
14 or 114 	SELECT CONVERT(NVARCHAR, GETDATE(), 14) 	13:39:17:090
20 or 120 	SELECT CONVERT(NVARCHAR, GETDATE(), 20) 	2019-08-23 13:39:17
21 or 25 or 121 	SELECT CONVERT(NVARCHAR, GETDATE(), 21) 	2019-08-23 13:39:17.090
22 	SELECT CONVERT(NVARCHAR, GETDATE(), 22) 	08/23/19 1:39:17 PM
23 	SELECT CONVERT(NVARCHAR, GETDATE(), 23) 	2019-08-23
101 	SELECT CONVERT(NVARCHAR, GETDATE(), 101) 	08/23/2019
102 	SELECT CONVERT(NVARCHAR, GETDATE(), 102) 	2019.08.23
103 	SELECT CONVERT(NVARCHAR, GETDATE(), 103) 	23/08/2019
104 	SELECT CONVERT(NVARCHAR, GETDATE(), 104) 	23.08.2019
105 	SELECT CONVERT(NVARCHAR, GETDATE(), 105) 	23-08-2019
106 	SELECT CONVERT(NVARCHAR, GETDATE(), 106) 	23 Aug 2019
107 	SELECT CONVERT(NVARCHAR, GETDATE(), 107) 	Aug 23, 2019
110 	SELECT CONVERT(NVARCHAR, GETDATE(), 110) 	08-23-2019
111 	SELECT CONVERT(NVARCHAR, GETDATE(), 111) 	2019/08/23
112 	SELECT CONVERT(NVARCHAR, GETDATE(), 112) 	20190823
113 	SELECT CONVERT(NVARCHAR, GETDATE(), 113) 	23 Aug 2019 13:39:17.090
120 	SELECT CONVERT(NVARCHAR, GETDATE(), 120) 	2019-08-23 13:39:17
121 	SELECT CONVERT(NVARCHAR, GETDATE(), 121) 	2019-08-23 13:39:17.090
126 	SELECT CONVERT(NVARCHAR, GETDATE(), 126) 	2019-08-23T13:39:17.090
127 	SELECT CONVERT(NVARCHAR, GETDATE(), 127) 	2019-08-23T13:39:17.090
130 	SELECT CONVERT(NVARCHAR, GETDATE(), 130) 	22 ذو الحجة 1440 1:39:17.090P
131 	SELECT CONVERT(NVARCHAR, GETDATE(), 131) 	22/12/1440 1:39:17.090PM
*/