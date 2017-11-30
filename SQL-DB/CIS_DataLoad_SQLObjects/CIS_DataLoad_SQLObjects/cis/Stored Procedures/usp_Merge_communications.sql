CREATE PROCEDURE [cis].[usp_Merge_communications]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.communications AS t
USING cis_delta.communications AS s 
ON (t.[address_number] = s.[address_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[address_number]
      ,[contact_number]
      ,[device]
      ,[ex_directory]
      ,[dialling_code]
      ,[std_code]
      ,[number]
      ,[extension]
      ,[notes]
      ,[cli_number]
      ,[amended_by]
      ,[amended_on]
      ,[communication_number]
      ,[valid_from]
      ,[valid_to]
      ,[is_active]
      ,[mail]
      ,[device_default]
      ,[preferred_method]
      ,[archive]
	) 
	
VALUES(

	   s.[address_number]
      ,s.[contact_number]
      ,s.[device]
      ,s.[ex_directory]
      ,s.[dialling_code]
      ,s.[std_code]
      ,s.[number]
      ,s.[extension]
      ,s.[notes]
      ,s.[cli_number]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[communication_number]
      ,s.[valid_from]
      ,s.[valid_to]
      ,s.[is_active]
      ,s.[mail]
      ,s.[device_default]
      ,s.[preferred_method]
      ,s.[archive])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[address_number] = s.[address_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[device] = s.[device]
      ,t.[ex_directory] = s.[ex_directory]
      ,t.[dialling_code] = s.[dialling_code]
      ,t.[std_code] = s.[std_code]
      ,t.[number] = s.[number]
      ,t.[extension] = s.[extension]
      ,t.[notes] = s.[notes]
      ,t.[cli_number] = s.[cli_number]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[communication_number] = s.[communication_number]
      ,t.[valid_from] = s.[valid_from]
      ,t.[valid_to] = s.[valid_to]
      ,t.[is_active] = s.[is_active]
      ,t.[mail] = s.[mail]
      ,t.[device_default] = s.[device_default]
      ,t.[preferred_method] = s.[preferred_method]
      ,t.[archive] = s.[archive]

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

	SELECT 'cis.communications' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
