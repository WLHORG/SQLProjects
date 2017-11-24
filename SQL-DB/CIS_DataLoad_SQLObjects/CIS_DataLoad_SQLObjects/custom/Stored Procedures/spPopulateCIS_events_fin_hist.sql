


/*==============================================================================================================
-- Author:			Lindsay Scott

-- Create date:		18/03/2015

-- Version:			1.2

-- Description:		Populates [custom].[cis_events_fin_hist] 
					
--					This sproc and table replace vw_events_fin_hist in CISReporting
--					And is an attempt to try to link events participants to donations that have been sent 
--					in support them.	

-- Version history
-- Version	Date		By	Description
-- 1.0		2015-03-18	LJS	Initial version.
-- 1.1		2014-02-11  LJS	Created composite key and changed logic that populates [custom].[cis_events_fin_hist] 
							To avoid duplicate transactions loading into table
							Added new Online contribution segments:	
							Segment 5 pulls in Other (not JG) online donations that are not linked to a donor
							Segment 6 pulls in Other online donations that are not linked to a donor 
										AND aren't linked the DE expenditure group
--										and isn't a '%CHG%' (charge Product)
--1.2		2015-05-19	LJS	Added rule to all segments to exclude concatenation of contact_number, batch_number
							, transaction_number and line_number to avoid loading duplicate rows into table
							Changed rules to build composite keys throoughout. It's now based on batch_number
							, transaction_number and line_number.
--1.3		2015-07-27	LJS	Amended code to replace 'DE expenditure group with new income coding structure
							replaced "where expenditure_group = 'DE'"
							with	"where substring(fhd.[source],3,1) in('E','F')"
							and resolved primary key violation which was preventing rows being loaded to table.
				
-- ==========================================================================================================*/
CREATE PROCEDURE [custom].[spPopulateCIS_events_fin_hist] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

truncate table [custom].[cis_events_fin_hist]

--select 1 as segment,  -- gets in challenge donations, where income on the donor
insert into [custom].[cis_events_fin_hist]
(composite_key
, segment
, master_contact
, financial_links_donor
, [payment_method]
, [transaction_date]
, [amount]
, [product]
, [source]
, [top_level]
, [expenditure_group]
, [batch_number]
, [transaction_number]
, [line_number]
, [distribution_code]
, [rate]
, [transaction_origin]
, [reference]
, [line_type])
--select concat(isnull(fl1.contact_number,fh.contact_number)
--						,fl1.donor_contact_number
--						,fh.batch_number
--						,fh.transaction_number
--						,fhd.line_number) as composite_key,
select concat('bn',fh.batch_number
				,'tn',fh.transaction_number
				,'ln',fhd.line_number) as composite_key,
		1,
		isnull(fl1.contact_number,fh.contact_number) as master_contact,
		fl1.donor_contact_number as financial_links_donor,
		fh.payment_method,
		fh.transaction_date,
		fhd.amount,
		fhd.product,
		fhd.source,
		tl.top_level,
		pg.expenditure_group,
		fh.batch_number,
		fh.transaction_number,
		fhd.line_number,
		fhd.distribution_code,
		fhd.rate,
		fh.transaction_origin,
		fh.reference,
		fl1.line_type
from cis.financial_history fh
inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
											and fh.transaction_number=fhd.transaction_number
left join cis.product_groups pg on pg.product=fhd.product
left join custom.cis_expenditure_groups_top_level tl on tl.expenditure_group=pg.expenditure_group
left join cis.financial_links fl1 on fh.batch_number=fl1.batch_number 
								and fh.transaction_number=fl1.transaction_number
								and fhd.line_number=fl1.line_number
								and fl1.line_type in ('H','S')
--where expenditure_group = 'DE'
where substring(fhd.[source],3,1) in('E','F')
and (fh.transaction_origin = 'CH_W')

--select 2 as segment,  -- gets in org dons where income is on the donor
insert into [custom].[cis_events_fin_hist]
(composite_key
, segment
, master_contact
, financial_links_donor
, [payment_method]
, [transaction_date]
, [amount]
, [product]
, [source]
, [top_level]
, [expenditure_group]
, [batch_number]
, [transaction_number]
, [line_number]
, [distribution_code]
, [rate]
, [transaction_origin]
, [reference]
, [line_type])
--select concat(isnull(fl1.contact_number,fh.contact_number)
--						,fl1.donor_contact_number
--						,fh.batch_number
--						,fh.transaction_number
--						,fhd.line_number) as composite_key,
select distinct concat('bn',fh.batch_number
						,'tn',fh.transaction_number
						,'ln',fhd.line_number) as composite_key,
		2,
		isnull(fl1.contact_number,fh.contact_number) as master_contact,
		fl1.donor_contact_number as financial_links_donor,
		fh.payment_method,
		fh.transaction_date,
		fhd.amount,
		fhd.product,
		fhd.source,
		tl.top_level,
		pg.expenditure_group,
		fh.batch_number,
		fh.transaction_number,
		fhd.line_number,
		fhd.distribution_code,
		fhd.rate,
		fh.transaction_origin,
		fh.reference,
		fl1.line_type
