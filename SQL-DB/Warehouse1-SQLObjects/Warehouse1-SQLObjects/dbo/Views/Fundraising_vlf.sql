
CREATE VIEW [dbo].[Fundraising_vlf]
AS
SELECT        F.PK_ID, F.FK_Date, F.FK_Activity, F.FK_Team, F.FK_Channel, F.FK_Product, F.FK_PayMethod, F.FK_Contact, F.FK_Address, F.FK_FundRegion, F.FK_ContactRegion, 
                         F.FK_Organisation, F.FK_TranOrigin, F.FK_TranType, F.FK_Rate, F.FK_Orders, F.FK_Restriction, F.FK_Source, F.Amount, F.VAT, F.Quantity, F.GiftAid, 
                         F.WkLotteryActiveLine, F.DateLoad
FROM            dbo.Fundraising AS F 
INNER JOIN dbo.DimDate AS d ON F.FK_Date = d.DateKey
INNER JOIN dbo.DimTeam AS tm ON F.FK_Team = tm.PK_ID
INNER JOIN	dbo.DimActivity AS a ON f.FK_Activity = a.PK_ID 
WHERE        (tm.cost_centre_team = 'F') 
AND		(a.[cost_centre_activity] <>'IF')
AND (F.Amount <> 0) 
AND (d.[Date] BETWEEN DATEADD(m, DATEDIFF(m, - 1, GETDATE()) - 2, 0) AND GETDATE())


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "F"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 274
               Bottom = 135
               Right = 487
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tm"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 248
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
      Begin ColumnWidths = 11
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Fundraising_vlf';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Fundraising_vlf';

