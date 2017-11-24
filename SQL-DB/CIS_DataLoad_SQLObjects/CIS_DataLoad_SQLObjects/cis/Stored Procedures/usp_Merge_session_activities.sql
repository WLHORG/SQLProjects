﻿CREATE PROCEDURE [cis].[usp_Merge_session_activities]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.session_activities  AS t
USING cis_delta.session_activities  AS s 
ON (t.[event_number] = s.[event_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[event_number]
      ,[session_number]
      ,[activity]
      ,[activity_value]
      ,[amended_by]
      ,[amended_on])
	
VALUES(

	   s.[event_number]
      ,s.[session_number]
      ,s.[activity]
      ,s.[activity_value]
      ,s.[amended_by]
      ,s.[amended_on])
WHEN MATCHED 
    THEN UPDATE SET
		
	t.[event_number] = s.[event_number]
      ,t.[session_number] = s.[session_number]
      ,t.[activity] = s.[activity]
      ,t.[activity_value] = s.[activity_value]
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

	SELECT 'cis.session_activities' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
