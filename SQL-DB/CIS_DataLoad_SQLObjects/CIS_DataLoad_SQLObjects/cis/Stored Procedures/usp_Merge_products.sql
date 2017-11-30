CREATE PROCEDURE [cis].[usp_Merge_products]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.products AS t
USING cis_delta.products AS s 
ON (t.[product] = s.[product]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[product]
      ,[product_desc]
      ,[extra_key]
      ,[product_vat_category]
      ,[nominal_account]
      ,[company]
      ,[sales_group]
      ,[stock_item]
      ,[despatch_method]
      ,[subscription]
      ,[donation]
      ,[cost_of_sale]
      ,[cost_of_sale_account]
      ,[cost_of_sale_accrual]
      ,[course]
      ,[accommodation]
      ,[postage_packing]
      ,[uses_product_numbers]
      ,[next_product_number]
      ,[max_numbers_allowed]
      ,[source]
      ,[warehouse]
      ,[bin_number]
      ,[weight]
      ,[sort_group]
      ,[history_only]
      ,[activity]
      ,[activity_value]
      ,[secondary_group]
      ,[product_category]
      ,[start_date]
      ,[last_stock_count]
      ,[original_cost]
      ,[amended_by]
      ,[amended_on]
      ,[sales_description]
      ,[subsequent_nominal_account]
      ,[sales_quantity]
      ,[minimum_quantity]
      ,[maximum_quantity]
      ,[sponsorship_event]
      ,[eligible_for_gift_aid]
      ,[pack_product]
      ,[web_publish]
	) 
	
VALUES(

	   s.[product]
      ,s.[product_desc]
      ,s.[extra_key]
      ,s.[product_vat_category]
      ,s.[nominal_account]
      ,s.[company]
      ,s.[sales_group]
      ,s.[stock_item]
      ,s.[despatch_method]
      ,s.[subscription]
      ,s.[donation]
      ,s.[cost_of_sale]
      ,s.[cost_of_sale_account]
      ,s.[cost_of_sale_accrual]
      ,s.[course]
      ,s.[accommodation]
      ,s.[postage_packing]
      ,s.[uses_product_numbers]
      ,s.[next_product_number]
      ,s.[max_numbers_allowed]
      ,s.[source]
      ,s.[warehouse]
      ,s.[bin_number]
      ,s.[weight]
      ,s.[sort_group]
      ,s.[history_only]
      ,s.[activity]
      ,s.[activity_value]
      ,s.[secondary_group]
      ,s.[product_category]
      ,s.[start_date]
      ,s.[last_stock_count]
      ,s.[original_cost]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[sales_description]
      ,s.[subsequent_nominal_account]
      ,s.[sales_quantity]
      ,s.[minimum_quantity]
      ,s.[maximum_quantity]
      ,s.[sponsorship_event]
      ,s.[eligible_for_gift_aid]
      ,s.[pack_product]
      ,s.[web_publish])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[product] = s.[product]
      ,t.[product_desc] = s.[product_desc]
      ,t.[extra_key] = s.[extra_key]
      ,t.[product_vat_category] = s.[product_vat_category]
      ,t.[nominal_account] = s.[nominal_account]
      ,t.[company] = s.[company]
      ,t.[sales_group] = s.[sales_group]
      ,t.[stock_item] = s.[stock_item]
      ,t.[despatch_method] = s.[despatch_method]
      ,t.[subscription] = s.[subscription]
      ,t.[donation] = s.[donation]
      ,t.[cost_of_sale] = s.[cost_of_sale]
      ,t.[cost_of_sale_account] = s.[cost_of_sale_account]
      ,t.[cost_of_sale_accrual] = s.[cost_of_sale_accrual]
      ,t.[course] = s.[course]
      ,t.[accommodation] = s.[accommodation]
      ,t.[postage_packing] = s.[postage_packing]
      ,t.[uses_product_numbers] = s.[uses_product_numbers]
      ,t.[next_product_number] = s.[next_product_number]
      ,t.[max_numbers_allowed] = s.[max_numbers_allowed]
      ,t.[source] = s.[source]
      ,t.[warehouse] = s.[warehouse]
      ,t.[bin_number] = s.[bin_number]
      ,t.[weight] = s.[weight]
      ,t.[sort_group] = s.[sort_group]
      ,t.[history_only] = s.[history_only]
      ,t.[activity] = s.[activity]
      ,t.[activity_value] = s.[activity_value]
      ,t.[secondary_group] = s.[secondary_group]
      ,t.[product_category] = s.[product_category]
      ,t.[start_date] = s.[start_date]
      ,t.[last_stock_count] = s.[last_stock_count]
      ,t.[original_cost] = s.[original_cost]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[sales_description] = s.[sales_description]
      ,t.[subsequent_nominal_account] = s.[subsequent_nominal_account]
      ,t.[sales_quantity] = s.[sales_quantity]
      ,t.[minimum_quantity] = s.[minimum_quantity]
      ,t.[maximum_quantity] = s.[maximum_quantity]
      ,t.[sponsorship_event] = s.[sponsorship_event]
      ,t.[eligible_for_gift_aid] = s.[eligible_for_gift_aid]
      ,t.[pack_product] = s.[pack_product]
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

	SELECT 'cis.products' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
