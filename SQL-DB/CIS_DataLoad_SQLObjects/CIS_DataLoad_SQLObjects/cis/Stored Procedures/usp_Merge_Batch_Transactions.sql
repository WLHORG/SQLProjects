CREATE PROCEDURE [cis].[usp_Merge_Batch_Transactions]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; 
--Synchronize the target table with
--refreshed data from source table
MERGE cis.Batch_Transactions AS t
USING cis_delta.Batch_Transactions AS s 
ON (t.[batch_number] = s.[batch_number]
AND t.transaction_number = s.transaction_number
AND t.[contact_number] = s.[contact_number]  ) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	  [batch_number]
      ,[transaction_number]
      ,[contact_number]
      ,[address_number]
      ,[transaction_date]
      ,[transaction_type]
      ,[bank_details_number]
      ,[amount]
      ,[currency_amount]
      ,[payment_method]
      ,[reference]
      ,[next_line_number]
      ,[line_total]
      ,[mailing]
      ,[receipt]
      ,[mailing_contact_number]
      ,[mailing_address_number]
      ,[amended_by]
      ,[amended_on]
      ,[eligible_for_gift_aid]
      ,[transaction_origin]
      ,[notes]
	) 
	
VALUES(

	   s.[batch_number]
      ,s.[transaction_number]
      ,s.[contact_number]
      ,s.[address_number]
      ,s.[transaction_date]
      ,s.[transaction_type]
      ,s.[bank_details_number]
      ,s.[amount]
      ,s.[currency_amount]
      ,s.[payment_method]
      ,s.[reference]
      ,s.[next_line_number]
      ,s.[line_total]
      ,s.[mailing]
      ,s.[receipt]
      ,s.[mailing_contact_number]
      ,s.[mailing_address_number]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[eligible_for_gift_aid]
      ,s.[transaction_origin]
      ,s.[notes])
WHEN MATCHED   
    THEN UPDATE SET
	
		
	 t.[batch_number] = s.[batch_number]
    ,t.[transaction_number] = s.[transaction_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]
      ,t.[transaction_date] = s.[transaction_date]
      ,t.[transaction_type] = s.[transaction_type]
      ,t.[bank_details_number] = s.[bank_details_number]
      ,t.[amount] = s.[amount]
      ,t.[currency_amount] = s.[currency_amount]
      ,t.[payment_method] = s.[payment_method]
      ,t.[reference] = s.[reference]
      ,t.[next_line_number] = s.[next_line_number]
      ,t.[line_total] = s.[line_total]
      ,t.[mailing] = s.[mailing]
      ,t.[receipt] = s.[receipt]
      ,t.[mailing_contact_number] = s.[mailing_contact_number]
      ,t.[mailing_address_number] = s.[mailing_address_number]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[eligible_for_gift_aid] = s.[eligible_for_gift_aid]
      ,t.[transaction_origin] = s.[transaction_origin]
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

	SELECT 'cis.Batch_Transactions' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
