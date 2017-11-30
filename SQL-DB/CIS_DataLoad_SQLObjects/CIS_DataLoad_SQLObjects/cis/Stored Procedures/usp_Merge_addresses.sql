CREATE PROCEDURE [cis].[usp_Merge_addresses]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.addresses AS t
USING cis_delta.addresses AS s 
ON (t.[address_number] = s.[address_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
	[address_number]
      ,[address_type]
      ,[house_name]
      ,[address]
      ,[town]
      ,[county]
      ,[country]
      ,[postcode]
      ,[sortcode]
      ,[mosaic_code]
      ,[paf]
      ,[branch]
      ,[amended_by]
      ,[amended_on]
      ,[address_line1]
      ,[address_line2]
      ,[address_line3]
      ,[address_line4]
      ,[building_number]
      ,[delivery_point_suffix]
	) 
	
VALUES(

	   s.[address_number]
      ,s.[address_type]
      ,s.[house_name]
      ,s.[address]
      ,s.[town]
      ,s.[county]
      ,s.[country]
      ,s.[postcode]
      ,s.[sortcode]
      ,s.[mosaic_code]
      ,s.[paf]
      ,s.[branch]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[address_line1]
      ,s.[address_line2]
      ,s.[address_line3]
      ,s.[address_line4]
      ,s.[building_number]
      ,s.[delivery_point_suffix])
WHEN MATCHED 
    THEN UPDATE SET
		
	 t.[address_number] = s.[address_number]
      ,t.[address_type] = s.[address_type]
      ,t.[house_name] = s.[house_name]
      ,t.[address] = s.[address]
      ,t.[town] = s.[town]
      ,t.[county] = s.[county]
      ,t.[country] = s.[country]
      ,t.[postcode] = s.[postcode]
      ,t.[sortcode] = s.[sortcode]
      ,t.[mosaic_code] = s.[mosaic_code]
      ,t.[paf] = s.[paf]
      ,t.[branch] = s.[branch]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[address_line1] = s.[address_line1]
      ,t.[address_line2] = s.[address_line2]
      ,t.[address_line3] = s.[address_line3]
      ,t.[address_line4] = s.[address_line4]
      ,t.[building_number] = s.[building_number]
      ,t.[delivery_point_suffix] = s.[delivery_point_suffix]
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

	SELECT 'cis.addresses' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
