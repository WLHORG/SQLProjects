CREATE PROCEDURE [cis].[usp_Merge_Legacy_Bequests]  
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; 
--Synchronize the target table with
--refreshed data from source table
MERGE [cis].[legacy_bequests] AS t   
USING [cis_delta].[legacy_bequests] AS s 
ON (t.[legacy_number] = s.[legacy_number]
AND t.[bequest_number] = s.[bequest_number] ) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[legacy_number]
      ,[bequest_number]
      ,[bequest_description]
      ,[bequest_type]
      ,[bequest_sub_type]
      ,[bequest_status]
      ,[expected_value]
      ,[estimated_outstanding]
      ,[estimate]
      ,[product]
      ,[rate]
      ,[amended_by]
      ,[amended_on]
      ,[expected_fraction_quantity]
      ,[expected_fraction_division]
      ,[condition_met_date]
      ,[distribution_code]
      ,[notes]
	) 
	
VALUES(

	   s.[legacy_number]
      ,s.[bequest_number]
      ,s.[bequest_description]
      ,s.[bequest_type]
      ,s.[bequest_sub_type]
      ,s.[bequest_status]
      ,s.[expected_value]
      ,s.[estimated_outstanding]
      ,s.[estimate]
      ,s.[product]
      ,s.[rate]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[expected_fraction_quantity]
      ,s.[expected_fraction_division]
      ,s.[condition_met_date]
      ,s.[distribution_code]
      ,s.[notes])
WHEN MATCHED   
    THEN UPDATE SET
	
		
 	   t.[legacy_number]           =		s.[legacy_number]
      ,t.[bequest_number]			    = 	s.[bequest_number]
      ,t.[bequest_description]		    = 	s.[bequest_description]
      ,t.[bequest_type]				    = 	s.[bequest_type]
      ,t.[bequest_sub_type]			    = 	s.[bequest_sub_type]
      ,t.[bequest_status]			    = 	s.[bequest_status]
      ,t.[expected_value]			    = 	s.[expected_value]
      ,t.[estimated_outstanding]	    = 	s.[estimated_outstanding]
      ,t.[estimate]					    = 	s.[estimate]
      ,t.[product]					    = 	s.[product]
      ,t.[rate]						    = 	s.[rate]
      ,t.[amended_by]				    = 	s.[amended_by]
      ,t.[amended_on]				    = 	s.[amended_on]
      ,t.[expected_fraction_quantity]   = 	s.[expected_fraction_quantity]
      ,t.[expected_fraction_division]   = 	s.[expected_fraction_division]
      ,t.[condition_met_date]		    = 	s.[condition_met_date]
      ,t.[distribution_code]		    = 	s.[distribution_code]
      ,t.[notes]						=	s.[notes]
	 
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

	SELECT 'cis.legacy_bequests' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END