CREATE  PROCEDURE [cis].[usp_Merge_Fundraising_Request_Targets]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE [cis].[fundraising_request_targets]  AS t
USING [cis_delta].[fundraising_request_targets]  AS s 
ON (t.[fundraising_request_number] = s.[fundraising_request_number]
) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[fundraising_request_number]
      ,[previous_target_amount]
      ,[target_amount]
      ,[change_reason]
      ,[changed_by]
      ,[changed_on])
	
VALUES(

	   s.[fundraising_request_number]
      ,s.[previous_target_amount]
      ,s.[target_amount]
      ,s.[change_reason]
      ,s.[changed_by]
      ,s.[changed_on])
WHEN MATCHED 
    THEN UPDATE SET
	
	 t.[fundraising_request_number]	  =  s.[fundraising_request_number]
      ,t.[previous_target_amount]	  =  s.[previous_target_amount]
      ,t.[target_amount]			  =  s.[target_amount]
      ,t.[change_reason]			  =  s.[change_reason]
      ,t.[changed_by]				  =  s.[changed_by]
      ,t.[changed_on]				  =  s.[changed_on]
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

	SELECT 'cis.fundraising_request_targets' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END