CREATE PROCEDURE [cis].[usp_Merge_Invoice_Payment_History] 
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; 
--Synchronize the target table with
--refreshed data from source table
MERGE cis.Invoice_Payment_History AS t   
USING cis_delta.Invoice_Payment_History AS s 
ON (t.[invoice_number] = s.[invoice_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	   [invoice_number]
      ,[batch_number]
      ,[transaction_number]
      ,[line_number]
      ,[amount]
      ,[status]
      ,[provisional_invoice_number]
      ,[allocation_date]
      ,[allocation_batch_number]
      ,[allocation_transaction_number]
      ,[allocation_line_number]
	) 
	
VALUES(

	   s.[invoice_number]
      ,s.[batch_number]
      ,s.[transaction_number]
      ,s.[line_number]
      ,s.[amount]
      ,s.[status]
      ,s.[provisional_invoice_number]
      ,s.[allocation_date]
      ,s.[allocation_batch_number]
      ,s.[allocation_transaction_number]
      ,s.[allocation_line_number])
WHEN MATCHED   
    THEN UPDATE SET
	
		
 	 t.[invoice_number] = s.[invoice_number]
      ,t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[line_number] = s.[line_number]
      ,t.[amount] = s.[amount]
      ,t.[status] = s.[status]
      ,t.[provisional_invoice_number] = s.[provisional_invoice_number]
      ,t.[allocation_date] = s.[allocation_date]
      ,t.[allocation_batch_number] = s.[allocation_batch_number]
      ,t.[allocation_transaction_number] = s.[allocation_transaction_number]
      ,t.[allocation_line_number] = s.[allocation_line_number]

	 
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

	SELECT 'cis.Invoice_Payment_History' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
