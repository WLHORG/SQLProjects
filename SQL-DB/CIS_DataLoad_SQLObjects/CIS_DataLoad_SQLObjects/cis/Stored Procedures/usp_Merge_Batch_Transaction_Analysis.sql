CREATE PROCEDURE [cis].[usp_Merge_Batch_Transaction_Analysis] 
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; 
--Synchronize the target table with
--refreshed data from source table
MERGE cis.Batch_Transaction_Analysis AS t
USING cis_delta.Batch_Transaction_Analysis AS s 
ON (t.[batch_number] = s.[batch_number]
AND t.[transaction_number] = s.[transaction_number]
AND t.[line_number] = s.[line_number] ) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	   [batch_number]
      ,[transaction_number]
      ,[line_number]
      ,[line_type]
      ,[product]
      ,[rate]
      ,[quantity]
      ,[issued]
      ,[gross_amount]
      ,[amount]
      ,[currency_amount]
      ,[discount]
      ,[vat_rate]
      ,[vat_amount]
      ,[currency_vat_amount]
      ,[order_number]
      ,[member_number]
      ,[covenant_number]
      ,[deceased_contact_number]
      ,[accept_as_full]
      ,[despatch_method]
      ,[source]
      ,[when]
      ,[contact_number]
      ,[address_number]
      ,[distribution_code]
      ,[amended_by]
      ,[amended_on]
      ,[sales_contact_number]
      ,[invoice_number]
      ,[product_number]
      ,[warehouse]
      ,[notes]
	) 
	
VALUES(

	   s.[batch_number]
      ,s.[transaction_number]
      ,s.[line_number]
      ,s.[line_type]
      ,s.[product]
      ,s.[rate]
      ,s.[quantity]
      ,s.[issued]
      ,s.[gross_amount]
      ,s.[amount]
      ,s.[currency_amount]
      ,s.[discount]
      ,s.[vat_rate]
      ,s.[vat_amount]
      ,s.[currency_vat_amount]
      ,s.[order_number]
      ,s.[member_number]
      ,s.[covenant_number]
      ,s.[deceased_contact_number]
      ,s.[accept_as_full]
      ,s.[despatch_method]
      ,s.[source]
      ,s.[when]
      ,s.[contact_number]
      ,s.[address_number]
      ,s.[distribution_code]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[sales_contact_number]
      ,s.[invoice_number]
      ,s.[product_number]
      ,s.[warehouse]
      ,s.[notes])
WHEN MATCHED   
    THEN UPDATE SET
	
		
	 t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[line_number] = s.[line_number]
      ,t.[line_type] = s.[line_type]
      ,t.[product] = s.[product]
      ,t.[rate] = s.[rate]
      ,t.[quantity] = s.[quantity]
      ,t.[issued] = s.[issued]
      ,t.[gross_amount] = s.[gross_amount]
      ,t.[amount] = s.[amount]
      ,t.[currency_amount] = s.[currency_amount]
      ,t.[discount] = s.[discount]
      ,t.[vat_rate] = s.[vat_rate]
      ,t.[vat_amount] = s.[vat_amount]
      ,t.[currency_vat_amount] = s.[currency_vat_amount]
      ,t.[order_number] = s.[order_number]
      ,t.[member_number] = s.[member_number]
      ,t.[covenant_number] = s.[covenant_number]
      ,t.[deceased_contact_number] = s.[deceased_contact_number]
      ,t.[accept_as_full] = s.[accept_as_full]
      ,t.[despatch_method] = s.[despatch_method]
      ,t.[source] = s.[source]
      ,t.[when] = s.[when]
      ,t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]
      ,t.[distribution_code] = s.[distribution_code]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[sales_contact_number] = s.[sales_contact_number]
      ,t.[invoice_number] = s.[invoice_number]
      ,t.[product_number] = s.[product_number]
      ,t.[warehouse] = s.[warehouse]
      ,t.[notes] = s.[notes]

	 
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

	SELECT 'cis.Batch_Transaction_Analysis' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
