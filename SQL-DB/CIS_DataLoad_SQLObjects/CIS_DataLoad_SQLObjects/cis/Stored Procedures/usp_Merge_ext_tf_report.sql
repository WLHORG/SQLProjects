CREATE PROCEDURE [cis].[usp_Merge_ext_tf_report]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.[ext_tf_report] AS t
USING cis_delta.[ext_tf_report] AS s 
ON (t.[organisation_number] = s.[organisation_number]
AND t.[organisation_number_2] = s.[organisation_number_2]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	  [organisation_number]
      ,[organisation_source_date]
      ,[organisation_number_2]
      ,[organisation_name]
      ,[relationship]
      ,[contact_number]
      ,[label_name]
      ,[source]
      ,[source_desc]
      ,[product]
      ,[product_desc]
      ,[amount]
      ,[donation]
      ,[status]
      ,[source_date]
      ,[transaction_date]
      ,[reference]
      ,[batch_number]
      ,[transaction_number]
      ,[line_number]
      ,[transaction_type]
      ,[financial_links_ind]
      ,[report_ind]
	) 
	
VALUES(

	   s.[organisation_number]
      ,s.[organisation_source_date]
      ,s.[organisation_number_2]
      ,s.[organisation_name]
      ,s.[relationship]
      ,s.[contact_number]
      ,s.[label_name]
      ,s.[source]
      ,s.[source_desc]
      ,s.[product]
      ,s.[product_desc]
      ,s.[amount]
      ,s.[donation]
      ,s.[status]
      ,s.[source_date]
      ,s.[transaction_date]
      ,s.[reference]
      ,s.[batch_number]
      ,s.[transaction_number]
      ,s.[line_number]
      ,s.[transaction_type]
      ,s.[financial_links_ind]
      ,s.[report_ind])
WHEN MATCHED 
    THEN UPDATE SET
		
	  t.[organisation_number] = s.[organisation_number]
      ,t.[organisation_source_date] = s.[organisation_source_date]
      ,t.[organisation_number_2] = s.[organisation_number_2]
      ,t.[organisation_name] = s.[organisation_name]
      ,t.[relationship] = s.[relationship]
      ,t.[contact_number] = s.[contact_number]
      ,t.[label_name] = s.[label_name]
      ,t.[source] = s.[source]
      ,t.[source_desc] = s.[source_desc]
      ,t.[product] = s.[product]
      ,t.[product_desc] = s.[product_desc]
      ,t.[amount] = s.[amount]
      ,t.[donation] = s.[donation]
      ,t.[status] = s.[status]
      ,t.[source_date] = s.[source_date]
      ,t.[transaction_date] = s.[transaction_date]
      ,t.[reference] = s.[reference]
      ,t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[line_number] = s.[line_number]
      ,t.[transaction_type] = s.[transaction_type]
      ,t.[financial_links_ind] = s.[financial_links_ind]
      ,t.[report_ind] = s.[report_ind]
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

	SELECT 'cis.ext_tf_report' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
