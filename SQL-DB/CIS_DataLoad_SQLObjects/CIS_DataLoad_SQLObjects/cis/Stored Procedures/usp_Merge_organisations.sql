CREATE PROCEDURE [cis].[usp_Merge_organisations]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.organisations  AS t
USING cis_delta.organisations  AS s 
ON (t.[organisation_number] = s.[organisation_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[organisation_number]
      ,[address_number]
      ,[contact_number]
      ,[name]
      ,[sort_name]
      ,[abbreviation]
      ,[dialling_code]
      ,[std_code]
      ,[telephone]
      ,[source]
      ,[source_date]
      ,[status]
      ,[status_date]
      ,[status_reason]
      ,[department]
      ,[notes]
      ,[amended_by]
      ,[amended_on]
      ,[organisation_group]
      ,[ownership_group])
	
VALUES(

	   s.[organisation_number]
      ,s.[address_number]
      ,s.[contact_number]
      ,s.[name]
      ,s.[sort_name]
      ,s.[abbreviation]
      ,s.[dialling_code]
      ,s.[std_code]
      ,s.[telephone]
      ,s.[source]
      ,s.[source_date]
      ,s.[status]
      ,s.[status_date]
      ,s.[status_reason]
      ,s.[department]
      ,s.[notes]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[organisation_group]
      ,s.[ownership_group])
WHEN MATCHED 
    THEN UPDATE SET
		
	t.[organisation_number] = s.[organisation_number]
      ,t.[address_number] = s.[address_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[name] = s.[name]
      ,t.[sort_name] = s.[sort_name]
      ,t.[abbreviation] = s.[abbreviation]
      ,t.[dialling_code] = s.[dialling_code]
      ,t.[std_code] = s.[std_code]
      ,t.[telephone] = s.[telephone]
      ,t.[source] = s.[source]
      ,t.[source_date] = s.[source_date]
      ,t.[status] = s.[status]
      ,t.[status_date] = s.[status_date]
      ,t.[status_reason] = s.[status_reason]
      ,t.[department] = s.[department]
      ,t.[notes] = s.[notes]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[organisation_group] = s.[organisation_group]
      ,t.[ownership_group] = s.[ownership_group]

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

	SELECT 'cis.organisations' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
