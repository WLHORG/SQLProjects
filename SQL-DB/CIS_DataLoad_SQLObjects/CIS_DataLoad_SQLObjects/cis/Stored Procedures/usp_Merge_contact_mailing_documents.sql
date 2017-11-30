CREATE PROCEDURE [cis].[usp_Merge_contact_mailing_documents]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.contact_mailing_documents AS t
USING cis_delta.contact_mailing_documents AS s 
ON (t.[mailing_document_number] = s.[mailing_document_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[mailing_document_number]
      ,[mailing_template]
      ,[selected_paragraphs]
      ,[contact_number]
      ,[address_number]
      ,[batch_number]
      ,[transaction_number]
      ,[order_number]
      ,[gaye_pledge_number]
      ,[declaration_number]
      ,[document_text]
      ,[created_by]
      ,[created_on]
      ,[fulfillment_number]
      ,[mailing]
      ,[new_contact]
      ,[earliest_fulfilment_date]
	) 
	
VALUES(

	   s.[mailing_document_number]
      ,s.[mailing_template]
      ,s.[selected_paragraphs]
      ,s.[contact_number]
      ,s.[address_number]
      ,s.[batch_number]
      ,s.[transaction_number]
      ,s.[order_number]
      ,s.[gaye_pledge_number]
      ,s.[declaration_number]
      ,s.[document_text]
      ,s.[created_by]
      ,s.[created_on]
      ,s.[fulfillment_number]
      ,s.[mailing]
      ,s.[new_contact]
      ,s.[earliest_fulfilment_date])
WHEN MATCHED 
    THEN UPDATE SET
		
	 t.[mailing_document_number] = s.[mailing_document_number]
      ,t.[mailing_template] = s.[mailing_template]
      ,t.[selected_paragraphs] = s.[selected_paragraphs]
      ,t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]
      ,t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[order_number] = s.[order_number]
      ,t.[gaye_pledge_number] = s.[gaye_pledge_number]
      ,t.[declaration_number] = s.[declaration_number]
      ,t.[document_text] = s.[document_text]
      ,t.[created_by] = s.[created_by]
      ,t.[created_on] = s.[created_on]
      ,t.[fulfillment_number] = s.[fulfillment_number]
      ,t.[mailing] = s.[mailing]
      ,t.[new_contact] = s.[new_contact]
      ,t.[earliest_fulfilment_date] = s.[earliest_fulfilment_date]
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

	SELECT 'cis.contact_mailing_documents' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
