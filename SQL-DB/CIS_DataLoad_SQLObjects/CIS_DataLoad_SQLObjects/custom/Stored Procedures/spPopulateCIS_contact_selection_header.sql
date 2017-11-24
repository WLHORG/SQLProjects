
/*-------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
REPORT NAME		spPopulateCIS_contact_selection_header
REDMINE				
AUTHOR			Lindsay Scott
CREATED ON		18 December 2014
VERSION			2.0
NOTES			Based on code from Paul Mehta

				Populates CIS Contact Selection Header table (custom.CIS_contact_selection_header)
				Used as a standard mailing output for Data Team Selections


				1.0		18 December 2014	Initial Version Based on code from Paul Mehta
											from CISReporting db
				
---------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------*/

CREATE procedure [custom].[spPopulateCIS_contact_selection_header] as

begin

SET NOCOUNT ON;

/*Add organisation_number to communications table where contact_number is null
Assumption is that where they match, it is the orgnisations switchboard/info email etc..
Should really run via organisation_addresses first, but we do not have it, therore only
works for approx 95% of orginsations. 
*/
update cis.communications
set contact_number = organisation_number
from cis.communications as c
      join cis.organisations as  o on c.address_number = o.address_number
      and c.contact_number is null



--Populates Parents Table
--exec [custom].[spPopulateCIS_parents]


/*---------------------------------------------------------------------------
--Table Building for custom.cis_preferred_communications....  Takes 30 seconds
---------------------------------------------------------------------------*/

truncate table custom.cis_preferred_communications

;

with cte_pem (contact_number, communication_number, preferred_email)
	as(
select distinct c1.contact_number, c1.communication_number, c1.number as preferred_email
from cis.communications c1
	inner join (select contact_number, max(communication_number) as communication_number
				from cis.communications
				where device in ('EM','EC','WR')
				and is_active = 'Y'
				and (valid_to is null or valid_to > getdate())
				group by contact_number)
				c2 on c2.contact_number = c1.contact_number
					and c2.communication_number = c1.communication_number
)
,
cte_pph (contact_number, communication_number, preferred_phone)
as(
select distinct c1.contact_number, c1.communication_number, c1.cli_number as preferred_phone
from cis.communications c1
	inner join (select contact_number, max(communication_number) as communication_number
				from cis.communications
				where device in ('T','TD')
				and is_active = 'Y'
				and (valid_to is null or valid_to > getdate())
				group by contact_number)
				c2 on c2.contact_number = c1.contact_number
					and c2.communication_number = c1.communication_number
)
,
cte_pmb (contact_number, communication_number, preferred_mobile)
as(
select distinct c1.contact_number, c1.communication_number, c1.cli_number as preferred_mobile
from cis.communications c1
	inner join (select contact_number, max(communication_number) as communication_number
				from cis.communications
				where device = 'MB'
				and is_active = 'Y'
				and (valid_to is null or valid_to > getdate())
				group by contact_number)
				c2 on c2.contact_number = c1.contact_number
					and c2.communication_number = c1.communication_number
)

insert into custom.cis_preferred_communications
select c.contact_number,
replace(c1.preferred_email,',', ' '),
replace(c2.preferred_phone,',', ' '),
replace(c3.preferred_mobile,',', ' ')
from cis.contacts c
	left join cte_pem c1 on c1.contact_number = c.contact_number
	left join cte_pph c2 on c2.contact_number = c.contact_number
	left join cte_pmb c3 on c3.contact_number = c.contact_number
--order by c.contact_number


;

/*---------------------------------------------------------------------------
--Table Building for custom.cis_preferred_communications
---------------------------------------------------------------------------*/

--drop table Y_contact_selection_header

--create table  Y_contact_selection_header
--(contact_number int,
--label_name varchar(80),
--title varchar(40),
--initials varchar(7),
--forenames varchar(60),
--preffered_name varchar(30),
--surname varchar(50),
--honorifics varchar(30),
--salutation varchar(80),
--date_of_birth varchar(20),
--sex varchar(1),
--source varchar(10),
--source_desc varchar(60),
--address_number int,
--organisation_name varchar(80),
--house_name varchar(60),
--address_line1 varchar(80),
--address_line2 varchar(80),
--address_line3 varchar(80),
--address_line4 varchar(80),
--town varchar(35),
--county varchar(35),
--postcode varchar(10),
--country varchar(30),
--preferred_email varchar(128),
--preferred_phone varchar(128),
--preferred_mobile varchar(128),
--diabetes_type varchar(60),
--gift_aid_status varchar(1),
--disability_suppressions varchar(128),
--parent varchar(1)
--)
;

