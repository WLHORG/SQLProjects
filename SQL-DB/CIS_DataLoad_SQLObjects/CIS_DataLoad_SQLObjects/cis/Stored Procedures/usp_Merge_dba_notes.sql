CREATE PROCEDURE [cis].[usp_Merge_dba_notes]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE [cis].[dba_notes]  AS t
USING [cis_delta].[dba_notes]  AS s 
ON (t.[master] = s.[master]
) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[master]
      ,[duplicate]
      ,[notes]
      ,[merged_on])
	
VALUES(

	   s.[master]
      ,s.[duplicate]
      ,s.[notes]
      ,s.[merged_on])
WHEN MATCHED 
    THEN UPDATE SET
			
     t.[master] = s.[master]
      ,t.[duplicate] = s.[duplicate]
      ,t.[notes] = s.[notes]
      ,t.[merged_on] = s.[merged_on]
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

	SELECT 'cis.dba_notes' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
