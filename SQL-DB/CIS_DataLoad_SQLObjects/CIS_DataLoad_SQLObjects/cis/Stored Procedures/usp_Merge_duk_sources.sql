CREATE PROCEDURE [cis].[usp_Merge_duk_sources]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.duk_sources AS t
USING cis_delta.duk_sources AS s 
ON (t.[source] = s.[source]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[source]
      ,[source_desc]
      ,[df_flag]
      ,[df_batch_type]
      ,[df_mapping]
      ,[acq_source_group]
      ,[acq_source_sub_group]
      ,[donation_product]
      ,[donation_rg_product]
      ,[web_alias]
      ,[rate]
      ,[amended_by]
      ,[amended_on]
      ,[num_ring_fence_days]
      ,[is_event]
	) 
	
VALUES(

	   s.[source]
      ,s.[source_desc]
      ,s.[df_flag]
      ,s.[df_batch_type]
      ,s.[df_mapping]
      ,s.[acq_source_group]
      ,s.[acq_source_sub_group]
      ,s.[donation_product]
      ,s.[donation_rg_product]
      ,s.[web_alias]
      ,s.[rate]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[num_ring_fence_days]
      ,s.[is_event])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[source] = s.[source]
      ,t.[source_desc] = s.[source_desc]
      ,t.[df_flag] = s.[df_flag]
      ,t.[df_batch_type] = s.[df_batch_type]
      ,t.[df_mapping] = s.[df_mapping]
      ,t.[acq_source_group] = s.[acq_source_group]
      ,t.[acq_source_sub_group] = s.[acq_source_sub_group]
      ,t.[donation_product] = s.[donation_product]
      ,t.[donation_rg_product] = s.[donation_rg_product]
      ,t.[web_alias] = s.[web_alias]
      ,t.[rate] = s.[rate]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[num_ring_fence_days] = s.[num_ring_fence_days]
      ,t.[is_event] = s.[is_event]
	 
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

	SELECT 'cis.duk_sources' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
