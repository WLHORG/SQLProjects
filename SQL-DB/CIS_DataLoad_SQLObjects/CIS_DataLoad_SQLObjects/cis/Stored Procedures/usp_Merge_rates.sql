CREATE PROCEDURE [cis].[usp_Merge_rates]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.rates AS t
USING cis_delta.rates AS s 
ON (t.[product] = s.[product]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[product]
      ,[rate]
      ,[current_price]
      ,[future_price]
      ,[price_change_date]
      ,[history_only]
      ,[nominal_account_suffix]
      ,[rate_desc]
      ,[concessionary]
      ,[vat_exclusive]
      ,[amended_by]
      ,[amended_on]
      ,[currency_code]
      ,[subsequent_nominal_suffix]
      ,[current_price_lower_limit]
      ,[current_price_upper_limit]
      ,[future_price_lower_limit]
      ,[future_price_upper_limit]
      ,[fixed_price]
      ,[upper_lower_price_mandatory]
      ,[days_prior_from]
      ,[days_prior_to]
      ,[membership_lookup_group]
      ,[use_modifiers]
      ,[price_is_percentage]
      ,[web_publish]
	) 
	
VALUES(

	   s.[product]
      ,s.[rate]
      ,s.[current_price]
      ,s.[future_price]
      ,s.[price_change_date]
      ,s.[history_only]
      ,s.[nominal_account_suffix]
      ,s.[rate_desc]
      ,s.[concessionary]
      ,s.[vat_exclusive]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[currency_code]
      ,s.[subsequent_nominal_suffix]
      ,s.[current_price_lower_limit]
      ,s.[current_price_upper_limit]
      ,s.[future_price_lower_limit]
      ,s.[future_price_upper_limit]
      ,s.[fixed_price]
      ,s.[upper_lower_price_mandatory]
      ,s.[days_prior_from]
      ,s.[days_prior_to]
      ,s.[membership_lookup_group]
      ,s.[use_modifiers]
      ,s.[price_is_percentage]
      ,s.[web_publish])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[product] = s.[product]
      ,t.[rate] = s.[rate]
      ,t.[current_price] = s.[current_price]
      ,t.[future_price] = s.[future_price]
      ,t.[price_change_date] = s.[price_change_date]
      ,t.[history_only] = s.[history_only]
      ,t.[nominal_account_suffix] = s.[nominal_account_suffix]
      ,t.[rate_desc] = s.[rate_desc]
      ,t.[concessionary] = s.[concessionary]
      ,t.[vat_exclusive] = s.[vat_exclusive]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[currency_code] = s.[currency_code]
      ,t.[subsequent_nominal_suffix] = s.[subsequent_nominal_suffix]
      ,t.[current_price_lower_limit] = s.[current_price_lower_limit]
      ,t.[current_price_upper_limit] = s.[current_price_upper_limit]
      ,t.[future_price_lower_limit] = s.[future_price_lower_limit]
      ,t.[future_price_upper_limit] = s.[future_price_upper_limit]
      ,t.[fixed_price] = s.[fixed_price]
      ,t.[upper_lower_price_mandatory] = s.[upper_lower_price_mandatory]
      ,t.[days_prior_from] = s.[days_prior_from]
      ,t.[days_prior_to] = s.[days_prior_to]
      ,t.[membership_lookup_group] = s.[membership_lookup_group]
      ,t.[use_modifiers] = s.[use_modifiers]
      ,t.[price_is_percentage] = s.[price_is_percentage]
      ,t.[web_publish] = s.[web_publish]
	



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

	SELECT 'cis.rates' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
