CREATE PROCEDURE [cis].[usp_Merge_gaye_payments]
AS  
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.[gaye_payments] AS t
USING cis_delta.[gaye_payments] AS s 
ON (t.[gaye_payment_number] = s.[gaye_payment_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
[gaye_payment_number]
      ,[donor_name]
      ,[donor_id]
      ,[address_line_1]
      ,[address_line_2]
      ,[address_line_3]
      ,[address_line_4]
      ,[address_line_5]
      ,[postcode]
      ,[employer_name]
      ,[source_code]
      ,[pfo_code]
      ,[new_donor]
      ,[employee_donation]
      ,[employer_donation]
      ,[gov_payment]
      ,[admin_fee]
      ,[no_of_donations]
      ,[agency_number]
      ,[contact_number]
      ,[organisation_number]
      ,[address_number]
      ,[gaye_pledge_number]
      ,[title]
      ,[initials]
      ,[forenames]
      ,[surname]
      ,[transaction_date]
      ,[post_batch_to_cb]
      ,[reconciled]
	) 
	
VALUES(

	   s.[gaye_payment_number]
      ,s.[donor_name]
      ,s.[donor_id]
      ,s.[address_line_1]
      ,s.[address_line_2]
      ,s.[address_line_3]
      ,s.[address_line_4]
      ,s.[address_line_5]
      ,s.[postcode]
      ,s.[employer_name]
      ,s.[source_code]
      ,s.[pfo_code]
      ,s.[new_donor]
      ,s.[employee_donation]
      ,s.[employer_donation]
      ,s.[gov_payment]
      ,s.[admin_fee]
      ,s.[no_of_donations]
      ,s.[agency_number]
      ,s.[contact_number]
      ,s.[organisation_number]
      ,s.[address_number]
      ,s.[gaye_pledge_number]
      ,s.[title]
      ,s.[initials]
      ,s.[forenames]
      ,s.[surname]
      ,s.[transaction_date]
      ,s.[post_batch_to_cb]
      ,s.[reconciled])
WHEN MATCHED 
    THEN UPDATE SET
		
      t.[gaye_payment_number] = s.[gaye_payment_number]
      ,t.[donor_name] = s.[donor_name]
      ,t.[donor_id] = s.[donor_id]
      ,t.[address_line_1] = s.[address_line_1]
      ,t.[address_line_2] = s.[address_line_2]
      ,t.[address_line_3] = s.[address_line_3]
      ,t.[address_line_4] = s.[address_line_4]
      ,t.[address_line_5] = s.[address_line_5]
      ,t.[postcode] = s.[postcode]
      ,t.[employer_name] = s.[employer_name]
      ,t.[source_code] = s.[source_code]
      ,t.[pfo_code] = s.[pfo_code]
      ,t.[new_donor] = s.[new_donor]
      ,t.[employee_donation] = s.[employee_donation]
      ,t.[employer_donation] = s.[employer_donation]
      ,t.[gov_payment] = s.[gov_payment]
      ,t.[admin_fee] = s.[admin_fee]
      ,t.[no_of_donations] = s.[no_of_donations]
      ,t.[agency_number] = s.[contact_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[organisation_number] = s.[organisation_number]
      ,t.[address_number] = s.[address_number]
      ,t.[gaye_pledge_number] = s.[gaye_pledge_number]
      ,t.[title] = s.[title]
      ,t.[initials] = s.[initials]
      ,t.[forenames] = s.[forenames]
      ,t.[surname] = s.[surname]
      ,t.[transaction_date] = s.[transaction_date]
      ,t.[post_batch_to_cb] = s.[post_batch_to_cb]
      ,t.[reconciled] = s.[reconciled]
	  
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

	SELECT 'cis.gaye_payments' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
