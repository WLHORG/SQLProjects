CREATE PROCEDURE [cis].[usp_Merge_branch_postcodes]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.branch_postcodes AS t
USING cis_delta.branch_postcodes AS s 
ON (t.[branch] = s.[branch]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[branch]
      ,[outward_postcode]
      ,[amended_on]
      ,[amended_by]
	) 
	
VALUES(

	   s.[branch]
      ,s.[outward_postcode]
      ,s.[amended_on]
      ,s.[amended_by])
WHEN MATCHED 
    THEN UPDATE SET
		
	 t.[branch] = s.[branch]
      ,t.[outward_postcode] = s.[outward_postcode]
      ,t.[amended_on] = s.[amended_on]
      ,t.[amended_by] = s.[amended_by]
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

	SELECT 'cis.branch_postcodes' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
