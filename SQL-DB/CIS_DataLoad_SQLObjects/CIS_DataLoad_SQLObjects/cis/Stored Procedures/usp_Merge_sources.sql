CREATE PROCEDURE [cis].[usp_Merge_sources]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.sources AS t
USING cis_delta.sources AS s 
ON (t.[source] = s.[source]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[source]
      ,[source_desc]
      ,[incentive_trigger_level]
      ,[thank_you_letter]
      ,[incentive_scheme]
      ,[history_only]
      ,[distribution_code]
      ,[discount_percentage]
      ,[amended_by]
      ,[amended_on]
      ,[source_number]
	) 
	
VALUES(

	   s.[source]
      ,s.[source_desc]
      ,s.[incentive_trigger_level]
      ,s.[thank_you_letter]
      ,s.[incentive_scheme]
      ,s.[history_only]
      ,s.[distribution_code]
      ,s.[discount_percentage]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[source_number])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[source] = s.[source]
      ,t.[source_desc] = s.[source_desc]
      ,t.[incentive_trigger_level] = s.[incentive_trigger_level]
      ,t.[thank_you_letter] = s.[thank_you_letter]
      ,t.[incentive_scheme] = s.[incentive_scheme]
      ,t.[history_only] = s.[history_only]
      ,t.[distribution_code] = s.[distribution_code]
      ,t.[discount_percentage] = s.[discount_percentage]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[source_number] = s.[source_number]


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

	SELECT 'cis.sources' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
