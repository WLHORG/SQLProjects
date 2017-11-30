-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimContact]
	
AS
BEGIN
	 	SET NOCOUNT ON;
DECLARE @CurrentDate DATETIME
--SET		@CurrentDate = CAST(CONVERT(VARCHAR(10), GETDATE(), 121) AS DATETIME)
SET		@CurrentDate = cast(getdate() as date)

DECLARE @Tranhist TABLE 
(contact_number int NOT NULL PRIMARY KEY,
PrevYearTransactionAmount float,   
Prev2YearTransactionAmount float,
Prev3YearTransactionAmount float,
Prev4YearTransactionAmount float,
Prev5YearTransactionAmount float,
TotalTransactionAmount float,
LastPaymentDate DATE
)


INSERT INTO @Tranhist (contact_number,
PrevYearTransactionAmount,   
Prev2YearTransactionAmount,
Prev3YearTransactionAmount,
Prev4YearTransactionAmount,
Prev5YearTransactionAmount,
TotalTransactionAmount,
LastPaymentDate)

SELECT   fin.contact_number
		,SUM(CASE
				WHEN fin.transaction_date BETWEEN DATEADD(d, -365, @CurrentDate) AND @CurrentDate
				THEN fin.amount
				ELSE 0.00
			 END) AS PrevYearTransactionAmount
		,SUM(CASE
				WHEN fin.transaction_date BETWEEN DATEADD(d, -730, @CurrentDate) AND DATEADD(d, -366, @CurrentDate)
				THEN fin.amount
				ELSE 0.00
			 END) AS Prev2YearTransactionAmount
		,SUM(CASE
				WHEN fin.transaction_date BETWEEN DATEADD(d, -1095, @CurrentDate) AND DATEADD(d, -731, @CurrentDate)
				THEN fin.amount
				ELSE 0.00
			 END) AS Prev3YearTransactionAmount
		,SUM(CASE
				WHEN fin.transaction_date BETWEEN DATEADD(d, -1460, @CurrentDate) AND DATEADD(d, -1096, @CurrentDate)
				THEN fin.amount
				ELSE 0.00
			 END) AS Prev4YearTransactionAmount
		,SUM(CASE
				WHEN fin.transaction_date BETWEEN DATEADD(d, -1825, @CurrentDate) AND DATEADD(d, -1461, @CurrentDate)
				THEN fin.amount
				ELSE 0.00
			 END) AS Prev5YearTransactionAmount 
		,SUM(fin.amount) AS TotalTransactionAmount
		,MAX(CASE
				WHEN fin.Amount > 0
				AND  fin.transaction_date < @CurrentDate
				THEN fin.transaction_date
				-- Fix any future entered transactions
				WHEN fin.Amount > 0
				AND  fin.transaction_date >= @CurrentDate
				THEN fin.posted
				ELSE NULL
			 END) AS LastPaymentDate

FROM	 DiabetesDWH.custom.repFinancialHistory fin
GROUP BY fin.contact_number

----------------------------------------------------------------------------------------------------------------------------
--Commitments
----------------------------------------------------------------------------------------------------------------------------
DECLARE @Commitments TABLE 
(contact_number int NOT NULL PRIMARY KEY,
ActiveFinancialRelationships int,   
CommittmentValue float,
CommittmentValueMembership float,
CommittmentValueRegularGiving float,
CommittmentValueWeeklyLottery float
)

INSERT INTO  @Commitments
(contact_number,
ActiveFinancialRelationships,   
CommittmentValue,
CommittmentValueMembership,
CommittmentValueRegularGiving,
CommittmentValueWeeklyLottery)

SELECT   reg.contact_number
		,COUNT(reg.contact_number)	AS ActiveFinancialRelationships
		,SUM(reg.AnnualisedAmount)	AS CommittmentValue
		,SUM(CASE
				WHEN reg.Product = 'Membership'
				THEN reg.AnnualisedAmount
				ELSE 0.00
			 END) AS CommittmentValueMembership
		,SUM(CASE
				WHEN reg.Product = 'Regular_Giving'
				THEN reg.AnnualisedAmount
				ELSE 0.00
			 END) AS CommittmentValueRegularGiving
		,SUM(CASE
				WHEN reg.Product = 'Weekly_Lottery'
				THEN reg.AnnualisedAmount
				ELSE 0.00
			 END) AS CommittmentValueWeeklyLottery

