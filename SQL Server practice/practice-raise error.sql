select * from sys.messages
where severity = 16 

RAISERROR (15600,-1,-1, 'mysp_CreateCustomer');
RAISERROR (15600,1,-1, 'mysp_CreateCustomer');

-- 连续的参数替换连续的转换规格；第一个参数替换第一个转换规格，第二个参数替换第二个转换规格，以此类推。 例如，在以下 RAISERROR 语句中，第一个参数 N'number' 替换第一个转换规格 %s，第二个参数 5 替换第二个转换规格 %d.。
RAISERROR (N'This is message %s %d.', -- Message text.  
           10, -- Severity,  
           1, -- State,  
           N'number', -- First argument.  第一个参数 N'number' 替换第一个转换规格 %s
           5); -- Second argument.  第二个参数 5 替换第二个转换规格 %d
-- The message text returned is: This is message number 5.  
GO


    declare @error_mes varchar(1000)
    set @error_mes='这里是错误描述的示例'
    raiserror(@error_mes,16,1)
	go

declare @error_mes varchar(1000)
set @error_mes='这里是用户%s引发的错误描述'
raiserror(@error_mes,16,1,'张三')
go

---% [[flag] [width] [. precision] [{h | l}]] type 

RAISERROR (N'<\<%*.*s>>', -- Message text.  
           10, -- Severity,  
           1, -- State,  
           7, -- First argument used for width.  
           3, -- Second argument used for precision.  
           N'abcde'); -- Third argument supplies the string.  
-- The message text returned is: <\<    abc>>.  
GO  

RAISERROR (N'<\<%7.3s>>', -- Message text.  
           10, -- Severity,  
           1, -- State,  
           N'abcde'); -- First argument supplies the string.  
-- The message text returned is: <\<    abc>>.  
GO

----------------------------------------------------
--Returning error information from a CATCH block 从 CATCH 块返回错误消息
BEGIN TRY  
    -- RAISERROR with severity 11-19 will cause execution to   
    -- jump to the CATCH block.  
    RAISERROR ('Error raised in TRY block.', -- Message text.  
               16, -- Severity.  
               1 -- State.  
               );  
END TRY  
BEGIN CATCH  
    DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  
  
    SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE();  
  
    -- Use RAISERROR inside the CATCH block to return error  
    -- information about the original error that caused  
    -- execution to jump to the CATCH block.  
    RAISERROR (@ErrorMessage, -- Message text.  
               @ErrorSeverity, -- Severity.  
               @ErrorState -- State.  
               );  
END CATCH;
go
----------------------------------------------------


IF EXISTS (SELECT * FROM SYSOBJECTS WHERE name='my_sp_test' AND TYPE='P') BEGIN
  DROP PROCEDURE my_sp_test;
END;
GO
create procedure my_sp_test @i int, @outstr varchar(100) out as
begin try
  declare @j int;
  if @i<10 begin
   set @outstr = 'system exception.';
   set @j = 10/0; -- 因为被除数为0,所以这里将会抛出一个系统的异常
  end
  else begin
   set @j = @i;
   set @outstr = 'customer exception';
   -- 抛出自定义的异常,在最后的catch块中统一处理异常
   RAISERROR (66666, -- Message id.
      16, -- Severity,
      1 -- State,
      ) ;
  end;
end try
begin catch
  if @@ERROR=66666 begin -- 通过@@ERROR的值来判断是否是自定义的异常
    set @outstr = @outstr + '---------------- customer exception';
  end;
  return;
end catch;
go
 

 begin try
 raiserror('THIS IS AN ERROR',16,1) --注意，只有severity级别在11~19之间，控制才会跳转到catch块中。
end try
begin catch
 declare @error_message varchar(1000)  
 set @error_message=error_message()  
 raiserror(@error_message,16,1)  
 return  
end catch
go


----------------------------------------------------
-- Creating an ad hoc message in sys.messages 在 sys.messages 中创建即席消息
sp_addmessage @msgnum = 50005,  
              @severity = 10,  
              @msgtext = N'<\<%7.3s>>';  
GO  
RAISERROR (50005, -- Message id.  
           10, -- Severity,  
           1, -- State,  
           N'abcde'); -- First argument supplies the string.  
-- The message text returned is: <<    abc>>.  
GO  
sp_dropmessage @msgnum = 50005;  
GO
----------------------------------------------------


----------------------------------------------------
-- Using a local variable to supply the message text 使用局部变量提供消息文本
DECLARE @StringVariable NVARCHAR(50);  
SET @StringVariable = N'<\<%7.3s>>';  
  
RAISERROR (@StringVariable, -- Message text.  
           10, -- Severity,  
           1, -- State,  
           N'abcde'); -- First argument supplies the string.  
-- The message text returned is: <<    abc>>.  
GO
----------------------------------------------------



-- RAISERROR 可以代替 PRINT 将消息返回到调用应用程序。 RAISERROR 支持类似于 C 标准库中 printf 函数功能的字符代替，而 Transact-SQL PRINT 语句则不支持。 PRINT 语句不受 TRY 块的影响，而在严重级别为 11 到 19 的情况下在 TRY 块中运行的 RAISERROR 会将控制传输至关联的 CATCH 块。 指定严重级别为 10 或更低以使用 RAISERROR 返回 TRY 块中的消息，而不必调用 CATCH 块。
/* example
begin 
	print ...
	return
end

-------RETURN语句用于查询或过程中无条件退出。RETURN语句可在任何时候用于从过程、批处理或语句块中退出，位于RETURN之后的语句不会被执行。

begin
	raiseerror(...)
end
*/
	
BEGIN TRY  
    -- Generate a divide-by-zero error.  
    SELECT 1/0;  
END TRY  
BEGIN CATCH  
    SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  
GO


BEGIN TRY  
    -- Generate a divide-by-zero error.  
    SELECT 1/0;  
END TRY  
BEGIN CATCH  
    SELECT ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  
GO