CREATE PROCEDURE [cis].[usp_Merge_contact_address_usages]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.contact_address_usages AS t
USING cis_delta.contact_address_usages AS s 
ON (t.[address_number] = s.[address_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[address_number]
      ,[contact_number]
      ,[address_usage]
      ,[notes]
      ,[amended_by]
      ,[amended_on]
	) 
	
VALUES(

	   s.[address_number]
      ,s.[contact_number]
      ,s.[address_usage]
      ,s.[notes]
      ,s.[amended_by]
      ,s.[amended_on])
WHEN MATCHED 
    THEN UPDATE SET
		
	 t.[address_number] = s.[address_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[address_usage] = s.[address_usage]
      ,t.[notes] = s.[notes]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
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

	SELECT 'cis.contact_address_usages' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