from cis.financial_history fh
inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
											and fh.transaction_number=fhd.transaction_number
left join cis.product_groups pg on pg.product=fhd.product
left join custom.cis_expenditure_groups_top_level tl on tl.expenditure_group=pg.expenditure_group
left join cis.financial_links fl1 on fh.batch_number=fl1.batch_number 
								and fh.transaction_number=fl1.transaction_number
								and fhd.line_number=fl1.line_number
								and fl1.line_type in ('H','S')
inner join cis.organisations o on o.organisation_number = fh.contact_number 
		--  an organisation can not be a fundraiser, therefore must be matched giving
--where expenditure_group = 'DE'
where substring(fhd.[source],3,1) in('E','F')
and concat('bn',fh.batch_number
				,'tn',fh.transaction_number
				,'ln',fhd.line_number)   not in (select composite_key 
													from [custom].[cis_events_fin_hist])
--and concat(isnull(fl1.contact_number,fh.contact_number)
--						,fl1.donor_contact_number
--						,fh.batch_number
--						,fh.transaction_number
--						,fhd.line_number) not in (select composite_key 
--													from [custom].[cis_events_fin_hist])

--select 3 as segment,  -- gets in JG donations, data is on the fundraiser not donor
insert into [custom].[cis_events_fin_hist]
(composite_key
, segment
, master_contact
, financial_links_donor
, [payment_method]
, [transaction_date]
, [amount]
, [product]
, [source]
, [top_level]
, [expenditure_group]
, [batch_number]
, [transaction_number]
, [line_number]
, [distribution_code]
, [rate]
, [transaction_origin]
, [reference]
, [line_type])
--select concat(isnull(fl1.contact_number,fh.contact_number)
--						,fl1.donor_contact_number
--						,fh.batch_number
--						,fh.transaction_number
--						,fhd.line_number) as composite_key,
select concat('bn',fh.batch_number
				,'tn',fh.transaction_number
				,'ln',fhd.line_number) as composite_key,
		3,
		fh.contact_number as master_contact,
		fl1.donor_contact_number as financial_links_donor,
		fh.payment_method,
		fh.transaction_date,
		fhd.amount,
		fhd.product,
		fhd.source,
		tl.top_level,
		pg.expenditure_group,
		fh.batch_number,
		fh.transaction_number,
		fhd.line_number,
		fhd.distribution_code,
		fhd.rate,
		fh.transaction_origin,
		fh.reference,
		fl1.line_type
from cis.financial_history fh
inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
											and fh.transaction_number=fhd.transaction_number
left join cis.product_groups pg on pg.product=fhd.product
left join custom.cis_expenditure_groups_top_level tl on tl.expenditure_group=pg.expenditure_group
inner join cis.financial_links fl1 on fh.batch_number=fl1.batch_number 
								and fh.transaction_number=fl1.transaction_number
								and fhd.line_number=fl1.line_number
								and fl1.line_type in ('H','S')
--where expenditure_group = 'DE'
where substring(fhd.[source],3,1) in('E','F')
and fh.transaction_origin in ('JG_W','JGEW','JGIW','JGMW','JGSW')
and concat('bn',fh.batch_number
				,'tn',fh.transaction_number
				,'ln',fhd.line_number)   not in (select composite_key 
													from [custom].[cis_events_fin_hist])
