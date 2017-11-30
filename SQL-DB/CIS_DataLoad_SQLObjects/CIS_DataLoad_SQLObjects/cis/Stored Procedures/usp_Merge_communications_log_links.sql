CREATE PROCEDURE [cis].[usp_Merge_communications_log_links]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.communications_log_links AS t
USING cis_delta.communications_log_links  AS s 
ON (t.[communications_log_number] = s.[communications_log_number]
AND t.[contact_number]  = s.[contact_number]
AND t.[address_number] = s.[address_number]
AND t.[link_type] = s.[link_type]
AnD t.[processed] = s.[processed]
) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[communications_log_number]
      ,[contact_number]
      ,[address_number]
      ,[link_type]
      ,[processed]
      ,[notified]
	) 
	
VALUES(

	   s.[communications_log_number]
      ,s.[contact_number]
      ,s.[address_number]
      ,s.[link_type]
      ,s.[processed]
      ,s.[notified])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[communications_log_number] = s.[communications_log_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]
      ,t.[link_type] = s.[link_type]
      ,t.[processed] = s.[processed]
      ,t.[notified] = s.[notified]
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

	SELECT 'cis.communications_log_links' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
