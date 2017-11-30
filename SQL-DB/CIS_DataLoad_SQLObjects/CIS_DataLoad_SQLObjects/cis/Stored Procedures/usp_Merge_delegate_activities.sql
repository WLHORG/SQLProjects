CREATE PROCEDURE [cis].[usp_Merge_delegate_activities]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.delegate_activities AS t
USING [cis_delta].delegate_activities AS s 
ON (t.[delegate_activity_number] = s.[delegate_activity_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		 [delegate_activity_number]
      ,[event_delegate_number]
      ,[activity]
      ,[activity_value]
      ,[quantity]
      ,[source]
      ,[valid_from]
      ,[valid_to]
      ,[activity_date]
      ,[notes]
      ,[amended_by]
      ,[amended_on]
	) 
	
VALUES(

	   s.[delegate_activity_number]
      ,s.[event_delegate_number]
      ,s.[activity]
      ,s.[activity_value]
      ,s.[quantity]
      ,s.[source]
      ,s.[valid_from]
      ,s.[valid_to]
      ,s.[activity_date]
      ,s.[notes]
      ,s.[amended_by]
      ,s.[amended_on])
WHEN MATCHED 
    THEN UPDATE SET
		
	 t.[delegate_activity_number] = s.[delegate_activity_number]
      ,t.[event_delegate_number] = s.[event_delegate_number]
      ,t.[activity] = s.[activity]
      ,t.[activity_value] = s.[activity_value]
      ,t.[quantity] = s.[quantity]
      ,t.[source] = s.[source]
      ,t.[valid_from] = s.[valid_from]
      ,t.[valid_to] = s.[valid_to]
      ,t.[activity_date] = s.[activity_date]
      ,t.[notes] = s.[notes]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
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

	SELECT 'cis.delegate_activities' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
