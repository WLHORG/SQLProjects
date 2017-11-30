CREATE PROCEDURE [cis].[usp_Merge_Users]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE [cis].[users]  AS t
USING [cis_delta].[users]  AS s 
ON (t.[logname] = s.[logname]
) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[logname]
      ,[department]
      ,[printer]
      ,[label_style]
      ,[amended_on]
      ,[amended_by]
      ,[menu_item]
      ,[access_level]
      ,[full_name]
      ,[position]
      ,[personal_db]
      ,[contact_number]
      ,[organisation_number]
      ,[email_login]
      ,[remote_user]
      ,[access_control_group]
      ,[ownership_group]
      ,[history_only]
      ,[network_logname]
      ,[email_password])
	
VALUES(

	   s.[logname]
      ,s.[department]
      ,s.[printer]
      ,s.[label_style]
      ,s.[amended_on]
      ,s.[amended_by]
      ,s.[menu_item]
      ,s.[access_level]
      ,s.[full_name]
      ,s.[position]
      ,s.[personal_db]
      ,s.[contact_number]
      ,s.[organisation_number]
      ,s.[email_login]
      ,s.[remote_user]
      ,s.[access_control_group]
      ,s.[ownership_group]
      ,s.[history_only]
      ,s.[network_logname]
      ,s.[email_password])
WHEN MATCHED 
    THEN UPDATE SET
			
		t.[logname] = s.[logname]
      ,t.[department] = s.[department]
      ,t.[printer] = s.[printer]
      ,t.[label_style] = s.[label_style]
      ,t.[amended_on] = s.[amended_on]
      ,t.[amended_by] = s.[amended_by]
      ,t.[menu_item] = s.[menu_item]
      ,t.[access_level] = s.[access_level]
      ,t.[full_name] = s.[full_name]
      ,t.[position] = s.[position]
      ,t.[personal_db] = s.[personal_db]
      ,t.[contact_number] = s.[contact_number]
      ,t.[organisation_number] = s.[organisation_number]
      ,t.[email_login] = s.[email_login]
      ,t.[remote_user] = s.[remote_user]
      ,t.[access_control_group] = s.[access_control_group]
      ,t.[ownership_group] = s.[ownership_group]
      ,t.[history_only] = s.[history_only]
      ,t.[network_logname] = s.[network_logname]
      ,t.[email_password] = s.[email_password]
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

	SELECT 'cis.users' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
