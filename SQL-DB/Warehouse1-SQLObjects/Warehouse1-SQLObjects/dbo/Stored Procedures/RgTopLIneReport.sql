CREATE PROCEDURE [dbo].[RgTopLIneReport]  @Channel varchar(1) = NULL,    @Agency varchar(20) = NULL 
AS
BEGIN
		SET NOCOUNT ON;
		
DECLARE @ChannelCDE varchar(1) 
DECLARE @AgencyCDE varchar(20)
 

SET @ChannelCDE = @Channel
SET @AgencyCDE = @Agency

--variables

--start current month
declare       @StartCurrentMonth datetime
set    @StartCurrentMonth   = dateadd(m, datediff(m, 0, getdate()), 0)

--start previous 12 months
declare       @StartLast12Months datetime
set @startlast12months     = dateadd(m, -12, @startcurrentmonth)

--Start Current Year
declare       @StartCurrentYear datetime
set    @StartCurrentYear    = cast(cast(year(getdate()) as char(4)) + '-01-01' as datetime)

--For top line report
if object_id('tempdb..#RegularGivingTopLine') is not null drop table #RegularGivingTopLine

--For churn figures
if object_id('tempdb..#Churn') is not null drop table #Churn
create table #Churn
(Started_Contacts int, 
Finished_Contacts int,
Contacts_Attrited int, 
Started_Orders int, 
Finished_Orders int,
Orders_Attrited int,
Contact_Retention float,
Order_Retention float,
Contact_Attrition float,
Order_Attrition float)

if object_id('tempdb..#atstart') is not null drop table #atstart

if object_id('tempdb..#atend') is not null drop table #atend

--Orders that were current at the time of @startdate

SELECT	DISTINCT  SUB.Order_Number
		, contact_number
	into #atstart
FROM (
	select	 ord.order_number
			, ord.created_by
			, ord.fk_contact as contact_number
			, ord.PK_ID
from (SELECT  t.PK_ID
		, t.order_number
		, t.fk_contact
		, t.order_date
		, t.renewal_date
		, t.payment_frequency
		, t.last_Payment_date
		, t.cancelled_on
		, t.created_by
		, t1.product
		, t1.detailline_source as Source
FROM DimOrder t
INNER JOIN [dbo].[DimOrderDetail] t1 ON t1.FK_Order = t.PK_ID) ord
INNER JOIN [dbo].[DimContact] as c ON ord.fk_contact = c.PK_ID
where ord.product ='DON-REGGIV-DUK-OS' -- AND c.IsActiveRegularGiving = 1 
AND @StartLast12Months between ord.order_date and isnull(ord.cancelled_on,'31 dec 2099')
and ((ord.payment_frequency in ('I', 'M') and ord.last_payment_date>dateadd(mm,-2,@StartLast12Months))
       or (ord.payment_frequency in ('J', 'Q') and ord.last_payment_date>dateadd(mm,-4,@StartLast12Months))
       or (ord.payment_frequency in ('H','K') and ord.last_payment_date>dateadd(mm,-7,@StartLast12Months))
       or (ord.payment_frequency in ('A','O') and ord.last_payment_date>dateadd(mm,-13,@StartLast12Months))) )SUB
left outer JOIN [dbo].[fundraising] f ON sub.PK_ID = f.FK_Orders
INNER JOIN [dbo].[DimChannel] ch ON f.FK_Channel = ch.PK_ID
WHERE (ch.Channel = @ChannelCDE or @ChannelCDE IS NULL )
AND (sub.created_by = @AgencyCDE OR @AgencyCDE IS NULL)
order by sub.order_number 

----Orders that were current at the time of @StartCurrentMonth

SELECT	DISTINCT  SUB.Order_Number
		, contact_number
	into #atend
