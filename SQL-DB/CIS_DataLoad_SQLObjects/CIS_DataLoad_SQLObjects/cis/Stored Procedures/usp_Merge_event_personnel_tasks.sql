CREATE PROCEDURE [cis].[usp_Merge_event_personnel_tasks]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.event_personnel_tasks  AS t
USING cis_delta.event_personnel_tasks  AS s 
ON (t.[event_personnel_number] = s.[event_personnel_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		 [event_personnel_number]
      ,[personnel_task]
      ,[amended_by]
      ,[amended_on]
      ,[event_personnel_task_number]
      ,[start_date]
      ,[start_time]
      ,[end_date]
      ,[end_time]
      ,[notes]
      ,[event_number]
      ,[external_task_id])
	
VALUES(

	   s.[event_personnel_number]
      ,s.[personnel_task]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[event_personnel_task_number]
      ,s.[start_date]
      ,s.[start_time]
      ,s.[end_date]
      ,s.[end_time]
      ,s.[notes]
      ,s.[event_number]
      ,s.[external_task_id])
WHEN MATCHED 
    THEN UPDATE SET
		
	t.[event_personnel_number] = s.[event_personnel_number]
      ,t.[personnel_task] = s.[personnel_task]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[event_personnel_task_number] = s.[event_personnel_task_number]
      ,t.[start_date] = s.[start_date]
      ,t.[start_time] = s.[start_time]
      ,t.[end_date] = s.[end_date]
      ,t.[end_time] = s.[end_time]
      ,t.[notes] = s.[notes]
      ,t.[event_number] = s.[event_number]
      ,t.[external_task_id] = s.[external_task_id]

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

	SELECT 'cis.event_personnel_tasks' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
