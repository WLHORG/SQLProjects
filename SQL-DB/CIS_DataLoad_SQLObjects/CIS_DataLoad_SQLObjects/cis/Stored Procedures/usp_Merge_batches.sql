CREATE PROCEDURE [cis].[usp_Merge_batches]  
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; 
--Synchronize the target table with
--refreshed data from source table
MERGE cis.[batches] AS t   
USING cis_delta.[batches] AS s 
ON (t.[batch_number] = s.[batch_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	 [batch_number]
      ,[batch_type]
      ,[batch_date]
      ,[cash_book_batch]
      ,[bank_account]
      ,[number_of_entries]
      ,[batch_total]
      ,[transaction_total]
      ,[number_of_transactions]
      ,[next_transaction_number]
      ,[ready_for_banking]
      ,[paying_in_slip_printed]
      ,[posted_to_cash_book]
      ,[detail_completed]
      ,[posted_to_nominal]
      ,[picked]
      ,[product]
      ,[rate]
      ,[source]
      ,[transaction_type]
      ,[payment_method]
      ,[paying_in_slip_number]
      ,[currency_indicator]
      ,[currency_batch_total]
      ,[currency_transaction_total]
      ,[currency_exchange_rate]
      ,[amended_by]
      ,[amended_on]
      ,[journal_number]
      ,[batch_category]
      ,[balanced_by]
      ,[balanced_on]
      ,[posted_by]
      ,[posted_on]
      ,[contents_amended_by]
      ,[contents_amended_on]
      ,[header_amended_by]
      ,[header_amended_on]
      ,[batch_created_by]
      ,[batch_created_on]
      ,[post_nominal]
      ,[job_number]
      ,[provisional]
      ,[agency_number]
      ,[claim_sent]
      ,[currency_code]
      ,[batch_analysis_code]
      ,[campaign]
      ,[appeal]
      ,[banking_date]
	) 
	
VALUES(

	   s.[batch_number]
      ,s.[batch_type]
      ,s.[batch_date]
      ,s.[cash_book_batch]
      ,s.[bank_account]
      ,s.[number_of_entries]
      ,s.[batch_total]
      ,s.[transaction_total]
      ,s.[number_of_transactions]
      ,s.[next_transaction_number]
      ,s.[ready_for_banking]
      ,s.[paying_in_slip_printed]
      ,s.[posted_to_cash_book]
      ,s.[detail_completed]
      ,s.[posted_to_nominal]
      ,s.[picked]
      ,s.[product]
      ,s.[rate]
      ,s.[source]
      ,s.[transaction_type]
      ,s.[payment_method]
      ,s.[paying_in_slip_number]
      ,s.[currency_indicator]
      ,s.[currency_batch_total]
      ,s.[currency_transaction_total]
      ,s.[currency_exchange_rate]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[journal_number]
      ,s.[batch_category]
      ,s.[balanced_by]
      ,s.[balanced_on]
      ,s.[posted_by]
      ,s.[posted_on]
      ,s.[contents_amended_by]
      ,s.[contents_amended_on]
      ,s.[header_amended_by]
      ,s.[header_amended_on]
      ,s.[batch_created_by]
      ,s.[batch_created_on]
      ,s.[post_nominal]
      ,s.[job_number]
      ,s.[provisional]
      ,s.[agency_number]
      ,s.[claim_sent]
      ,s.[currency_code]
      ,s.[batch_analysis_code]
      ,s.[campaign]
      ,s.[appeal]
      ,s.[banking_date])
WHEN MATCHED   
    THEN UPDATE SET
	
		
 	 t.[batch_number] = s.[batch_number]
      ,t.[batch_type] = s.[batch_type]
      ,t.[batch_date] = s.[batch_date]
      ,t.[cash_book_batch] = s.[cash_book_batch]
      ,t.[bank_account] = s.[bank_account]
      ,t.[number_of_entries] = s.[number_of_entries]
      ,t.[batch_total] = s.[batch_total]
      ,t.[transaction_total] = s.[transaction_total]
      ,t.[number_of_transactions] = s.[number_of_transactions]
      ,t.[next_transaction_number] = s.[next_transaction_number]
      ,t.[ready_for_banking] = s.[ready_for_banking]
      ,t.[paying_in_slip_printed] = s.[paying_in_slip_printed]
      ,t.[posted_to_cash_book] = s.[posted_to_cash_book]
      ,t.[detail_completed] = s.[detail_completed]
      ,t.[posted_to_nominal] = s.[posted_to_nominal]
      ,t.[picked] = s.[picked]
      ,t.[product] = s.[product]
      ,t.[rate] = s.[rate]
      ,t.[source] = s.[source]
      ,t.[transaction_type] = s.[transaction_type]
      ,t.[payment_method] = s.[payment_method]
      ,t.[paying_in_slip_number] = s.[paying_in_slip_number]
      ,t.[currency_indicator] = s.[currency_indicator]
      ,t.[currency_batch_total] = s.[currency_batch_total]
      ,t.[currency_transaction_total] = s.[currency_transaction_total]
      ,t.[currency_exchange_rate] = s.[currency_exchange_rate]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[journal_number] = s.[journal_number]
      ,t.[batch_category] = s.[batch_category]
      ,t.[balanced_by] = s.[balanced_by]
      ,t.[balanced_on] = s.[balanced_on]
      ,t.[posted_by] = s.[posted_by]
      ,t.[posted_on] = s.[posted_on]
      ,t.[contents_amended_by] = s.[contents_amended_by]
      ,t.[contents_amended_on] = s.[contents_amended_on]
      ,t.[header_amended_by] = s.[header_amended_by]
      ,t.[header_amended_on] = s.[header_amended_on]
      ,t.[batch_created_by] = s.[header_amended_on]
      ,t.[batch_created_on] = s.[batch_created_on]
      ,t.[post_nominal] = s.[post_nominal]
      ,t.[job_number] = s.[job_number]
      ,t.[provisional] = s.[provisional]
      ,t.[agency_number] = s.[agency_number]
      ,t.[claim_sent] = s.[claim_sent]
      ,t.[currency_code] = s.[currency_code]
      ,t.[batch_analysis_code] = s.[batch_analysis_code]
      ,t.[campaign] = s.[campaign]
      ,t.[appeal] = s.[appeal]
      ,t.[banking_date] = s.[banking_date]

	 
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

	SELECT 'cis.batches' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
