CREATE PROCEDURE [cis].[usp_Merge_contact_accounts]  
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; 
--Synchronize the target table with
--refreshed data from source table
MERGE cis.contact_accounts AS t   
USING cis_delta.contact_accounts AS s 
ON (t.[bank_details_number] = s.[bank_details_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[bank_details_number]
      ,[contact_number]
      ,[sort_code]
      ,[account_number]
      ,[account_name]
      ,[amended_by]
      ,[amended_on]
      ,[bank_payer_name]
      ,[notes]
      ,[default_account]
      ,[history_only]
	) 
	
VALUES(

	   s.[bank_details_number]
      ,s.[contact_number]
      ,s.[sort_code]
      ,s.[account_number]
      ,s.[account_name]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[bank_payer_name]
      ,s.[notes]
      ,s.[default_account]
      ,s.[history_only])
WHEN MATCHED   
    THEN UPDATE SET
	
		
 	 t.[bank_details_number] = s.[bank_details_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[sort_code] = s.[sort_code]
      ,t.[account_number] = s.[account_number]
      ,t.[account_name] = s.[account_name]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[bank_payer_name] = s.[bank_payer_name]
      ,t.[notes] = s.[notes]
      ,t.[default_account] = s.[default_account]
      ,t.[history_only] = s.[history_only]

	 
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

	SELECT 'cis.contact_accounts' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
