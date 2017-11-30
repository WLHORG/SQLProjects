-- ==============================================================================================================
-- Author:		Lindsay Scott

-- Create date: 18/05/2015

-- Description:	Populates custom.cis_source_code_mapping table. Table maps old source code structure to new.
--				
--VERSION HISTORY

--Version		Date		By		Description
--1.0			2015-05-18	LJS		Initial version.	
--1.1			2015-10-20	LJS		replaced duk_channel_codes_proxy with CIS.duk_channels 
				
-- ============================================================================================================
CREATE PROCEDURE [custom].[spPopulateCIS_source_code_mapping] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	truncate table custom.cis_source_code_mapping
insert into custom.cis_source_code_mapping
([source]
, source_desc
, new_source
, [year]
, [month]
, team
, activity
, region
, channel
, year_desc
, month_desc
, team_desc
, activity_desc
, region_desc
, channel_desc)
Select s.source
, s.source_desc
, isnull(d.new_source,'XXXZZXXXX') as new_source
, case when d.new_source is null then 'Z' else SUBSTRING(d.new_source,1,1) end as [year]
, case when d.new_source is null then 'X' else SUBSTRING(d.new_source,2,1) end as [month]
, case when d.new_source is null then 'X' else SUBSTRING(d.new_source,3,1) end as [team]
, case when d.new_source is null then 'ZZ' else SUBSTRING(d.new_source,4,2) end as [activity]
, case when d.new_source is null then 'X' else SUBSTRING(d.new_source,6,1) end as [region]
, case when d.new_source is null then 'X' else SUBSTRING(d.new_source,7,1) end as [channel]
, case when d.new_source is null then 'Historical' else  yc.year_code_desc end as year_desc
, case when d.new_source is null then 'ALL'
	when SUBSTRING(d.new_source,2,1) = 'X' then 'ALL'
		else  mc.month_code_desc end as month_desc
, case when d.new_source is null then 'TBC' 
	when  SUBSTRING(d.new_source,3,1) = 'X' then 'TBC'
		else cc.cost_centre_team_desc end as team_desc
, case when d.new_source is null then 'Other - General' 
		else  ca.cost_centre_activity_desc end as activity_desc
, case when d.new_source is null then 'Non Region Specific'
		else rr.region_desc end as region_desc
, case when d.new_source is null then 'UNKNOWN'
		else ss.channel_desc end as channel_desc
from cis.sources s
  left join (select source, new_source, new_cost_centre, new_programme
				from cis.duk_new2015_sources
				where new_product is null
				and region is null
			) d on d.source = s.source
  left join cis.duk_year_codes yc on yc.year_code = SUBSTRING(d.new_source,1,1)
  left join cis.duk_month_codes mc on mc.month_code = SUBSTRING(d.new_source,2,1)
  left join cis.duk_cost_centre_teams cc on cc.cost_centre_team = SUBSTRING(d.new_source,3,1)
  left join cis.duk_cost_centre_activities ca on ca.cost_centre_activity = SUBSTRING(d.new_source,4,2)
  left join cis.duk_regions rr on rr.region = SUBSTRING(d.new_source,6,1)
--  left join custom.duk_channel_codes_proxy ss on ss.channel_code = SUBSTRING(d.new_source,7,1)
  left join [cis].[duk_channels] ss on ss.channel = SUBSTRING(d.new_source,7,1)

  

END
