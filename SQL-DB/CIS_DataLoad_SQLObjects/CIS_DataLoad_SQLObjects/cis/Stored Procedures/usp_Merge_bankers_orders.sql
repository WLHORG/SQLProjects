CREATE PROCEDURE [cis].[usp_Merge_bankers_orders]  
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; 
--Synchronize the target table with
--refreshed data from source table
MERGE cis.bankers_orders AS t   
USING cis_delta.bankers_orders AS s 
ON (t.[bankers_order_number] = s.[bankers_order_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	  [bankers_order_number]
      ,[contact_number]
      ,[address_number]
      ,[order_number]
      ,[reference]
      ,[start_date]
      ,[amount]
      ,[bank_account]
      ,[bank_details_number]
      ,[cancellation_reason]
      ,[cancelled_on]
      ,[cancelled_by]
      ,[amended_by]
      ,[amended_on]
      ,[source]
      ,[standing_order_type]
      ,[cancellation_source]
      ,[created_by]
      ,[created_on]
      ,[future_cancellation_reason]
      ,[future_cancellation_date]
      ,[future_cancellation_source]
	) 
	
VALUES(

	   s.[bankers_order_number]
      ,s.[contact_number]
      ,s.[address_number]
      ,s.[order_number]
      ,s.[reference]
      ,s.[start_date]
      ,s.[amount]
      ,s.[bank_account]
      ,s.[bank_details_number]
      ,s.[cancellation_reason]
      ,s.[cancelled_on]
      ,s.[cancelled_by]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[source]
      ,s.[standing_order_type]
      ,s.[cancellation_source]
      ,s.[created_by]
      ,s.[created_on]
      ,s.[future_cancellation_reason]
      ,s.[future_cancellation_date]
      ,s.[future_cancellation_source])
WHEN MATCHED   
    THEN UPDATE SET
	
		
 	 t.[bankers_order_number] = s.[bankers_order_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]
      ,t.[order_number] = s.[order_number]
      ,t.[reference] = s.[reference]
      ,t.[start_date] = s.[start_date]
      ,t.[amount] = s.[amount]
      ,t.[bank_account] = s.[bank_account]
      ,t.[bank_details_number]  = s.[bank_details_number]
      ,t.[cancellation_reason] = s.[cancellation_reason]
      ,t.[cancelled_on] = s.[cancelled_on]
      ,t.[cancelled_by] = s.[cancelled_by]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[source] = s.[source]
      ,t.[standing_order_type] = s.[standing_order_type]
      ,t.[cancellation_source] = s.[cancellation_source]
      ,t.[created_by] = s.[created_by]
      ,t.[created_on] = s.[created_on]
      ,t.[future_cancellation_reason] = s.[future_cancellation_reason]
      ,t.[future_cancellation_date] = s.[future_cancellation_date]
      ,t.[future_cancellation_source] = s.[future_cancellation_reason]

	 
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

	SELECT 'cis.bankers_orders' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
