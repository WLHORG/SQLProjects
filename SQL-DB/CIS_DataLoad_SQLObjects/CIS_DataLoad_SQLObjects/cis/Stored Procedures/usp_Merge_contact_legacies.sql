CREATE PROCEDURE [cis].[usp_Merge_contact_legacies]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.contact_legacies AS t
USING cis_delta.contact_legacies AS s 
ON (t.[legacy_number] = s.[legacy_number]
AND t.[contact_number] = s.[contact_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	 [legacy_number]
      ,[contact_number]
      ,[legacy_id]
      ,[legacy_status]
      ,[source]
      ,[source_date]
      ,[will_date]
      ,[last_codicil_date]
      ,[gross_estate_value]
      ,[net_estate_value]
      ,[total_estimated_value]
      ,[date_of_death]
      ,[death_notification_source]
      ,[death_notification_date]
      ,[date_of_probate]
      ,[next_bequest_number]
      ,[amended_by]
      ,[amended_on]
      ,[admin_expenses_value]
      ,[tax_value]
      ,[other_bequests_value]
      ,[net_for_probate]
      ,[liabilities_value]
      ,[master_action]
      ,[review_date]
      ,[legacy_review_reason]
      ,[agency_notification_date]
      ,[accounts_received]
      ,[accounts_approved]
      ,[age_at_death]
      ,[lead_charity]
      ,[in_dispute]
      ,[legacy_dispute_reason]
	) 
	
VALUES(

	   s.[legacy_number]
      ,s.[contact_number]
      ,s.[legacy_id]
      ,s.[legacy_status]
      ,s.[source]
      ,s.[source_date]
      ,s.[will_date]
      ,s.[last_codicil_date]
      ,s.[gross_estate_value]
      ,s.[net_estate_value]
      ,s.[total_estimated_value]
      ,s.[date_of_death]
      ,s.[death_notification_source]
      ,s.[death_notification_date]
      ,s.[date_of_probate]
      ,s.[next_bequest_number]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[admin_expenses_value]
      ,s.[tax_value]
      ,s.[other_bequests_value]
      ,s.[net_for_probate]
      ,s.[liabilities_value]
      ,s.[master_action]
      ,s.[review_date]
      ,s.[legacy_review_reason]
      ,s.[agency_notification_date]
      ,s.[accounts_received]
      ,s.[accounts_approved]
      ,s.[age_at_death]
      ,s.[lead_charity]
      ,s.[in_dispute]
      ,s.[legacy_dispute_reason])
WHEN MATCHED 
    THEN UPDATE SET
		
		t.[legacy_number] = s.[legacy_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[legacy_id] = s.[legacy_id]
      ,t.[legacy_status] = s.[legacy_status]
      ,t.[source] = s.[source]
      ,t.[source_date] = s.[source_date]
      ,t.[will_date] = s.[will_date]
      ,t.[last_codicil_date] = s.[last_codicil_date]
      ,t.[gross_estate_value] = s.[gross_estate_value]
      ,t.[net_estate_value] = s.[net_estate_value]
      ,t.[total_estimated_value] = s.[total_estimated_value]
      ,t.[date_of_death] = s.[date_of_death]
      ,t.[death_notification_source] = s.[death_notification_source]
      ,t.[death_notification_date] = s.[death_notification_date]
      ,t.[date_of_probate] = s.[date_of_probate]
      ,t.[next_bequest_number] = s.[next_bequest_number]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[admin_expenses_value] = s.[admin_expenses_value]
      ,t.[tax_value] = s.[tax_value]
      ,t.[other_bequests_value] = s.[other_bequests_value]
      ,t.[net_for_probate] = s.[net_for_probate]
      ,t.[liabilities_value] = s.[liabilities_value]
      ,t.[master_action] = s.[master_action]
      ,t.[review_date] = s.[review_date]
      ,t.[legacy_review_reason] = s.[legacy_review_reason]
      ,t.[agency_notification_date] = s.[agency_notification_date]
      ,t.[accounts_received] = s.[accounts_received]
      ,t.[accounts_approved] = s.[accounts_approved]
      ,t.[age_at_death] = s.[age_at_death]
      ,t.[lead_charity] = s.[lead_charity]
      ,t.[in_dispute] = s.[in_dispute]
      ,t.[legacy_dispute_reason] = s.[legacy_dispute_reason]
	  
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

	SELECT 'cis.contact_legacies' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
