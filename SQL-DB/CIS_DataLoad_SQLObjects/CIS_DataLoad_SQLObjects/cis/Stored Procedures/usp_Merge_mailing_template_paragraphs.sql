CREATE PROCEDURE [cis].[usp_Merge_mailing_template_paragraphs]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.mailing_template_paragraphs AS t
USING cis_delta.mailing_template_paragraphs AS s 
ON (t.[mailing_template] = s.[mailing_template]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[mailing_template]
      ,[paragraph_number]
      ,[sequence_number]
      ,[paragraph_desc]
      ,[bookmark_name]
      ,[mandatory]
      ,[paragraph_condition]
      ,[control_value]
      ,[amended_by]
      ,[amended_on]
      ,[control_value2]
	) 
	
VALUES(

	   s.[mailing_template]
      ,s.[paragraph_number]
      ,s.[sequence_number]
      ,s.[paragraph_desc]
      ,s.[bookmark_name]
      ,s.[mandatory]
      ,s.[paragraph_condition]
      ,s.[control_value]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[control_value2])
WHEN MATCHED 
    THEN UPDATE SET
		
	 t.[mailing_template] = s.[mailing_template]
      ,t.[paragraph_number] = s.[paragraph_number]
      ,t.[sequence_number] = s.[sequence_number]
      ,t.[paragraph_desc] = s.[paragraph_desc]
      ,t.[bookmark_name] = s.[bookmark_name]
      ,t.[mandatory] = s.[mandatory]
      ,t.[paragraph_condition] = s.[paragraph_condition]
      ,t.[control_value] = s.[control_value]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[control_value2] = s.[control_value2]
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

	SELECT 'cis.mailing_template_paragraphs' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
