CREATE PROCEDURE [cis].[usp_Merge_delegates]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.delegates AS t
USING [cis_delta].delegates AS s 
ON (t.[event_number] = s.[event_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[event_number]
      ,[booking_number]
      ,[contact_number]
      ,[address_number]
      ,[attended]
      ,[position]
      ,[organisation_name]
      ,[amended_by]
      ,[amended_on]
      ,[event_delegate_number]
      ,[candidate_number]
      ,[pledged_amount]
      ,[donation_total]
      ,[sponsorship_total]
      ,[booking_payment_amount]
      ,[other_payments_total]
	) 
	
VALUES(

	   s.[event_number]
      ,s.[booking_number]
      ,s.[contact_number]
      ,s.[address_number]
      ,s.[attended]
      ,s.[position]
      ,s.[organisation_name]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[event_delegate_number]
      ,s.[candidate_number]
      ,s.[pledged_amount]
      ,s.[donation_total]
      ,s.[sponsorship_total]
      ,s.[booking_payment_amount]
      ,s.[other_payments_total])
WHEN MATCHED 
    THEN UPDATE SET
		
	 t.[event_number] = s.[event_number]
      ,t.[booking_number] = s.[booking_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]
      ,t.[attended] = s.[attended]
      ,t.[position] = s.[position]
      ,t.[organisation_name] = s.[organisation_name]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[event_delegate_number] = s.[event_delegate_number]
      ,t.[candidate_number] = s.[candidate_number]
      ,t.[pledged_amount] = s.[pledged_amount]
      ,t.[donation_total] = s.[donation_total]
      ,t.[sponsorship_total] = s.[sponsorship_total]
      ,t.[booking_payment_amount] = s.[booking_payment_amount]
      ,t.[other_payments_total] = s.[other_payments_total]
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

	SELECT 'cis.delegates' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