FROM	
(select CASE
			WHEN cca.cost_centre_activity IN ('MM' --Membership
											, 'MA' --Membership
											, 'MB' --Membership
											, 'MU' --Membership
											, 'MC' --Membership
											, 'MR' --Membership
											, 'PM' --Professional_Membership
											, 'PA' --Professional_Membership
											, 'PR' --Professional_Membership
											, 'PD') --Professional_Membership 
				THEN 'Membership'
			WHEN cca.cost_centre_activity IN ('DM' --Regular_Donation
											, 'DR' --Regular_Donation										
											, 'RG' --Regular_Giving
											, 'RU' --Regular_Giving
											, 'RC' --Regular_Giving
											, 'RR') --Regular_Giving
				THEN 'Regular_Giving'
			
			WHEN cca.cost_centre_activity IN ('WL' --Weekly_Lottery
											, 'WU' --Weekly_Lottery
											, 'WC' --Weekly_Lottery
											, 'WR' --Weekly_Lottery
											, 'WS') --Weekly_Lottery
				THEN 'Weekly_Lottery'
		END AS Product
, ord.contact_number
, ord.payment_frequency
, nsr.new_source
, SUM(ord.frequency_amount)	AS frequency_amount
, SUM(	CASE
			WHEN ord.payment_frequency in ('A','O')
				THEN ord.frequency_amount * 1.00
			WHEN ord.payment_frequency in ('H','K')
				THEN ord.frequency_amount * 2.00
			WHEN ord.payment_frequency IN ('J', 'Q')
				THEN ord.frequency_amount * 4.00
			WHEN ord.payment_frequency IN ('I', 'M')
				THEN ord.frequency_amount * 12.00
		END)	AS AnnualisedAmount
from DiabetesDWH.cis.orders as ord
inner join DiabetesDWH.cis.order_details as odt on ord.order_number=odt.order_number
										and odt.detail_number = 1
inner join DiabetesDWH.cis.products as prd on odt.product=prd.product
inner join DiabetesDWH.cis.duk_new2015_sources as nsr on odt.[source]=nsr.new_source
inner join DiabetesDWH.cis.duk_cost_centre_activities as cca on substring(nsr.new_source,4,2)=cca.cost_centre_activity
													and cca.cost_centre_activity in ('DM' --Regular_Donation
																					, 'DR' --Regular_Donation
																					, 'MM' --Membership
																					, 'MA' --Membership
																					, 'MB' --Membership
																					, 'MU' --Membership
																					, 'MC' --Membership
																					, 'MR' --Membership
																					, 'PA' --Payroll_Giving
																					, 'PM' --Professional_Membership
																					, 'PA' --Professional_Membership
																					, 'PR' --Professional_Membership
																					, 'PD' --Professional_Membership
																					, 'RG' --Regular_Giving
																					, 'RU' --Regular_Giving
																					, 'RC' --Regular_Giving
																					, 'RR' --Regular_Giving
																					, 'WL' --Weekly_Lottery
																					, 'WU' --Weekly_Lottery
																					, 'WC' --Weekly_Lottery
																					, 'WR' --Weekly_Lottery
																					, 'WS') --Weekly_Lottery
																			
WHERE	 ord.cancelled_on IS NULL
GROUP BY cca.cost_centre_activity
		, ord.contact_number
		, ord.payment_frequency
		, nsr.new_source) as Reg
GROUP BY reg.contact_number
 
 ----------------------------------------------------------------------------------------------------------------------------------------
 --Product Cash
 ----------------------------------------------------------------------------------------------------------------------------------------

 DECLARE @ProductCash TABLE 
(contact_number int NOT NULL PRIMARY KEY,
Cash int)

INSERT INTO @ProductCash (contact_number, Cash)
 
SELECT   fht.contact_number
		,	CASE
				WHEN DATEDIFF(d, MAX(fht.transaction_date), @CurrentDate) <= 730
					THEN 1
				ELSE 0
			END AS Cash
FROM	 DiabetesDWH.custom.repFinancialHistory	as fht
inner join DiabetesDWH.cis.duk_new2015_sources as nsr on FHT.[source]=nsr.new_source
												and fht.product in('DON-NOGIFTAID-DUK-OS'
																	, 'DON-GIFTAID-DUK-OS') --Donations
inner join DiabetesDWH.cis.duk_cost_centre_activities as cca on substring(nsr.new_source,4,2)=cca.cost_centre_activity
													and cca.cost_centre_activity in ('DM'
																					,'DR') --Appeals												
WHERE	 fht.amount > 0.00
GROUP BY fht.contact_number

------------------------------------------------------------------------------------------------------------------------------------------------
--Product Raffle
------------------------------------------------------------------------------------------------------------------------------------------------


 DECLARE @ProductRaffle TABLE 
(contact_number int NOT NULL PRIMARY KEY,
Raffle int)

INSERT INTO @ProductRaffle (contact_number, Raffle)

SELECT   fht.contact_number
		,CASE
			WHEN DATEDIFF(d, MAX(fht.transaction_date), @CurrentDate) <= 730
			THEN 1
			ELSE 0
		 END AS Raffle 
