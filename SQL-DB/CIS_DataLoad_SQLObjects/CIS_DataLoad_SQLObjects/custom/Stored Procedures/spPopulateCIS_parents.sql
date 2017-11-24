

CREATE procedure [custom].[spPopulateCIS_parents] as

begin

SET NOCOUNT ON;

--drop table Y_Parents
--drop index Y_Parents.ind_Y_Parents

--create table Y_Parents
--(contact_number int)

--create unique index ind_Y_Parents on Y_Parents (contact_number)

truncate table custom.cis_parents;
--test ALTERATION
--- Building CTEs for the parents table
with cte_01 (contact_number)
	as(
	select distinct cp.contact_number
	from cis.contact_positions cp
		left join cis.organisations o on cp.organisation_number = o.organisation_number
		left join cis.contacts c on c.contact_number = cp.contact_number
	where o.organisation_group = 'VOLG'
	and (o.[status] is null or o.[status] = 'REL')
	and o.organisation_number <> cp.contact_number
	and cp.[current] = 'Y'
	and c.[status] is null
	and o.organisation_number in (select organisation_number
								from cis.organisation_categories
								where activity = 'VGT'
								and activity_value = 'F'
								and getdate() between valid_from and isnull(valid_to,'31 dec 2199'))
	)
,
cte_02 (contact_number)
	as(
	select distinct cl.contact_number_1
	from cis.contact_links cl
		left join cis.contacts c1 on c1.contact_number = cl.contact_number_1
		left join cis.contacts C2 on C2.contact_number = cl.contact_number_2
	where cl.relationship = 'PAR'
	and c2.status is null
	and floor(datediff(dd,c2.date_of_birth,getdate())/365.25) < 18
	and floor(datediff(dd,c2.date_of_birth,getdate())/365.25) >= 0
	)
/*---------------------------------------------------------------------------
--Table Insert
---------------------------------------------------------------------------*/

insert into custom.cis_parents
(contact_number)
select distinct cte_01.contact_number
from cte_01
UNION
select distinct cte_02.contact_number
from cte_02


/*---------------------------------------------------------------------------
--Counts
---------------------------------------------------------------------------*/

--select count(*) as parents_count_1, count(distinct contact_number) as parents_count_2
--from custom.cis_parents

END

