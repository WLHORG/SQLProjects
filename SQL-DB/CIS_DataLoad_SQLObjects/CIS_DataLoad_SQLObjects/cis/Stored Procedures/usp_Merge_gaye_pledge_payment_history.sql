CREATE PROCEDURE [cis].[usp_Merge_gaye_pledge_payment_history]
AS  
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.[gaye_pledge_payment_history] AS t
USING cis_delta.[gaye_pledge_payment_history] AS s 
ON (t.[gaye_pledge_number] = s.[gaye_pledge_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
[gaye_pledge_number]
      ,[batch_number]
      ,[transaction_number]
      ,[donor_amount]
      ,[employer_amount]
      ,[government_amount]
      ,[admin_fee_amount]
      ,[payment_number]
	) 
	
VALUES(

	   s.[gaye_pledge_number]
      ,s.[batch_number]
      ,s.[transaction_number]
      ,s.[donor_amount]
      ,s.[employer_amount]
      ,s.[government_amount]
      ,s.[admin_fee_amount]
      ,s.[payment_number])
WHEN MATCHED 
    THEN UPDATE SET
		
      t.[gaye_pledge_number] = s.[gaye_pledge_number]
      ,t.[batch_number] = s.[batch_number]
      ,t.[transaction_number] = s.[transaction_number]
      ,t.[donor_amount] = s.[donor_amount]
      ,t.[employer_amount] = s.[employer_amount]
      ,t.[government_amount] = s.[government_amount]
      ,t.[admin_fee_amount] = s.[admin_fee_amount]
      ,t.[payment_number] = s.[payment_number]
	  
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

	SELECT 'cis.gaye_pledge_payment_history' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
