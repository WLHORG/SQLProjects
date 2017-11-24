CREATE PROCEDURE [cis].[usp_Merge_mailing_history]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.mailing_history AS t
USING cis_delta.mailing_history AS s 
ON (t.[mailing] = s.[mailing]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[mailing]
      ,[mailing_date]
      ,[mailing_by]
      ,[number_in_mailing]
      ,[mailing_number]
      ,[mailing_filename]
      ,[notes]
      ,[issue_id]
      ,[number_emails_bounced]
      ,[number_emails_opened]
      ,[number_emails_clicked]
	) 
	
VALUES(

	   s.[mailing]
      ,s.[mailing_date]
      ,s.[mailing_by]
      ,s.[number_in_mailing]
      ,s.[mailing_number]
      ,s.[mailing_filename]
      ,s.[notes]
      ,s.[issue_id]
      ,s.[number_emails_bounced]
      ,s.[number_emails_opened]
      ,s.[number_emails_clicked])
WHEN MATCHED 
    THEN UPDATE SET
		
	 t.[mailing] = s.[mailing]
      ,t.[mailing_date] = s.[mailing_date]
      ,t.[mailing_by] = s.[mailing_by]
      ,t.[number_in_mailing] = s.[number_in_mailing]
      ,t.[mailing_number] = s.[mailing_number]
      ,t.[mailing_filename] = s.[mailing_filename]
      ,t.[notes] = s.[notes]
      ,t.[issue_id] = s.[issue_id]
      ,t.[number_emails_bounced] = s.[number_emails_bounced]
      ,t.[number_emails_opened] = s.[number_emails_opened]
      ,t.[number_emails_clicked] = s.[number_emails_clicked]
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

	SELECT 'cis.mailing_history' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