FROM	 DiabetesDWH.custom.repFinancialHistory	as fht
inner join DiabetesDWH.cis.duk_new2015_sources as nsr on FHT.[source]=nsr.new_source
inner join DiabetesDWH.cis.duk_cost_centre_activities as cca on substring(nsr.new_source,4,2)=cca.cost_centre_activity
													and cca.cost_centre_activity in ('RM'
																					, 'RE') --Raffle
WHERE	 fht.amount > 0.00
GROUP BY fht.contact_number


------------------------------------------------------------------------------------------------------------------------------------------------
--Product FreePrizeDraw
------------------------------------------------------------------------------------------------------------------------------------------------

 DECLARE @ProductFreePrizeDraw TABLE 
(contact_number int,
product VARCHAR(20),
cost_centre_activity_desc VARCHAR(60), 
FreePrizeDraw int)

INSERT INTO @ProductFreePrizeDraw (contact_number, product, cost_centre_activity_desc, FreePrizeDraw)

SELECT   fht.contact_number
, fht.product
, cca.cost_centre_activity_desc
		,CASE
			WHEN DATEDIFF(d, MAX(fht.transaction_date), @CurrentDate) <= 730
			THEN 1
			ELSE 0
		 END AS FreePrizeDraw
FROM	 DiabetesDWH.custom.repFinancialHistory	as fht
inner join DiabetesDWH.cis.duk_new2015_sources as nsr on fht.[source]=nsr.new_source
											and fht.product = 'LOTTRAFF-SALE-SER-EX'
inner join DiabetesDWH.cis.duk_cost_centre_activities as cca on substring(nsr.new_source,4,2)=cca.cost_centre_activity
													and cca.cost_centre_activity in ('DE'
																					, 'DF'
																					, 'TP') 
GROUP BY fht.contact_number
, fht.product
, cca.cost_centre_activity_desc



------------------------------------------------------------------------------------------------------------------------------------------------
--Product ProductInMemory	
------------------------------------------------------------------------------------------------------------------------------------------------

 DECLARE @ProductInMemory TABLE 
(contact_number int,
--product VARCHAR(20),
cost_centre_activity_desc VARCHAR(60), 
InMemory int)

--INSERT INTO @ProductInMemory (contact_number, product, cost_centre_activity_desc, InMemory)  --RDP Jan 16 - Removed Product from In Mem calc as causing duplication.  Not used here, we just set contact to IsinMem or not, not using product
INSERT INTO @ProductInMemory (contact_number, cost_centre_activity_desc, InMemory)

SELECT   fht.contact_number
--, fht.product
, cca.cost_centre_activity_desc
		,CASE
			WHEN DATEDIFF(d, MAX(fht.transaction_date), @CurrentDate) <= 730
			THEN 1
			ELSE 0
		 END AS InMemory 
FROM	 DiabetesDWH.custom.repFinancialHistory	as fht
inner join DiabetesDWH.cis.duk_new2015_sources as nsr on fht.[source]=nsr.new_source
inner join DiabetesDWH.cis.duk_cost_centre_activities as cca on substring(nsr.new_source,4,2)=cca.cost_centre_activity
													and cca.cost_centre_activity = 'IM'  
GROUP BY fht.contact_number
--, fht.product
, cca.cost_centre_activity_desc

------------------------------------------------------------------------------------------------------------------------------------------------
--Product ProductInMemory	
------------------------------------------------------------------------------------------------------------------------------------------------

 DECLARE @ProductMembership TABLE 
(contact_number int NOT NULL PRIMARY KEY,
Membership int)

INSERT INTO @ProductMembership (contact_number, Membership)

SELECT SM.contact_number
, sum(Membership) as Membership
FROM
(SELECT distinct  ord.contact_number
		,CASE
				WHEN (ord.cancelled_on is null and ord.next_payment_due >= @CurrentDate)
				AND	 ISNULL(ord.cancelled_on, @CurrentDate) <= @CurrentDate
				THEN 1
				ELSE 0
			 END AS Membership
FROM	 DiabetesDWH.cis.orders	as ord
		 INNER JOIN DiabetesDWH.cis.order_details as odt ON ord.order_number=odt.order_number
												AND odt.detail_number = 1
		 INNER JOIN DiabetesDWH.cis.products as pro ON pro.product = odt.product
		 INNER JOIN DiabetesDWH.cis.duk_new2015_sources as nsr on odt.[source]=nsr.new_source	 
		 INNER JOIN DiabetesDWH.cis.duk_cost_centre_activities as cca on substring(nsr.new_source,4,2)=cca.cost_centre_activity
															and cca.cost_centre_activity in ('MM' 
																							, 'MA' 
																							, 'MB' 
																							, 'MU' 
																							, 'MC' 
																							, 'MR' 
																							, 'PM' 
																							, 'PA' 
																							, 'PR' 
																							, 'PD')
where substring(odt.[source],4,2)in ('MM' 
									, 'MA' 
									, 'MB' 
									, 'MU' 
									, 'MC' 
									, 'MR' 
									, 'PM' 
									, 'PA' 
									, 'PR' 
									, 'PD')) as SM
