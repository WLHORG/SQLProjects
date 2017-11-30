CREATE PROCEDURE [cis].[usp_Merge_Financial_History] 
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; 
--Synchronize the target table with
--refreshed data from source table
MERGE cis.Financial_History AS t
USING cis_delta.Financial_History AS s 
ON (t.[batch_number] = s.[batch_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	    [batch_number]
      ,[transaction_number]
      ,[contact_number]
      ,[transaction_date]
      ,[transaction_type]
      ,[bank_details_number]
      ,[amount]
      ,[payment_method]
      ,[reference]
      ,[posted]
      ,[address_number]
      ,[status]
      ,[currency_amount]
      ,[transaction_origin]
      ,[notes]
	) 
	
VALUES(

	   s.[batch_number]
      ,s.[transaction_number]
      ,s.[contact_number]
      ,s.[transaction_date]
      ,s.[transaction_type]
      ,s.[bank_details_number]
      ,s.[amount]
      ,s.[payment_method]
      ,s.[reference]
      ,s.[posted]
      ,s.[address_number]
      ,s.[status]
      ,s.[currency_amount]
      ,s.[transaction_origin]
      ,s.[notes])
WHEN MATCHED   
    THEN UPDATE SET
	
		
	 t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[transaction_date] = s.[transaction_date]
      ,t.[transaction_type] = s.[transaction_type]
      ,t.[bank_details_number] = s.[bank_details_number]
      ,t.[amount] = s.[amount]
      ,t.[payment_method] = s.[payment_method]
      ,t.[reference] = s.[reference]
      ,t.[posted] = s.[posted]
      ,t.[address_number] = s.[address_number]
      ,t.[status] = s.[status]
      ,t.[currency_amount] = s.[currency_amount]
      ,t.[transaction_origin] = s.[transaction_origin]
      ,t.[notes] = s.[notes]

	 
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

	SELECT 'cis.Financial_History' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