--and concat(isnull(fl1.contact_number,fh.contact_number)
--						,fl1.donor_contact_number
--						,fh.batch_number
--						,fh.transaction_number
--						,fhd.line_number) not in (select composite_key 
--													from [custom].[cis_events_fin_hist])
--select 4 as segment,  -- gets in JG donations that are not linked to a donor
insert into [custom].[cis_events_fin_hist]
(composite_key
, segment
, master_contact
, financial_links_donor
, [payment_method]
, [transaction_date]
, [amount]
, [product]
, [source]
, [top_level]
, [expenditure_group]
, [batch_number]
, [transaction_number]
, [line_number]
, [distribution_code]
, [rate]
, [transaction_origin]
, [reference]
, [line_type])
--select concat(isnull(fl1.contact_number,fh.contact_number)
--						,fl1.donor_contact_number
--						,fh.batch_number
--						,fh.transaction_number
--						,fhd.line_number) as composite_key,
select concat('bn',fh.batch_number
				,'tn',fh.transaction_number
				,'ln',fhd.line_number) as composite_key,
		4,
		fh.contact_number as master_contact,
		fh.contact_number ,
		fh.payment_method,
		fh.transaction_date,
		fhd.amount,
		fhd.product,
		fhd.source,
		tl.top_level,
		pg.expenditure_group,
		fh.batch_number,
		fh.transaction_number,
		fhd.line_number,
		fhd.distribution_code,
		fhd.rate,
		fh.transaction_origin,
		fh.reference,
		''
from cis.financial_history fh
inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
											and fh.transaction_number=fhd.transaction_number
left join cis.product_groups pg on pg.product=fhd.product
left join custom.cis_expenditure_groups_top_level tl on tl.expenditure_group=pg.expenditure_group
--where expenditure_group = 'DE'
where substring(fhd.[source],3,1) in('E','F')
and fh.transaction_origin in ('JG_W','JGEW','JGIW','JGMW','JGSW')
and concat('bn',fh.batch_number
				,'tn',fh.transaction_number
				,'ln',fhd.line_number)   not in (select composite_key 
													from [custom].[cis_events_fin_hist])
--and concat(fh.contact_number
--				,fh.batch_number
--				,fh.transaction_number
--				,fhd.line_number)  not in (select composite_key 
--													from [custom].[cis_events_fin_hist])

-- segment 5 -- gets in Other online donations that are not linked to a donor
insert into [custom].[cis_events_fin_hist]
(composite_key
, segment
, master_contact
, financial_links_donor
, [payment_method]
, [transaction_date]
, [amount]
, [product]
, [source]
, [top_level]
, [expenditure_group]
, [batch_number]
, [transaction_number]
, [line_number]
, [distribution_code]
, [rate]
, [transaction_origin]
, [reference]
, [line_type])
--select concat(isnull(fl1.contact_number,fh.contact_number)
--						,fl1.donor_contact_number
--						,fh.batch_number
--						,fh.transaction_number
--						,fhd.line_number) as composite_key,
select concat('bn',fh.batch_number
				,'tn',fh.transaction_number
				,'ln',fhd.line_number) as composite_key,
		5,
		fh.contact_number as master_contact,
		fh.contact_number ,
		fh.payment_method,
		fh.transaction_date,
		fhd.amount,
		fhd.product,
		fhd.source,
		tl.top_level,
		pg.expenditure_group,
		fh.batch_number,
		fh.transaction_number,
		fhd.line_number,
		fhd.distribution_code,
		fhd.rate,
		fh.transaction_origin,
		fh.reference,
		''
from cis.financial_history fh
inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
											and fh.transaction_number=fhd.transaction_number
left join cis.product_groups pg on pg.product=fhd.product
left join custom.cis_expenditure_groups_top_level tl on tl.expenditure_group=pg.expenditure_group
--where expenditure_group = 'DE'
where substring(fhd.[source],3,1) in('E','F')
and fh.transaction_origin in ('AN_W',
								'BMCW',
								'BTMW',
								'CH_W',
								'DFCW',
								'VM_W')
and concat('bn',fh.batch_number
				,'tn',fh.transaction_number
				,'ln',fhd.line_number)   not in (select composite_key 
													from [custom].[cis_events_fin_hist])
--and concat(fh.contact_number
--				,fh.batch_number
--				,fh.transaction_number
--				,fhd.line_number)  not in (select composite_key 
--													from [custom].[cis_events_fin_hist])

-- segment 6 -- gets in Other online donations that are not linked to a donor and aren't linked the DE expenditure group
--					and isn't a CHG (charge Product)
insert into [custom].[cis_events_fin_hist]
(composite_key
, segment
, master_contact
, financial_links_donor
, [payment_method]
, [transaction_date]
, [amount]
, [product]
, [source]
, [top_level]
, [expenditure_group]
, [batch_number]
, [transaction_number]
, [line_number]
, [distribution_code]
, [rate]
, [transaction_origin]
, [reference]
, [line_type])
--select concat(isnull(fl1.contact_number,fh.contact_number)
--						,fl1.donor_contact_number
--						,fh.batch_number
--						,fh.transaction_number
--						,fhd.line_number) as composite_key,
select concat('bn',fh.batch_number
				,'tn',fh.transaction_number
				,'ln',fhd.line_number) as composite_key,
		6,
		fh.contact_number as master_contact,
		fh.contact_number ,
		fh.payment_method,
		fh.transaction_date,
		fhd.amount,
		fhd.product,
		fhd.source,
		tl.top_level,
		pg.expenditure_group,
		fh.batch_number,
		fh.transaction_number,
		fhd.line_number,
		fhd.distribution_code,
		fhd.rate,
		fh.transaction_origin,
		fh.reference,
		''