FROM (
	select	 ord.order_number
			, ord.created_by
			, ord.fk_contact as contact_number
			, ord.PK_ID
from (SELECT  t.PK_ID
		, t.order_number
		, t.fk_contact
		, t.order_date
		, t.renewal_date
		, t.payment_frequency
		, t.last_Payment_date
		, t.cancelled_on
		, t.created_by
		, t1.product
		, t1.detailline_source as Source
FROM DimOrder t
INNER JOIN [dbo].[DimOrderDetail] t1 ON t1.FK_Order = t.PK_ID) ord
INNER JOIN [dbo].[DimContact] as c ON ord.fk_contact = c.PK_ID
where ord.product ='DON-REGGIV-DUK-OS'  --AND c.IsActiveRegularGiving = 1  
AND @StartCurrentMonth between ord.order_date and isnull(ord.cancelled_on,'31 dec 2099')
and ((ord.payment_frequency in ('I','M') and ord.last_payment_date>dateadd(mm,-2,@StartCurrentMonth))
       or (ord.payment_frequency in ('J','Q') and ord.last_payment_date>dateadd(mm,-4,@StartCurrentMonth))
       or (ord.payment_frequency in ('H','K') and ord.last_payment_date>dateadd(mm,-7,@StartCurrentMonth))
       or (ord.payment_frequency in ('A','O') and ord.last_payment_date>dateadd(mm,-13,@StartCurrentMonth))) )SUB
LEFT OUTER JOIN [dbo].[fundraising] f ON sub.PK_ID = f.FK_Orders
INNER JOIN [dbo].[DimChannel] ch ON f.FK_Channel = ch.PK_ID
WHERE (ch.Channel = @ChannelCDE or @ChannelCDE IS NULL)
AND (sub.created_by =  @AgencyCDE OR @AgencyCDE IS NULL)
order by sub.order_number 



insert into #Churn
(started_contacts
, finished_contacts
, contacts_attrited
, started_orders
, finished_orders
, orders_attrited)


select ret.started_contacts
, ret.finished_contacts
, sum(ret.started_contacts-ret.finished_contacts) as contacts_attrited
, ret.started_orders
, ret.finished_orders 
, sum(ret.started_orders-ret.finished_orders) as orders_attrited
 
