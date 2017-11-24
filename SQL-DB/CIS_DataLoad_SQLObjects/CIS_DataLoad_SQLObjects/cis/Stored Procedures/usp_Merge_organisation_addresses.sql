CREATE PROCEDURE [cis].[usp_Merge_organisation_addresses]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.organisation_addresses  AS t
USING cis_delta.organisation_addresses  AS s 
ON (t.[address_link_number] = s.[address_link_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[address_link_number]
      ,[address_number]
      ,[organisation_number]
      ,[historical]
      ,[valid_from]
      ,[valid_to]
      ,[amended_by]
      ,[amended_on])
	
VALUES(

	   s.[address_link_number]
      ,s.[address_number]
      ,s.[organisation_number]
      ,s.[historical]
      ,s.[valid_from]
      ,s.[valid_to]
      ,s.[amended_by]
      ,s.[amended_on])
WHEN MATCHED 
    THEN UPDATE SET
		
	t.[address_link_number] = s.[address_link_number]
      ,t.[address_number] = s.[address_number]
      ,t.[organisation_number] = s.[organisation_number]
      ,t.[historical] = s.[historical]
      ,t.[valid_from] = s.[valid_from]
      ,t.[valid_to] = s.[valid_to]
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

	SELECT 'cis.organisation_addresses' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
