/*-- ==============================================================================================================
--	Author:			Lindsay Scott

--	Create date:	20/10/2014

--	Description:	Populates UniverseFile_Output Table (custom.cis_universefile_output)
--					This table is used to attempt to find the most appropriate mailing address for CIS contacts
	
VERSION HISTORY

Version		Date			By		Description
1.0			2011?			RL		Initial version.
1.1			2015-05-06		LJS		Added non default mc non historic address condition
								
-- ============================================================================================================*/
CREATE PROCEDURE [custom].[spPopulateCIS_universefile_output]



AS


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


--create table custom.universefile_output
--(contact_number int
--, address_number int)


--this sets up the universefile output
if object_id('tempdb..#goodoutput') is not null drop table #GoodOutput
create table #goodoutput
(contact_number int primary key, 
address_number int, 
address_type varchar(50))

if object_id('tempdb..#notdealtwith') is not null drop table #notdealtwith
create table #notdealtwith
(contact_number int)

--default mc non historic address
;
with con_add as 
(select cau.contact_number, 
		cau.address_number, 
		cau.address_usage, 
		c.address_number as defaultaddress, 
		ca.historical
 from cis.contacts c
	inner join cis.contact_address_usages cau on c.contact_number=cau.contact_number 
	inner join cis.contact_addresses ca on cau.contact_number=ca.contact_number 
										and cau.address_number=ca.address_number)
	
	
insert into #goodoutput
select  ca.contact_number, 
		ca.address_number, 
		'default mc non historic'
from con_add ca 
where historical='N' 
and address_usage='MC' 
and defaultaddress=address_number

---------------------------------------------------------------------------------------------------
----------------------LJS Suggestion - non default mc non historic address-------------------------
---------------------------------------------------------------------------------------------------
;
with con_add as 
(select cau.contact_number, 
		cau.address_number, 
		cau.address_usage, 
		c.address_number as defaultaddress, 
		ca.historical,
		rank() OVER (partition by cau.contact_number order by ca.amended_on desc) as amend_ID,
		rank() OVER (partition by cau.contact_number order by ca.address_number desc) as address_ID
 from cis.contacts c
	inner join cis.contact_address_usages cau on c.contact_number=cau.contact_number 
	inner join cis.contact_addresses ca on cau.contact_number=ca.contact_number 
										and cau.address_number=ca.address_number)
insert into #goodoutput
select  ca.contact_number, 
		ca.address_number, 
		'non default mc non historic'
from con_add ca 
where historical='N' 
and address_usage='MC' 
and amend_ID = 1
and address_ID = 1
and contact_number not in (select contact_number 
								from #goodoutput)

---------------------------------------------------------------------------------------------------
----------------------End LJS Suggestion-----------------------------------------------------------
---------------------------------------------------------------------------------------------------



--only address from contact_addresses
;
with con_add as 
(select c.contact_number, 
		c.address_number, 
		c.address_number as defaultaddress, 
		ca.historical
 from cis.contacts c
	left join cis.contact_addresses ca on c.contact_number=ca.contact_number)
		
insert into #goodoutput
select ca.contact_number, 
		ca.address_number, 
		'only address'
from con_add ca 
where (select count(*) 
		from con_add ca2 
		where ca.contact_number=ca2.contact_number)=1
and ca.contact_number not in (select contact_number 
								from #goodoutput)

--only nonhistoric address
;with con_add as 
(select cau.contact_number, 
		cau.address_number, 
		cau.address_usage, 
		c.address_number as defaultaddress, 
		ca.historical
 from cis.contacts c
	inner join cis.contact_address_usages cau on c.contact_number=cau.contact_number 
	inner join cis.contact_addresses ca on cau.contact_number=ca.contact_number 
										and cau.address_number=ca.address_number)


insert into #goodoutput
select ca.contact_number,
		ca.address_number, 
		'only non historic address'
from con_add ca 
where  (select count(*) 
		from con_add ca2 
		where historical='N' 
		and ca.contact_number=ca2.contact_number)=1
and ca.contact_number not in (select contact_number 
								from #goodoutput)
and ca.historical='N' 

--default address
insert into #goodoutput
select c.contact_number, 
		c.address_number, 
		'default address'
from cis.contacts c
where contact_number not in (select contact_number 
								from #goodoutput)

insert into #notdealtwith
select contact_number 
from cis.contacts 
where contact_number not in (select contact_number 
								from #goodoutput)


truncate table custom.cis_universefile_output

insert into custom.cis_universefile_output
select c.contact_number, 
		a.address_number
from #goodoutput g
	inner join cis.contacts c on g.contact_number=c.contact_number
	inner join cis.addresses a on g.address_number=a.address_number 


---------------------------------------------------------------------------------------------------
----------------------populates custom.cis_universefile_output_detail------------------------------
---------------------------------------------------------------------------------------------------

truncate table custom.cis_universefile_output_detail

insert into custom.cis_universefile_output_detail
(contact_number,
address_number,
label_name, 
title, 
initials, 
forenames, 
preferred_forename,
surname, 
honorifics, 
salutation, 
organisation_name, 
house_name,
address_line1,
address_line2,
address_line3, 
address_line4,
town, 
county, 
postcode, 
country,
source,
source_date,
[status],
date_of_birth,
sex)
select distinct c.contact_number,
a.address_number, 
isnull(replace(c.label_name,',', ' '),'') as label_name, 
isnull(replace(c.title,',', ' '),'') as title, 
isnull(replace(c.initials,',', ' '),'') as initials, 
isnull(replace(c.forenames,',', ' '),'') as forenames, 
isnull(replace(c.preferred_forename,',', ' '),'') as preferred_forename,
isnull(replace(c.surname,',', ' '),'') as surname, 
isnull(replace(c.honorifics,',', ' '),'') as honorifics, 
isnull(replace(c.salutation,',', ' '),'') as salutation, 
isnull(replace(o.name,',', ' '),'') as organisation_name, 
isnull(replace(a.house_name,',', ' '),'') as house_name,
isnull(replace(a.address_line1,',', ' '),'') as address_line1,
isnull(replace(a.address_line2,',', ' '),'') as address_line2,
isnull(replace(a.address_line3,',', ' '),'') as address_line3, 
isnull(replace(a.address_line4,',', ' '),'') as address_line4,
isnull(replace(a.town,',', ' '),'') as town, 
isnull(replace(a.county,',', ' '),'') as county, 
isnull(replace(a.postcode,',', ' '),'') as postcode, 
isnull(replace(a.country,',', ' '),'') as country,
c.source,
c.source_date,
c.[status],
c.date_of_birth,
c.sex
from custom.cis_universefile_output u
	inner join cis.contacts c on u.contact_number=c.contact_number
	inner join cis.addresses a on u.address_number=a.address_number
	left join cis.organisations o on u.address_number=o.address_number
where address_line1 not like '%unknown%'







END
