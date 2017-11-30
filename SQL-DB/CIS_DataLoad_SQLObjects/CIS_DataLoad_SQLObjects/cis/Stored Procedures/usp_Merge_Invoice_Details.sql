CREATE PROCEDURE [cis].[usp_Merge_Invoice_Details] 
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; 
--Synchronize the target table with
--refreshed data from source table
MERGE cis.Invoice_Details AS t
USING cis_delta.Invoice_Details AS s 
ON (t.[batch_number] = s.[batch_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	   [batch_number]
      ,[transaction_number]
      ,[line_number]
      ,[invoice_number]
	) 
	
VALUES(

	   s.[batch_number]
      ,s.[transaction_number]
      ,s.[line_number]
      ,s.[invoice_number])
WHEN MATCHED   
    THEN UPDATE SET
	
		
 	 t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[line_number] = s.[line_number]
      ,t.[invoice_number] = s.[invoice_number]

	 
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

	SELECT 'cis.Invoice_Details' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