from cis.financial_history fh
inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
											and fh.transaction_number=fhd.transaction_number
left join cis.product_groups pg on pg.product=fhd.product
left join custom.cis_expenditure_groups_top_level tl on tl.expenditure_group=pg.expenditure_group
--where pg.expenditure_group <> 'DE'
where substring(fhd.[source],3,1) not in('E','F')
and fh.transaction_origin in ('AN_W',
								'BMCW',
								'BTMW',
								'CH_W',
								'DFCW',
								'VM_W')
and fhd.product not like '%CHG%'
and concat('bn',fh.batch_number
				,'tn',fh.transaction_number
				,'ln',fhd.line_number)   not in (select composite_key 
													from [custom].[cis_events_fin_hist])
--and concat(fh.contact_number
--				,fh.batch_number
--				,fh.transaction_number
--				,fhd.line_number)  not in (select composite_key 
--													from [custom].[cis_events_fin_hist])

--select 7 as segment,  -- anything else in fincial links, assumpotion is money is on the donor
insert into [custom].[cis_events_fin_hist]
(composite_key
, segment
, master_contact
, financial_links_donor
, [payment_method]
, [transaction_date]
, [amount]
, [product]
, [source]
, [top_level]
, [expenditure_group]
, [batch_number]
, [transaction_number]
, [line_number]
, [distribution_code]
, [rate]
, [transaction_origin]
, [reference]
, [line_type])
--select concat(isnull(fl1.contact_number,fh.contact_number)
--						,fl1.donor_contact_number
--						,fh.batch_number
--						,fh.transaction_number
--						,fhd.line_number) as composite_key,
select concat('bn',fh.batch_number
				,'tn',fh.transaction_number
				,'ln',fhd.line_number) as composite_key,
		7,
		isnull(fl1.contact_number,fh.contact_number) as master_contact,
		fl1.donor_contact_number as financial_links_donor,
		fh.payment_method,
		fh.transaction_date,
		fhd.amount,
		fhd.product,
		fhd.source,
		tl.top_level,
		pg.expenditure_group,
		fh.batch_number,
		fh.transaction_number,
		fhd.line_number,
		fhd.distribution_code,
		fhd.rate,
		fh.transaction_origin,
		fh.reference,
		fl1.line_type
from cis.financial_history fh
inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
											and fh.transaction_number=fhd.transaction_number
left join cis.product_groups pg on pg.product=fhd.product
left join custom.cis_expenditure_groups_top_level tl on tl.expenditure_group=pg.expenditure_group
inner join cis.financial_links fl1 on fh.batch_number=fl1.batch_number 
								and fh.transaction_number=fl1.transaction_number
								and fhd.line_number=fl1.line_number
								and fl1.line_type in ('H','S')
--where expenditure_group = 'DE'
where substring(fhd.[source],3,1) in('E','F')
and concat('bn',fh.batch_number
				,'tn',fh.transaction_number
				,'ln',fhd.line_number)   not in (select composite_key 
													from [custom].[cis_events_fin_hist])
--and concat(isnull(fl1.contact_number,fh.contact_number)
--						,fl1.donor_contact_number
--						,fh.batch_number
--						,fh.transaction_number
--						,fhd.line_number) not in (select composite_key 
--													from [custom].[cis_events_fin_hist])

