CREATE PROCEDURE [cis].[usp_Merge_Contact_Roles]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE [cis].[contact_roles]  AS t
USING [cis_delta].[contact_roles]  AS s 
ON (t.[contact_number] = s.[contact_number]
AND t.[contact_role_number] = s.[contact_role_number]
) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[contact_number]
      ,[organisation_number]
      ,[role]
      ,[valid_from]
      ,[valid_to]
      ,[is_active]
      ,[amended_by]
      ,[amended_on]
      ,[contact_role_number])
	
VALUES(

	   s.[contact_number]
      ,s.[organisation_number]
      ,s.[role]
      ,s.[valid_from]
      ,s.[valid_to]
      ,s.[is_active]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[contact_role_number])
WHEN MATCHED 
    THEN UPDATE SET
			
      t.[contact_number] = s.[contact_number]
      ,t.[organisation_number] = s.[organisation_number]
      ,t.[role] = s.[role]
      ,t.[valid_from] = s.[valid_from]
      ,t.[valid_to] = s.[valid_to]
      ,t.[is_active] = s.[is_active]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[contact_role_number] = s.[contact_role_number]
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

	SELECT 'cis.contact_roles' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
