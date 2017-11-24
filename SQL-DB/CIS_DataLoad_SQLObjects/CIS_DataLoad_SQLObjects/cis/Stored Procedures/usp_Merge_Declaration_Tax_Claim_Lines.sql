CREATE PROCEDURE [cis].[usp_Merge_Declaration_Tax_Claim_Lines]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.declaration_tax_claim_lines AS t
USING cis_delta.declaration_tax_claim_lines AS s 
ON (t.[declaration_or_covenant_number] = s.[declaration_or_covenant_number]
AND t.[batch_number] = s.[batch_number]
AND t.[transaction_number] = s.[transaction_number] 
AND t.[line_number] = s.[line_number] ) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[claim_number]
      ,[cd_number]
      ,[declaration_or_covenant_number]
      ,[batch_number]
      ,[transaction_number]
      ,[line_number]
      ,[net_amount]
      ,[amount_claimed]
	) 
	
VALUES(

	   s.[claim_number]
      ,s.[cd_number]
      ,s.[declaration_or_covenant_number]
      ,s.[batch_number]
      ,s.[transaction_number]
      ,s.[line_number]
      ,s.[net_amount]
      ,s.[amount_claimed])
WHEN MATCHED 
    THEN UPDATE SET
		

	  t.[claim_number] = s.[claim_number]
      ,t.[cd_number] = s.[cd_number]
      ,t.[declaration_or_covenant_number] = s.[declaration_or_covenant_number]
      ,t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[line_number] = s.[line_number]
      ,t.[net_amount] = s.[net_amount]
      ,t.[amount_claimed] = s.[amount_claimed]
	  
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

	SELECT 'cis.declaration_tax_claim_lines' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
