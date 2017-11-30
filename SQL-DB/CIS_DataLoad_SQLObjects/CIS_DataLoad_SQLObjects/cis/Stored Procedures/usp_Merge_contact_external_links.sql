CREATE PROCEDURE [cis].[usp_Merge_contact_external_links]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE [cis].[contact_external_links]  AS t
USING [cis_delta].[contact_external_links]  AS s 
ON (t.[contact_number] = s.[contact_number]
) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[contact_number]
      ,[data_source]
      ,[external_reference]
      ,[amended_by]
      ,[amended_on])
	
VALUES(

	   s.[contact_number]
      ,s.[data_source]
      ,s.[external_reference]
      ,s.[amended_by]
      ,s.[amended_on])
WHEN MATCHED 
    THEN UPDATE SET
			
      t.[contact_number] = s.[contact_number]
      ,t.[data_source] = s.[data_source]
      ,t.[external_reference] = s.[external_reference]
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

	SELECT 'cis.contact_external_links' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
