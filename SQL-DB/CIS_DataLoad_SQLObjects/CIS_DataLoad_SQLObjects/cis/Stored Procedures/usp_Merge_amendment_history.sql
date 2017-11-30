CREATE PROCEDURE [cis].[usp_Merge_amendment_history]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.amendment_history  AS t
USING cis_delta.amendment_history  AS s 
ON (t.[operation] = s.[operation]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[operation]
      ,[operation_date]
      ,[table_name]
      ,[logname]
      ,[data_values]
      ,[select_1]
      ,[select_2]
      ,[contact_journal_number])
	
VALUES(

	   s.[operation]
      ,s.[operation_date]
      ,s.[table_name]
      ,s.[logname]
      ,s.[data_values]
      ,s.[select_1]
      ,s.[select_2]
      ,s.[contact_journal_number])
WHEN MATCHED 
    THEN UPDATE SET
		
	t.[operation] = s.[operation]
      ,t.[operation_date] = s.[operation_date]
      ,t.[table_name] = s.[table_name]
      ,t.[logname] = s.[logname]
      ,t.[data_values] = s.[data_values]
      ,t.[select_1] = s.[select_1]
      ,t.[select_2] = s.[select_2]
      ,t.[contact_journal_number] = s.[contact_journal_number]

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

	SELECT 'cis.amendment_history' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
