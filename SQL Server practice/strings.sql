-- STRINGS
-- char - ascii: known and fixed length
-- varchar - ascii: variable length
-- nchar - unicode
-- nvarchar - unicode

declare @chrMyCharacters as char(10);
set @chrMyCharacters = 'hello';
select @chrMyCharacters as myString, len(@chrMyCharacters) as myLength, datalength(@chrMyCharacters) as myDataLength;
-- result: len:5. datalength:10 --> char(10)
/*
declare @chrMyCharacters2 as char(10);
set @chrMyCharacters2 = 'hellohellohello';
select @chrMyCharacters2 as myString, len(@chrMyCharacters2) as myLength, datalength(@chrMyCharacters2) as myDataLength;
-- result: len:10. datalength:10 --> char(10)
*/
declare @chrMyCharacters3 as char(10);
set @chrMyCharacters3 = 'hello';
select left(@chrMyCharacters3, 2), right(@chrMyCharacters3, 2), SUBSTRING(@chrMyCharacters3,6,3);
-- result: he, NULL, NULL

declare @chrMyCharacters4 as char(10);
set @chrMyCharacters4 = 'hellothere';
select left(@chrMyCharacters4, 2) as myleft, right(@chrMyCharacters4, 2) as myright, SUBSTRING(@chrMyCharacters4,3,2) as mysubstring, replace(@chrMyCharacters4, 'l', 'L') as myReplace;
-- result: he, re, ll(substring from the 3rd character with length of 2), heLLOthere
select upper(@chrMyCharacters4) as myUpper, lower(@chrMyCharacters4) as myLower;
-- result: HELLOTHERE, hellothere


