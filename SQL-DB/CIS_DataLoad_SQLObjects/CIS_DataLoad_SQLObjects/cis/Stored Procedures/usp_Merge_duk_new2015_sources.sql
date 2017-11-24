CREATE PROCEDURE [cis].[usp_Merge_duk_new2015_sources]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.duk_new2015_sources AS t
USING cis_delta.duk_new2015_sources AS s 
ON (t.[source] = s.[source]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[source]
      ,[new_product]
      ,[region]
      ,[new_source]
      ,[new_source_desc]
      ,[new_cost_centre]
      ,[new_programme]
      ,[amended_by]
      ,[amended_on]
	) 
	
VALUES(

	   s.[source]
      ,s.[new_product]
      ,s.[region]
      ,s.[new_source]
      ,s.[new_source_desc]
      ,s.[new_cost_centre]
      ,s.[new_programme]
      ,s.[amended_by]
      ,s.[amended_on])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[source] = s.[source]
      ,t.[new_product] = s.[new_product]
      ,t.[region] = s.[region]
      ,t.[new_source] = s.[new_source]
      ,t.[new_source_desc] = s.[new_source_desc]
      ,t.[new_cost_centre] = s.[new_cost_centre]
      ,t.[new_programme] = s.[new_programme]
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

	SELECT 'cis.duk_new2015_sources' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
