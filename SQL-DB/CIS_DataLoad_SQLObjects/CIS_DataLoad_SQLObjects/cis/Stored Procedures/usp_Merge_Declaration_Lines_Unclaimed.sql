CREATE PROCEDURE [cis].[usp_Merge_Declaration_Lines_Unclaimed]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.declaration_lines_unclaimed AS t
USING cis_delta.declaration_lines_unclaimed AS s 
ON (t.[cd_number] = s.[cd_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	 [cd_number]
      ,[contact_number]
      ,[batch_number]
      ,[transaction_number]
      ,[line_number]
      ,[declaration_or_covenant_number]
      ,[net_amount]
	) 
	
VALUES(

	   s.[cd_number]
      ,s.[contact_number]
      ,s.[batch_number]
      ,s.[transaction_number]
      ,s.[line_number]
      ,s.[declaration_or_covenant_number]
      ,s.[net_amount])
WHEN MATCHED 
    THEN UPDATE SET
		

	  t.[cd_number] = s.[cd_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[line_number] = s.[line_number]
      ,t.[declaration_or_covenant_number] = s.[declaration_or_covenant_number]
      ,t.[net_amount] = s.[net_amount]
	  
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

	SELECT 'cis.Declaration_lines_unclaimed' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
