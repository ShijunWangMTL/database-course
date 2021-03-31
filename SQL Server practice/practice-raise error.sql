select * from sys.messages
where severity = 16 

RAISERROR (15600,-1,-1, 'mysp_CreateCustomer');
RAISERROR (15600,1,-1, 'mysp_CreateCustomer');

-- �����Ĳ����滻������ת����񣻵�һ�������滻��һ��ת����񣬵ڶ��������滻�ڶ���ת������Դ����ơ� ���磬������ RAISERROR ����У���һ������ N'number' �滻��һ��ת����� %s���ڶ������� 5 �滻�ڶ���ת����� %d.��
RAISERROR (N'This is message %s %d.', -- Message text.  
           10, -- Severity,  
           1, -- State,  
           N'number', -- First argument.  ��һ������ N'number' �滻��һ��ת����� %s
           5); -- Second argument.  �ڶ������� 5 �滻�ڶ���ת����� %d
-- The message text returned is: This is message number 5.  
GO


    declare @error_mes varchar(1000)
    set @error_mes='�����Ǵ���������ʾ��'
    raiserror(@error_mes,16,1)
	go

declare @error_mes varchar(1000)
set @error_mes='�������û�%s�����Ĵ�������'
raiserror(@error_mes,16,1,'����')
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
--Returning error information from a CATCH block �� CATCH �鷵�ش�����Ϣ
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
   set @j = 10/0; -- ��Ϊ������Ϊ0,�������ｫ���׳�һ��ϵͳ���쳣
  end
  else begin
   set @j = @i;
   set @outstr = 'customer exception';
   -- �׳��Զ�����쳣,������catch����ͳһ�����쳣
   RAISERROR (66666, -- Message id.
      16, -- Severity,
      1 -- State,
      ) ;
  end;
end try
begin catch
  if @@ERROR=66666 begin -- ͨ��@@ERROR��ֵ���ж��Ƿ����Զ�����쳣
    set @outstr = @outstr + '---------------- customer exception';
  end;
  return;
end catch;
go
 

 begin try
 raiserror('THIS IS AN ERROR',16,1) --ע�⣬ֻ��severity������11~19֮�䣬���ƲŻ���ת��catch���С�
end try
begin catch
 declare @error_message varchar(1000)  
 set @error_message=error_message()  
 raiserror(@error_message,16,1)  
 return  
end catch
go


----------------------------------------------------
-- Creating an ad hoc message in sys.messages �� sys.messages �д�����ϯ��Ϣ
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
-- Using a local variable to supply the message text ʹ�þֲ������ṩ��Ϣ�ı�
DECLARE @StringVariable NVARCHAR(50);  
SET @StringVariable = N'<\<%7.3s>>';  
  
RAISERROR (@StringVariable, -- Message text.  
           10, -- Severity,  
           1, -- State,  
           N'abcde'); -- First argument supplies the string.  
-- The message text returned is: <<    abc>>.  
GO
----------------------------------------------------



-- RAISERROR ���Դ��� PRINT ����Ϣ���ص�����Ӧ�ó��� RAISERROR ֧�������� C ��׼���� printf �������ܵ��ַ����棬�� Transact-SQL PRINT �����֧�֡� PRINT ��䲻�� TRY ���Ӱ�죬�������ؼ���Ϊ 11 �� 19 ��������� TRY �������е� RAISERROR �Ὣ���ƴ����������� CATCH �顣 ָ�����ؼ���Ϊ 10 �������ʹ�� RAISERROR ���� TRY ���е���Ϣ�������ص��� CATCH �顣
/* example
begin 
	print ...
	return
end

-------RETURN������ڲ�ѯ��������������˳���RETURN�������κ�ʱ�����ڴӹ��̡���������������˳���λ��RETURN֮�����䲻�ᱻִ�С�

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