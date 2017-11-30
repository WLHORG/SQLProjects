CREATE PROCEDURE [cis].[usp_Merge_fundraising_requests]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.fundraising_requests  AS t
USING cis_delta.fundraising_requests  AS s 
ON (t.[fundraising_request_number] = s.[fundraising_request_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		 [fundraising_request_number]
      ,[contact_number]
      ,[request_date]
      ,[request_description]
      ,[fundraising_request_stage]
      ,[fundraising_status]
      ,[fundraising_request_type]
      ,[source]
      ,[target_amount]
      ,[pledged_amount]
      ,[pledged_date]
      ,[received_amount]
      ,[received_date]
      ,[notes]
      ,[amended_by]
      ,[amended_on]
      ,[expected_amount]
      ,[gik_expected_amount]
      ,[gik_pledged_amount]
      ,[gik_pledged_date]
      ,[total_gik_received_amount]
      ,[latest_gik_received_date]
      ,[number_of_payments]
      ,[request_end_date]
      ,[logname]
      ,[created_by]
      ,[created_on]
      ,[target_date]
      ,[fundraising_business_type])
	
VALUES(

	   s.[fundraising_request_number]
      ,s.[contact_number]
      ,s.[request_date]
      ,s.[request_description]
      ,s.[fundraising_request_stage]
      ,s.[fundraising_status]
      ,s.[fundraising_request_type]
      ,s.[source]
      ,s.[target_amount]
      ,s.[pledged_amount]
      ,s.[pledged_date]
      ,s.[received_amount]
      ,s.[received_date]
      ,s.[notes]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[expected_amount]
      ,s.[gik_expected_amount]
      ,s.[gik_pledged_amount]
      ,s.[gik_pledged_date]
      ,s.[total_gik_received_amount]
      ,s.[latest_gik_received_date]
      ,s.[number_of_payments]
      ,s.[request_end_date]
      ,s.[logname]
      ,s.[created_by]
      ,s.[created_on]
      ,s.[target_date]
      ,s.[fundraising_business_type])
WHEN MATCHED 
    THEN UPDATE SET
		
	t.[fundraising_request_number] = s.[fundraising_request_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[request_date] = s.[request_date]
      ,t.[request_description] = s.[request_description]
      ,t.[fundraising_request_stage] = s.[fundraising_request_stage]
      ,t.[fundraising_status] = s.[fundraising_status]
      ,t.[fundraising_request_type] = s.[fundraising_request_type]
      ,t.[source] = s.[source]
      ,t.[target_amount] = s.[target_amount]
      ,t.[pledged_amount] = s.[pledged_amount]
      ,t.[pledged_date] = s.[pledged_date]
      ,t.[received_amount] = s.[received_amount]
      ,t.[received_date] = s.[received_date]
      ,t.[notes] = s.[notes]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[expected_amount] = s.[expected_amount]
      ,t.[gik_expected_amount] = s.[gik_expected_amount]
      ,t.[gik_pledged_amount] = s.[gik_pledged_amount]
      ,t.[gik_pledged_date] = s.[gik_pledged_date]
      ,t.[total_gik_received_amount] = s.[total_gik_received_amount]
      ,t.[latest_gik_received_date] = s.[latest_gik_received_date]
      ,t.[number_of_payments] = s.[number_of_payments]
      ,t.[request_end_date] = s.[request_end_date]
      ,t.[logname] = s.[logname]
      ,t.[created_by] = s.[created_by]
      ,t.[created_on] = s.[created_on]
      ,t.[target_date] = s.[target_date]
      ,t.[fundraising_business_type] = s.[fundraising_business_type]

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

	SELECT 'cis.fundraising_requests' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
