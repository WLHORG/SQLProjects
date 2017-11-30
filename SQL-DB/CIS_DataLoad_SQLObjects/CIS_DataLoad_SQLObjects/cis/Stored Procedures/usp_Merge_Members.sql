CREATE PROCEDURE [cis].[usp_Merge_Members]  
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; 
--Synchronize the target table with
--refreshed data from source table
MERGE cis.Members AS t
USING cis_delta.Members AS s 
ON (t.[order_number] = s.[order_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	   [contact_number]
      ,[membership_type]
      ,[order_number]
      ,[number_of_members]
      ,[age_override]
      ,[branch]
      ,[joined]
      ,[branch_member]
      ,[applied]
      ,[accepted]
      ,[voting_rights]
      ,[membership_card_expires]
      ,[cancellation_reason]
      ,[cancelled_by]
      ,[cancelled_on]
      ,[amended_by]
      ,[amended_on]
      ,[address_number]
      ,[source]
      ,[membership_number]
      ,[member_number]
      ,[reprint_mship_card]
      ,[cancellation_source]
      ,[membership_card_issue_number]
      ,[membership_status]
	) 
	
VALUES(

	   s.[contact_number]
      ,s.[membership_type]
      ,s.[order_number]
      ,s.[number_of_members]
      ,s.[age_override]
      ,s.[branch]
      ,s.[joined]
      ,s.[branch_member]
      ,s.[applied]
      ,s.[accepted]
      ,s.[voting_rights]
      ,s.[membership_card_expires]
      ,s.[cancellation_reason]
      ,s.[cancelled_by]
      ,CAST(s.[cancelled_on] as DATE) 
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[address_number]
      ,s.[source]
      ,s.[membership_number]
      ,s.[member_number]
      ,s.[reprint_mship_card]
      ,s.[cancellation_source]
      ,s.[membership_card_issue_number]
      ,s.[membership_status])
WHEN MATCHED   
    THEN UPDATE SET
	
		
	 t.[contact_number] = s.[contact_number]
      ,t.[membership_type] = s.[membership_type]
      ,t.[order_number] = s.[order_number]
      ,t.[number_of_members] = s.[number_of_members]
      ,t.[age_override] = s.[age_override]
      ,t.[branch] = s.[branch]
      ,t.[joined] = s.[joined]
      ,t.[branch_member] = s.[branch_member]
      ,t.[applied] = s.[applied]
      ,t.[accepted] = s.[accepted]
      ,t.[voting_rights] = s.[voting_rights]
      ,t.[membership_card_expires] = s.[membership_card_expires]
      ,t.[cancellation_reason] = s.[cancellation_reason]
      ,t.[cancelled_by] = s.[cancelled_by]
      ,t.[cancelled_on] = s.[cancelled_on]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[address_number] = s.[address_number]
      ,t.[source] = s.[source]
      ,t.[membership_number] = s.[membership_number]
      ,t.[member_number] = s.[member_number]
      ,t.[reprint_mship_card] = s.[reprint_mship_card]
      ,t.[cancellation_source] = s.[cancellation_source]
      ,t.[membership_card_issue_number] = s.[membership_card_issue_number]
      ,t.[membership_status] = s.[membership_status]

	 
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

	SELECT 'cis.Members' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
