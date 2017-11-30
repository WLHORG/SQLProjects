CREATE PROCEDURE [cis].[usp_Merge_contact_suppressions]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE [cis].[contact_suppressions]  AS t
USING [cis_delta].[contact_suppressions]  AS s 
ON (t.[contact_number] = s.[contact_number]
AND t.[mailing_suppression] = s.[mailing_suppression]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[contact_number]
      ,[mailing_suppression]
      ,[valid_from]
      ,[valid_to]
      ,[amended_by]
      ,[amended_on]
      ,[notes]
      ,[source])
	
VALUES(

	   s.[contact_number]
      ,s.[mailing_suppression]
      ,s.[valid_from]
      ,s.[valid_to]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[notes]
      ,s.[source])
WHEN MATCHED 
    THEN UPDATE SET
			
      t.[contact_number] = s.[contact_number]
      ,t.[mailing_suppression] = s.[contact_number]
      ,t.[valid_from] = s.[contact_number]
      ,t.[valid_to] = s.[contact_number]
      ,t.[amended_by] = s.[contact_number]
      ,t.[amended_on] = s.[contact_number]
      ,t.[notes] = s.[contact_number]
      ,t.[source] = s.[contact_number]

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

	SELECT 'cis.contact_suppressions' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
