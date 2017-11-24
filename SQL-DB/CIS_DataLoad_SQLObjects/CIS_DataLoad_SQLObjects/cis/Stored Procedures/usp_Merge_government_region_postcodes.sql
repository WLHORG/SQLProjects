﻿CREATE PROCEDURE [cis].[usp_Merge_government_region_postcodes]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.government_region_postcodes AS t
USING cis_delta.government_region_postcodes AS s 
ON (t.[government_region] = s.[government_region]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
[government_region]
      ,[postcode]
      ,[amended_by]
      ,[amended_on]
	) 
	
VALUES(
 
      s.[government_region]
      ,s.[postcode]
      ,s.[amended_by]
      ,s.[amended_on])
WHEN MATCHED 
    THEN UPDATE SET
		
      t.[government_region] = s.[government_region]
      ,t.[postcode] = s.[postcode]
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

	SELECT 'cis.government_region_postcodes' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
