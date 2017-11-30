CREATE PROCEDURE [cis].[usp_Merge_Financial_Links] 
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; 
--Synchronize the target table with
--refreshed data from source table
MERGE cis.Financial_Links AS t
USING cis_delta.Financial_Links AS s 
ON (t.[batch_number] = s.[batch_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	   [contact_number]
      ,[donor_contact_number]
      ,[batch_number]
      ,[transaction_number]
      ,[line_number]
      ,[line_type]
	) 
	
VALUES(

	   s.[contact_number]
      ,s.[donor_contact_number]
      ,s.[batch_number]
      ,s.[transaction_number]
      ,s.[line_number]
      ,s.[line_type])
WHEN MATCHED   
    THEN UPDATE SET
	
		
	 t.[contact_number] = s.[contact_number]
      ,t.[donor_contact_number] = s.[donor_contact_number]
      ,t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[line_number] = s.[line_number]
      ,t.[line_type] = s.[line_type]

	 
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

	SELECT 'cis.Financial_Links' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
