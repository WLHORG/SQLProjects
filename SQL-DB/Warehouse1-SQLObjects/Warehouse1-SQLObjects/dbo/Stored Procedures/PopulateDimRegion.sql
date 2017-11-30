-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimRegion]
AS
BEGIN

SELECT		'UNKNOWN' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'' as fund_region
		,'' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]

   UNION ALL

		SELECT		'OVERSEAS' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'' as fund_region
		,'' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]

     UNION ALL

		SELECT		'A' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'YOR' as fund_region
		,'North East' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (England)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]

     UNION ALL

		SELECT		'B' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'YOR' as fund_region
		,'Yorkshire' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (England)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]

		   UNION ALL

		SELECT		'C' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'NEW' as fund_region
		,'North West' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (England)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]
		
		   UNION ALL

		SELECT		'D' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'WMI' as fund_region
		,'West Midlands' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (England)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]
		
		   UNION ALL

		SELECT		'E' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'EMI' as fund_region
		,'East Midlands' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (England)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]
		
		   UNION ALL

		SELECT		'F' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'EAS' as fund_region
		,'Eastern' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (England)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]
		
		   UNION ALL

		SELECT		'G' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'LON' as fund_region
		,'London' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (England)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]
		   
		   UNION ALL

		SELECT		'S' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'SEC' as fund_region
		,'South East Coast' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (England)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]
		
		   UNION ALL

		SELECT		'I' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'SOC' as fund_region
		,'South Central' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (England)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		 , GETDATE() as  [DW_LoadDate]
		 
		   UNION ALL

		SELECT		'J' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'SWE' as fund_region
		,'South West' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (England)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]

		   UNION ALL

		SELECT		'K' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'SCW' as fund_region
		,'Scotland - West' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (Scotland)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]
		
		   UNION ALL

		SELECT		'L' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'SCE' as fund_region
		,'Scotland - East' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (Scotland)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		 , GETDATE() as  [DW_LoadDate]
		 
		   UNION ALL

		SELECT		'M' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'SCH' as fund_region
		,'Scotland - Highlands' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (Scotland)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]
		
		   UNION ALL

		SELECT		'N' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'WAL' as fund_region
		,'Wales' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (Cymru)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]
		
		   UNION ALL

		SELECT		'O' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'NIR' as fund_region
		,'Northern Ireland' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (Northern Ireland)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]
		
		   UNION ALL

		SELECT		'P' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'' as fund_region
		,'Scotland' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (England)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
	 , GETDATE() as  [DW_LoadDate]

	   UNION ALL

		SELECT		'Q' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'' as fund_region
		,'Midlands' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (England)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
	   , GETDATE() as  [DW_LoadDate]
	   
	   UNION ALL

		SELECT		'R' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'' as fund_region
		,'Northern & Yorkshire' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (England)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
	   , GETDATE() as  [DW_LoadDate]
	   
	   UNION ALL

		SELECT		'X' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'' as fund_region
		,'Non Region Specific' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (England)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
	  , GETDATE() as  [DW_LoadDate]

	  	   UNION ALL

		SELECT		'H' as postcode
		,'' as latitude
		,'' as longitude
		,'' as Easting
		,'' as Northing
		,'' as GridRef
		,'' as County
		,'' as District
		,'' as Ward
		,'' as parish
		,'' as Country
		,'' as Constituency
		,'' as branch
		,'' as branch_desc
		,'' as rf_area
		,'' as rf_area_desc
		,'' as fund_region
		,'South East' as fund_region_desc
		,'' as PCO_SHA
		,'' as  DUK_region
		,'Diabetes U K (England)' as duk_nation
		,'' as organisation_desc_1
		,'' as relationship_desc_1
		,'' as organisation_desc_2
		,'' as relationship_desc_2
		,'' as  organisation_desc_3
		,'' as  relationship_desc_3
		,'' as  organisation_desc_4
		,'' as  relationship_desc_4
		,'' as [Lower layer super output area]
		,'' as [Rural urban]
		,'' as [population]
		,'' as Households
		,'' as acorn_group
		,'' as acorn_category
		,'' as acorn_type
		, GETDATE() as  [DW_LoadDate]

		UNION ALL 

SELECT bc.outward_postcode as postcode 
		, ISNULL(p.latitude, '') as latitude
		, ISNULL(p.longitude, '') as longitude
		, ISNULL(p.Easting, '') as Easting
		, ISNULL(p.Northing, '') as Northing
		, ISNULL(p.GridRef, '') as GridRef
		, ISNULL(p.County, '') as County
		, ISNULL(p.District, '') as District
		, ISNULL(p.Ward, '') as Ward
		, ISNULL(p.parish, '') as parish
		, ISNULL(p.Country, '') as Country
		, ISNULL(p.Constituency, '') as Constituency
		, bc.branch
		, bn.branch_desc
		, fa.rf_area
		, fa.rf_area_desc
		, fr.fund_region
		, fr.fund_region_desc
		, bn.PCO_SHA
		, bn.DUK_region
		, bn.duk_nation
		, rh.organisation_desc_1
		, rh.relationship_desc_1
		, rh.organisation_desc_2
		, rh.relationship_desc_2
		, ISNULL(rh.organisation_desc_3, 'N/A') organisation_desc_3
		, ISNULL(rh.relationship_desc_3, 'N/A') relationship_desc_3
		, ISNULL(rh.organisation_desc_4, 'N/A') organisation_desc_4
		, ISNULL(rh.relationship_desc_4, 'N/A') relationship_desc_4
		, ISNULL(p.[Lower layer super output area], '') as [Lower layer super output area]
		, ISNULL(p.[Rural urban], '') as [Rural urban]
		, ISNULL(p.[population], '') as [population]
		, ISNULL(p.Households, '') as Households
		, ISNULL(ag.acorn_group, '') as acorn_group
		, ISNULL(ac.acorn_category, '') as acorn_category
		, ISNULL(at.acorn_type, '') as acorn_type
		, GETDATE() as  [DW_LoadDate]

  FROM [DiabetesDWH].[cis].[branch_postcodes]bc 
  LEFT OUTER JOIN [DiabetesDWH].[cis].[duk_fund_region_hierarchy] fh ON bc.branch = fh.branch
  LEFT OUTER JOIN [DiabetesDWH].[cis].[duk_fundraising_areas] fa ON fh.rf_area = fa.rf_area
  LEFT OUTER JOIN [DiabetesDWH].[cis].[duk_fundraising_regions] fr ON fr.fund_region =	fh.fund_region
  LEFT OUTER JOIN  [DiabetesDWH].[cis].[duk_region_hierarchy] rh ON fh.branch = rh.branch 
  LEFT OUTER JOIN [DiabetesDWH].[custom].[cis_branch_to_nation] bn ON bn.branch = fh.branch
  LEFT OUTER JOIN [DiabetesDWH].[acorn].[acorn_postcode_directory_2014] ad ON bc.outward_postcode =	ad.postcode
  LEFT OUTER JOIN [DiabetesDWH].[acorn].[acorn_types_2014] at ON ad.Acorn_category = at.category_id AND ad.Acorn_type=  at.[type_id] 
  LEFT OUTER JOIN [DiabetesDWH].[acorn].[acorn_categories_2014] ac ON at.category_id = ac.category_id
  LEFT OUTER JOIN  [DiabetesDWH].[acorn].[acorn_groups_2014] ag ON at.group_id = ag.group_id
  LEFT OUTER JOIN  [DiabetesDWH]..postcodes p ON bc.outward_postcode = p.postcode

  END