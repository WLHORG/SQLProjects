CREATE PROCEDURE [cis].[usp_Merge_Status_History]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE [cis].[status_history]  AS t
USING [cis_delta].[status_history]  AS s 
ON (t.[contact_number] = s.[contact_number]
AND t.[status] = s.[status]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		 [contact_number]
      ,[status]
      ,[status_reason]
      ,[valid_to]
      ,[amended_by]
      ,[amended_on]
      ,[response_channel])
	
VALUES(

	   s.[contact_number]
      ,s.[status]
      ,s.[status_reason]
      ,s.[valid_to]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[response_channel])
WHEN MATCHED 
    THEN UPDATE SET
		
	  t.[contact_number] =  s.[contact_number]
      ,t.[status] =  s.[status]
      ,t.[status_reason] =  s.[status_reason]
      ,t.[valid_to] =  s.[valid_to]
      ,t.[amended_by] =  s.[amended_by]
      ,t.[amended_on] =  s.[amended_on]
      ,t.[response_channel] =  s.[response_channel]

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

	SELECT 'cis.status_history' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
