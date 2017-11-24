-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimAddress]
AS
BEGIN


 SELECT NULL AS address_type
		, NULL AS  house_name
		, NULL AS  [address]
		, NULL AS  town
		, NULL AS  county
		, NULL AS  country
		, NULL AS  postcode
		, NULL AS  sortcode
		, NULL AS  mosaic_code
		, NULL AS  paf
		, NULL AS  branch
		, NULL AS  address_line1
		, NULL AS  address_line2
		, NULL AS  address_line3
		, NULL AS  address_line4
		, GETDATE() as [DW_LoadDate]
				
UNION ALL 

SELECT	a.address_type
		, ISNULL(a.house_name, '') as house_name
		, a.[address]
		, a.town
		, ISNULL(a.county, '') as county
		, a.country
		, ISNULL(a.postcode, '') as postcode
		, ISNULL(a.sortcode, '') as sortcode
		, a.mosaic_code
		, ISNULL(a.paf, '') as paf
		, ISNULL(a.branch, '') as branch
		, ISNULL(a.address_line1, '') as   address_line1
		, ISNULL(a.address_line2, '') as   address_line2
		, ISNULL(a.address_line3, '') as   address_line3
		, ISNULL(a.address_line4, '') as   address_line4
		, GETDATE() as [DW_LoadDate]
 FROM  [DiabetesDWH].[cis].[addresses] a

 


END
