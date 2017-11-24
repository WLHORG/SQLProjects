CREATE PROCEDURE [cis].[usp_Merge_event_booking_options]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.event_booking_options AS t
USING cis_delta.event_booking_options AS s 
ON (t.[event_number] = s.[event_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[event_number]
      ,[option_number]
      ,[option_desc]
      ,[pick_sessions]
      ,[number_of_sessions]
      ,[deduct_from_event]
      ,[maximum_bookings]
      ,[product]
      ,[rate]
      ,[amended_by]
      ,[amended_on]
      ,[long_description]
	) 
	
VALUES(

	   s.[event_number]
      ,s.[option_number]
      ,s.[option_desc]
      ,s.[pick_sessions]
      ,s.[number_of_sessions]
      ,s.[deduct_from_event]
      ,s.[maximum_bookings]
      ,s.[product]
      ,s.[rate]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[long_description])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[event_number] = s.[event_number]
      ,t.[option_number] = s.[option_number]
      ,t.[option_desc] = s.[option_desc]
      ,t.[pick_sessions] = s.[pick_sessions]
      ,t.[number_of_sessions] = s.[number_of_sessions]
      ,t.[deduct_from_event] = s.[deduct_from_event]
      ,t.[maximum_bookings] = s.[maximum_bookings]
      ,t.[product] = s.[product]
      ,t.[rate] = s.[rate]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[long_description] = s.[long_description]


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

	SELECT 'cis.event_booking_options' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
