-- ==============================================================================================================
-- Author:		Lindsay Scott

-- Create date: 21/10/2014

-- Description:	Populates CIS Contact_To_Nation table (custom.cis_contact_to_nation)
--				This table is used to map contacts to their Branch, DUK Region and DUK Nation
								
-- ============================================================================================================
CREATE PROCEDURE [custom].[spPopulateCIS_contact_to_nation] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

truncate table custom.cis_contact_to_nation

insert into custom.cis_contact_to_nation
(contact_number
, branch
, branch_desc
, organisation_number_2
, PCO_to_SHA
, organisation_number_3
, DUK_Region
, DUK_Nation
, rf_area
, rf_area_desc
, fund_region
, fund_region_desc)
select c.contact_number
,a.branch
,drh.organisation_desc_1 as 'Branch_Desc'
,[organisation_number_2]
,drh.organisation_desc_2 as 'PCO_to_SHA'
,[organisation_number_3]
,coalesce (drh.organisation_desc_3
,drh.organisation_desc_2
,drh.organisation_desc_1) as 'DUK_Region'
,coalesce (drh.organisation_desc_4
,drh.organisation_desc_3
,drh.organisation_desc_2
,drh.organisation_desc_1) as 'DUK_Nation'
,fgrn.rf_area
,fgrn.rf_area_desc
,fgrn.[fund_region]
,fgrn.fund_region_desc
from cis.contacts c
inner join cis.addresses a on c.address_number=a.address_number
inner join cis.duk_region_hierarchy drh on a.branch=drh.branch
left join (select dfrh.branch
			, dfrh.rf_area
			, dfa.rf_area_desc
			, dfrh.fund_region
			, dfr.fund_region_desc
			from cis.duk_fund_region_hierarchy as dfrh 
			inner join cis.duk_fundraising_areas as dfa on dfrh.rf_area=dfa.rf_area 
			inner join cis.duk_fundraising_regions as dfr on dfrh.fund_region=dfr.fund_region) as fgrn on a.branch=fgrn.branch;

END
