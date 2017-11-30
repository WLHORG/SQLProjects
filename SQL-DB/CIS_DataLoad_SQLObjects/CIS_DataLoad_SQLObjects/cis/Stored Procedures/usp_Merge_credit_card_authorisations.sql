CREATE PROCEDURE [cis].[usp_Merge_credit_card_authorisations]  
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; 
--Synchronize the target table with
--refreshed data from source table
MERGE cis.credit_card_authorisations AS t   
USING cis_delta.credit_card_authorisations AS s 
ON (t.[authorisation_number] = s.[authorisation_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[authorisation_number]
      ,[batch_number]
      ,[transaction_number]
      ,[authorisation_type]
      ,[authorised_on]
      ,[authorisation_code]
      ,[authorisation_response_code]
      ,[authorisation_response_message]
      ,[authorised_amount]
      ,[address_verification_result]
      ,[address_verification_message]
      ,[csc_result_code]
      ,[csc_result_message]
      ,[authorised_transaction_number]
      ,[authorised_text_id]
	) 
	
VALUES(

	   s.[authorisation_number]
      ,s.[batch_number]
      ,s.[transaction_number]
      ,s.[authorisation_type]
      ,s.[authorised_on]
      ,s.[authorisation_code]
      ,s.[authorisation_response_code]
      ,s.[authorisation_response_message]
      ,s.[authorised_amount]
      ,s.[address_verification_result]
      ,s.[address_verification_message]
      ,s.[csc_result_code]
      ,s.[csc_result_message]
      ,s.[authorised_transaction_number]
      ,s.[authorised_text_id])
WHEN MATCHED   
    THEN UPDATE SET
	
		
 	 t.[authorisation_number] = s.[authorisation_number]
      ,t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[authorisation_type] = s.[authorisation_type]
      ,t.[authorised_on] = s.[authorised_on]
      ,t.[authorisation_code] = s.[authorisation_code]
      ,t.[authorisation_response_code] = s.[authorisation_response_code]
      ,t.[authorisation_response_message] = s.[authorisation_response_message]
      ,t.[authorised_amount] = s.[authorised_amount]
      ,t.[address_verification_result] = s.[address_verification_result]
      ,t.[address_verification_message] = s.[address_verification_message]
      ,t.[csc_result_code] = s.[csc_result_code]
      ,t.[csc_result_message] = s.[csc_result_message]
      ,t.[authorised_transaction_number] = s.[authorised_transaction_number]
      ,t.[authorised_text_id] = s.[authorised_text_id]

	 
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

	SELECT 'cis.credit_card_authorisations' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
