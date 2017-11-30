CREATE PROCEDURE [cis].[usp_Merge_communications_log_subjects]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.communications_log_subjects AS t
USING cis_delta.communications_log_subjects AS s 
ON (t.[communications_log_number] = s.[communications_log_number]
AND t.[topic] = s.[topic]
AND t.[sub_topic] = s.[sub_topic]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[communications_log_number]
      ,[topic]
      ,[sub_topic]
      ,[primary]
      ,[quantity]
      ,[amended_on]
      ,[amended_by]
	) 
	
VALUES(

	   s.[communications_log_number]
      ,s.[topic]
      ,s.[sub_topic]
      ,s.[primary]
      ,s.[quantity]
      ,s.[amended_on]
      ,s.[amended_by])
WHEN MATCHED 
    THEN UPDATE SET
		
	 t.[communications_log_number] = s.[communications_log_number]
      ,t.[topic] = s.[topic]
      ,t.[sub_topic] = s.[sub_topic]
      ,t.[primary] = s.[primary]
      ,t.[quantity] = s.[quantity]
      ,t.[amended_on] = s.[amended_on]
      ,t.[amended_by] = s.[amended_by]
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

	SELECT 'cis.communications_log_subjects' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
