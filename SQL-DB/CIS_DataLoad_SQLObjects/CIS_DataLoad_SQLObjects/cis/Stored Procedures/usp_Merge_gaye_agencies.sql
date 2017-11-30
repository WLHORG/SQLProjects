CREATE PROCEDURE [cis].[usp_Merge_gaye_agencies]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.[gaye_agencies] AS t
USING cis_delta.[gaye_agencies] AS s 
ON (t.[organisation_number] = s.[organisation_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
[organisation_number]
      ,[post_batches_to_cb]
      ,[amended_by]
      ,[amended_on]
      ,[admin_fee_percentage]
      ,[minimum_admin_fee]
      ,[maximum_admin_fee]
	) 
	
VALUES(

	   s.[organisation_number]
      ,s.[post_batches_to_cb]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[admin_fee_percentage]
      ,s.[minimum_admin_fee]
      ,s.[maximum_admin_fee])
WHEN MATCHED 
    THEN UPDATE SET
		

	  t.[organisation_number] = s.[organisation_number]
      ,t.[post_batches_to_cb] = s.[post_batches_to_cb]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[admin_fee_percentage] = s.[admin_fee_percentage]
      ,t.[minimum_admin_fee] = s.[minimum_admin_fee]
      ,t.[maximum_admin_fee] = s.[maximum_admin_fee]
	  
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

	SELECT 'cis.gaye_agencies' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