--select 8 as segment,  -- remainder of DE income in fh, assume income is the fundraisers
insert into [custom].[cis_events_fin_hist]
(composite_key
, segment
, master_contact
, financial_links_donor
, [payment_method]
, [transaction_date]
, [amount]
, [product]
, [source]
, [top_level]
, [expenditure_group]
, [batch_number]
, [transaction_number]
, [line_number]
, [distribution_code]
, [rate]
, [transaction_origin]
, [reference])
--select concat(isnull(fl1.contact_number,fh.contact_number)
--						,fl1.donor_contact_number
--						,fh.batch_number
--						,fh.transaction_number
--						,fhd.line_number) as composite_key,
select distinct concat('bn',fh.batch_number
						,'tn',fh.transaction_number
						,'ln',fhd.line_number) as composite_key,
		8,
		fh.contact_number as master_contact,
		fh.contact_number as financial_links_donor,
		fh.payment_method,
		fh.transaction_date,
		fhd.amount,
		fhd.product,
		fhd.source,
		tl.top_level,
		pg.expenditure_group,
		fh.batch_number,
		fh.transaction_number,
		fhd.line_number,
		fhd.distribution_code,
		fhd.rate,
		fh.transaction_origin,
		fh.reference
from cis.financial_history fh
inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
											and fh.transaction_number=fhd.transaction_number
left join cis.product_groups pg on pg.product=fhd.product
left join custom.cis_expenditure_groups_top_level tl on tl.expenditure_group=pg.expenditure_group
--where expenditure_group = 'DE'
where substring(fhd.[source],3,1) in('E','F')
and concat('bn',fh.batch_number
				,'tn',fh.transaction_number
				,'ln',fhd.line_number)   not in (select composite_key 
													from [custom].[cis_events_fin_hist])
--and concat(fh.contact_number
--						,fh.batch_number
--						,fh.transaction_number
--						,fhd.line_number) not in (select composite_key 
--													from [custom].[cis_events_fin_hist])


---------------------------------------------------------------------------------------------------
----------------------Previous version code below--------------------------------------------------
---------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------
----------------------Workings for London Marathon Thanking 2015_07_27-----------------------------
---------------------------------------------------------------------------------------------------

--declare		@Source1			as varchar(10);
--declare		@Source2			as varchar(10);
--declare		@Source3			as varchar(10);
--declare		@Source4			as varchar(10);
--declare		@Source5			as varchar(10);

--set           @Source1             = 'NXELMXE00'        --  New style source for this event, again in the brief
--set           @Source2             = 'N22000001'        --  Old style source for this event
--set           @Source3             = 'NXELMXO00'        --  iraiser sponsorship forms
--set           @Source4             = 'NXELMXD00'        --  
--set           @Source5             = 'NXELMXT00'        --  social media page

--select CONCAT ('bn', batch_number, 'tn', transaction_number, 'ln', line_number) AS compo_key, batch_number, transaction_number, amount, line_number
--from custom.cis_events_fin_hist
--where master_contact = 2288257
--and source in (@Source1,@Source2,@Source3,@Source4,@Source5)
--order by batch_number

--select * 
--from custom.cis_events_fin_hist
--where master_contact = 2288257
--and batch_number in (125807,126871)





--select efh.* 
--, s.source_desc
--from custom.cis_events_fin_hist as efh
--inner join cis.sources as s on efh.[source]=s.[source]
--where composite_key in (select composite_key
--							from custom.cis_events_fin_hist
--							group by composite_key
--							having count(composite_key) >1)
--and segment <>8
--order by composite_key



----select fin_hist.*
----from (select CONCAT ('bn', fh.batch_number, 'tn', fh.transaction_number, 'ln', fhd.line_number) AS compo_key, fh.batch_number, fh.transaction_number, fhd.line_number, fh.contact_number, fhd.amount, fhd.source, fh.transaction_date
----              from cis.financial_history fh 
----                     inner join cis.financial_history_details fhd on fh.batch_number = fhd.batch_number
----                     and fh.transaction_number = fhd.transaction_number
----                     where contact_number = 2288257
----                     and source in (@Source1,@Source2,@Source3,@Source4,@Source5)) as fin_hist
----where fin_hist.compo_key not in (select CONCAT ('bn', batch_number, 'tn', transaction_number, 'ln', line_number) AS compo_key--, batch_number, transaction_number, amount, line_number
----                                                                     from custom.cis_events_fin_hist
----                                                                     where master_contact = 2288257
----                                                                     and source in (@Source1,@Source2,@Source3,@Source4,@Source5))

----select *--CONCAT ('bn', fh.batch_number, 'tn', fh.transaction_number, 'ln', fhd.line_number) AS compo_key, fh.batch_number, fh.transaction_number, fhd.line_number, fh.contact_number, fh.amount, fhd.source, fh.transaction_date
----from cis.financial_history fh 
----inner join cis.financial_history_details fhd on fh.batch_number = fhd.batch_number
----                                                                           and fh.transaction_number = fhd.transaction_number
----where contact_number = 2288257
----and fh.batch_number in (125807,126871)


