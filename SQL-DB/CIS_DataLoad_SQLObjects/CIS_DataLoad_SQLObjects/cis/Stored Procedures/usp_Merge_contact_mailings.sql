CREATE PROCEDURE [cis].[usp_Merge_contact_mailings]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.contact_mailings AS t
USING cis_delta.contact_mailings AS s 
ON (t.[contact_number] = s.[contact_number]) 
AND (t.[address_number] = s.[address_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	 [contact_number]
      ,[address_number]
      ,[mailing_number]
	) 
	
VALUES(

	   s.[contact_number]
      ,s.[address_number]
      ,s.[mailing_number])
WHEN MATCHED 
    THEN UPDATE SET
		
	 t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]
      ,t.[mailing_number] = s.[mailing_number]
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

	SELECT 'cis.contact_mailings' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