GROUP BY SM.contact_number

------------------------------------------------------------------------------------------------------------------------------------------------
--Product ProductRegularGiving	
------------------------------------------------------------------------------------------------------------------------------------------------

 DECLARE @ProductRegularGiving TABLE 
(contact_number int NOT NULL PRIMARY KEY,
RegularGiving int)

INSERT INTO @ProductRegularGiving (contact_number, RegularGiving)

SELECT RG.contact_number
, sum(RegularGiving) as RegularGiving
FROM
(SELECT distinct ord.contact_number
		,CASE
				WHEN ord.next_payment_due >= @CurrentDate
				AND	 ISNULL(ord.cancelled_on, @CurrentDate) <= @CurrentDate
				THEN 1
				ELSE 0
			 END AS RegularGiving
FROM	 DiabetesDWH.cis.orders	as ord
		 INNER JOIN DiabetesDWH.cis.order_details as odt ON ord.order_number=odt.order_number
												AND odt.detail_number = 1
		 INNER JOIN DiabetesDWH.cis.products as pro ON pro.product = odt.product
		 inner join DiabetesDWH.cis.duk_new2015_sources as nsr on odt.[source]=nsr.new_source	 
		 inner join DiabetesDWH.cis.duk_cost_centre_activities as cca on substring(nsr.new_source,4,2)=cca.cost_centre_activity
															and cca.cost_centre_activity in ('DM'
																							, 'DR'
																							, 'PA'
																							, 'RG'
																							, 'RU'
																							, 'RC'
																							, 'RR')		 
where substring(odt.[source],4,2)in ('DM'
									, 'DR'
										, 'PA'
										, 'RG'
										, 'RU'
										, 'RC'
										, 'RR')) as RG
GROUP BY RG.contact_number

------------------------------------------------------------------------------------------------------------------------------------------------
--Product ProductWeeklyLottery	
------------------------------------------------------------------------------------------------------------------------------------------------

 DECLARE @ProductWeeklyLottery TABLE 
(contact_number int NOT NULL PRIMARY KEY,
WeeklyLottery int)

INSERT INTO @ProductWeeklyLottery (contact_number, WeeklyLottery)

select WL.contact_number
, sum(WeeklyLottery) as WeeklyLottery
FROM
(SELECT   distinct ord.contact_number
		,CASE
				WHEN ord.next_payment_due >= @CurrentDate 
				AND	 ISNULL(ord.cancelled_on, @CurrentDate) <= @CurrentDate
				THEN 1
				ELSE 0
			 END AS WeeklyLottery
FROM	 DiabetesDWH.cis.orders	as ord
		 INNER JOIN DiabetesDWH.cis.order_details as odt ON ord.order_number = odt.order_number
												AND odt.detail_number = 1
		 INNER JOIN DiabetesDWH.cis.products as pro ON pro.product = odt.product	
		 inner join DiabetesDWH.cis.duk_new2015_sources as nsr on odt.[source]=nsr.new_source	 
		 inner join DiabetesDWH.cis.duk_cost_centre_activities as cca on substring(nsr.new_source,4,2)=cca.cost_centre_activity
															and cca.cost_centre_activity in ('WL'
																							,'WU'
																							,'WC'
																							,'WR'
																							,'WS')		 
where substring(odt.[source],4,2) in ('WL'
									,'WU'
									,'WC'
									,'WR'
									,'WS')) as WL
GROUP BY WL.contact_number

------------------------------------------------------------------------------------------------------------------------------------------------
--Product ProductPayrollGiving	
------------------------------------------------------------------------------------------------------------------------------------------------

 DECLARE @ProductPayrollGiving TABLE 
(contact_number int NOT NULL PRIMARY KEY,
PayrollGiving int)

INSERT INTO @ProductPayrollGiving (contact_number, PayrollGiving)

SELECT PA.contact_number
, sum(PayrollGiving) as PayrollGiving
FROM
(SELECT distinct ord.contact_number
		,CASE
				WHEN ord.next_payment_due >= @CurrentDate
				AND	 ISNULL(ord.cancelled_on, @CurrentDate) <= @CurrentDate
				THEN 1
				ELSE 0
			 END AS PayrollGiving
FROM	 DiabetesDWH.cis.orders	as ord 
		 INNER JOIN DiabetesDWH.cis.order_details as odt ON  ord.order_number = odt.order_number
		 AND odt.detail_number = 1
		 INNER JOIN DiabetesDWH.cis.products as pro ON pro.product = odt.product
 		 inner join DiabetesDWH.cis.duk_new2015_sources as nsr on odt.[source]=nsr.new_source	 
		 inner join DiabetesDWH.cis.duk_cost_centre_activities as cca on substring(nsr.new_source,4,2)=cca.cost_centre_activity
															and cca.cost_centre_activity = 'PG' --Payroll_Giving
where substring(odt.[source],4,2) ='PG') as PA
GROUP BY PA.contact_number