--                                                                     --order by transaction_date desc


----select distinct [source]
----, pg.expenditure_group
----, pg.product 
----, fh.transaction_origin
----, fh.batch_number
----, fh.transaction_number
----, fhd.line_number
----, fhd.amount
----, fl1.*
----from cis.financial_history fh
----inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
----											and fh.transaction_number=fhd.transaction_number
----left join cis.product_groups pg on pg.product=fhd.product
----left join cis.financial_links fl1 on fh.batch_number=fl1.batch_number 
----								and fh.transaction_number=fl1.transaction_number
----								and fhd.line_number=fl1.line_number
------where expenditure_group = 'DE'
----where substring(fhd.[source],3,1) in('E','F')
----and fh.contact_number = 2288257
----and source in (@Source1,@Source2,@Source3,@Source4,@Source5)

----and batch_number in (125807,126871)

--insert into [custom].[cis_events_fin_hist]
--(composite_key
--, segment
--, master_contact
--, financial_links_donor
--, [payment_method]
--, [transaction_date]
--, [amount]
--, [product]
--, [source]
--, [top_level]
--, [expenditure_group]
--, [batch_number]
--, [transaction_number]
--, [line_number]
--, [distribution_code]
--, [rate]
--, [transaction_origin]
--, [reference])
--select composite_key
--, segment
--, master_contact
--, financial_links_donor
--, [payment_method]
--, [transaction_date]
--, [amount]
--, [product]
--, [source]
--, [top_level]
--, [expenditure_group]
--, [batch_number]
--, [transaction_number]
--, [line_number]
--, [distribution_code]
--, [rate]
--, [transaction_origin]
--, [reference]
--from (select concat('bn',fh.batch_number
--				,'tn',fh.transaction_number
--				,'ln',fhd.line_number) as composite_key,
--		8 as segment,
--		fh.contact_number as master_contact,
--		fh.contact_number as financial_links_donor,
--		fh.payment_method,
--		fh.transaction_date,
--		fhd.amount,
--		fhd.product,
--		fhd.source,
--		tl.top_level,
--		pg.expenditure_group,
--		fh.batch_number,
--		fh.transaction_number,
--		fhd.line_number,
--		fhd.distribution_code,
--		fhd.rate,
--		fh.transaction_origin,
--		fh.reference
--from cis.financial_history fh
--inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
--											and fh.transaction_number=fhd.transaction_number
--left join cis.product_groups pg on pg.product=fhd.product
--left join custom.cis_expenditure_groups_top_level tl on tl.expenditure_group=pg.expenditure_group
----where expenditure_group = 'DE'
--where substring(fhd.[source],3,1) in('E','F')) as A
----and fh.contact_number = 2288257
----and source in (@Source1,@Source2,@Source3,@Source4,@Source5)
----and fh.batch_number in (125807,126871)

--where A.composite_key not in (select composite_key 
--								from [custom].[cis_events_fin_hist])



----where A. concat('bn',fh.batch_number
----				,'tn',fh.transaction_number
----				,'ln',fhd.line_number)   

--select * from [custom].[cis_events_fin_hist] where composite_key in ('bn125807tn20ln1','bn125807tn20ln2','bn126871tn1ln1')



--delete from [custom].[cis_events_fin_hist] where composite_key= 'bn125807tn20ln1'




--select CONCAT ('bn', fh.batch_number, 'tn', fh.transaction_number, 'ln', fhd.line_number) AS compo_key, fh.batch_number, fh.transaction_number, fhd.line_number, fh.contact_number, fh.amount, fhd.source, fh.transaction_date
--from cis.financial_history fh 
--     inner join cis.financial_history_details fhd on fh.batch_number = fhd.batch_number
--     and fh.transaction_number = fhd.transaction_number
--     where contact_number = 2288257
--     and source in (@Source1,@Source2,@Source3,@Source4,@Source5)
       
--     order by transaction_date desc


--select CONCAT ('bn', batch_number, 'tn', transaction_number, 'ln', line_number) AS compo_key, batch_number, transaction_number, amount, line_number
--     from custom.cis_events_fin_hist
--     where master_contact = 2288257
--     and source in (@Source1,@Source2,@Source3,@Source4,@Source5)
--     order by transaction_date desc

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------




----------------------V1.1 Workings below----------------------------------------------------------


--select * 
--from [custom].[cis_events_fin_hist] 
--where master_contact in (2367816, 5921, 13328)
--and batch_number in (118032, 124151)
--order by master_contact
--,segment
--,batch_number
--,transaction_number
--,line_number



