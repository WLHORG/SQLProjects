CREATE PROCEDURE [cis].[usp_Merge_gaye_pledges]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.[gaye_pledges] AS t
USING cis_delta.[gaye_pledges] AS s 
ON (t.[gaye_pledge_number] = s.[gaye_pledge_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
[gaye_pledge_number]
      ,[contact_number]
      ,[organisation_number]
      ,[agency_number]
      ,[donor_id]
      ,[pfo_code]
      ,[work_address_number]
      ,[paybill_address_number]
      ,[pledge_amount]
      ,[donor_total]
      ,[employer_total]
      ,[government_total]
      ,[admin_fees_total]
      ,[net_total]
      ,[start_date]
      ,[source]
      ,[product]
      ,[rate]
      ,[cancellation_reason]
      ,[cancelled_on]
      ,[cancelled_by]
      ,[distribution_code]
      ,[payroll_number]
      ,[amended_by]
      ,[amended_on]
      ,[payroll_organisation_number]
      ,[cancellation_source]
      ,[last_payment_date]
      ,[payment_frequency]
      ,[payment_number]
      ,[address_number]
      ,[created_by]
      ,[created_on]
	) 
	
VALUES(

	   s.[gaye_pledge_number]
      ,s.[contact_number]
      ,s.[organisation_number]
      ,s.[agency_number]
      ,s.[donor_id]
      ,s.[pfo_code]
      ,s.[work_address_number]
      ,s.[paybill_address_number]
      ,s.[pledge_amount]
      ,s.[donor_total]
      ,s.[employer_total]
      ,s.[government_total]
      ,s.[admin_fees_total]
      ,s.[net_total]
      ,s.[start_date]
      ,s.[source]
      ,s.[product]
      ,s.[rate]
      ,s.[cancellation_reason]
      ,s.[cancelled_on]
      ,s.[cancelled_by]
      ,s.[distribution_code]
      ,s.[payroll_number]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[payroll_organisation_number]
      ,s.[cancellation_source]
      ,s.[last_payment_date]
      ,s.[payment_frequency]
      ,s.[payment_number]
      ,s.[address_number]
      ,s.[created_by]
      ,s.[created_on])
WHEN MATCHED 
    THEN UPDATE SET
		
	 t.[gaye_pledge_number] = s.[gaye_pledge_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[organisation_number] = s.[organisation_number]
      ,t.[agency_number] = s.[agency_number]
      ,t.[donor_id] = s.[donor_id]
      ,t.[pfo_code] = s.[pfo_code]
      ,t.[work_address_number] = s.[work_address_number]
      ,t.[paybill_address_number] = s.[paybill_address_number]
      ,t.[pledge_amount] = s.[pledge_amount]
      ,t.[donor_total] = s.[donor_total]
      ,t.[employer_total] = s.[employer_total]
      ,t.[government_total] = s.[government_total]
      ,t.[admin_fees_total] = s.[admin_fees_total]
      ,t.[net_total] = s.[net_total]
      ,t.[start_date] = s.[start_date]
      ,t.[source] = s.[source]
      ,t.[product] = s.[product]
      ,t.[rate] = s.[rate]
      ,t.[cancellation_reason] = s.[cancellation_reason]
      ,t.[cancelled_on] = s.[cancelled_on]
      ,t.[cancelled_by] = s.[cancelled_by]
      ,t.[distribution_code] = s.[distribution_code]
      ,t.[payroll_number] = s.[payroll_number]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[payroll_organisation_number] = s.[payroll_organisation_number]
      ,t.[cancellation_source] = s.[cancellation_source]
      ,t.[last_payment_date] = s.[last_payment_date]
      ,t.[payment_frequency] = s.[payment_frequency]
      ,t.[payment_number] = s.[payment_number]
      ,t.[address_number] = s.[address_number]
      ,t.[created_by] = s.[created_by]
      ,t.[created_on] = s.[created_on]
	  
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

	SELECT 'cis.gaye_pledges' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