------------------------------------------------------------------------------------------------------------------------------------------------
--Legacy Hierarchy
------------------------------------------------------------------------------------------------------------------------------------------------

 DECLARE @Legacy TABLE 
(contact_number int,
activity VARCHAR(6),
LegacyHierarchy int, 
activity_desc VARCHAR(40),
valid_from DATETIME)

INSERT INTO @Legacy (contact_number, activity, LegacyHierarchy, activity_desc, valid_from)


SELECT   DISTINCT
		 cct.contact_number
		,cct.activity
		,CASE
			WHEN cct.activity = 'LP'		THEN 1
			WHEN cct.activity = 'LPI'		THEN 2
			WHEN cct.activity = 'LE'		THEN 3
			WHEN cct.activity = 'LEGCON'	THEN 4
		 END AS LegacyHierarchy
		,act.activity_desc
		,cct.valid_from
FROM	 DiabetesDWH.cis.contact_categories	cct
		 INNER JOIN DiabetesDWH.cis.activities as act ON  act.activity = cct.activity
		 AND cct.valid_from = (SELECT	MAX(c.valid_from)
								FROM	DiabetesDWH.cis.contact_categories as	c 
								WHERE	c.activity	= cct.activity
								AND		c.contact_number = cct.contact_number
								AND		@CurrentDate BETWEEN c.valid_from AND ISNULL(c.valid_to, '31/12/2199'))
WHERE	 cct.activity IN ('LP','LPI','LE','LEGCON')
AND		 @CurrentDate BETWEEN cct.valid_from AND ISNULL(cct.valid_to, '31/12/2199');

 DECLARE @LegacySupporter TABLE 
(contact_number int NOT NULL PRIMARY KEY,
activity VARCHAR(6),
LegacyHierarchy int, 
LegacyHierarchyDesc VARCHAR(40),
valid_from DATETIME)

INSERT INTO @LegacySupporter (contact_number, activity, LegacyHierarchy, LegacyHierarchyDesc, valid_from)

SELECT   leg.contact_number
		,leg.activity
		,leg.LegacyHierarchy
		,leg.activity_desc	AS LegacyHierarchyDesc
		,leg.valid_from
FROM	 @Legacy			leg
WHERE	 leg.LegacyHierarchy = (SELECT	MIN(l.LegacyHierarchy)
								FROM	@Legacy	l
								WHERE	l.contact_number = leg.contact_number);

------------------------------------------------------------------------------------------------------------------------------------------------
--SELECTION
------------------------------------------------------------------------------------------------------------------------------------------------


 SELECT DISTINCT  '' as title
				 ,'' as initials
				 ,'' as forename
				 ,'' as preferred_forename
				 ,'' as surname
				 ,'' as label_name
				 ,0  as CISContactNumber
				 ,'' as honorifics
				 ,'' as salutation
				 ,NULL as dob
				 ,NULL  as Age
				 ,'' as isUnder18 
				 ,'' as [age_band]
				 ,'' as sex
				 ,'' AS LengthOfRelationshipId
				 ,'' AS LengthOfRelationship -- Am assuming source_date is when they're entered the system
				 ,'' as EthnicityId
				 ,'' as EthnicityTypeDesc
				 ,'' as DiabetesTypeValue
				 ,'' as DiabetesTypeDesc
				 ,'' as [source]
				 ,'' as source_date 
				 ,'' as [status]
				 ,'' as status_date
				 ,'' as status_reaso
				 ,'' as contact_type	
				 ,'' as ownership_group
				 ,'' as branch
				 , 0 AS IsActiveMembership
				 , 0 AS IsActiveRegularGiving
				 , 0 AS IsActiveWeeklyLottery
				 , 0 AS IsActiveCash
				 , 0 AS IsActiveRaffle
				 , 0 AS IsActiveFreePrizeDraw
				 , 0 AS IsActiveInMemory
				 , 0 AS IsActivePayrollGiving
				 , 0 AS ActiveFinancialRelationships
				 , 0.00  AS CommittmentValue
				 , 0 AS CommittmentValueId
				 ,'' AS CommittmentValueDesc
				 , 0.00  AS CommittmentValueMembership
				 , 0.00  AS CommittmentValueRegularGiving
				 , 0.00  AS CommittmentValueWeeklyLottery	 
				 , 0.00  AS PrevYearTransactionAmount
				 , 0.00  AS Prev2YearTransactionAmount
				 , 0.00  AS Prev3YearTransactionAmount
				 , 0.00  AS Prev4YearTransactionAmount
				 , 0.00  AS Prev5YearTransactionAmount						
				 , 0.00  AS TotalTransactionAmount
				 , 0 AS LastPaymentTimeframeId	 
				 ,'' AS LastPaymentTimeframeDesc
				 ,'' as LegacyHierarchy
				 ,'' as LegacyHierarchyDesc
				 ,GETDATE() as [DW_LoadDate]

	UNION ALL 


