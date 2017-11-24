CREATE PROCEDURE [cis].[usp_Merge_event_personnel]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.event_personnel  AS t
USING cis_delta.event_personnel  AS s 
ON (t.[session_number] = s.[session_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		 [session_number]
      ,[contact_number]
      ,[address_number]
      ,[function]
      ,[confirmed]
      ,[confirmed_by]
      ,[expenses_received]
      ,[expenses]
      ,[authorised_on]
      ,[authorised_by]
      ,[task]
      ,[start_date]
      ,[end_date]
      ,[start_time]
      ,[end_time]
      ,[position]
      ,[organisation_name]
      ,[amended_on]
      ,[amended_by]
      ,[event_personnel_number]
      ,[issue_resources])
	
VALUES(

	   s.[session_number]
      ,s.[contact_number]
      ,s.[address_number]
      ,s.[function]
      ,s.[confirmed]
      ,s.[confirmed_by]
      ,s.[expenses_received]
      ,s.[expenses]
      ,s.[authorised_on]
      ,s.[authorised_by]
      ,s.[task]
      ,s.[start_date]
      ,s.[end_date]
      ,s.[start_time]
      ,s.[end_time]
      ,s.[position]
      ,s.[organisation_name]
      ,s.[amended_on]
      ,s.[amended_by]
      ,s.[event_personnel_number]
      ,s.[issue_resources])
WHEN MATCHED 
    THEN UPDATE SET
		
	t.[session_number] = s.[session_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]
      ,t.[function] = s.[function]
      ,t.[confirmed] = s.[confirmed]
      ,t.[confirmed_by] = s.[confirmed_by]
      ,t.[expenses_received] = s.[expenses_received]
      ,t.[expenses] = s.[expenses]
      ,t.[authorised_on] = s.[authorised_on]
      ,t.[authorised_by] = s.[authorised_by]
      ,t.[task] = s.[task]
      ,t.[start_date] = s.[start_date]
      ,t.[end_date] = s.[end_date]
      ,t.[start_time] = s.[start_time]
      ,t.[end_time] = s.[end_time]
      ,t.[position] = s.[position]
      ,t.[organisation_name] = s.[organisation_name]
      ,t.[amended_on] = s.[amended_on]
      ,t.[amended_by] = s.[amended_by]
      ,t.[event_personnel_number] = s.[event_personnel_number]
      ,t.[issue_resources] = s.[issue_resources]

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

	SELECT 'cis.event_personnel' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
