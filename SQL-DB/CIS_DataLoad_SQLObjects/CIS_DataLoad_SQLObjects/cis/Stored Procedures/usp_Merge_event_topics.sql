CREATE PROCEDURE [cis].[usp_Merge_event_topics]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.event_topics  AS t
USING cis_delta.event_topics  AS s 
ON (t.[event_number] = s.[event_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[event_number]
      ,[topic]
      ,[sub_topic]
      ,[quantity]
      ,[amended_by]
      ,[amended_on]
      ,[notes])
	
VALUES(

	   s.[event_number]
      ,s.[topic]
      ,s.[sub_topic]
      ,s.[quantity]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[notes])
WHEN MATCHED 
    THEN UPDATE SET
		
	t.[event_number] = s.[event_number]
      ,t.[topic] = s.[topic]
      ,t.[sub_topic] = s.[sub_topic]
      ,t.[quantity] = s.[quantity]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[notes] = s.[notes]

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

	SELECT 'cis.event_topics' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
