CREATE PROCEDURE [cis].[usp_Merge_contact_positions]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE [cis].[contact_positions]  AS t
USING [cis_delta].[contact_positions]  AS s 
ON (t.[contact_number] = s.[contact_number]
) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[contact_number]
      ,[organisation_number]
      ,[address_number]
      ,[position]
      ,[mail]
      ,[current]
      ,[started]
      ,[finished]
      ,[position_location]
      ,[amended_by]
      ,[amended_on]
      ,[contact_position_number]
      ,[position_function]
      ,[position_seniority]
      ,[single_position])
	
VALUES(

	   s.[contact_number]
      ,s.[organisation_number]
      ,s.[address_number]
      ,s.[position]
      ,s.[mail]
      ,s.[current]
      ,s.[started]
      ,s.[finished]
      ,s.[position_location]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[contact_position_number]
      ,s.[position_function]
      ,s.[position_seniority]
      ,s.[single_position])
WHEN MATCHED 
    THEN UPDATE SET
			
      t.[contact_number] = s.[contact_number]
      ,t.[organisation_number] = s.[organisation_number]
      ,t.[address_number] = s.[address_number]
      ,t.[position] = s.[position]
      ,t.[mail] = s.[mail]
      ,t.[current] = s.[current]
      ,t.[started] = s.[started]
      ,t.[finished] = s.[finished]
      ,t.[position_location] = s.[position_location]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[contact_position_number] = s.[contact_position_number]
      ,t.[position_function] = s.[position_function]
      ,t.[position_seniority] = s.[position_seniority]
      ,t.[single_position] = s.[single_position]
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

	SELECT 'cis.contact_positions' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