from (select count(distinct contact_number) as started_contacts
                           , (select count(distinct e.contact_number) 
                                  from #atend e 
                                  inner join #atstart s2 on e.contact_number=s2.contact_number)as finished_contacts
                     , count(order_number) as started_orders
                           , (select count(distinct e.order_number) 
                                  from #atend e
                                  inner join #atstart s2 on e.order_number=s2.order_number) as finished_orders
              from #atstart as s) as ret
group by started_contacts
, finished_contacts
, started_orders
, finished_orders



update #Churn
set contact_attrition=cast(NULLIF(contacts_attrited, 0) as float)/cast(started_contacts as float), 
       order_attrition=cast(NULLIF(orders_attrited, 0) as float)/cast(started_orders as float)

update #Churn
set Contact_Retention=cast(NULLIF(finished_contacts, 0)  as decimal(9,2))/cast(started_contacts as decimal(9,2)), 
       Order_Retention=cast(NULLIF(finished_orders, 0)  as decimal(9,2))/cast(started_orders as decimal(9,2));
	    

with noshow as
(select count(FK_Contact) as cancelled
		from (SELECT distinct o.FK_Contact
		from DimORder o 
		inner join dimOrderDetail od on  o.PK_ID=od.fk_order
		where od.product ='DON-REGGIV-DUK-OS'
		AND (SUBSTRING(od.detailline_source, 7, 1) =  @ChannelCDE or @ChannelCDE IS NULL)
		and o.cancelled_on between @StartLast12Months and @StartCurrentMonth
		AND (o.created_by =  @AgencyCDE OR @AgencyCDE IS NULL)
		group by o.FK_Contact
		having max(o.payment_number) <1 ) as canx_rg)

, per_canx as				
(select count(FK_Contact) as cancelled
from (select distinct o.FK_Contact
		from DimORder o 
		inner join dimOrderDetail  od on o.PK_ID=od.fk_order
		where od.product ='DON-REGGIV-DUK-OS'
		AND (SUBSTRING(od.detailline_source, 7, 1) =  @ChannelCDE or @ChannelCDE IS NULL)
		AND (o.created_by =  @AgencyCDE OR @AgencyCDE IS NULL)
		and o.cancelled_on between @StartLast12Months and @StartCurrentMonth
		and o.order_date between @StartLast12Months and @StartCurrentMonth
		group by o.FK_Contact) as canx_rg)



select DISTINCT
--Count of Active Regular Givers: 
(


select count(distinct sub.contact_number)
       from 
	   (SELECT ord.contact_number
				, ord.created_by
				, ord.PK_ID FROM 
	   (SELECT  t.PK_ID
		, t.order_number
		, t.fk_contact as contact_number
		, t.order_date
		, t.renewal_date
		, t.payment_frequency
		, t.last_Payment_date
		, t.payment_number
		, t.cancelled_on
		, t.created_by
		, t1.product
		, t1.detailline_source as Source
FROM DimOrder t
INNER JOIN [dbo].[DimOrderDetail] t1 ON t1.FK_Order = t.PK_ID) ord
INNER JOIN [dbo].[DimContact] as c ON ord.contact_number = c.PK_ID
where ord.product ='DON-REGGIV-DUK-OS'  --AND c.IsActiveRegularGiving = 1 
       and ( (ord.payment_frequency in ('M', 'I') and ord.last_payment_date>dateadd(mm,-2,getdate()))
              or (ord.payment_frequency in ('Q', 'J') and ord.last_payment_date>dateadd(mm,-4,getdate()))
              or (ord.payment_frequency in ('A', 'K') and ord.last_payment_date>dateadd(mm,-13,getdate())))
       and ord.cancelled_on is null	  ) sub 
LEFT OUTER JOIN  [dbo].[fundraising] as f ON f.FK_orders = sub.pk_id
INNER JOIN [dbo].[DimChannel] ch ON f.fk_channel = ch.PK_ID
WHERE   (ch.channel =  @ChannelCDE or @ChannelCDE IS NULL)
AND (sub.created_by =  @AgencyCDE OR @AgencyCDE IS NULL)
	   ) as count_of_current_RG


, (select cast(cancelled as float)/(select cast(nullif(cancelled,0) as float)from per_canx)from noshow)as No_Show_Rate
, (select cast(cancelled as float) from noshow)as No_Show_Num
--12 Month Attrition:
, (select cast(contact_attrition as decimal(9,3)) as contact_attrition_pct
       from #Churn) as pct_RG_Contact_Attrition_Last_12_Months
, (select cast(contacts_attrited as decimal(9,3)) as contacts_attrited
       from #Churn) as numattrited
, (select cast(started_contacts as decimal(9,3))  as started_contacts  from #Churn) as started_contacts
--12 MOnth Retention:
, (select cast(contact_retention as decimal(9,3)) as contact_attrition_pct
       from #Churn) as pct_RG_Contact_Retention_Last_12_Months
, (select cast(finished_contacts as decimal(9,3)) as finished_contacts
       from #Churn) as numretained
       from
	   (select rg_annual.contact_number --
	   --,cast(sum(annual_amount)/12 as decimal(9,2)) as monthly_amnt
                     from (select distinct sub.contact_number
                                  ,sub.order_number
								  from 
	   (SELECT ord.contact_number
				, ord.PK_ID
				, ord.cancelled_on
				, ord.created_by
				, ord.order_Number FROM 
	   (SELECT  t.PK_ID
		, t.order_number
		, t.fk_contact as contact_number
		, t.order_date
		, t.renewal_date
		, t.payment_frequency
		, t.last_Payment_date
		, t.payment_number
		, t.cancelled_on
		, t.created_by
		, t1.product
		, t1.detailline_source as Source
FROM DimOrder t
INNER JOIN [dbo].[DimOrderDetail] t1 ON t1.FK_Order = t.PK_ID) ord
INNER JOIN [dbo].[DimContact] as c ON ord.contact_number = c.PK_ID
where ord.product ='DON-REGGIV-DUK-OS' --  AND c.IsActiveRegularGiving = 1  
                                  and ( (ord.payment_frequency in ('M', 'I') and ord.last_payment_date>dateadd(mm,-2,getdate()))
                                         or (ord.payment_frequency in ('Q', 'J') and ord.last_payment_date>dateadd(mm,-4,getdate()))
                                         or (ord.payment_frequency in ('A', 'K') and ord.last_payment_date>dateadd(mm,-13,getdate())))
       and ord.cancelled_on is null	  ) sub 
LEFT JOIN  [dbo].[fundraising] as f ON f.FK_orders = sub.pk_id
INNER JOIN [dbo].[DimChannel] ch ON f.fk_channel = ch.PK_ID
WHERE   (ch.channel =  @ChannelCDE or @ChannelCDE IS NULL)
AND (sub.created_by =  @AgencyCDE OR @AgencyCDE IS NULL)
          		and sub.cancelled_on is null) as rg_annual
                     group by rg_annual.contact_number) as rg_monthly
					 --) as avg_RG_gift_per_month
END










































































