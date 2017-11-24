CREATE PROCEDURE [cis].[usp_Merge_sessions]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.[sessions]  AS t
USING cis_delta.[sessions]  AS s 
ON (t.[event_number] = s.[event_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[event_number]
      ,[session_number]
      ,[session_desc]
      ,[session_type]
      ,[subject]
      ,[skill_level]
      ,[start_date]
      ,[end_date]
      ,[start_time]
      ,[end_time]
      ,[location]
      ,[minimum_attendees]
      ,[maximum_attendees]
      ,[target_attendees]
      ,[number_interested]
      ,[number_of_attendees]
      ,[number_on_waiting_list]
      ,[maximum_on_waiting_list]
      ,[notes]
      ,[venue_booking_number]
      ,[cpd_approval_status]
      ,[cpd_awarding_body]
      ,[cpd_category]
      ,[cpd_year]
      ,[cpd_points]
      ,[cpd_notes]
      ,[amended_by]
      ,[amended_on]
      ,[cpd_date_approved]
      ,[long_description]
      ,[external_appointment_id])
	
VALUES(

	   s.[event_number]
      ,s.[session_number]
      ,s.[session_desc]
      ,s.[session_type]
      ,s.[subject]
      ,s.[skill_level]
      ,s.[start_date]
      ,s.[end_date]
      ,s.[start_time]
      ,s.[end_time]
      ,s.[location]
      ,s.[minimum_attendees]
      ,s.[maximum_attendees]
      ,s.[target_attendees]
      ,s.[number_interested]
      ,s.[number_of_attendees]
      ,s.[number_on_waiting_list]
      ,s.[maximum_on_waiting_list]
      ,s.[notes]
      ,s.[venue_booking_number]
      ,s.[cpd_approval_status]
      ,s.[cpd_awarding_body]
      ,s.[cpd_category]
      ,s.[cpd_year]
      ,s.[cpd_points]
      ,s.[cpd_notes]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[cpd_date_approved]
      ,s.[long_description]
      ,s.[external_appointment_id])
WHEN MATCHED 
    THEN UPDATE SET
		
	t.[event_number] = s.[event_number]
      ,t.[session_number] = s.[session_number]
      ,t.[session_desc] = s.[session_desc]
      ,t.[session_type] = s.[session_type]
      ,t.[subject] = s.[subject]
      ,t.[skill_level] = s.[skill_level]
      ,t.[start_date] = s.[start_date]
      ,t.[end_date] = s.[end_date]
      ,t.[start_time] = s.[start_time]
      ,t.[end_time] = s.[end_time]
      ,t.[location] = s.[location]
      ,t.[minimum_attendees] = s.[minimum_attendees]
      ,t.[maximum_attendees] = s.[maximum_attendees]
      ,t.[target_attendees] = s.[target_attendees]
      ,t.[number_interested] = s.[number_interested]
      ,t.[number_of_attendees] = s.[number_of_attendees]
      ,t.[number_on_waiting_list] = s.[number_on_waiting_list]
      ,t.[maximum_on_waiting_list] = s.[maximum_on_waiting_list]
      ,t.[notes] = s.[notes]
      ,t.[venue_booking_number] = s.[venue_booking_number]
      ,t.[cpd_approval_status] = s.[cpd_approval_status]
      ,t.[cpd_awarding_body] = s.[cpd_awarding_body]
      ,t.[cpd_category] = s.[cpd_category]
      ,t.[cpd_year] = s.[cpd_year]
      ,t.[cpd_points] = s.[cpd_points]
      ,t.[cpd_notes] = s.[cpd_notes]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[cpd_date_approved] = s.[cpd_date_approved]
      ,t.[long_description] = s.[long_description]
      ,t.[external_appointment_id] = s.[external_appointment_id]

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

	SELECT 'cis.sessions' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
