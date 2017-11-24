CREATE PROCEDURE [cis].[usp_Merge_selected_contacts]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.selected_contacts AS t
USING cis_delta.selected_contacts AS s 
ON (t.[selection_set] = s.[selection_set]
AND t.[revision]  = s.[revision]
AND t.[contact_number] = s.[contact_number]
AND t.[address_number] = s.[address_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[selection_set]
      ,[revision]
      ,[contact_number]
      ,[address_number]
	) 
	
VALUES(

	   s.[selection_set]
      ,s.[revision]
      ,s.[contact_number]
      ,s.[address_number])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[selection_set] = s.[selection_set]
      ,t.[revision] = s.[revision]
      ,t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]


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

	SELECT 'cis.selected_contacts' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
