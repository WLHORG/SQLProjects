CREATE PROCEDURE [cis].[usp_Merge_GAD_Invalid_Declaration_date]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.GAD_Invalid_Declaration_date AS t
USING cis_delta.GAD_Invalid_Declaration_date AS s 
ON (t.[DECLARATION_NUMBER] = s.[DECLARATION_NUMBER]
AND t.[CONTACT_NUMBER] = s.[CONTACT_NUMBER] ) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
[DECLARATION_NUMBER]
      ,[CONTACT_NUMBER]
      ,[DECLARATION_DATE]
      ,[DECLARATION_TYPE]
      ,[SOURCE]
      ,[CONFIRMED_ON]
      ,[METHOD]
      ,[START_DATE]
      ,[END_DATE]
      ,[NOTES]
      ,[AMENDED_BY]
      ,[AMENDED_ON]
      ,[BATCH_NUMBER]
      ,[TRANSACTION_NUMBER]
      ,[ORDER_NUMBER]
      ,[CANCELLATION_REASON]
      ,[CANCELLED_BY]
      ,[CANCELLED_ON]
      ,[CANCELLATION_SOURCE]
      ,[CREATED_BY]
      ,[CREATED_ON]
	) 
	
VALUES(

	   s.[DECLARATION_NUMBER]
      ,s.[CONTACT_NUMBER]
      ,s.[DECLARATION_DATE]
      ,s.[DECLARATION_TYPE]
      ,s.[SOURCE]
      ,s.[CONFIRMED_ON]
      ,s.[METHOD]
      ,s.[START_DATE]
      ,s.[END_DATE]
      ,s.[NOTES]
      ,s.[AMENDED_BY]
      ,s.[AMENDED_ON]
      ,s.[BATCH_NUMBER]
      ,s.[TRANSACTION_NUMBER]
      ,s.[ORDER_NUMBER]
      ,s.[CANCELLATION_REASON]
      ,s.[CANCELLED_BY]
      ,s.[CANCELLED_ON]
      ,s.[CANCELLATION_SOURCE]
      ,s.[CREATED_BY]
      ,s.[CREATED_ON])
WHEN MATCHED 
    THEN UPDATE SET
		
      t.[DECLARATION_NUMBER]	   = s.[DECLARATION_NUMBER]
      ,t.[CONTACT_NUMBER]		   = s.[CONTACT_NUMBER]
      ,t.[DECLARATION_DATE]		   = s.[DECLARATION_DATE]
      ,t.[DECLARATION_TYPE]		   = s.[DECLARATION_TYPE]
      ,t.[SOURCE]				   = s.[SOURCE]
      ,t.[CONFIRMED_ON]			   = s.[CONFIRMED_ON]
      ,t.[METHOD]				   = s.[METHOD]
      ,t.[START_DATE]			   = s.[START_DATE]
      ,t.[END_DATE]				   = s.[END_DATE]
      ,t.[NOTES]				   = s.[NOTES]
      ,t.[AMENDED_BY]			   = s.[AMENDED_BY]
      ,t.[AMENDED_ON]			   = s.[AMENDED_ON]
      ,t.[BATCH_NUMBER]			   = s.[BATCH_NUMBER]
      ,t.[TRANSACTION_NUMBER]	   = s.[TRANSACTION_NUMBER]
      ,t.[ORDER_NUMBER]			   = s.[ORDER_NUMBER]
      ,t.[CANCELLATION_REASON]	   = s.[CANCELLATION_REASON]
      ,t.[CANCELLED_BY]			   = s.[CANCELLED_BY]
      ,t.[CANCELLED_ON]			   = s.[CANCELLED_ON]
      ,t.[CANCELLATION_SOURCE]	   = s.[CANCELLATION_SOURCE]
      ,t.[CREATED_BY]			   = s.[CREATED_BY]
      ,t.[CREATED_ON]			   = s.[CREATED_ON]
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

	SELECT 'cis.GAD_Invalid_Declaration_date' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END