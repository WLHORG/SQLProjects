CREATE PROCEDURE [cis].[usp_Merge_Contacts]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.contacts AS t
USING cis_delta.contacts AS s 
ON (t.[contact_number] = s.[contact_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	   [contact_number]
	  ,[title]
      ,[forenames]
      ,[initials]
      ,[surname]
      ,[honorifics]
      ,[salutation]
      ,[label_name]
      ,[preferred_forename]
      ,[sex]
      ,[source]
      ,[source_date]
      ,[name_gathering_source]
      ,[date_of_birth]
      ,[status]
      ,[status_date]
      ,[status_reason]
      ,[department]
      ,[address_number]
      ,[dialling_code]
      ,[std_code]
      ,[telephone]
      ,[ex_directory]
      ,[notes]
      ,[contact_vat_category]
      ,[amended_by]
      ,[amended_on]
      ,[contact_type]
      ,[dob_estimated]
      ,[contact_group]
      ,[ownership_group]
      ,[prefix_honorifics]
      ,[surname_prefix]
      ,[informal_salutation]
      ,[ni_number]
      ,[label_name_format_code]
	  ,[CIS_CHECKSUM]
	) 
	
VALUES(

	   s.[contact_number]
	  ,s.[title]
      ,s.[forenames]
      ,s.[initials]
      ,s.[surname]
      ,s.[honorifics]
      ,s.[salutation]
      ,s.[label_name]
      ,s.[preferred_forename]
      ,s.[sex]
      ,s.[source]
      ,s.[source_date]
      ,s.[name_gathering_source]
      ,s.[date_of_birth]
      ,s.[status]
      ,s.[status_date]
      ,s.[status_reason]
      ,s.[department]
      ,s.[address_number]
      ,s.[dialling_code]
      ,s.[std_code]
      ,s.[telephone]
      ,s.[ex_directory]
      ,s.[notes]
      ,s.[contact_vat_category]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[contact_type]
      ,s.[dob_estimated]
      ,s.[contact_group]
      ,s.[ownership_group]
      ,s.[prefix_honorifics]
      ,s.[surname_prefix]
      ,s.[informal_salutation]
      ,s.[label_name_format_code]
      ,s.[ni_number]
	  , s.[CIS_CHECKSUM])
WHEN MATCHED  --AND s.ETLAction <> 3  --MATCHED AND NOT A DELETION
    THEN UPDATE SET
	
		
	 t.[contact_number] =  s.[contact_number]
	  ,t.[title] =  s.[title]
      ,t.[forenames] = s.[forenames]
      ,t.[initials] = s.[initials]
      ,t.[surname] = s.[surname]
      ,t.[honorifics] = s.[honorifics]
      ,t.[salutation] = s.[salutation]
      ,t.[label_name] = s.[label_name]
      ,t.[preferred_forename] = s.[preferred_forename]
      ,t.[sex] = s.[sex]
      ,t.[source] = s.[source]
      ,t.[source_date] = s.[source_date]
      ,t.[name_gathering_source] = s.[name_gathering_source]
      ,t.[date_of_birth] = s.[date_of_birth]
      ,t.[status] = s.[status]
      ,t.[status_date] = s.[status_date]
      ,t.[status_reason] = s.[status_reason]
      ,t.[department] =  s.[department]
      ,t.[address_number] = s.[address_number]
      ,t.[dialling_code] = s.[dialling_code]
      ,t.[std_code] = s.[std_code]
      ,t.[telephone] = s.[telephone]
      ,t.[ex_directory] = s.[ex_directory]
      ,t.[notes] = s.[notes]
      ,t.[contact_vat_category] = s.[contact_vat_category]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[contact_type] = s.[contact_type]
      ,t.[dob_estimated] = s.[dob_estimated]
      ,t.[contact_group] = s.[contact_group]
      ,t.[ownership_group] = s.[ownership_group]
      ,t.[prefix_honorifics] = s.[prefix_honorifics]
      ,t.[surname_prefix] = s.[surname_prefix]
      ,t.[informal_salutation] = s.[informal_salutation]
      ,t.[ni_number] = s.[ni_number]
      ,t.[label_name_format_code] = s.[label_name_format_code]
	  ,t.[CIS_CHECKSUM] = s.[CIS_CHECKSUM]

	 
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

	SELECT 'cis.contacts' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
