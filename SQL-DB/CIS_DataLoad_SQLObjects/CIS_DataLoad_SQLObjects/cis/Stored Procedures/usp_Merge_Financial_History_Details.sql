CREATE PROCEDURE [cis].[usp_Merge_Financial_History_Details]
AS 

BEGIN TRY
    BEGIN TRANSACTION;
--wrap in tran - error handling
INSERT INTO  cis.[financial_history_details] 

	 SELECT
	  s.[batch_number]
      ,s.[transaction_number]
      ,s.[line_number]
      ,s.[amount]
      ,s.[product]
      ,s.[rate]
      ,s.[source]
      ,s.[quantity]
      ,s.[vat_rate]
      ,s.[vat_amount]
      ,s.[status]
      ,s.[sales_contact_number]
      ,s.[invoice_payment]
      ,s.[distribution_code]
      ,s.[currency_amount]
      ,s.[currency_vat_amount]
	  FROM cis_delta.[financial_history_details] s
  		
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

	SELECT 'cis.financial_history_details' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH
	 COMMIT TRANSACTION;
	
