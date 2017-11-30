CREATE PROCEDURE [cis].[usp_Merge_direct_debits]  
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; 
--Synchronize the target table with
--refreshed data from source table
MERGE cis.direct_debits AS t   
USING cis_delta.direct_debits AS s 
ON (t.[direct_debit_number] = s.[direct_debit_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[direct_debit_number]
      ,[contact_number]
      ,[address_number]
      ,[order_number]
      ,[start_date]
      ,[bank_details_number]
      ,[bank_account]
      ,[cancellation_reason]
      ,[cancelled_on]
      ,[cancelled_by]
      ,[amended_on]
      ,[amended_by]
      ,[amount]
      ,[source]
      ,[reference]
      ,[first_claim]
      ,[emandate_created]
      ,[auddis_cancel_notified]
      ,[cancellation_source]
      ,[mandate_type]
      ,[created_by]
      ,[created_on]
      ,[future_cancellation_reason]
      ,[future_cancellation_date]
      ,[future_cancellation_source]
	) 
	
VALUES(

	   s.[direct_debit_number]
      ,s.[contact_number]
      ,s.[address_number]
      ,s.[order_number]
      ,s.[start_date]
      ,s.[bank_details_number]
      ,s.[bank_account]
      ,s.[cancellation_reason]
      ,s.[cancelled_on]
      ,s.[cancelled_by]
      ,s.[amended_on]
      ,s.[amended_by]
      ,s.[amount]
      ,s.[source]
      ,s.[reference]
      ,s.[first_claim]
      ,s.[emandate_created]
      ,s.[auddis_cancel_notified]
      ,s.[cancellation_source]
      ,s.[mandate_type]
      ,s.[created_by]
      ,s.[created_on]
      ,s.[future_cancellation_reason]
      ,s.[future_cancellation_date]
      ,s.[future_cancellation_source])
WHEN MATCHED   
    THEN UPDATE SET
	
		
 	 t.[direct_debit_number] = s.[direct_debit_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]
      ,t.[order_number] = s.[order_number]
      ,t.[start_date] = s.[start_date]
      ,t.[bank_details_number] = s.[bank_details_number]
      ,t.[bank_account] = s.[bank_account]
      ,t.[cancellation_reason] = s.[cancellation_reason]
      ,t.[cancelled_on] = s.[cancelled_on]
      ,t.[cancelled_by] = s.[cancelled_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amount] = s.[amount]
      ,t.[source] = s.[source]
      ,t.[reference] = s.[reference]
      ,t.[first_claim] = s.[first_claim]
      ,t.[emandate_created] = s.[emandate_created]
      ,t.[auddis_cancel_notified] = s.[auddis_cancel_notified]
      ,t.[cancellation_source] = s.[cancellation_source]
      ,t.[mandate_type] = s.[mandate_type]
      ,t.[created_by] = s.[created_by]
      ,t.[created_on] = s.[created_on]
      ,t.[future_cancellation_reason] = s.[future_cancellation_reason]
      ,t.[future_cancellation_date] = s.[future_cancellation_date]
      ,t.[future_cancellation_source] = s.[future_cancellation_source]
	 
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

	SELECT 'cis.direct_debits' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
