CREATE PROCEDURE [cis].[usp_Merge_Declaration_Tax_Claims]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.Declaration_tax_claims AS t
USING cis_delta.Declaration_tax_claims AS s 
ON (t.[claim_number] = s.[claim_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[claim_number]
      ,[claim_generated_date]
      ,[amount_claimed]
      ,[claim_tax_year_start]
      ,[calculated_tax_amount]
	) 
	
VALUES(

	   s.[claim_number]
      ,s.[claim_generated_date]
      ,s.[amount_claimed]
      ,s.[claim_tax_year_start]
      ,s.[calculated_tax_amount])
WHEN MATCHED 
    THEN UPDATE SET
		

	  t.[claim_number] = s.[claim_number]
      ,t.[claim_generated_date] = s.[claim_generated_date]
      ,t.[amount_claimed] = s.[amount_claimed]
      ,t.[claim_tax_year_start] = s.[claim_tax_year_start]
      ,t.[calculated_tax_amount] = s.[calculated_tax_amount]
	  
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

	SELECT 'cis.Declaration_tax_claims' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
