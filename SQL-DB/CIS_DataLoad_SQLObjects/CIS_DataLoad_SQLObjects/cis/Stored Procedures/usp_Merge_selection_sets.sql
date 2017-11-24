CREATE PROCEDURE [cis].[usp_Merge_selection_sets]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.selection_sets AS t
USING cis_delta.selection_sets AS s 
ON (t.[selection_set] = s.[selection_set]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[selection_set]
      ,[user_name]
      ,[department]
      ,[selection_set_desc]
      ,[number_in_set]
      ,[selection_group]
      ,[custom_data]
      ,[attribute_captions]
      ,[show_owner]
      ,[show_position]
      ,[check_box_captions]
      ,[source]
	) 
	
VALUES(

	   s.[selection_set]
      ,s.[user_name]
      ,s.[department]
      ,s.[selection_set_desc]
      ,s.[number_in_set]
      ,s.[selection_group]
      ,s.[custom_data]
      ,s.[attribute_captions]
      ,s.[show_owner]
      ,s.[show_position]
      ,s.[check_box_captions]
      ,s.[source])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[selection_set] = s.[selection_set]
      ,t.[user_name] = s.[user_name]
      ,t.[department] = s.[department]
      ,t.[selection_set_desc] = s.[selection_set_desc]
      ,t.[number_in_set] = s.[number_in_set]
      ,t.[selection_group] = s.[selection_group]
      ,t.[custom_data] = s.[custom_data]
      ,t.[attribute_captions] = s.[attribute_captions]
      ,t.[show_owner] = s.[show_owner]
      ,t.[show_position] = s.[show_position]
      ,t.[check_box_captions] = s.[check_box_captions]
      ,t.[source] = s.[source]

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

	SELECT 'cis.selection_sets' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
