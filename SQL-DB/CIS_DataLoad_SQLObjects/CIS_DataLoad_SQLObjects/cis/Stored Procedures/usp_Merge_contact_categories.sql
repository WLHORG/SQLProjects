CREATE PROCEDURE [cis].[usp_Merge_contact_categories]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE [cis].[contact_categories]  AS t
USING [cis_delta].[contact_categories]  AS s 
ON (t.[contact_number] = s.[contact_number]
) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[contact_number]
      ,[activity]
      ,[activity_value]
      ,[quantity]
      ,[source]
      ,[valid_from]
      ,[valid_to]
      ,[amended_by]
      ,[amended_on]
      ,[notes]
      ,[activity_date])
	
VALUES(

	   s.[contact_number]
      ,s.[activity]
      ,s.[activity_value]
      ,s.[quantity]
      ,s.[source]
      ,s.[valid_from]
      ,s.[valid_to]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[notes]
      ,s.[activity_date])
WHEN MATCHED 
    THEN UPDATE SET
		
	 t.[contact_number] = s.[contact_number]
      ,t.[activity] = s.[activity]
      ,t.[activity_value] = s.[activity_value]
      ,t.[quantity] = s.[quantity]
      ,t.[source] = s.[source]
      ,t.[valid_from] = s.[valid_from]
      ,t.[valid_to] = s.[valid_to]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[notes] = s.[notes]
      ,t.[activity_date] = s.[activity_date]

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

	SELECT 'cis.contact_categories' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
