CREATE PROCEDURE [cis].[usp_Merge_legacy_bequest_receipts]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.[legacy_bequest_receipts] AS t
USING cis_delta.[legacy_bequest_receipts] AS s 
ON (t.[legacy_number] = s.[legacy_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	  [legacy_number]
      ,[bequest_number]
      ,[receipt_number]
      ,[amount]
      ,[batch_number]
      ,[transaction_number]
      ,[line_number]
      ,[amended_by]
      ,[amended_on]
      ,[date_received]
      ,[notes]
      ,[status]
	) 
	
VALUES(

	   s.[legacy_number]
      ,s.[bequest_number]
      ,s.[receipt_number]
      ,s.[amount]
      ,s.[batch_number]
      ,s.[transaction_number]
      ,s.[line_number]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[date_received]
      ,s.[notes]
      ,s.[status])
WHEN MATCHED 
    THEN UPDATE SET
		
	   t.[legacy_number] = s.[legacy_number]
      ,t.[bequest_number] = s.[bequest_number]
      ,t.[receipt_number] = s.[receipt_number]
      ,t.[amount] = s.[amount]
      ,t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[line_number] = s.[line_number]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[date_received] = s.[date_received]
      ,t.[notes] = s.[notes]
      ,t.[status] = s.[status]
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

	SELECT 'cis.legacy_bequest_receipts' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
