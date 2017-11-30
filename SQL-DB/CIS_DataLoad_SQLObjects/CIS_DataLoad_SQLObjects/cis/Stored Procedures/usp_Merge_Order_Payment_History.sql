CREATE PROCEDURE [cis].[usp_Merge_Order_Payment_History]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; 
--Synchronize the target table with
--refreshed data from source table
MERGE cis.Order_Payment_History AS t
USING cis_delta.Order_Payment_History AS s 
ON (t.[batch_number] = s.[batch_number]
AND t.[transaction_number] = s.[transaction_number]
AND t.[line_number] = s.[line_number]
and t.[payment_number] = s.[payment_number]
AND t.[order_number] = s.[order_number]
and t.[scheduled_payment_number] = s.[scheduled_payment_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	   [batch_number]
      ,[transaction_number]
      ,[line_number]
      ,[payment_number]
      ,[order_number]
      ,[amount]
      ,[balance]
      ,[status]
      ,[scheduled_payment_number]
      ,[posted]
	) 
	
VALUES(

	   s.[batch_number]
      ,s.[transaction_number]
      ,s.[line_number]
      ,s.[payment_number]
      ,s.[order_number]
      ,s.[amount]
      ,s.[balance]
      ,s.[status]
      ,s.[scheduled_payment_number]
      ,s.[posted])
WHEN MATCHED   
    THEN UPDATE SET
	
		
	 t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[line_number] = s.[line_number]
      ,t.[payment_number] = s.[payment_number]
      ,t.[order_number] = s.[order_number]
      ,t.[amount] = s.[amount]
      ,t.[balance] = s.[balance]
      ,t.[status] = s.[status]
      ,t.[scheduled_payment_number] = s.[scheduled_payment_number]
      ,t.[posted] = s.[posted]

	 
	  ; 


	 		 COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    IF @@TRANCOUNT > 0
    ROLLBACK TRANSACTION;
 
    DECLARE @ErrorNumber INT = ERROR_NUMBER();
    DECLARE @ErrorLine INT = ERROR_LINE();
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
    DECLARE @ErrorState INT = ERROR_STATE();
 

	INSERT INTO [control].[TableErrors]

	SELECT 'cis.Order_Payment_History' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
