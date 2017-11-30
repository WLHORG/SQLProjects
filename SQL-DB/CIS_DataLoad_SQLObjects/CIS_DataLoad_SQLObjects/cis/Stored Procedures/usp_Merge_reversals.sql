CREATE PROCEDURE [cis].[usp_Merge_reversals]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.reversals AS t
USING cis_delta.reversals AS s 
ON (t.[batch_number] = s.[batch_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[batch_number]
      ,[transaction_number]
      ,[line_number]
      ,[was_batch_number]
      ,[was_transaction_number]
      ,[was_line_number]
      ,[was_oph_status]
	) 
	
VALUES(

	   s.[batch_number]
      ,s.[transaction_number]
      ,s.[line_number]
      ,s.[was_batch_number]
      ,s.[was_transaction_number]
      ,s.[was_line_number]
      ,s.[was_oph_status])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[line_number] = s.[line_number]
      ,t.[was_batch_number] = s.[was_batch_number]
      ,t.[was_transaction_number] = s.[was_transaction_number]
      ,t.[was_line_number] = s.[was_line_number]
      ,t.[was_oph_status] = s.[was_oph_status]



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

	SELECT 'cis.reversals' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
