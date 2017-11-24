/*------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
DATABASE        DiabetesDWH
SCHEMA          Custom
TABLE NAME      Various
AUTHOR          Meena Shah
REDMINE         http://camdukcppv01:8080/redmine/issues/16098
CREATED ON      17 Oct 2017
VERSION         1.0
NOTES	
                Built as defined by Paul M

-- Version history
-- Version    	Date		         By	  Description
-- 1.1         yyyy-mm-dd     xx   As per RMxxxxx - xxxxxxxxxxxx
--
--------------------------------------------------------------------------------------
------------------------------------------------------------------------------------*/
--CREATE
CREATE
 PROCEDURE [custom].[spPopulateCIS_branch_reg_nat_transformation] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

/*
SELECT OBJECT_ID('MeenaS.cis_branch_reg_nat_transformation', 'U')
;
--862782281
*/

/*

----truncate table custom.cis_branch_reg_nat_transformation
IF  OBJECT_ID('MeenaS.cis_branch_reg_nat_transformation', 'U') IS NULL
    PRINT 'TABLE MeenaS.cis_branch_reg_nat_transformation not found'
ELSE
    PRINT 'TABLE MeenaS.cis_branch_reg_nat_transformation exists'
    TRUNCATE TABLE MeenaS.cis_branch_reg_nat_transformation
--Dropping the table for now as it will not let me trunacte id
--    DROP TABLE MeenaS.cis_branch_reg_nat_transformation
;

*/

/*
*/
----truncate table custom.cis_branch_reg_nat_transformation
IF  OBJECT_ID('CUSTOM.cis_branch_reg_nat_transformation', 'U') IS NULL
    PRINT 'TABLE CUSTOM.cis_branch_reg_nat_transformation not found'
ELSE
    PRINT 'TABLE CUSTOM.cis_branch_reg_nat_transformation exists'
    TRUNCATE TABLE CUSTOM.cis_branch_reg_nat_transformation
;
/*
*/

/***

--Drop the table if it exists
IF  object_id('DiabetesDWH.MeenaS.cis_branch_reg_nat_transformation') IS NOT NULL
BEGIN
    PRINT 'Table [MeenaS].[cis_branch_reg_nat_transformation] exists, so dropping it';
    DROP TABLE DiabetesDWH.MeenaS.cis_branch_reg_nat_transformation
END
;

***/

/***

--Drop the table if it exists
IF  object_id('DiabetesDWH.CUSTOM.cis_branch_reg_nat_transformation') IS NOT NULL
BEGIN
    PRINT 'Table [CUSTOM].[cis_branch_reg_nat_transformation] exists, so dropping it';
    DROP TABLE DiabetesDWH.CUSTOM.cis_branch_reg_nat_transformation
END
;

***/


---------------------------------------------------------------------------------------------------
----------------------Output Code------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
/* */
INSERT INTO CUSTOM.cis_branch_reg_nat_transformation
----INSERT INTO MeenaS.cis_branch_reg_nat_transformation
     (
       branch
     , organisation_number_1
     , organisation_desc_1
--                                AS 'Branch_Desc'
     , organisation_number_2
     , organisation_desc_2
--                                AS 'PCO_to_SHA'
     , organisation_number_3
     , organisation_desc_3
     , organisation_number_4
     , organisation_desc_4
     , duk_ops_region
     , duk_ops_nation
     , rf_area
     , rf_area_desc
     , Fund_Region
     , Fund_Region_Desc
     , Volunteering_Regions
     , DUK_Region_CIS
     , DUK_Region
     , DUK_Nation_CIS
     , DUK_Nation
     )
/* */
SELECT
       drh.branch
     , drh.[organisation_number_1]
     , drh.organisation_desc_1
--                                AS 'Branch_Desc'
     , drh.[organisation_number_2]
     , drh.organisation_desc_2
