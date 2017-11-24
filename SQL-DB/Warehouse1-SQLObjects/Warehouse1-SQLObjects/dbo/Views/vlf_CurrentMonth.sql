

CREATE VIEW [dbo].[vlf_CurrentMonth]
AS
SELECT	contact_number
, Contact_Type
, label_name
, source
, area
, area_desc
, fundraising_region_desc
, transaction_date
, transaction_origin
, cost_centre_activity
, cost_centre_activity_desc
, SUM(Amount) AS Amount
, [10YrsGift]
, NumberGifts10Yrs
FROM	(SELECT	COALESCE (NULLIF (c.CISContactNumber, 0), NULLIF (o.CISContactNumber, 0)) AS contact_number
			,	CASE WHEN f.FK_Contact = 1 THEN 'O' ELSE 'C' END AS Contact_Type
			,	COALESCE (NULLIF (c.label_name, ''), NULLIF (o.label_name, 'N/A')) AS label_name
			,	s.[source]
			,	ISNULL(NULLIF (r.rf_area, ''), 'Unspecified Region') AS area
			,	ISNULL(NULLIF (r.rf_area_desc, ''), 'Unspecified Region Area') AS area_desc
			,	r.fund_region_desc AS fundraising_region_desc
			,	CONVERT(DATE, d.Date, 101) AS transaction_date
			,	ISNULL(NULLIF (t.transaction_origin_desc, 'N/A'),'Other') AS transaction_origin
			,	a.cost_centre_activity
			,	a.cost_centre_activity_desc
			,	f.Amount
			,	tot.SUMAMOUNT AS [10YrsGift]
			,	tot.CNTAMNT AS NumberGifts10Yrs
		FROM		dbo.Fundraising AS f 
		INNER JOIN	dbo.DimContact AS c ON f.FK_Contact = c.PK_ID 
		INNER JOIN	dbo.DimOrganisation AS o ON f.FK_Organisation = o.PK_ID 
		INNER JOIN	dbo.DimRegion AS r ON f.FK_ContactRegion = r.PK_ID 
		INNER JOIN	dbo.DimSource AS s ON f.FK_Source = s.PK_ID 
		INNER JOIN	dbo.DimActivity AS a ON f.FK_Activity = a.PK_ID 
		INNER JOIN	dbo.DimDate AS d ON f.FK_Date = d.DateKey 
		INNER JOIN	dbo.DimTranOrigin AS t ON f.FK_TranOrigin = t.PK_ID 
		INNER JOIN	dbo.DimTeam AS tm ON f.FK_Team = tm.PK_ID 
		INNER JOIN	(SELECT FK_Contact
						, FK_Organisation
						, SUM(Amount) AS SUMAMOUNT
						, COUNT(Amount) AS CNTAMNT
						FROM	dbo.Fundraising AS f
						WHERE	(FK_Date >= FK_Date - 100000) 
						AND (Amount <> 0)
						GROUP BY FK_Contact, FK_Organisation) AS tot ON f.FK_Contact = tot.FK_Contact AND f.FK_Organisation = tot.FK_Organisation
		WHERE	(d.Date BETWEEN DATEADD(m, - 1, DATEADD(m, DATEDIFF(m, 0, GETDATE()), 0)) AND EOMONTH(GETDATE())) 
		AND		(tm.cost_centre_team = 'F') 
		AND		(f.Amount <> 0)
		AND		(a.[cost_centre_activity] <>'IF')) AS sub
GROUP BY	contact_number
, contact_type
, label_name
, [source]
, area
, area_desc
, fundraising_region_desc
, transaction_date
, transaction_origin
, cost_centre_activity
, cost_centre_activity_desc
, [10YrsGift]
, NumberGifts10Yrs
HAVING	(SUM(Amount) > 0)



GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[36] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "sub"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 275
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vlf_CurrentMonth';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vlf_CurrentMonth';

