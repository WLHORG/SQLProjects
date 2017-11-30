CREATE PROCEDURE [cis].[usp_Merge_Venues]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.venues AS t
USING cis_delta.venues AS s 
ON (t.[venue] = s.[venue]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[venue]
      ,[venue_desc]
      ,[contact_number]
      ,[organisation_number]
      ,[address_number]
      ,[amended_by]
      ,[amended_on]
      ,[location]
      ,[venue_capacity]
	) 
	
VALUES(

	   s.[venue]
      ,s.[venue_desc]
      ,s.[contact_number]
      ,s.[organisation_number]
      ,s.[address_number]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[location]
      ,s.[venue_capacity])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[venue] = s.[venue]
      ,t.[venue_desc] = s.[venue_desc]
      ,t.[contact_number] = s.[contact_number]
      ,t.[organisation_number] = s.[organisation_number]
      ,t.[address_number] = s.[address_number]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[location] = s.[location]
      ,t.[venue_capacity] = s.[venue_capacity]

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

	SELECT 'cis.venues' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
