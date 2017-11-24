CREATE PROCEDURE [cis].[usp_Merge_Order_Payment_Schedule]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.Order_Payment_Schedule AS t
USING cis_delta.Order_Payment_Schedule AS s 
ON (t.[scheduled_payment_number] = s.[scheduled_payment_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[scheduled_payment_number]
      ,[order_number]
      ,[due_date]
      ,[claim_date]
      ,[amount_due]
      ,[amount_outstanding]
      ,[revised_amount]
      ,[expected_balance]
      ,[scheduled_payment_status]
      ,[schedule_creation_reason]
      ,[amended_by]
      ,[amended_on]
	) 
	
VALUES(

	   s.[scheduled_payment_number]
      ,s.[order_number]
      ,s.[due_date]
      ,s.[claim_date]
      ,s.[amount_due]
      ,s.[amount_outstanding]
      ,s.[revised_amount]
      ,s.[expected_balance]
      ,s.[scheduled_payment_status]
      ,s.[schedule_creation_reason]
      ,s.[amended_by]
      ,s.[amended_on])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[scheduled_payment_number] = s.[scheduled_payment_number]
      ,t.[order_number] = s.[order_number]
      ,t.[due_date] = s.[due_date]
      ,t.[claim_date] = s.[claim_date]
      ,t.[amount_due] = s.[amount_due]
      ,t.[amount_outstanding] = s.[amount_outstanding]
      ,t.[revised_amount] = s.[revised_amount]
      ,t.[expected_balance] = s.[expected_balance]
      ,t.[scheduled_payment_status] = s.[scheduled_payment_status]
      ,t.[schedule_creation_reason] = s.[schedule_creation_reason]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
	 
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

	SELECT 'cis.Order_Payment_Schedule' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
