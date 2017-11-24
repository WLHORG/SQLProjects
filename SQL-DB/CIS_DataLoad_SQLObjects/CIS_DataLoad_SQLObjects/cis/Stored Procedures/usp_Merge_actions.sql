CREATE PROCEDURE [cis].[usp_Merge_actions]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.actions  AS t
USING cis_delta.actions  AS s 
ON (t.[action_number] = s.[action_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		 [action_number]
      ,[master_action]
      ,[action_level]
      ,[sequence_number]
      ,[action_desc]
      ,[action_text]
      ,[action_priority]
      ,[action_status]
      ,[document_class]
      ,[created_by]
      ,[created_on]
      ,[duration_days]
      ,[duration_hours]
      ,[duration_minutes]
      ,[deadline]
      ,[scheduled_on]
      ,[completed_on]
      ,[repeat_count]
      ,[delayed_activation]
      ,[actioner_setting]
      ,[manager_setting]
      ,[amended_by]
      ,[amended_on])
	
VALUES(

	   s.[action_number]
      ,s.[master_action]
      ,s.[action_level]
      ,s.[sequence_number]
      ,s.[action_desc]
      ,s.[action_text]
      ,s.[action_priority]
      ,s.[action_status]
      ,s.[document_class]
      ,s.[created_by]
      ,s.[created_on]
      ,s.[duration_days]
      ,s.[duration_hours]
      ,s.[duration_minutes]
      ,s.[deadline]
      ,s.[scheduled_on]
      ,s.[completed_on]
      ,s.[repeat_count]
      ,s.[delayed_activation]
      ,s.[actioner_setting]
      ,s.[manager_setting]
      ,s.[amended_by]
      ,s.[amended_on])
WHEN MATCHED 
    THEN UPDATE SET
		
	t.[action_number] = s.[action_number]
      ,t.[master_action] = s.[master_action]
      ,t.[action_level] = s.[action_level]
      ,t.[sequence_number] = s.[sequence_number]
      ,t.[action_desc] = s.[action_desc]
      ,t.[action_text] = s.[action_text]
      ,t.[action_priority] = s.[action_priority]
      ,t.[action_status] = s.[action_status]
      ,t.[document_class] = s.[document_class]
      ,t.[created_by] = s.[created_by]
      ,t.[created_on] = s.[created_on]
      ,t.[duration_days] = s.[duration_days]
      ,t.[duration_hours] = s.[duration_hours]
      ,t.[duration_minutes] = s.[duration_minutes]
      ,t.[deadline] = s.[deadline]
      ,t.[scheduled_on] = s.[scheduled_on]
      ,t.[completed_on] = s.[completed_on]
      ,t.[repeat_count] = s.[repeat_count]
      ,t.[delayed_activation] = s.[delayed_activation]
      ,t.[actioner_setting] = s.[actioner_setting]
      ,t.[manager_setting] = s.[manager_setting]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]

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

	SELECT 'cis.actions' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
