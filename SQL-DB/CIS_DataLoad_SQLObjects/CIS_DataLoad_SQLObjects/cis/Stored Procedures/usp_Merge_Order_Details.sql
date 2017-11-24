CREATE PROCEDURE [cis].[usp_Merge_Order_Details] 
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; 
--Synchronize the target table with
--refreshed data from source table
MERGE cis.Order_Details AS t
USING cis_delta.Order_Details AS s 
ON (t.[order_number] = s.[order_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	   [order_number]
      ,[contact_number]
      ,[address_number]
      ,[detail_number]
      ,[product]
      ,[rate]
      ,[quantity]
      ,[amount]
      ,[balance]
      ,[arrears]
      ,[despatch_method]
      ,[time_status]
      ,[product_number]
      ,[distribution_code]
      ,[amended_by]
      ,[amended_on]
      ,[source]
      ,[created_by]
      ,[created_on]
      ,[communication_number]
      ,[effective_date]
      ,[valid_from]
      ,[valid_to]
      ,[net_fixed_amount]
	) 
	
VALUES(

	   s.[order_number]
      ,s.[contact_number]
      ,s.[address_number]
      ,s.[detail_number]
      ,s.[product]
      ,s.[rate]
      ,s.[quantity]
      ,s.[amount]
      ,s.[balance]
      ,s.[arrears]
      ,s.[despatch_method]
      ,s.[time_status]
      ,s.[product_number]
      ,s.[distribution_code]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[source]
      ,s.[created_by]
      ,s.[created_on]
      ,s.[communication_number]
      ,s.[effective_date]
      ,s.[valid_from]
      ,s.[valid_to]
      ,s.[net_fixed_amount])
WHEN MATCHED   
    THEN UPDATE SET
	
		
	 t.[order_number] = s.[order_number]
      ,t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]
      ,t.[detail_number] = s.[detail_number]
      ,t.[product] = s.[product]
      ,t.[rate] = s.[rate]
      ,t.[quantity] = s.[quantity]
      ,t.[amount] = s.[amount]
      ,t.[balance] = s.[balance]
      ,t.[arrears] = s.[arrears]
      ,t.[despatch_method] = s.[despatch_method]
      ,t.[time_status] = s.[time_status]
      ,t.[product_number] = s.[product_number]
      ,t.[distribution_code] = s.[distribution_code]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[source] = s.[source]
      ,t.[created_by] = s.[created_by]
      ,t.[created_on] = s.[created_on]
      ,t.[communication_number] = s.[communication_number]
      ,t.[effective_date] = s.[effective_date]
      ,t.[valid_from] = s.[valid_from]
      ,t.[valid_to] = s.[valid_to]
      ,t.[net_fixed_amount] = s.[net_fixed_amount]

	 
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

	SELECT 'cis.Order_Details' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
