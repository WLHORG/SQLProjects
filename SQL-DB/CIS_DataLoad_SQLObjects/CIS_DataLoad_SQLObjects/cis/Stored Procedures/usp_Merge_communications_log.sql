CREATE PROCEDURE [cis].[usp_Merge_communications_log]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.communications_log AS t
USING cis_delta.communications_log AS s 
ON (t.[communications_log_number] = s.[communications_log_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[communications_log_number]
      ,[contact_number]
      ,[address_number]
      ,[document_type]
      ,[created_by]
      ,[precis]
      ,[document_class]
      ,[direction]
      ,[our_reference]
      ,[their_reference]
      ,[document]
      ,[department]
      ,[standard_document]
      ,[archiver]
      ,[recipient]
      ,[forwarded]
      ,[completed]
      ,[dated]
      ,[received]
      ,[package]
      ,[in_use_by]
      ,[distributed]
      ,[call_duration]
      ,[total_duration]
      ,[source]
      ,[subject]
      ,[selection_set]
	) 
	
VALUES(

	   s.[communications_log_number]
      ,s.[contact_number]
      ,s.[address_number]
      ,s.[document_type]
      ,s.[created_by]
      ,s.[precis]
      ,s.[document_class]
      ,s.[direction]
      ,s.[our_reference]
      ,s.[their_reference]
      ,s.[document]
      ,s.[department]
      ,s.[standard_document]
      ,s.[archiver]
      ,s.[recipient]
      ,s.[forwarded]
      ,s.[completed]
      ,s.[dated]
      ,s.[received]
      ,s.[package]
      ,s.[in_use_by]
      ,s.[distributed]
      ,s.[call_duration]
      ,s.[total_duration]
      ,s.[source]
      ,s.[subject]
      ,s.[selection_set])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[communications_log_number] = s.[communications_log_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]
      ,t.[document_type] = s.[document_type]
      ,t.[created_by] = s.[created_by]
      ,t.[precis] = s.[precis]
      ,t.[document_class] = s.[document_class]
      ,t.[direction] = s.[direction]
      ,t.[our_reference] = s.[our_reference]
      ,t.[their_reference] = s.[their_reference]
      ,t.[document] = s.[document]
      ,t.[department] = s.[department]
      ,t.[standard_document] = s.[standard_document]
      ,t.[archiver] = s.[archiver]
      ,t.[recipient] = s.[recipient]
      ,t.[forwarded] = s.[forwarded]
      ,t.[completed] = s.[completed]
      ,t.[dated] = s.[dated]
      ,t.[received] = s.[received]
      ,t.[package] = s.[package]
      ,t.[in_use_by] = s.[in_use_by]
      ,t.[distributed] = s.[distributed]
      ,t.[call_duration] = s.[call_duration]
      ,t.[total_duration] = s.[total_duration]
      ,t.[source] = s.[source]
      ,t.[subject] = s.[subject]
      ,t.[selection_set] = s.[selection_set]
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

	SELECT 'cis.communications_log' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