--                                AS 'PCO_to_SHA'
     , drh.[organisation_number_3]
     , drh.organisation_desc_3
     , drh.[organisation_number_4]
     , drh.organisation_desc_4
     , CASE WHEN drh.organisation_desc_3 IS NULL 
            THEN drh.organisation_desc_2
            ELSE drh.organisation_desc_3
       END
                                AS duk_ops_region
     , CASE WHEN drh.organisation_desc_4 IS NULL
            THEN drh.organisation_desc_2
            ELSE drh.organisation_desc_4
       END
                                AS duk_ops_nation
     , fgrn.rf_area
     , fgrn.rf_area_desc
     , fgrn.[fund_region]
     , fgrn.fund_region_desc
     , CASE WHEN drh.organisation_desc_3 IN
               ( 'Diabetes U K (London Region)'
               , 'Diabetes U K (South East Region)'
               )
            THEN 'A - Lon & SE'
	           WHEN drh.organisation_desc_3 IN
               ( 'Diabetes U K (Eastern Region)'
               , 'Diabetes U K (East Midlands Region)'
               , 'Diabetes U K (West Midlands Region)'
               )
            THEN 'B - Midlands & Eastern'
		          WHEN drh.organisation_desc_3 IN
               ( 'Diabetes U K (North West Region)'
               , 'Diabetes U K (Northern & Yorks Region)'
               )
            THEN 'C - The North'
			         WHEN drh.organisation_desc_3 = 'Diabetes U K (South West Region)'
            THEN 'D - South West' 
				        WHEN drh.organisation_desc_2 = 'Diabetes U K (Northern Ireland)'
            THEN 'E - Northern Ireland'
					       WHEN drh.organisation_desc_2 = 'Diabetes U K (Scotland)'
            THEN 'F - Scotland'
						      WHEN drh.organisation_desc_2 = 'Diabetes U K (Cymru)'
            THEN 'G - Wales'
       END
                                AS volunteering_regions
     , COALESCE(drh.organisation_desc_3, drh.organisation_desc_2, drh.organisation_desc_1)
                                AS 'DUK_Region_CIS'
     , ISNULL(
                 (REPLACE
                     (REPLACE
                         (REPLACE
                             (COALESCE(drh.organisation_desc_3, drh.organisation_desc_2, drh.organisation_desc_1)
                             , 'Diabetes U K (', ''
                             )
                         , ' region)', ''
                         )
                         , ')', ''
                     )
                 ), 'Unknown'
             )
                                AS 'DUK_Region'
     , REPLACE(COALESCE(drh.organisation_desc_4, drh.organisation_desc_3, drh.organisation_desc_2, drh.organisation_desc_1), 'Cymru', 'Wales')
                                AS 'DUK_Nation_CIS'
     , ISNULL(
                 (REPLACE
                     (REPLACE
                         (REPLACE
                             (REPLACE
                                 (COALESCE(drh.organisation_desc_4, drh.organisation_desc_3, drh.organisation_desc_2, drh.organisation_desc_1)
                                 , 'Cymru', 'Wales'
                                 )
                             , 'Diabetes U K (', ''
                             )
                         , ' region)', ''
                         )
                         , ')', ''
                     )
                 ), 'Unknown'
             )
                                AS 'DUK_Nation'
--INTO MeenaS.cis_branch_reg_nat_transformation
--INTO CUSTOM.cis_branch_reg_nat_transformation
FROM
       cis.duk_region_hierarchy AS drh
LEFT JOIN
    (
    SELECT
           dfrh.branch
         , dfrh.rf_area
         , dfa.rf_area_desc
         , dfrh.fund_region
         , dfr.fund_region_desc
    FROM
           cis.duk_fund_region_hierarchy AS dfrh
    INNER JOIN
           cis.duk_fundraising_areas     AS dfa
       ON  dfrh.rf_area                   = dfa.rf_area
    INNER JOIN
           cis.duk_fundraising_regions   AS dfr
       ON  dfrh.fund_region               = dfr.fund_region
    )
                                AS fgrn
   ON drh.branch                 = fgrn.branch
;

/*  Test the output

SELECT *
--FROM   MeenaS.cis_branch_reg_nat_transformation
FROM   CUSTOM.cis_branch_reg_nat_transformation
where  branch = '4999'
   or organisation_desc_1 like 'Diabetes U%'
;

*/
---------------------------------------------------------------------------------------------------
----------------------End Outputs------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
----------------------Workings Below---------------------------------------------------------------
---------------------------------------------------------------------------------------------------
/*

-- REGIONAL CODE MAPPINGS PAN ORGANISATION
-- NEEDS ONE PLACE
-- ONE TRANSFORMATION

with cte as (
Select d.branch
, d.organisation_desc_1
, d.organisation_desc_2
, d.organisation_desc_3
, d.organisation_desc_4
, case when d.organisation_desc_3 is null then d.organisation_desc_2 else d.organisation_desc_3 end as duk_ops_region
, case when d.organisation_desc_4 is null then d.organisation_desc_2 else d.organisation_desc_4 end as duk_ops_nation
, fr.rf_area
, dfa.rf_area_desc
, fr.fund_region
, dfr.fund_region_desc
, Case when d.organisation_desc_3 in ('Diabetes U K (London Region)','Diabetes U K (South East Region)') then 'A - Lon & SE'
	when d.organisation_desc_3 in ('Diabetes U K (Eastern Region)','Diabetes U K (East Midlands Region)','Diabetes U K (West Midlands Region)') then 'B - Midlands & Eastern'
		when d.organisation_desc_3 in ('Diabetes U K (North West Region)','Diabetes U K (Northern & Yorks Region)') then 'C - The North'
			when d.organisation_desc_3 = 'Diabetes U K (South West Region)' then 'D - South West' 
				when d.organisation_desc_2 = 'Diabetes U K (Northern Ireland)' then 'E - Northern Ireland'
					when d.organisation_desc_2 = 'Diabetes U K (Scotland)' then 'F - Scotland'
						when d.organisation_desc_2 = 'Diabetes U K (Cymru)' then 'G - Wales'
				end as volunteering_regions
from cis.duk_region_hierarchy d
	left join cis.duk_fund_region_hierarchy fr on fr.branch = d.branch
	left join cis.duk_fundraising_areas dfa on dfa.rf_area = fr.rf_area
	left join cis.duk_fundraising_regions dfr on dfr.fund_region = fr.fund_region
)
select c.*
, replace(
		replace(
			replace(c.duk_ops_region,'Diabetes U K (',''),
							' region)',''),
							')','') as DUK_region  -- can we change 'Cymru to wales'
, replace(
		replace(
			replace(c.duk_ops_nation,'Diabetes U K (',''),
							' region)',''),
							')','') as DUK_nation  -- can we change 'Cymru to wales'
from cte c
where branch <> '4999'
*/
---------------------------------------------------------------------------------------------------
----------------------End Of Workings--------------------------------------------------------------
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
----------------------End Of Code------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

END
