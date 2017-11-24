CREATE PROCEDURE [cis].[usp_Merge_event_bookings]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.event_bookings  AS t
USING cis_delta.event_bookings  AS s 
ON (t.[event_number] = s.[event_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[event_number]
      ,[booking_number]
      ,[booking_date]
      ,[batch_number]
      ,[transaction_number]
      ,[line_number]
      ,[rate]
      ,[option_number]
      ,[booking_status]
      ,[contact_number]
      ,[address_number]
      ,[quantity]
      ,[allocated]
      ,[cancellation_reason]
      ,[cancelled_by]
      ,[cancelled_on]
      ,[amended_by]
      ,[amended_on]
      ,[sales_contact_number]
      ,[cancellation_source]
      ,[notes]
      ,[adult_quantity]
      ,[child_quantity]
      ,[start_time]
      ,[end_time]
	) 
	
VALUES(

	   s.[event_number]
      ,s.[booking_number]
      ,s.[booking_date]
      ,s.[batch_number]
      ,s.[transaction_number]
      ,s.[line_number]
      ,s.[rate]
      ,s.[option_number]
      ,s.[booking_status]
      ,s.[contact_number]
      ,s.[address_number]
      ,s.[quantity]
      ,s.[allocated]
      ,s.[cancellation_reason]
      ,s.[cancelled_by]
      ,s.[cancelled_on]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[sales_contact_number]
      ,s.[cancellation_source]
      ,s.[notes]
      ,s.[adult_quantity]
      ,s.[child_quantity]
      ,s.[start_time]
      ,s.[end_time])
WHEN MATCHED 
    THEN UPDATE SET
		
	t.[event_number] = s.[event_number]
      ,t.[booking_number] = s.[booking_number]
      ,t.[booking_date] = s.[booking_date]
      ,t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[line_number] = s.[line_number]
      ,t.[rate] = s.[rate]
      ,t.[option_number] = s.[option_number]
      ,t.[booking_status] = s.[booking_status]
      ,t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]
      ,t.[quantity] = s.[quantity]
      ,t.[allocated] = s.[allocated]
      ,t.[cancellation_reason] = s.[cancellation_reason]
      ,t.[cancelled_by] = s.[cancelled_by]
      ,t.[cancelled_on] = s.[cancelled_on]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[sales_contact_number] = s.[sales_contact_number]
      ,t.[cancellation_source] = s.[cancellation_source]
      ,t.[notes] = s.[notes]
      ,t.[adult_quantity] = s.[adult_quantity]
      ,t.[child_quantity] = s.[child_quantity]
      ,t.[start_time] = s.[start_time]
      ,t.[end_time] = s.[end_time]

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

	SELECT 'cis.event_bookings' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
