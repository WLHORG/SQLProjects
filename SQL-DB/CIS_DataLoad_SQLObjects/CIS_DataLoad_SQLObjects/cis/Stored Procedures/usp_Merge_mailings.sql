CREATE PROCEDURE [cis].[usp_Merge_mailings]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.mailings AS t
USING cis_delta.mailings AS s 
ON (t.[mailing] = s.[mailing]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[mailing]
      ,[mailing_desc]
      ,[department]
      ,[history_only]
      ,[amended_by]
      ,[amended_on]
      ,[marketing]
      ,[direction]
      ,[mailing_template]
      ,[notes]
      ,[mailing_due]
	) 
	
VALUES(

	   s.[mailing]
      ,s.[mailing_desc]
      ,s.[department]
      ,s.[history_only]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[marketing]
      ,s.[direction]
      ,s.[mailing_template]
      ,s.[notes]
      ,s.[mailing_due])
WHEN MATCHED 
    THEN UPDATE SET
		
	 t.[mailing]  = s.[mailing]
      ,t.[mailing_desc]  = s.[mailing_desc]
      ,t.[department]  = s.[department]
      ,t.[history_only]  = s.[history_only]
      ,t.[amended_by]  = s.[amended_by]
      ,t.[amended_on]  = s.[amended_on]
      ,t.[marketing]  = s.[marketing]
      ,t.[direction]  = s.[direction]
      ,t.[mailing_template]  = s.[mailing_template]
      ,t.[notes]  = s.[notes]
      ,t.[mailing_due]  = s.[mailing_due]
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

	SELECT 'cis.mailings' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