SELECT		 ISNULL(t.title, '') as title
			, ISNULL(t.initials, '') as initials
			, ISNULL(t.forenames, '') as forename
			, ISNULL(t.Preferred_forename, '') as preferred_forename
			, t.surname
			, t.label_name
			, t.contact_number as CISContactNumber
			, ISNULL(t.honorifics, '')  as honorifics
			, t.salutation
			, COALESCE(t.date_of_birth, NULLIF([birth_date], '1899-12-30'))  as dob
			, FLOOR(DATEDIFF(dd, COALESCE(t.date_of_birth, NULLIF([birth_date], '1899-12-30')), COALESCE( CASE WHEN t.status <> 'DE' THEN NULL ELSE status_date END, GETDATE()))/365.23076923074) as Age
			, (CASE WHEN FLOOR(DATEDIFF(dd,  COALESCE(t.date_of_birth, NULLIF([birth_date], '1899-12-30')), COALESCE(status_date, GETDATE()))/365.23076923074) <= 18 then 1 else 0 END) as isUnder18 
			, ab.[age_band]
			, t.sex
			,CASE
			WHEN DATEDIFF(m, t.source_date, GETDATE()) <= 12 THEN 1
			WHEN DATEDIFF(m, t.source_date, GETDATE()) BETWEEN 13 AND 24 THEN 2
			WHEN DATEDIFF(m, t.source_date, GETDATE()) BETWEEN 25 AND 36 THEN 3
			WHEN DATEDIFF(m, t.source_date, GETDATE()) BETWEEN 37 AND 48 THEN 4
			WHEN DATEDIFF(m, t.source_date, GETDATE()) BETWEEN 49 AND 60 THEN 5
			WHEN DATEDIFF(m, ISNULL(t.source_date, GETDATE()), GETDATE()) > 60 THEN 6
			ELSE 7
			 END AS LengthOfRelationshipId
			,CASE
			WHEN DATEDIFF(m, t.source_date, GETDATE()) <= 12 THEN '0-12'
			WHEN DATEDIFF(m, t.source_date, GETDATE()) BETWEEN 13 AND 24 THEN '13-24'
			WHEN DATEDIFF(m, t.source_date, GETDATE()) BETWEEN 25 AND 36 THEN '25-36'
			WHEN DATEDIFF(m, t.source_date, GETDATE()) BETWEEN 37 AND 48 THEN '37-48'
			WHEN DATEDIFF(m, t.source_date, GETDATE()) BETWEEN 49 AND 60 THEN '49-60'
			WHEN DATEDIFF(m, ISNULL(t.source_date, GETDATE()), GETDATE()) > 60 THEN '60+'
			ELSE 'Unknown'
			 END AS LengthOfRelationship -- Am assuming source_date is when they're entered the system
			, ISNULL(eth.EthnicityId, '') as EthnicityId
			, ISNULL(eth.EthnicityTypeDesc, '') as EthnicityTypeDesc
			, ISNULL(dia.DiabetesTypeValue, '') as DiabetesTypeValue
			, ISNULL(dia.DiabetesTypeDesc, '') as DiabetesTypeDesc
			, t.[source]
			, t.source_date 
			, ISNULL(t.[status], '') as [status]
			, ISNULL(t.status_date, '')    as status_date
			, ISNULL(t.status_reason, '')    as status_reaso
			, t.contact_type	
			, t.ownership_group
			, ISNULL(t1.branch, '')    as branch
			,CASE
			WHEN mbr.Membership > 1
			THEN 1
			ELSE ISNULL(mbr.Membership, 0)
		 END AS IsActiveMembership
		,CASE
			WHEN rgg.RegularGiving > 1
			THEN 1
			ELSE ISNULL(rgg.RegularGiving, 0)
		 END AS IsActiveRegularGiving
		,CASE
			WHEN wkl.WeeklyLottery > 1
			THEN 1
			ELSE ISNULL(wkl.WeeklyLottery, 0)
		 END AS IsActiveWeeklyLottery
		,ISNULL(csh.Cash, 0) AS IsActiveCash
		,ISNULL(raf.Raffle, 0) AS IsActiveRaffle
		,ISNULL(fpd.FreePrizeDraw, 0) AS IsActiveFreePrizeDraw
		,ISNULL(mem.InMemory, 0) AS IsActiveInMemory
		,CASE
			WHEN prg.PayrollGiving > 1
			THEN 1
			ELSE ISNULL(prg.PayrollGiving, 0)
		 END AS IsActivePayrollGiving
		,ISNULL(afr.ActiveFinancialRelationships, 0)
		+ ISNULL(csh.Cash, 0)
		+ ISNULL(raf.Raffle, 0)
		+ ISNULL(fpd.FreePrizeDraw, 0)
		+ CASE
			WHEN prg.PayrollGiving > 1
			THEN 1
			ELSE ISNULL(prg.PayrollGiving, 0)
		  END
		+ CASE
			WHEN leg.LegacyHierarchy IN (1, 2)
			THEN 1
			ELSE 0
		  END AS ActiveFinancialRelationships
		,ISNULL(afr.CommittmentValue, 0.00)				AS CommittmentValue
		,CASE
			WHEN ISNULL(afr.CommittmentValue, 0.00) BETWEEN 0.00 AND 20.00	THEN 1
			WHEN afr.CommittmentValue BETWEEN 20.01 AND 50.00	THEN 2
			WHEN afr.CommittmentValue BETWEEN 50.01 AND 100.00	THEN 3
			WHEN afr.CommittmentValue BETWEEN 100.01 AND 200.00 THEN 4
			WHEN afr.CommittmentValue >= 200.01					THEN 5
			ELSE 1
		 END AS CommittmentValueId
		,CASE
			WHEN ISNULL(afr.CommittmentValue, 0.00) BETWEEN 0.00 AND 20.00	THEN '0 - 20'
			WHEN afr.CommittmentValue BETWEEN 20.01 AND 50.00	THEN '20 - 50'
			WHEN afr.CommittmentValue BETWEEN 50.01 AND 100.00	THEN '50 - 100'
			WHEN afr.CommittmentValue BETWEEN 100.01 AND 200.00 THEN '100 - 200'
			WHEN afr.CommittmentValue >= 200.01					THEN '200+'
			ELSE '0 - 20'
		 END AS CommittmentValueDesc
		,ISNULL(afr.CommittmentValueMembership, 0.00)		AS CommittmentValueMembership
		,ISNULL(afr.CommittmentValueRegularGiving, 0.00)	AS CommittmentValueRegularGiving
		,ISNULL(afr.CommittmentValueWeeklyLottery, 0.00)	AS CommittmentValueWeeklyLottery	 
		,ISNULL(fht.PrevYearTransactionAmount, 0.00)	AS PrevYearTransactionAmount
		,ISNULL(fht.Prev2YearTransactionAmount, 0.00)	AS Prev2YearTransactionAmount
		,ISNULL(fht.Prev3YearTransactionAmount, 0.00)	AS Prev3YearTransactionAmount
		,ISNULL(fht.Prev4YearTransactionAmount, 0.00)	AS Prev4YearTransactionAmount
		,ISNULL(fht.Prev5YearTransactionAmount, 0.00)	AS Prev5YearTransactionAmount						
		,ISNULL(fht.TotalTransactionAmount, 0.00)		AS TotalTransactionAmount
		,CASE
			WHEN t.contact_type in ('o','j')
			THEN 1
			WHEN ISNULL(fht.PrevYearTransactionAmount, 0.00) + ISNULL(fht.Prev2YearTransactionAmount, 0.00) > 0.00
			THEN 2
			WHEN ISNULL(fht.Prev3YearTransactionAmount, 0.00) + ISNULL(fht.Prev4YearTransactionAmount, 0.00) + ISNULL(fht.Prev5YearTransactionAmount, 0.00) > 0.00
			THEN 3
			WHEN ISNULL(fht.TotalTransactionAmount, 0.00) - (ISNULL(fht.PrevYearTransactionAmount, 0.00) + ISNULL(fht.Prev2YearTransactionAmount, 0.00) + ISNULL(fht.Prev3YearTransactionAmount, 0.00) + ISNULL(fht.Prev4YearTransactionAmount, 0.00) + ISNULL(fht.Prev5YearTransactionAmount, 0.00)) > 0.00
			THEN 4
			WHEN ISNULL(fht.TotalTransactionAmount, 0.00) = 0.00
			THEN 5
			ELSE 5
		 END AS LastPaymentTimeframeId	 
		,CASE
			WHEN t.contact_type in ('o','j')
			THEN 'Ex - Staff/Orgs'
			WHEN ISNULL(fht.PrevYearTransactionAmount, 0.00) + ISNULL(fht.Prev2YearTransactionAmount, 0.00) > 0.00
			THEN '<= 2yrs'
			WHEN ISNULL(fht.Prev3YearTransactionAmount, 0.00) + ISNULL(fht.Prev4YearTransactionAmount, 0.00) + ISNULL(fht.Prev5YearTransactionAmount, 0.00) > 0.00
			THEN '2 - 5yrs'
			WHEN ISNULL(fht.TotalTransactionAmount, 0.00) - (ISNULL(fht.PrevYearTransactionAmount, 0.00) + ISNULL(fht.Prev2YearTransactionAmount, 0.00) + ISNULL(fht.Prev3YearTransactionAmount, 0.00) + ISNULL(fht.Prev4YearTransactionAmount, 0.00) + ISNULL(fht.Prev5YearTransactionAmount, 0.00)) > 0.00
			THEN '> 5yrs'
			WHEN ISNULL(fht.TotalTransactionAmount, 0.00) = 0.00
			THEN 'Never Given'
			ELSE 'Never Given'
		 END AS LastPaymentTimeframeDesc
		,leg.LegacyHierarchy
		,leg.LegacyHierarchyDesc
		,GETDATE() as [DW_LoadDate]


				FROM [DiabetesDWH].[cis].[contacts] t   -- where is contacts  C not O
				LEFT OUTER JOIN [DiabetesDWH].[wft].[DOB_and_Age_Bands] ab ON t.contact_number = ab.contact_number
				LEFT OUTER JOIN [DiabetesDWH].[custom].[cis_contact_to_nation] t1 ON t.contact_number = t1.contact_number
				LEFT OUTER JOIN 

				(SELECT   eth.contact_number
					,ISNULL(etv.activity_value, 'ZZ')			AS EthnicityId
					,ISNULL(etv.activity_value_desc, 'Unknown') AS EthnicityTypeDesc
			FROM	 [DiabetesDWH].[cis].[contact_categories]				eth
					 LEFT OUTER JOIN
					 [DiabetesDWH].[cis].[activity_values]				etv 
					 ON  eth.activity = etv.activity
					 AND eth.activity_value = etv.activity_value
			WHERE	 eth.activity = 'ETHN'
			AND		 eth.valid_to >= GETDATE()
			AND		 eth.valid_from = (SELECT	MAX(c.valid_from)
										FROM	[DiabetesDWH].[cis].[contact_categories] c
										WHERE	c.contact_number = eth.contact_number
										AND		c.activity = 'ETHN'
										AND		c.valid_to >= GETDATE())

			) eth ON t.contact_number = eth.contact_number
			LEFT OUTER JOIN (
			SELECT   distinct cct.contact_number
					,CASE
						WHEN cct.activity_value = '1'	THEN '1'
						WHEN cct.activity_value = '2'	THEN '2'
						WHEN cct.activity_value = 'DH'	THEN '3'
						WHEN cct.activity_value = 'DK'	THEN '4'
						WHEN cct.activity_value = 'NG'	THEN '5'
						WHEN cct.activity_value = 'OT'	THEN '6'
						ELSE '7'
					 END AS DiabetesTypeId
					,cct.activity_value	AS DiabetesTypeValue
					,CASE
						WHEN cct.activity_value = '1'	THEN 'Type 1'
						WHEN cct.activity_value = '2'	THEN 'Type 2'
						WHEN cct.activity_value = 'DH'	THEN 'I do not have diabetes'
						WHEN cct.activity_value = 'DK'	THEN 'I do not know'
						WHEN cct.activity_value = 'NG'	THEN 'I would prefer not to say'
						WHEN cct.activity_value = 'OT'	THEN 'Other'
						ELSE 'Unknown'
					 END AS DiabetesTypeDesc
			FROM	 [DiabetesDWH].[cis].[contact_categories]				cct  
			WHERE	 cct.activity = 'DIAT'
			AND		 cct.valid_to >= GETDATE()
			AND		 cct.valid_from = (SELECT	MAX(c.valid_from)
										FROM	[DiabetesDWH].[cis].[contact_categories] c  
										WHERE	c.contact_number = cct.contact_number
										AND		c.activity = 'DIAT'
										AND		c.valid_to >= GETDATE())) dia

			ON t.contact_number = dia.contact_number
		 LEFT OUTER JOIN @LegacySupporter as leg ON leg.contact_number = t.contact_number
		 LEFT OUTER JOIN @Commitments as afr ON afr.contact_number = t.contact_number
		 LEFT OUTER JOIN @Tranhist as fht ON t.contact_number = fht.contact_number
		 LEFT OUTER JOIN @ProductCash as csh ON t.contact_number = csh.contact_number
		 LEFT OUTER JOIN @ProductRaffle as raf ON t.contact_number = raf.contact_number
		 LEFT OUTER JOIN @ProductFreePrizeDraw as fpd ON t.contact_number = fpd.contact_number
		 LEFT OUTER JOIN @ProductInMemory as mem ON t.contact_number = mem.contact_number
		 LEFT OUTER JOIN @ProductMembership	as mbr ON t.contact_number = mbr.contact_number
		 LEFT OUTER JOIN @ProductRegularGiving as rgg ON t.contact_number = rgg.contact_number
		 LEFT OUTER JOIN @ProductWeeklyLottery as wkl ON t.contact_number = wkl.contact_number
		 LEFT OUTER JOIN @ProductPayrollGiving as prg ON t.contact_number = prg.contact_number
	WHERE t.contact_type IN ('C', 'J')  and t.label_name <> 'N/A'

END