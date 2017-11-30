CREATE PROCEDURE [cis].[usp_Merge_Covenants]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.covenants AS t
USING cis_delta.covenants AS s 
ON (t.[contact_number] = s.[contact_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[contact_number]
      ,[address_number]
      ,[covenant_number]
      ,[covenant_type]
      ,[covenant_term]
      ,[fixed]
      ,[covenant_status]
      ,[covenanted_amount]
      ,[start_date]
      ,[signature_date]
      ,[deposited_deed]
      ,[net]
      ,[annual_claim]
      ,[order_number]
      ,[last_tax_claim]
      ,[tax_claimed_to]
      ,[r185_return]
      ,[r185_sent]
      ,[cancellation_reason]
      ,[cancelled_on]
      ,[cancelled_by]
      ,[source]
      ,[amended_by]
      ,[amended_on]
      ,[created_by]
      ,[created_on]
      ,[payment_number]
      ,[r185_payment_number]
      ,[initial_payment_number]
      ,[cancellation_source]
	) 
	
VALUES(

	   s.[contact_number]
      ,s.[address_number]
      ,s.[covenant_number]
      ,s.[covenant_type]
      ,s.[covenant_term]
      ,s.[fixed]
      ,s.[covenant_status]
      ,s.[covenanted_amount]
      ,s.[start_date]
      ,s.[signature_date]
      ,s.[deposited_deed]
      ,s.[net]
      ,s.[annual_claim]
      ,s.[order_number]
      ,s.[last_tax_claim]
      ,s.[tax_claimed_to]
      ,s.[r185_return]
      ,s.[r185_sent]
      ,s.[cancellation_reason]
      ,s.[cancelled_on]
      ,s.[cancelled_by]
      ,s.[source]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[created_by]
      ,s.[created_on]
      ,s.[payment_number]
      ,s.[r185_payment_number]
      ,s.[initial_payment_number]
      ,s.[cancellation_source])
WHEN MATCHED 
    THEN UPDATE SET
		

	  t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]
      ,t.[covenant_number] = s.[covenant_number]
      ,t.[covenant_type] = s.[covenant_type]
      ,t.[covenant_term] = s.[covenant_term]
      ,t.[fixed] = s.[fixed]
      ,t.[covenant_status] = s.[covenant_status]
      ,t.[covenanted_amount] = s.[covenanted_amount]
      ,t.[start_date] = s.[start_date]
      ,t.[signature_date] = s.[signature_date]
      ,t.[deposited_deed] = s.[deposited_deed]
      ,t.[net] = s.[net]
      ,t.[annual_claim] = s.[annual_claim]
      ,t.[order_number] = s.[order_number]
      ,t.[last_tax_claim] = s.[last_tax_claim]
      ,t.[tax_claimed_to] = s.[tax_claimed_to]
      ,t.[r185_return] = s.[r185_return]
      ,t.[r185_sent] = s.[r185_sent]
      ,t.[cancellation_reason] = s.[cancellation_reason]
      ,t.[cancelled_on] = s.[cancelled_on]
      ,t.[cancelled_by] = s.[cancelled_by]
      ,t.[source] = s.[source]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[created_by] = s.[created_by]
      ,t.[created_on] = s.[created_on]
      ,t.[payment_number] = s.[payment_number]
      ,t.[r185_payment_number] = s.[r185_payment_number]
      ,t.[initial_payment_number] = s.[initial_payment_number]
      ,t.[cancellation_source] = s.[cancellation_source]
	  
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

	SELECT 'cis.covenants' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