--select * 
--from [custom].[cis_events_fin_hist] 
--where master_contact in (76773
--						, 548297
--						, 770397
--						, 928935
--						, 794172)
--order by segment

----select a.*,b.bntnln,b.segment
----from (select segment
----		, master_contact
----		, batch_number
----		, transaction_number
----		, line_number
----		, concat(batch_number
----		, transaction_number
----		, line_number) as bntnln
----		from [custom].[cis_events_fin_hist]) as a
----inner join (select segment
----		, master_contact
----		, batch_number
----		, transaction_number
----		, line_number
----		, concat(batch_number
----		, transaction_number
----		, line_number) as bntnln
----		from [custom].[cis_events_fin_hist]) as b on a.bntnln=b.bntnln and a.segment<>b.segment
----order by batch_number
----, transaction_number
----, line_number 


--select distinct c1.segment
--, c1.master_contact
--, c2.segment
--, c2.master_contact
--from [custom].[cis_events_fin_hist] c1
--inner join [custom].[cis_events_fin_hist] c2 on c1.master_contact=c2.master_contact 
--												and c1.segment<>c2.segment
--order by c1.segment



--select segment
--, master_contact
--, batch_number
--, transaction_number
--, line_number
--, amount
--, line_type
--from [custom].[cis_events_fin_hist]
--where master_contact in (20017888
--						, 1443357
--						, 1745375
--						, 78336
--						, 1484200)
--order by master_contact
--, batch_number
--, transaction_number
--, line_number

----------------------V1.1 Workings below----------------------------------------------------------




--version 1.0 code below

--truncate table [custom].[cis_events_fin_hist]

