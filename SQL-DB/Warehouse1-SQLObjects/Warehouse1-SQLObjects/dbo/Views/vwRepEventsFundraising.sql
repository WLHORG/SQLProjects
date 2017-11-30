

CREATE VIEW [dbo].[vwRepEventsFundraising]
AS
SELECT	F.PK_ID
		, F.FK_Date
		, F.FK_Activity
		, F.FK_Team
		, F.FK_Channel
		, F.FK_Product
		, F.FK_PayMethod
		, F.FK_Contact
		, F.FK_Address
		, F.FK_FundRegion
		, F.FK_ContactRegion
		, F.FK_Organisation
		, F.FK_TranOrigin
		, F.FK_TranType
		, F.FK_Rate
		, F.FK_Orders
		, F.FK_Restriction
		, F.FK_Source
		, F.Amount
		, F.VAT
		, F.Quantity
		, F.GiftAid
		, F.WkLotteryActiveLine
		, F.DateLoad
		,	tm.cost_centre_team
FROM		dbo.Fundraising AS F 
INNER JOIN	dbo.DimDate AS d ON F.FK_Date = d.DateKey 
INNER JOIN	dbo.DimTeam AS tm ON F.FK_Team = tm.PK_ID
	--where	(tm.cost_centre_team = 'E') AND		allow user to choose CC team    SM
WHERE	(F.Amount <> 0) 
AND		(d.Date BETWEEN DATEADD(m, DATEDIFF(m, - 1, GETDATE()) - 2, 0) AND GETDATE())


