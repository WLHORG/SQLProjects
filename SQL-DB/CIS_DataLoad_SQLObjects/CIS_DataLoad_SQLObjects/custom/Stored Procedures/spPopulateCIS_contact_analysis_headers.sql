

---------------------------------------------------------------------------------------------------
-- Author:		Lindsay Scott
-- Create date: 29 November 2013
-- Description:	Rebuilds the Contact Analysis Header Tables
-- Version:		1.1

-- Version history
-- Version	Date		By	Description
-- 1.0		2015-02-18	LJS	Initial version migrated from CISreporting on GS1DUKSQLV01.
--							Version 1.0 code just replaces Y_contact_analysis_headers_FINANCIALS
--								with custom.cis_contact_analysis_headers_financials.
-- 1.1		0215-03-10	LJS	Version 1.1 code adds code for custom.cis_contact_analysis_headers_Person
--								and custom.cis_contact_analysis_headers_Person				
									
---------------------------------------------------------------------------------------------------

CREATE PROCEDURE [custom].[spPopulateCIS_contact_analysis_headers]
as
BEGIN


	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   --exclude joint records and organisations
if object_id('tempdb..##exclusions') is not null drop table ##exclusions
create table ##exclusions
(contact_number int)

insert into ##exclusions
(contact_number)
select contact_number
from cis.contacts 
where contact_type in ('o','j')						
and contact_number not in (select contact_number
							from ##exclusions)	
							
---------------------------------------------------------------------------------------------------
----------------------Populate custom.cis_Contact_Analysis_Headers_FINANCIALS----------------------
---------------------------------------------------------------------------------------------------			
--RG
--#rg
if object_id('tempdb..#rg') is not null drop table #rg
create table #rg
(uniqueifier int not null identity(1,1)
,contact_number int 
,transaction_date datetime
,amount numeric(9,2)
,unique clustered(uniqueifier,contact_number))
insert into #rg
(contact_number
,transaction_date
,amount)
select distinct fin_hist.contact_number 
,fin_hist.transaction_date
,fin_hist.amount
--from vw_fin_hist as fin_hist
from [wft].[wft_financial_history_merge] as fin_hist
where top_level ='RG'
and contact_number not in (select contact_number 
							from ##exclusions)
--#rg_detail							
if object_id('tempdb..#rg_detail') is not null drop table #rg_detail
create table #rg_detail
(contact_number int primary key
,date_of_first_RG_payment datetime
,date_of_last_RG_payment datetime	
,amount_of_first_RG_payment numeric(9,2)
,amount_of_last_RG_payment numeric(9,2)
,current_RG int)
insert into #rg_detail
(contact_number
,date_of_first_RG_payment
,date_of_last_RG_payment	
,amount_of_first_RG_payment
,amount_of_last_RG_payment
,current_rg)
select distinct rg1.contact_number
,(select top 1 rg.transaction_date
	from #rg as rg
	where rg.contact_number=rg1.contact_number
	order by transaction_date) as date_of_first_RG_payment
,(select top 1 rg.transaction_date
	from #rg as rg
	where rg.contact_number=rg1.contact_number
	order by transaction_date desc) as date_of_last_RG_payment	
,(select top 1 sum(rg.amount)
	from #rg as rg
	where rg.contact_number=rg1.contact_number
	group by rg.transaction_date
	order by transaction_date) as amount_of_first_RG_payment
,(select top 1 sum(rg.amount)
	from #rg as rg
	where rg.contact_number=rg1.contact_number
	group by rg.transaction_date
	order by rg.transaction_date desc) as amount_of_last_RG_payment		
,case when rg1.contact_number in (select contact_number 
										from custom.cis_current_rg) then 1 else 0 end as current_RG	
from #rg as rg1


--SM
if object_id('tempdb..#sm') is not null drop table #sm
create table #sm
(uniqueifier int not null identity(1,1)
,contact_number int 
,transaction_date datetime
,amount numeric(9,2)
,unique clustered(uniqueifier,contact_number))
insert into #sm
(contact_number
,transaction_date
,amount)
select distinct fin_hist.contact_number 
,fin_hist.transaction_date
,fin_hist.amount
--from vw_fin_hist as fin_hist
from [wft].[wft_financial_history_merge] as fin_hist
where top_level ='SM'
and contact_number not in (select contact_number 
							from ##exclusions)
union							
select distinct members.contact_number
,null
,null 
from cis.members as members
where members.membership_type in ('LVG'
									,'LB'
									,'LBD')
and members.contact_number not in (select contact_number 
									from ##exclusions)	
--#sm_detail							
if object_id('tempdb..#sm_detail') is not null drop table #sm_detail
create table #sm_detail
(contact_number int primary key
,date_of_first_SM_payment datetime
,date_of_last_SM_payment datetime	
,amount_of_first_SM_payment numeric(9,2)
,amount_of_last_SM_payment numeric(9,2)
,current_SM int)
insert into #sm_detail
(contact_number
,date_of_first_SM_payment
,date_of_last_SM_payment	
,amount_of_first_SM_payment
,amount_of_last_SM_payment
,current_SM)
select distinct sm1.contact_number
,(select top 1 sm.transaction_date
	from #sm as sm
	where sm.contact_number=sm1.contact_number
	order by transaction_date) as date_of_first_sm_payment
,(select top 1 sm.transaction_date
	from #sm as sm
	where sm.contact_number=sm1.contact_number
	order by transaction_date desc) as date_of_last_sm_payment	
,(select top 1 sum(sm.amount)
	from #sm as sm
	where sm.contact_number=sm1.contact_number
	group by sm.transaction_date
	order by sm.transaction_date) as amount_of_first_sm_payment
,(select top 1 sum(sm.amount)
	from #sm as sm
	where sm.contact_number=sm1.contact_number
	group by sm.transaction_date
	order by sm.transaction_date desc) as amount_of_last_sm_payment		
,case when sm1.contact_number in (select distinct contact_number 
										from cis.members
										where membership_type in ('SM'
																	,'SMF'
																	,'SMO'
																	,'LVG'
																	,'LB'
																	,'LBD')
										and cancellation_reason is null
										and membership_type not in('PM'
																	,'PHL')) then 1 else 0 end as current_sm	
from #sm as sm1


--WL
if object_id('tempdb..#WL') is not null drop table #WL
create table #WL
(uniqueifier int not null identity(1,1)
,contact_number int 
,transaction_date datetime
,amount numeric(9,2)
,unique clustered(uniqueifier,contact_number))
insert into #WL
(contact_number
,transaction_date
,amount)
select distinct fin_hist.contact_number 
,fin_hist.transaction_date
,fin_hist.amount
--from vw_fin_hist as fin_hist
from [wft].[wft_financial_history_merge] as fin_hist
where top_level ='WL'
and contact_number not in (select contact_number 
							from ##exclusions)
--#WL_detail							
if object_id('tempdb..#WL_detail') is not null drop table #WL_detail
create table #WL_detail
(contact_number int primary key
,date_of_first_WL_payment datetime
,date_of_last_WL_payment datetime	
,amount_of_first_WL_payment numeric(9,2)
,amount_of_last_WL_payment numeric(9,2)
,current_WL_player int)
insert into #WL_detail
(contact_number
,date_of_first_WL_payment
,date_of_last_WL_payment	
,amount_of_first_WL_payment
,amount_of_last_WL_payment
,current_WL_player)
select distinct WL1.contact_number
,(select top 1 WL.transaction_date
	from #WL as WL
	where WL.contact_number=WL1.contact_number
	order by WL.transaction_date) as date_of_first_WL_payment
,(select top 1 WL.transaction_date
	from #WL as WL
	where WL.contact_number=WL1.contact_number
	group by WL.transaction_date
	order by WL.transaction_date desc) as date_of_last_WL_payment	
,(select top 1 sum(WL.amount)
	from #WL as WL
	where WL.contact_number=WL1.contact_number
	group by WL.transaction_date
	order by WL.transaction_date) as amount_of_first_WL_payment
,(select top 1 sum(WL.amount)
	from #WL as WL
	where WL.contact_number=WL1.contact_number
	group by WL.transaction_date
	order by WL.transaction_date desc) as amount_of_last_WL_payment		
,case when WL1.contact_number in (select distinct contacts.contact_number 
										from cis.contacts as contacts
										inner join [wft].[wft_financial_history_merge] as fh on contacts.contact_number=fh.contact_number
										where ((fh.product in ('SRLTWANULTIC'
																,'SRLTWINVANULTIC') and fh.transaction_date >dateadd(mm,-14,getdate())) 
											or (fh.product in ('SRLTWBIANTIC'
																,'SRLTWINVBIANTIC') and fh.transaction_date >dateadd(mm,-8,getdate()))
											or (fh.product in ('SRLTWQTRLTIC'
																,'SRLTWINVQTRLTIC') and fh.transaction_date >dateadd(mm,-5,getdate()))
											or (fh.product in ('SRLTWMTHTIC'
																,'SRLTWINVMTHTIC') and fh.transaction_date >dateadd(mm,-3,getdate())))) then 1 else 0 end as current_WL_player
from #WL as WL1


--Raffle
if object_id('tempdb..#Raffle') is not null drop table #Raffle
create table #Raffle
(uniqueifier int not null identity(1,1)
,contact_number int 
,transaction_date datetime
,amount numeric(9,2)
,unique clustered(uniqueifier,contact_number))
insert into #Raffle
(contact_number
,transaction_date
,amount)
select distinct fin_hist.contact_number 
,fin_hist.transaction_date
,fin_hist.amount
--from vw_fin_hist as fin_hist
from [wft].[wft_financial_history_merge] as fin_hist
where top_level ='PD'
and contact_number not in (select contact_number 
							from ##exclusions)
--#Raffle_detail							
if object_id('tempdb..#Raffle_detail') is not null drop table #Raffle_detail
create table #Raffle_detail
(contact_number int primary key
,date_of_first_Raffle_payment datetime
,date_of_last_Raffle_payment datetime	
,amount_of_first_Raffle_payment numeric(9,2)
,amount_of_last_Raffle_payment numeric(9,2)
,current_Raffle_player int)
insert into #Raffle_detail
(contact_number
,date_of_first_Raffle_payment
,date_of_last_Raffle_payment	
,amount_of_first_Raffle_payment
,amount_of_last_Raffle_payment
,current_Raffle_player)
select distinct Raffle1.contact_number
,(select top 1 Raffle.transaction_date
	from #Raffle as Raffle
	where Raffle.contact_number=Raffle1.contact_number
	order by transaction_date) as date_of_first_Raffle_payment
,(select top 1 Raffle.transaction_date
	from #Raffle as Raffle
	where Raffle.contact_number=Raffle1.contact_number
	order by transaction_date desc) as date_of_last_Raffle_payment	
,(select top 1 Raffle.amount
	from #Raffle as Raffle
	where Raffle.contact_number=Raffle1.contact_number
	order by transaction_date) as amount_of_first_Raffle_payment
,(select top 1 Raffle.amount
	from #Raffle as Raffle
	where Raffle.contact_number=Raffle1.contact_number
	order by transaction_date desc) as amount_of_last_Raffle_payment		
,case when Raffle1.contact_number in (select distinct contacts.contact_number 
										from cis.contacts as contacts
										inner join [wft].[wft_financial_history_merge] as fh on contacts.contact_number=fh.contact_number
										where fh.top_level='PD'
										and fh.transaction_date between dateadd(mm,-24,getdate()) and getdate()) then 1 else 0 end as current_Raffle_player
from #Raffle as Raffle1

--Donation
if object_id('tempdb..#Donation') is not null drop table #Donation
create table #Donation
(uniqueifier int not null identity(1,1)
,contact_number int 
,transaction_date datetime
,amount numeric(9,2)
,unique clustered(uniqueifier,contact_number))
insert into #Donation
(contact_number
,transaction_date
,amount)
select distinct fin_hist.contact_number 
,fin_hist.transaction_date
,fin_hist.amount
--from vw_fin_hist as fin_hist
from [wft].[wft_financial_history_merge] as fin_hist
where top_level in ('APP'
					,'UNSOL')
and contact_number not in (select contact_number 
							from ##exclusions)
--#Donation_detail							
if object_id('tempdb..#Donation_detail') is not null drop table #Donation_detail
create table #Donation_detail
(contact_number int primary key
,date_of_first_Donation_payment datetime
,date_of_last_Donation_payment datetime	
,amount_of_last_Donation_payment numeric(9,2)
,count_of_Donations int
,total_sum_of_Donations numeric(9,2)
,current_Cash_Donor int)
insert into #Donation_detail
(contact_number
,date_of_first_Donation_payment
,date_of_last_Donation_payment	
,amount_of_last_Donation_payment
,count_of_Donations
,total_sum_of_Donations
,current_Cash_Donor)
select distinct Donation1.contact_number
,(select top 1 Donation.transaction_date
	from #Donation as Donation
	where Donation.contact_number=Donation1.contact_number
	order by transaction_date) as date_of_first_Donation_payment
,(select top 1 Donation.transaction_date
	from #Donation as Donation
	where Donation.contact_number=Donation1.contact_number
	order by transaction_date desc) as date_of_last_Donation_payment	
,(select top 1 Donation.amount
	from #Donation as Donation
	where Donation.contact_number=Donation1.contact_number
	order by transaction_date desc) as amount_of_last_Donation_payment		
,(select count(Donation.amount)
	from #Donation as Donation
	where Donation.contact_number=Donation1.contact_number)as count_of_donations
,(select sum(Donation.amount)
	from #Donation as Donation
	where Donation.contact_number=Donation1.contact_number) as total_sum_of_Donations
,case when Donation1.contact_number in (select distinct contacts.contact_number 
										from cis.contacts as contacts
										inner join [wft].[wft_financial_history_merge] as fh on contacts.contact_number=fh.contact_number
										where fh.top_level in ('APP'
																,'UNSOL')
										and fh.transaction_date between dateadd(mm,-24,getdate()) and getdate()) then 1 else 0 end as Active_Cash_Donor
from #Donation as Donation1

truncate table [custom].[cis_contact_analysis_headers_financials]
insert into [custom].[cis_contact_analysis_headers_financials]
(contact_number
,date_of_first_RG_payment
,date_of_last_RG_payment	
,amount_of_first_RG_payment
,amount_of_last_RG_payment
,current_RG
,date_of_first_SM_payment
,date_of_last_SM_payment	
,amount_of_first_SM_payment
,amount_of_last_SM_payment
,current_SM
,date_of_first_WL_payment
,date_of_last_WL_payment	
,amount_of_first_WL_payment
,amount_of_last_WL_payment
,current_WL_player
,date_of_first_RAFFLE_payment
,date_of_last_RAFFLE_payment
,amount_of_first_RAFFLE_payment
,amount_of_last_RAFFLE_payment
,current_RAFFLE_player
,date_of_first_Donation_payment
,date_of_last_Donation_payment
,amount_of_last_Donation_payment
,count_of_Donations
,total_sum_of_Donations
,current_Cash_Donor)
select contacts.contact_number
,rg_detail.date_of_first_RG_payment
,rg_detail.date_of_last_RG_payment	
,rg_detail.amount_of_first_RG_payment
,rg_detail.amount_of_last_RG_payment
,rg_detail.current_rg
,sm_detail.date_of_first_SM_payment
,sm_detail.date_of_last_SM_payment	
,sm_detail.amount_of_first_SM_payment
,sm_detail.amount_of_last_SM_payment
,sm_detail.current_SM
,wl_detail.date_of_first_WL_payment
,wl_detail.date_of_last_WL_payment	
,wl_detail.amount_of_first_WL_payment
,wl_detail.amount_of_last_WL_payment
,wl_detail.current_WL_Player
,Raffle_detail.date_of_first_RAFFLE_payment
,Raffle_detail.date_of_last_RAFFLE_payment
,Raffle_detail.amount_of_first_RAFFLE_payment
,Raffle_detail.amount_of_last_RAFFLE_payment
,Raffle_detail.current_RAFFLE_player
,don_detail.date_of_first_Donation_payment
,don_detail.date_of_last_Donation_payment	
,don_detail.amount_of_last_Donation_payment
,don_detail.count_of_Donations
,don_detail.total_sum_of_Donations
,don_detail.current_Cash_Donor
from cis.contacts as contacts
left join #rg_detail as rg_detail on contacts.contact_number=rg_detail.contact_number
left join #sm_detail as sm_detail on contacts.contact_number=sm_detail.contact_number
left join #WL_detail as wl_detail on contacts.contact_number=wl_detail.contact_number
left join #Raffle_detail as raffle_detail on contacts.contact_number=raffle_detail.contact_number
left join #Donation_detail as don_detail on contacts.contact_number=don_detail.contact_number


---------------------------------------------------------------------------------------------------
----------------------Populate custom.cis_Contact_Analysis_Headers_PERSON--------------------------
---------------------------------------------------------------------------------------------------		
							
--Populate y_Contact_Analysis_Header_PERSON table								
truncate table custom.cis_Contact_Analysis_Headers_PERSON
insert into custom.cis_Contact_Analysis_Headers_PERSON
(contact_number
,goneaway_status
,deceased_status
,[status]		
,gender
,date_of_birth
,age
,age_band
,DUK_region
,source_date
,source_and_source_desc
,recruitment_source
,diabetes_type
,acorn_type_and_types_name 
,category_id_and_category)
select distinct contacts.contact_number
,case when contacts.[status]='ga' then 1 else 0 end as goneaway_status
,case when contacts.[status]='de' then 1 else 0 end as deceased_status
,contacts.[status]			
,case when contacts.sex = 'm' then 'male'
		when contacts.sex = 'f' then 'female'
		when contacts.sex = 'u' then 'unknown' end as gender
,contacts.date_of_birth		
,floor(datediff(dd,contacts.date_of_birth,getdate())/365.25) as age
,case when datediff(year,contacts.date_of_birth,getdate()) between 0 and 17 then 'A - <18'
		when datediff(year,contacts.date_of_birth,getdate()) between 18 and 29 then 'B - 18 to 29' 
		when datediff(year,contacts.date_of_birth,getdate()) between 30 and 39 then 'C - 30 to 39'
		when datediff(year,contacts.date_of_birth,getdate()) between 40 and 49 then 'D - 40 to 49'
		when datediff(year,contacts.date_of_birth,getdate()) between 50 and 59 then 'E - 50 to 59'
		when datediff(year,contacts.date_of_birth,getdate()) between 60 and 69 then 'F - 60 to 69'
		when datediff(year,contacts.date_of_birth,getdate()) between 70 and 79 then 'G - 70 to 79'
		when datediff(year,contacts.date_of_birth,getdate()) between 80 and 89 then 'H - 80 to 89'
		when datediff(year,contacts.date_of_birth,getdate()) >=90 then 'I - 90+'
	else 'J - Unk' end as age_band
,replace(replace(replace(duk_region,'Diabetes U K (',''),' region)',''),')','') as DUK_region	
,contacts.source_date	
,contacts.[source]+' - '+sources.source_desc as source_and_desc	
,case when (contacts.[source] like '_01%'
			or contacts.[source] like 'DM_S_LEG_') then 'legacy' 
		when (contacts.[source] like '_02%'
			or contacts.[source] like 'DM_S_L1_' 
			or contacts.[source] = 'NDW_2001') then 'gaming'
		when contacts.[source] like '_03%' then 'Tax_effective_giving'
		when contacts.[source] like '_04%' then 'regular_giving'
		when (contacts.[source] like '_05%'
					or contacts.[source] like 'A01A01%')then 'donations'
		when (contacts.[source] like '_06%' 
						or contacts.[source] like '_07%'
						or contacts.[source] = 'DM_WI2003') then 'affinity_products' 
		when (contacts.[source] like '_08%' 
						or contacts.[source] like 'TRADE%') then 'trading' 
		when (contacts.[source] like '_09%' 
					or contacts.[source] like 'REN%') then 'lay_membership'
		when contacts.[source] like '_10%' then 'professional_membership'
		when contacts.[source] like '_11%' then 'in_mem_and_tribute_funds' 
		when contacts.[source] like '_12%' then 'customer_services'
			when (contacts.[source] like '_20%' 
						or contacts.[source] like '_21%') then 'community_fundraising' 	
		when (contacts.[source] like '_22%' 
						or contacts.[source] like '_23%'
						or contacts.[source] like '_24%'
						or contacts.[source] like '_25%'
						or contacts.[source] like '_26%'
						or contacts.[source] like '_27%'
						or contacts.[source] like '_28%') then 'events_fundraising' 		
		when contacts.[source] like '_40%' then 'general_corporate'
		when contacts.[source] like '_41%' then 'statutory'
		when contacts.[source] like '_42%' then 'trusts'
		when contacts.[source] like '_43%' then 'liveries'
		when (contacts.[source] like '_44%'
			or contacts.[source] like '_49%') then 'pharmaceutical_companies'
		when contacts.[source] like '_45%' then 'city_fundraising'
		when contacts.[source] like '_46%' then 'food_and_health_companies'
		when contacts.[source] like '_47%' then 'Payroll_giving'
		when contacts.[source] like '_48%' then 'major donors'	
		when contacts.[source] like '_AD%' then 'advertising'	
		when (contacts.[source] like '_BA%'
				or contacts.[source] = 'DM_SD28') then 'balance'  	
		when (contacts.[source] like '_CA%' 
				or contacts.[source] like '_DV%')then 'campaigning'	
		when contacts.[source] like '_CD%' then 'care_developments'		
		when contacts.[source] like '_CO%' then 'conferences'	
		when contacts.[source] like '_CS%' then 'care_support'
		when contacts.[source] like '_EL%' then 'enewsletter' 
		when contacts.[source] like '_FI%' then 'finance'	
		when contacts.[source] like '_GS%' then 'goverance'		
		when contacts.[source] like '_HP%' then 'healthcare_professional'	
		when (contacts.[source] like '_MK%' 
				or contacts.[source] = 'FSA001005') then 'marketing'	
		when contacts.[source] like '_PA%' then 'public_affairs_&_press'
		when contacts.[source] like '_PH%' then 'policy_&_healthcare'	
		when contacts.[source] like '_PU%' then 'publications'
		when (contacts.[source] like '_EA%' 
				or contacts.[source] like '_EM%'
				or contacts.[source] like '_ER%'
				or contacts.[source] like '_LR%'
				or contacts.[source] like '_NI%'
				or contacts.[source] like '_NW%'
				or contacts.[source] like '_NY%'
				or contacts.[source] like '_SC%'
				or contacts.[source] like '_SE%'
				or contacts.[source] like '_SW%'
				or contacts.[source] like '_WA%'
				or contacts.[source] like '_WM%') then 'regional_and_national_offices' 	
		when contacts.[source] like '_RE%' then 'research'			
		when contacts.[source] like '_SI%' then 'science_information'	
		when contacts.[source] like '_UI%' then 'user_involvement'	
		when contacts.[source] like '_VG%' then 'voluntary_groups'
		when contacts.[source] like '_VO%' then 'tesco'				
		else 'other' end as recruitment_source
,CC.activity_value_desc	
, cast(acorn.[type_id] as varchar)+' - '+acorn.acorn_type as acorn_type_and_types_name 
, cast(acorn.category_id as varchar) +' - '+acorn.acorn_category as category_id_and_category
from cis.contacts as contacts	
left join cis.sources as sources on contacts.source=sources.source
left join custom.CIS_contact_to_nation as ctn on contacts.contact_number=ctn.contact_number	
left join (select contact_categories.contact_number
					,contact_categories.valid_from
					,contact_categories.valid_to
					,contact_categories.activity
					,activity_values.activity_value_desc
			from cis.contact_categories as contact_categories
			inner join cis.activity_values as activity_values on contact_categories.activity=activity_values.activity
															and contact_categories.activity_value=activity_values.activity_value
			where contact_categories.activity='DIAT'												
			and getdate() between contact_categories.valid_from and isnull(contact_categories.valid_to, '31 dec 2199')) as CC on contacts.contact_number=CC.contact_number			
--left join acorn_vw_contact_type	as acorn on contacts.contact_number=acorn.contact_number
left join [acorn].[vwAcorn2014_Contact_To_Category]	as acorn on contacts.contact_number=acorn.contact_number

where contacts.contact_number not in (select contact_number 
										from ##exclusions)	
	
	
	
	
										
--Populate Y_Contact_Analysis_Headers_COMMUNICATION 										

--Communications
--Phone Number Table (inc mobiles)
if object_id('tempdb..#phone') is not null drop table #phone
create table #phone
(contact_number int primary key
,has_phone varchar(1)
,can_phone varchar(1))

insert into #phone
(contact_number
,has_phone
,can_phone)
Select contacts.contact_number,'',''
from cis.contacts as contacts

Update phone set phone.has_phone = 'Y'
from #phone as phone
where phone.contact_number in (select distinct comm.contact_number
								from cis.communications as comm
								where comm.device in ('T','TD','S','TW')
								and comm.device <> 'MB'
								and comm.number not like '07%')

Update phone set phone.can_phone = 'Y'
from #phone as phone
where phone.has_phone = 'Y'
and phone.contact_number in	(select distinct comm.contact_number
								from cis.communications as comm
								where comm.device in ('T','TD','S','TW')
								and comm.is_active = 'Y'
								and comm.device <> 'MB'
								and comm.number not like '07%')
and phone.contact_number not in (select distinct contact_suppressions.contact_number
									from cis.contact_suppressions as contact_suppressions
									--where contact_suppressions.mailing_suppression = 'NT'
									where contact_suppressions.mailing_suppression in ('NT'
																						,'NXXU')
									and getdate() between contact_suppressions.valid_from and isnull(contact_suppressions.valid_to,'31 dec 2199'))

Update phone set phone.has_phone = 'N'
from #phone as phone
where phone.has_phone <> 'Y'

Update phone set phone.can_phone = 'N'
from #phone as phone
where phone.can_phone <> 'Y'

--mobile
if object_id('tempdb..#mobile') is not null drop table #mobile
create table #mobile
(contact_number int primary key
,has_mobile varchar(1)
,can_mobile varchar(1)
,can_sms varchar(1))

insert into #mobile
(contact_number
,has_mobile
,can_mobile
,can_sms)
Select contacts.contact_number,'','',''
from cis.contacts as contacts

Update mobile set mobile.has_mobile = 'Y'
from #mobile as mobile
where mobile.contact_number in (select distinct comm.contact_number
									from cis.communications comm
									where comm.device = 'MB'
									or (comm.device in ('T'
														,'TD'
														,'S'
														,'TW')
									and comm.number like '07%'))

Update mobile set mobile.can_mobile = 'Y'
from #mobile as mobile
where mobile.has_mobile = 'Y'
and mobile.contact_number in (select distinct comm.contact_number
									from cis.communications comm
									where comm.device = 'MB'
									or (comm.device in ('T'
														,'TD'
														,'S'
														,'TW')
									and comm.number like '07%')
									and comm.is_active = 'Y')
and mobile.contact_number not in (select distinct cs.contact_number
									from cis.contact_suppressions cs
									--where cs.mailing_suppression = 'NT'
									where cs.mailing_suppression in ('NT'
																	,'NXXU')
									and getdate() between cs.valid_from and isnull(cs.valid_to,'31 dec 2199'))
							
Update mobile set mobile.can_sms = 'Y'
from #mobile as mobile
where mobile.has_mobile = 'Y'
and mobile.contact_number in (select distinct comm.contact_number
								from cis.communications comm
								where comm.device = 'MB'
								or (comm.device in ('T','TD','S','TW')
								and comm.number like '07%')
								and comm.is_active = 'Y')
and mobile.contact_number in (select distinct cs.contact_number
								from cis.contact_suppressions cs
								--where cs.mailing_suppression = 'SMS'
									where cs.mailing_suppression in ('SMS'
																	,'IXXK')
								and getdate() between cs.valid_from and isnull(cs.valid_to,'31 dec 2199'))						

Update mobile set mobile.has_mobile = 'N'
from #mobile as mobile
where mobile.has_mobile <> 'Y'

Update mobile set mobile.can_mobile = 'N'
from #mobile as mobile
where mobile.can_mobile <> 'Y'

Update mobile set mobile.can_sms = 'N'
from #mobile as mobile
where mobile.can_sms <> 'Y'						


truncate table custom.CIS_Contact_Analysis_Headers_COMMUNICATION
insert into custom.CIS_Contact_Analysis_Headers_COMMUNICATION
(contact_number
,DPA_Flag
,EOI_Flag
,has_email
,can_email
,has_phone_landline
,can_phone_landline
,has_phone_mobile
,can_phone_mobile
,can_sms	
,has_dm_address
,can_use_dm_address) 
select distinct contacts.contact_number
,case when contacts.contact_number in (select contact_number
										from cis.contact_suppressions
										--where mailing_suppression = 'DPA'
										where mailing_suppression in ('DPA'
																		, 'NFAX')																	
										and getdate() between valid_from and isnull(valid_to, '31 dec 2199')) then 1 else 0 end as DPA_Flag
,case when contacts.contact_number in (select contact_number
										from cis.contact_suppressions
										--where mailing_suppression = 'EOI'
										where mailing_suppression in ('EOI'
																		, 'IXXD')																	
																												
										and getdate() between valid_from and isnull(valid_to, '31 dec 2199')) then 1 else 0 end as EOI_Flag
,case when contacts.contact_number in (select co.contact_number
										from cis.communications co	
										where co.device in ('wr','em','ec')
										and co.is_active = 'Y') then 1 else 0 end as has_email 
,case when contacts.contact_number in (select contact_number 
										from custom.CIS_emailable) then 1 else 0 end as can_email																				
,case when contacts.contact_number in (select p.contact_number
										from #phone p
										where p.has_phone = 'Y') then 1 else 0 end as has_phone_landline 
,case when contacts.contact_number in (select p.contact_number
										from #phone p
										where p.can_phone = 'Y') then 1 else 0 end as can_phone_landline	
,case when contacts.contact_number in (select m.contact_number
										from #mobile m
										where m.has_mobile = 'Y') then 1 else 0 end	as has_phone_mobile
,case when contacts.contact_number in (select m.contact_number
										from #mobile m
										where m.can_mobile = 'Y') then 1 else 0 end	as can_phone_mobile																		
,case when contacts.contact_number in (select m.contact_number
										from #mobile m
										where m.can_sms = 'Y') then 1 else 0 end as can_sms	
,case when contacts.contact_number in (select distinct contact_number
										from custom.cis_universefile_output_detail) then 1 else 0 end as has_dm_address
,case when contacts.contact_number in (select vu.contact_number
										from custom.cis_universefile_output_detail vu
										where vu.contact_number not in (select cs.contact_number
																		from cis.contact_suppressions cs
																		--where mailing_suppression = 'DPA'
																		where mailing_suppression in ('DPA'
																										, 'NFAX')
																		and getdate() between valid_from 
																		and isnull(valid_to,'31 dec 2199'))
										)then 1 else 0 end as can_send_dm	
from cis.contacts as contacts
where contacts.contact_number not in (select contact_number 
										from ##exclusions)





END





