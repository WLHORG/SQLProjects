CREATE PROCEDURE [cis].[usp_Merge_contact_links]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE [cis].[contact_links]  AS t
USING [cis_delta].[contact_links]  AS s 
ON (t.[contact_number_1] = s.[contact_number_1]
AND t.[contact_number_2] = s.[contact_number_2]
) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
[contact_number_1]
      ,[contact_number_2]
      ,[relationship]
      ,[valid_from]
      ,[valid_to]
      ,[historical]
      ,[notes]
      ,[amended_by]
      ,[amended_on]
      ,[relationship_status])
	
VALUES(

	   s.[contact_number_1]
      ,s.[contact_number_2]
      ,s.[relationship]
      ,s.[valid_from]
      ,s.[valid_to]
      ,s.[historical]
      ,s.[notes]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[relationship_status])
WHEN MATCHED 
    THEN UPDATE SET
			
	t.[contact_number_1]  = s.[contact_number_1]
      ,t.[contact_number_2] = s.[contact_number_2]
      ,t.[relationship] = s.[relationship]
      ,t.[valid_from] = s.[valid_from]
      ,t.[valid_to] = s.[valid_to]
      ,t.[historical] = s.[historical]
      ,t.[notes] = s.[notes]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[relationship_status] = s.[relationship_status]
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

	SELECT 'cis.contact_links' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