--create unique index ind_Y_contact_selection_header on Y_contact_selection_header (contact_number);


truncate table custom.CIS_contact_selection_header;

insert into custom.CIS_contact_selection_header
select distinct
c.contact_number,
isnull(replace(c.label_name,',', ' '),'') as label_name, 
isnull(replace(c.title,',', ' '),'') as title, 
isnull(replace(c.initials,',', ' '),'') as initials, 
case when c.forenames is null then 'Supporter'
	when len(c.forenames) = 1 then 'Supporter'
		when LEN(forenames) = 3 and Charindex(' ',c.forenames) > 0 then 'Supporter'
			else c.forenames end as forenames,
isnull(replace(c.preferred_forename,',', ' '),'') as preferred_name,
isnull(replace(c.surname,',', ' '),'') as surname, 
isnull(replace(c.honorifics,',', ' '),'') as honorifics, 
isnull(replace(c.salutation,',', ' '),'') as salutation,
isnull(convert(varchar, c.date_of_birth, 103),'') as date_of_birth,
c.sex,
c.source,
s.source_desc,
u.address_number,
isnull(replace(o.name,',', ' '),'') as organisation_name, 
isnull(replace(a.house_name,',', ' '),'') as house_name,
isnull(replace(a.address_line1,',', ' '),'') as address_line1,
isnull(replace(a.address_line2,',', ' '),'') as address_line2,
isnull(replace(a.address_line3,',', ' '),'') as address_line3, 
isnull(replace(a.address_line4,',', ' '),'') as address_line4,
isnull(replace(a.town,',', ' '),'') as town, 
isnull(replace(a.county,',', ' '),'') as county, 
isnull(replace(a.postcode,',', ' '),'') as postcode, 
case when co.country in ('NI','UK') then ''
	else isnull(replace(co.country_desc,',', ' '),'') end as country,
isnull(yc.preferred_email,'') as preferred_email,
isnull(yc.preferred_phone,'') as preferred_phone,
isnull(yc.preferred_mobile,'') as preferred_mobile,
--isnull(replace(cc.activity_value_desc,',', ' '),'') as diabetes_type,
isnull(ltrim(stuff((select ', ' + av.activity_value_desc
					from cis.contact_categories as cc
						inner join cis.activity_values as av on cc.activity=av.activity 
															and cc.activity_value=av.activity_value 
					where cc.activity = 'DIAT'
					and getdate() between valid_from and isnull(valid_to, '31 dec 2099')
					and cc.contact_number=c.contact_number
					for xml path('')),1,1, '')),'') as diabetes_type,
case when g.contact_number is not null then 'Y' else 'N' end as gift_aid_status,
isnull(
ltrim(
stuff((select ', ' + ms.mailing_suppression_desc
					from cis.contact_suppressions cs
						inner join cis.mailing_suppressions ms on ms.mailing_suppression = cs.mailing_suppression
					where cs.contact_number is not null
					and cs.mailing_suppression in ('VI','VA','PLFX')
					and cs.contact_number = c.contact_number
					for xml path ('')), 1, 1, ''))
,'') as disability_suppressions,
case when y.contact_number is not null then 'Y' else 'N' end as parent 
from custom.cis_universefile_output u
	inner join cis.contacts c on u.contact_number=c.contact_number
	inner join cis.addresses a on u.address_number=a.address_number
	inner join cis.countries co on co.country = a.country
	inner join cis.sources s on s.source = c.source
	left join cis.organisations o on u.address_number=o.address_number
	left join custom.cis_Parents y on y.contact_number = u.contact_number
	left join (select distinct contact_number
				from cis.gift_aid_declarations
				where cancellation_reason is null) g on g.contact_number = c.contact_number
	--left join (select distinct contact_number, activity_value_desc
	--			from contact_categories
	--				inner join activity_values on contact_categories.activity = activity_values.activity
	--												and contact_categories.activity_value = activity_values.activity_value
	--			where contact_categories.activity = 'DIAT'
	--			and getdate() between valid_from and isnull(valid_to, '31 dec 2099')) cc
	--			on cc.contact_number = c.contact_number
	left join [custom].[cis_preferred_communications] yc on yc.contact_number = c.contact_number
where c.contact_type = 'C' 
--and c.contact_number in (767784,1724197,1196751)

--select * from Y_contact_selection_header

END



