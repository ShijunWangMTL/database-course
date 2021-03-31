SELECT CAST( 123456 AS BINARY(4) ); -- 0x0001E240
SELECT CAST( 123456 AS BINARY(2) ); -- 0xE240

DECLARE @BinaryVariable2 BINARY(2);  
SET @BinaryVariable2 = 123456;  
SET @BinaryVariable2 = @BinaryVariable2 + 1;    
SELECT CAST( @BinaryVariable2 AS INT);  
GO -- 57921