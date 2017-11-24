







CREATE VIEW [dbo].[vwRepEventsFundraisingCurrentMonthPreviousMonth]
AS
SELECT	contact_number
,	Contact_Type
,	label_name
,	source
,	area
,	area_desc
,	fundraising_region_desc
,	transaction_date
,	transaction_origin
,	cost_centre_activity
,	cost_centre_activity_desc
,	SUM(Amount) AS Amount
,	[10YrsGift]
,	NumberGifts10Yrs
,	cost_centre_team
FROM	(SELECT	COALESCE (NULLIF (c.CISContactNumber, 0), NULLIF (o.CISContactNumber, 0)) AS contact_number
				,	CASE WHEN f.FK_Contact = 1 THEN 'O' ELSE 'C' END AS Contact_Type, COALESCE (NULLIF (c.label_name, ''), NULLIF (o.label_name, 'N/A')) AS label_name
				,	s.source, ISNULL(NULLIF (r.rf_area, ''), 'Central') AS area
				,	ISNULL(NULLIF (r.rf_area_desc, ''), 'Central') AS area_desc
				,	r.fund_region_desc AS fundraising_region_desc, CONVERT(DATE, d.Date, 101) AS transaction_date
				,	ISNULL(NULLIF (t.transaction_origin_desc, 'N/A'),'Other') AS transaction_origin
				,	a.cost_centre_activity
				,	a.cost_centre_activity_desc
				,	f.Amount
				,	tot.SUMAMOUNT AS [10YrsGift]
				,	tot.CNTAMNT AS NumberGifts10Yrs
				,	tm.cost_centre_team
				FROM		dbo.Fundraising AS f 
			INNER JOIN	dbo.DimContact AS c ON f.FK_Contact = c.PK_ID 
			INNER JOIN	dbo.DimOrganisation AS o ON f.FK_Organisation = o.PK_ID 
			INNER JOIN	dbo.DimRegion AS r ON f.FK_ContactRegion = r.PK_ID
			INNER JOIN	dbo.DimSource AS s ON f.FK_Source = s.PK_ID
			INNER JOIN	dbo.DimActivity AS a ON f.FK_Activity = a.PK_ID
			INNER JOIN	dbo.DimDate AS d ON f.FK_Date = d.DateKey
			INNER JOIN	dbo.DimTranOrigin AS t ON f.FK_TranOrigin = t.PK_ID
			INNER JOIN	dbo.DimTeam AS tm ON f.FK_Team = tm.PK_ID
			INNER JOIN	(	SELECT	FK_Contact
								, FK_Organisation
								, SUM(Amount) AS SUMAMOUNT
								, COUNT(Amount) AS CNTAMNT
						FROM	dbo.Fundraising AS f
						WHERE	(FK_Date >= FK_Date - 100000) 
						AND (Amount <> 0)
						GROUP BY FK_Contact, FK_Organisation) AS tot ON f.FK_Contact = tot.FK_Contact AND f.FK_Organisation = tot.FK_Organisation
			WHERE	(d.[date] BETWEEN DATEADD(m, - 1, DATEADD(m, DATEDIFF(m, 0, GETDATE()), 0)) AND EOMONTH(GETDATE())) 
			-- AND		(tm.cost_centre_team = 'E')			--  user can choose between E and F		SM
			AND		(f.Amount <> 0)) AS sub
			GROUP BY contact_number
				,	Contact_Type
				,	label_name
				,	source
				,	area
				,	area_desc
				,	fundraising_region_desc
				,	transaction_date
				,	transaction_origin
				,	cost_centre_activity
				,	cost_centre_activity_desc                         
				,	[10YrsGift]
				,	NumberGifts10Yrs
				,	cost_centre_team
			HAVING	(SUM(Amount) > 0)








