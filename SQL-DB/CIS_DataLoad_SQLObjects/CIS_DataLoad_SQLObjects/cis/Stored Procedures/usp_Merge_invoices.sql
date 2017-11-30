CREATE PROCEDURE [cis].[usp_Merge_invoices]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.invoices AS t
USING cis_delta.invoices AS s 
ON (t.[contact_number] = s.[contact_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[contact_number]
      ,[address_number]
      ,[company]
      ,[batch_number]
      ,[transaction_number]
      ,[invoice_number]
      ,[invoice_date]
      ,[payment_due]
      ,[sales_ledger_batch]
      ,[sales_ledger_account]
      ,[invoice_pay_status]
      ,[invoice_dispute_code]
      ,[amount_paid]
      ,[record_type]
      ,[reprint_count]
      ,[deposit_amount]
      ,[print_invoice]
      ,[print_job_number]
      ,[provisional_invoice_number]
	) 
	
VALUES(

	   s.[contact_number]
      ,s.[address_number]
      ,s.[company]
      ,s.[batch_number]
      ,s.[transaction_number]
      ,s.[invoice_number]
      ,s.[invoice_date]
      ,s.[payment_due]
      ,s.[sales_ledger_batch]
      ,s.[sales_ledger_account]
      ,s.[invoice_pay_status]
      ,s.[invoice_dispute_code]
      ,s.[amount_paid]
      ,s.[record_type]
      ,s.[reprint_count]
      ,s.[deposit_amount]
      ,s.[print_invoice]
      ,s.[print_job_number]
      ,s.[provisional_invoice_number])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]
      ,t.[company] = s.[company]
      ,t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[invoice_number] = s.[invoice_number]
      ,t.[invoice_date] = s.[invoice_date]
      ,t.[payment_due] = s.[payment_due]
      ,t.[sales_ledger_batch] = s.[sales_ledger_batch]
      ,t.[sales_ledger_account] = s.[sales_ledger_account]
      ,t.[invoice_pay_status] = s.[invoice_pay_status]
      ,t.[invoice_dispute_code] = s.[invoice_dispute_code]
      ,t.[amount_paid] = s.[amount_paid]
      ,t.[record_type] = s.[record_type]
      ,t.[reprint_count] = s.[reprint_count]
      ,t.[deposit_amount] = s.[deposit_amount]
      ,t.[print_invoice] = s.[print_invoice]
      ,t.[print_job_number] = s.[print_job_number]
      ,t.[provisional_invoice_number] = s.[provisional_invoice_number]
	 
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

	SELECT 'cis.invoices' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
