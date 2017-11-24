CREATE PROCEDURE [cis].[usp_Merge_Gift_Aid_Declarations]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.gift_aid_declarations AS t
USING cis_delta.gift_aid_declarations AS s 
ON (t.[declaration_number] = s.[declaration_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[declaration_number]
      ,[contact_number]
      ,[declaration_date]
      ,[declaration_type]
      ,[source]
      ,[confirmed_on]
      ,[method]
      ,[start_date]
      ,[end_date]
      ,[notes]
      ,[amended_by]
      ,[amended_on]
      ,[batch_number]
      ,[transaction_number]
      ,[order_number]
      ,[cancellation_reason]
      ,[cancelled_by]
      ,[cancelled_on]
      ,[cancellation_source]
      ,[created_by]
      ,[created_on]
	) 
	
VALUES(

	   s.[declaration_number]
      ,s.[contact_number]
      ,s.[declaration_date]
      ,s.[declaration_type]
      ,s.[source]
      ,s.[confirmed_on]
      ,s.[method]
      ,s.[start_date]
      ,s.[end_date]
      ,s.[notes]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[batch_number]
      ,s.[transaction_number]
      ,s.[order_number]
      ,s.[cancellation_reason]
      ,s.[cancelled_by]
      ,s.[cancelled_on]
      ,s.[cancellation_source]
      ,s.[created_by]
      ,s.[created_on])
WHEN MATCHED 
    THEN UPDATE SET
		

	  t.[declaration_number] = s.[declaration_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[declaration_date] = s.[declaration_date]
      ,t.[declaration_type] = s.[declaration_type]
      ,t.[source] = s.[source]
      ,t.[confirmed_on] = s.[confirmed_on]
      ,t.[method] = s.[method]
      ,t.[start_date] = s.[start_date]
      ,t.[end_date] = s.[end_date]
      ,t.[notes] = s.[notes]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[order_number] = s.[order_number]
      ,t.[cancellation_reason] = s.[cancellation_reason]
      ,t.[cancelled_by] = s.[cancelled_by]
      ,t.[cancelled_on] = s.[cancelled_on]
      ,t.[cancellation_source] = s.[cancellation_source]
      ,t.[created_by] = s.[created_by]
      ,t.[created_on] = s.[created_on]
	 
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

	SELECT 'cis.gift_aid_declarations' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