--insert into [custom].[cis_events_fin_hist]
--(segment
--, master_contact
--, financial_links_donor
--, [payment_method]
--, [transaction_date]
--, [amount]
--, [product]
--, [source]
--, [top_level]
--, [expenditure_group]
--, [batch_number]
--, [transaction_number]
--, [line_number]
--, [distribution_code]
--, [rate]
--, [transaction_origin]
--, [reference]
--, [line_type])
--select 1 as segment,  -- gets in challenge donations, where income on the donor
--/*select*/ isnull(fl1.contact_number,fh.contact_number) as master_contact,
--		fl1.donor_contact_number as financial_links_donor,
--		fh.payment_method,
--		fh.transaction_date,
--		fhd.amount,
--		fhd.product,
--		fhd.source,
--		tl.top_level,
--		pg.expenditure_group,
--		fh.batch_number,
--		fh.transaction_number,
--		fhd.line_number,
--		fhd.distribution_code,
--		fhd.rate,
--		fh.transaction_origin,
--		fh.reference,
--		fl1.line_type
--from cis.financial_history fh
--inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
--											and fh.transaction_number=fhd.transaction_number
--left join cis.product_groups pg on pg.product=fhd.product
--left join custom.cis_expenditure_groups_top_level tl on tl.expenditure_group=pg.expenditure_group
--left join cis.financial_links fl1 on fh.batch_number=fl1.batch_number 
--								and fh.transaction_number=fl1.transaction_number
--								and fhd.line_number=fl1.line_number
--								and fl1.line_type in ('H','S')
--where pg.expenditure_group = 'DE'
--and (fh.transaction_origin = 'CH_W')
--UNION
--select 2 as segment,  -- gets in org dons where income is on the donor
--/*select*/	isnull(fl1.contact_number,fh.contact_number) as master_contact,
--		fl1.donor_contact_number as financial_links_donor,
--		fh.payment_method,
--		fh.transaction_date,
--		fhd.amount,
--		fhd.product,
--		fhd.source,
--		tl.top_level,
--		pg.expenditure_group,
--		fh.batch_number,
--		fh.transaction_number,
--		fhd.line_number,
--		fhd.distribution_code,
--		fhd.rate,
--		fh.transaction_origin,
--		fh.reference,
--		fl1.line_type
--from cis.financial_history fh
--inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
--											and fh.transaction_number=fhd.transaction_number
--left join cis.product_groups pg on pg.product=fhd.product
--left join custom.cis_expenditure_groups_top_level tl on tl.expenditure_group=pg.expenditure_group
--left join cis.financial_links fl1 on fh.batch_number=fl1.batch_number 
--								and fh.transaction_number=fl1.transaction_number
--								and fhd.line_number=fl1.line_number
--								and fl1.line_type in ('H','S')
--inner join cis.organisations o on o.organisation_number = fh.contact_number 
--		--  an organisation can not be a fundraiser, therefore must be matched giving
--where pg.expenditure_group = 'DE'
--union
--select 3 as segment,  -- gets in JG donations, data is on the fundraiser not donor
--/*select*/	fh.contact_number as master_contact,
--		fl1.donor_contact_number as financial_links_donor,
--		fh.payment_method,
--		fh.transaction_date,
--		fhd.amount,
--		fhd.product,
--		fhd.source,
--		tl.top_level,
--		pg.expenditure_group,
--		fh.batch_number,
--		fh.transaction_number,
--		fhd.line_number,
--		fhd.distribution_code,
--		fhd.rate,
--		fh.transaction_origin,
--		fh.reference,
--		fl1.line_type
--from cis.financial_history fh
--inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
--											and fh.transaction_number=fhd.transaction_number
--left join cis.product_groups pg on pg.product=fhd.product
--left join custom.cis_expenditure_groups_top_level tl on tl.expenditure_group=pg.expenditure_group
--inner join cis.financial_links fl1 on fh.batch_number=fl1.batch_number 
--								and fh.transaction_number=fl1.transaction_number
--								and fhd.line_number=fl1.line_number
--								and fl1.line_type in ('H','S')
--where pg.expenditure_group = 'DE'
--and fh.transaction_origin in ('JG_W','JGEW','JGIW','JGMW','JGSW')
--UNION
--select 4 as segment,  -- gets in JG donations that are not linked to a donor
--/*select*/	fh.contact_number as master_contact,
--		fh.contact_number ,
--		fh.payment_method,
--		fh.transaction_date,
--		fhd.amount,
--		fhd.product,
--		fhd.source,
--		tl.top_level,
--		pg.expenditure_group,
--		fh.batch_number,
--		fh.transaction_number,
--		fhd.line_number,
--		fhd.distribution_code,
--		fhd.rate,
--		fh.transaction_origin,
--		fh.reference,
--		''
--from cis.financial_history fh
--inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
--											and fh.transaction_number=fhd.transaction_number
--left join cis.product_groups pg on pg.product=fhd.product
--left join custom.cis_expenditure_groups_top_level tl on tl.expenditure_group=pg.expenditure_group
--where pg.expenditure_group = 'DE'
--and fh.transaction_origin in ('JG_W','JGEW','JGIW','JGMW','JGSW')
--UNION
--select 5 as segment,  -- anything else in fincial links, assumpotion is money is on the donor
--/*select*/	isnull(fl1.contact_number,fh.contact_number) as master_contact,
--		fl1.donor_contact_number as financial_links_donor,
--		fh.payment_method,
--		fh.transaction_date,
--		fhd.amount,
--		fhd.product,
--		fhd.source,
--		tl.top_level,
--		pg.expenditure_group,
--		fh.batch_number,
--		fh.transaction_number,
--		fhd.line_number,
--		fhd.distribution_code,
--		fhd.rate,
--		fh.transaction_origin,
--		fh.reference,
--		fl1.line_type
--from cis.financial_history fh
--inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
--											and fh.transaction_number=fhd.transaction_number
--left join cis.product_groups pg on pg.product=fhd.product
--left join custom.cis_expenditure_groups_top_level tl on tl.expenditure_group=pg.expenditure_group
--inner join cis.financial_links fl1 on fh.batch_number=fl1.batch_number 
--								and fh.transaction_number=fl1.transaction_number
--								and fhd.line_number=fl1.line_number
--								and fl1.line_type in ('H','S')
--where pg.expenditure_group = 'DE'
--UNION
--select 6 as segment,  -- remainder of DE income in fh, assume income is the fundraisers
--/*select*/	fh.contact_number as master_contact,
--		fh.contact_number as financial_links_donor,
--		fh.payment_method,
--		fh.transaction_date,
--		fhd.amount,
--		fhd.product,
--		fhd.source,
--		tl.top_level,
--		pg.expenditure_group,
--		fh.batch_number,
--		fh.transaction_number,
--		fhd.line_number,
--		fhd.distribution_code,
--		fhd.rate,
--		fh.transaction_origin,
--		fh.reference,
--		''
--from cis.financial_history fh
--inner join cis.financial_history_details fhd on fh.batch_number=fhd.batch_number 
--											and fh.transaction_number=fhd.transaction_number
--left join cis.product_groups pg on pg.product=fhd.product
--left join custom.cis_expenditure_groups_top_level tl on tl.expenditure_group=pg.expenditure_group
--where pg.expenditure_group = 'DE'


END



