CREATE PROCEDURE [cis].[usp_Merge_gaye_controls]
AS  
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.[gaye_controls] AS t
USING cis_delta.[gaye_controls] AS s 
ON (t.[donor_product] = s.[donor_product]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
[donor_product]
      ,[donor_rate]
      ,[employer_product]
      ,[employer_rate]
      ,[government_product]
      ,[government_rate]
      ,[admin_fee_product]
      ,[admin_fee_rate]
      ,[gaye_pledge_activity]
      ,[gaye_pledge_activity_value]
      ,[government_percentage]
      ,[source]
      ,[ni_data_source]
      ,[distribution_code]
      ,[employer_agency_relationship]
      ,[employer_payroll_relationship]
      ,[post_tax_donor_product]
      ,[post_tax_donor_rate]
      ,[post_tax_employer_product]
      ,[post_tax_employer_rate]
      ,[post_tax_pledge_source]
      ,[post_tax_distribution_code]
      ,[post_tax_employer_activity]
      ,[post_tax_employer_act_value]
      ,[post_tax_empr_payroll_relation]
      ,[post_tax_pledge_activity]
      ,[post_tax_pledge_activity_value]
	) 
	
VALUES(

	   s.[donor_product]
      ,s.[donor_rate]
      ,s.[employer_product]
      ,s.[employer_rate]
      ,s.[government_product]
      ,s.[government_rate]
      ,s.[admin_fee_product]
      ,s.[admin_fee_rate]
      ,s.[gaye_pledge_activity]
      ,s.[gaye_pledge_activity_value]
      ,s.[government_percentage]
      ,s.[source]
      ,s.[ni_data_source]
      ,s.[distribution_code]
      ,s.[employer_agency_relationship]
      ,s.[employer_payroll_relationship]
      ,s.[post_tax_donor_product]
      ,s.[post_tax_donor_rate]
      ,s.[post_tax_employer_product]
      ,s.[post_tax_employer_rate]
      ,s.[post_tax_pledge_source]
      ,s.[post_tax_distribution_code]
      ,s.[post_tax_employer_activity]
      ,s.[post_tax_employer_act_value]
      ,s.[post_tax_empr_payroll_relation]
      ,s.[post_tax_pledge_activity]
      ,s.[post_tax_pledge_activity_value])
WHEN MATCHED 
    THEN UPDATE SET
		
     t.[donor_product] = s.[donor_product]
      ,t.[donor_rate] = s.[donor_rate]
      ,t.[employer_product] = s.[employer_product]
      ,t.[employer_rate] = s.[employer_rate]
      ,t.[government_product] = s.[government_product]
      ,t.[government_rate] = s.[government_rate]
      ,t.[admin_fee_product] = s.[admin_fee_product]
      ,t.[admin_fee_rate] = s.[admin_fee_rate]
      ,t.[gaye_pledge_activity] = s.[gaye_pledge_activity]
      ,t.[gaye_pledge_activity_value] = s.[gaye_pledge_activity_value]
      ,t.[government_percentage] = s.[government_percentage]
      ,t.[source] = s.[source]
      ,t.[ni_data_source] = s.[ni_data_source]
      ,t.[distribution_code] = s.[distribution_code]
      ,t.[employer_agency_relationship] = s.[employer_agency_relationship]
      ,t.[employer_payroll_relationship] = s.[employer_payroll_relationship]
      ,t.[post_tax_donor_product] = s.[post_tax_donor_product]
      ,t.[post_tax_donor_rate] = s.[post_tax_donor_rate]
      ,t.[post_tax_employer_product] = s.[post_tax_employer_product]
      ,t.[post_tax_employer_rate] = s.[post_tax_employer_rate]
      ,t.[post_tax_pledge_source] = s.[post_tax_pledge_source]
      ,t.[post_tax_distribution_code] = s.[post_tax_distribution_code]
      ,t.[post_tax_employer_activity] = s.[post_tax_employer_activity]
      ,t.[post_tax_employer_act_value] = s.[post_tax_employer_act_value]
      ,t.[post_tax_empr_payroll_relation] = s.[post_tax_empr_payroll_relation]
      ,t.[post_tax_pledge_activity] = s.[post_tax_pledge_activity]
      ,t.[post_tax_pledge_activity_value] = s.[post_tax_pledge_activity_value]
	  
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

	SELECT 'cis.gaye_controls' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
