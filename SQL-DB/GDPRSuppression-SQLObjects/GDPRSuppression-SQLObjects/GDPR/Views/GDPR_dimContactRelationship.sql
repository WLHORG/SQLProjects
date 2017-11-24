CREATE VIEW [GDPR].[GDPR_dimContactRelationship]
AS

--[#IndividualGiving] 
WITH cte_IndividualGiving
     AS (
     SELECT DISTINCT
            [pfh].[contact_number]
          , CASE
                WHEN [pfh].[product_top_level] LIKE 'Supporting%'
                THEN '3 - Supporting Membership'
                WHEN [pfh].[product_top_level] LIKE 'Regular%'
                THEN '4 - Regular Giving'
                WHEN [pfh].[product_top_level] LIKE 'Weekly%'
                THEN '5 - Weekly Lottery'
                WHEN [pfh].[product_top_level] LIKE 'Cash%'
                THEN '6 - Cash'
                WHEN [pfh].[product_top_level] LIKE 'Raffle%'
                THEN '7 - Raffle'
                WHEN [pfh].[product_top_level] LIKE 'Fundraising_Events%'
                THEN '8 - Fundraising Events'
                WHEN [pfh].[product_top_level] LIKE 'Community%'
                THEN '9 - Community Fundraising'
                WHEN [pfh].[product_top_level] LIKE 'Prize_Draw%' --LJS20171024 - Space in 'Prize Draw' in original replaced with '_' here.
                THEN '10 - Prize Draw'
                WHEN [pfh].[product_top_level] LIKE 'Payroll%'
                THEN '11 - Payroll Giving'
                WHEN [pfh].[product_top_level] LIKE 'Professional%'
                THEN '12 - Professional Membership'
                WHEN [pfh].[product_top_level] LIKE 'Trading%'
                THEN '14 - Trading'
                ELSE 'Other'
            END AS [activity]
			
          , MAX([pfh].[transaction_date]) AS [last]
          , MIN([pfh].[transaction_date]) AS [first]
          , MAX([fhm].[order_cancellation_date]) AS [order_cancelled]
--INTO [#IndividualGiving]
     FROM [DiabetesDWH].[OneSupporterSSV].[Product_Aggregation_Financial_History] AS [pfh]
          INNER JOIN [DiabetesDWH].[wft].[wft_financial_history_merge] AS [fhm] ON [pfh].[batch_number] = [fhm].[batch_number]
                                                                                             AND [pfh].[transaction_number] = [fhm].[transaction_number]
                                                                                             AND [pfh].[line_number] = [fhm].[line_number]
     WHERE [pfh].[amount] > 0
           OR [product_top_level] LIKE 'Prize_Draw%'                                     --LJS20171024 - Space in 'Prize Draw' in original replaced with '_' here.
     GROUP BY [pfh].[contact_number]
            , CASE
                  WHEN [pfh].[product_top_level] LIKE 'Supporting%'
                  THEN '3 - Supporting Membership'
                  WHEN [pfh].[product_top_level] LIKE 'Regular%'
                  THEN '4 - Regular Giving'
                  WHEN [pfh].[product_top_level] LIKE 'Weekly%'
                  THEN '5 - Weekly Lottery'
                  WHEN [pfh].[product_top_level] LIKE 'Cash%'
                  THEN '6 - Cash'
                  WHEN [pfh].[product_top_level] LIKE 'Raffle%'
                  THEN '7 - Raffle'
                  WHEN [pfh].[product_top_level] LIKE 'Fundraising_Events%'
                  THEN '8 - Fundraising Events'
                  WHEN [pfh].[product_top_level] LIKE 'Community%'
                  THEN '9 - Community Fundraising'
                  WHEN [pfh].[product_top_level] LIKE 'Prize_Draw%' --LJS20171024 - Space in 'Prize Draw' in original replaced with '_' here.
                  THEN '10 - Prize Draw'
                  WHEN [pfh].[product_top_level] LIKE 'Payroll%'
                  THEN '11 - Payroll Giving'
                  WHEN [pfh].[product_top_level] LIKE 'Professional%'
                  THEN '12 - Professional Membership'
                  WHEN [pfh].[product_top_level] LIKE 'Trading%'
                  THEN '14 - Trading'
                  ELSE 'Other'
              END), 
		 
--SELECT * FROM cte_IndividualGiving

     cte_IndividualGivingStatus
     AS (
--[#IndividualGivingStatus]
     SELECT [igv].[contact_number]
          , [igv].[activity]
		   , CASE
                WHEN [igv].[activity] LIKE  '3 - Supporting Membership'
                THEN 30
                WHEN [igv].[activity] LIKE  '4 - Regular Giving'
                THEN 40
                WHEN [igv].[activity] LIKE '5 - Weekly Lottery'
                THEN 50
                WHEN [igv].[activity] LIKE '6 - Cash'
                THEN 60
                WHEN [igv].[activity] LIKE '7 - Raffle'
                THEN 70
                WHEN [igv].[activity] LIKE '8 - Fundraising Events'
                THEN 80
                WHEN [igv].[activity] LIKE '9 - Community Fundraising'
                THEN 90
                WHEN [igv].[activity] LIKE '10 - Prize Draw'
                THEN 100
                WHEN [igv].[activity] LIKE '11 - Payroll Giving'
                THEN 110
                WHEN [igv].[activity] LIKE '12 - Professional Membership'
                THEN 120
                WHEN [igv].[activity] LIKE '14 - Trading'
                THEN 130
                ELSE 500
            END AS [act_sort]
		   , CASE
                WHEN [igv].[first] > DATEADD([yy], -1, GETDATE())
                     AND ([igv].[order_cancelled] IS NULL
                          OR [igv].[order_cancelled] < [last])
                THEN '1.  New'
                WHEN [igv].[first] <= DATEADD([yy], -1, GETDATE())
                     AND ([igv].[order_cancelled] IS NULL
                          OR [igv].[order_cancelled] < [last])
                     AND [igv].[last] > DATEADD([yy], -2, GETDATE())
                THEN '2.  Active'
                WHEN [igv].[first] <= DATEADD([yy], -1, GETDATE())
                     AND [igv].[last] > DATEADD([yy], -2, GETDATE())
                THEN '3.  Recently Lapsed'
                WHEN [igv].[first] <= DATEADD([yy], -1, GETDATE())
                     AND [igv].[last] > DATEADD([yy], -4, GETDATE())
                     AND ([igv].[activity] IN('Raffle', 'Cash', 'Prize Draw', 'Trading', 'Community Fundraising', 'Fundraising Events')
                          OR [igv].[activity] = 'Weekly Lottery'
                          AND [igv].[order_cancelled] IS NULL)
                THEN '3.  Recently Lapsed'
                ELSE '4.  Long Lapsed'
            END AS [status]
          , NULL AS [Last_NonFinEngagement_Interaction_Date]
          , NULL AS [Contact_Source_Date]
--INTO [#IndividualGivingStatus]
     FROM [cte_IndividualGiving] AS [igv]),
--SELECT * FROM cte_IndividualGiving

---------------------------------------------------------------------------------------------------
----------------------End Individual Giving--------------------------------------------------------
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
----------------------Legacies---------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
     cte_Legacies
     AS (
--[#Legacies]
     SELECT [cct].[contact_number]
          , [cct].[valid_to]
          , [cct].[valid_from]
          , CASE
                WHEN [cct].[activity] = 'LP'
                     OR [cct].[activity] = 'LEGMK'
                     AND [cct].[activity_value] = 'PLE'
                THEN '1. Legacy Pledger'
                WHEN [cct].[activity] = 'LPI'
                     OR [cct].[activity] = 'LEGMK'
                     AND [cct].[activity_value] = 'IND'
                THEN '2. Legacy Pledge Intender'
                WHEN [cct].[activity] = 'LE'
                     OR [cct].[activity] = 'LEGMK'
                     AND [cct].[activity_value] = 'ENQ'
                THEN '3. Legacy Enquirer'
                WHEN [cct].[activity] = 'LEGCON'
                     OR [cct].[activity] = 'LEGEVT'
                     OR [cct].[activity] = 'LEGMA'
                     OR [cct].[activity] LIKE 'LY%'
                     OR [cct].[activity] = 'LEGMK'
                     AND [cct].[activity_value] = 'CONS'
                THEN '4. Legacy Connection'
            END AS [type]
--INTO [#Legacies]
     FROM [DiabetesDWH].[cis].[contact_categories] AS [cct]
     WHERE [cct].[activity] IN('LP'
                             , 'LPI'
                             , 'LE'
                             , 'LEGCON'
                             , 'LEGMK'
                             , 'LEGEVT'
                             , 'LEGMA')
           OR [cct].[activity] LIKE 'LY%'
     UNION
     SELECT [dlg].[contact_number]
          , [evt].[start_date]
          , [evt].[start_date]
          , '4. Legacy Connection'
     FROM [DiabetesDWH].[cis].[delegates] AS [dlg]
          INNER JOIN [DiabetesDWH].[cis].[events] AS [evt] ON [dlg].[event_number] = [evt].[event_number]
                                                                        AND [evt].[event_desc] LIKE '%Legacy%'),

--SELECT * FROM cte_Legacies

     cte_LegacyGrouping
     AS (
--[#LegacyGrouping]
     SELECT DISTINCT
            [lgc].[contact_number]
          , MIN([lgc].[valid_from]) AS [first]
          , MAX([lgc].[valid_to]) AS [last]
--INTO [#LegacyGrouping]
     FROM [cte_Legacies] AS [lgc]
     GROUP BY [lgc].[contact_number]
--ORDER BY [lgc].[contact_number]
     ),
     cte_LegacyStatus
     AS (
--[#legacycontactability]
     SELECT [lgr].[contact_number]
          , CASE
                WHEN [lgr].[first] > DATEADD([yy], -1, GETDATE())
                     AND [lgr].[last] >= GETDATE()
                THEN '1.  New'
                WHEN [lgr].[first] <= DATEADD([yy], -1, GETDATE())
                     AND [lgr].[last] >= GETDATE()
                THEN '2.  Active'
                WHEN [lgr].[first] <= DATEADD([yy], -1, GETDATE())
                     AND [lgr].[last] < DATEADD([yy], -2, GETDATE())
                THEN '3.  Recently Lapsed'
                ELSE '4.  Long Lapsed'
            END AS [status]
          , NULL AS [Last_NonFinEngagement_Interaction_Date]
          , NULL AS [Contact_Source_Date]
--INTO [#LegacyStatus]
     FROM [cte_LegacyGrouping] AS [lgr]
--ORDER BY [lgr].[contact_number]
     ),
---------------------------------------------------------------------------------------------------
----------------------End Legacies-----------------------------------------------------------------
---------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------
----------------------Major Supporters-------------------------------------------------------------
---------------------------------------------------------------------------------------------------
     cte_MajorSupporters
     AS (
--[#MajorSupporters]
     SELECT DISTINCT
            [p].[contact_number]
          , '1 - Major Supporters' AS [activity]
		  , 10 AS [act_sort]
          , MAX([p].[transaction_date]) AS [last]
          , MIN([p].[transaction_date]) AS [first]
--INTO [#MajorSupporters]
     FROM [DiabetesDWH].[OneSupporterSSV].[Product_Aggregation_Financial_History] AS [p]
     WHERE [p].[product_top_level] LIKE 'Major_Supporters%'
     GROUP BY [p].[contact_number]),


     cte_MajorSupportersStatus
     AS (
--Active – last gift given within the last 3 years
--Lapsed – Last gift given between 3 and 5 years ago
--Long-Lapsed – Last gift given over 5 years ago
--[#MajorSupportersStatus]
     SELECT [mjs].[contact_number]
          , [mjs].[activity]
		  ,  [mjs].[act_sort]
          , CASE
                WHEN [mjs].[last] BETWEEN DATEADD([yy], -3, GETDATE()) AND GETDATE()
                THEN '2.  Active'
                WHEN [mjs].[last] BETWEEN DATEADD([yy], -5, GETDATE()) AND DATEADD([yy], -3, GETDATE())
                THEN '3.  Recently Lapsed'
                ELSE '4.  Long Lapsed'
            END AS [status]
          , NULL AS [Last_NonFinEngagement_Interaction_Date]
          , NULL AS [Contact_Source_Date]
--INTO [#MajorSupportersStatus]
     FROM [cte_MajorSupporters] AS [mjs]), 
---------------------------------------------------------------------------------------------------
----------------------End Major Supporters---------------------------------------------------------
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
----------------------Non Financial Engagement-----------------------------------------------------
---------------------------------------------------------------------------------------------------

     cte_NonFinancialEngagement
     AS (
--Healthcare Professional
     SELECT [Contact_Number]
          , '13 - Healthcare Professional' AS [Activity]
		  , 130 AS [act_sort]
     --, CASE
     --      WHEN [Active_HCP] = 'Yes'
     --      THEN '2. Active'
     --      ELSE '3. Lapsed'
     --  END AS [Status]
          , NULL AS [Status]
          , [Last_HCP_Interaction] AS [Last_NonFinEngagement_Interaction_Date]
          , NULL AS [Contact_Source_Date]
--INTO #NonFinancialEngagementStatus
     FROM [DiabetesDWH].[OneSupporterSSV].[Non_Financial_Engagement]
     WHERE [HCP_Interactions_Ever] >= 1
     UNION ALL
--Volunteer
     SELECT [Contact_Number]
          , '15 - Volunteer' AS [Activity]
		  , 150  AS [act_sort]
     --, CASE
     --      WHEN [Active_HCP] = 'Yes'
     --      THEN '2. Active'
     --      ELSE '3. Lapsed'
     --  END AS [Status]
          , NULL AS [Status]
          , [Last_Volunteering_Interaction] AS [Last_NonFinEngagement_Interaction_Date]
          , NULL AS [Contact_Source_Date]
     FROM [DiabetesDWH].[OneSupporterSSV].[Non_Financial_Engagement]
     WHERE [Volunteering_Interactions_Ever] >= 1
     UNION ALL
--Campaigner
     SELECT [Contact_Number]
          , '16 - Campaigner' AS [Activity]
		  , 160 AS [act_sort]
     --, CASE
     --      WHEN [Active_HCP] = 'Yes'
     --      THEN '2. Active'
     --      ELSE '3. Lapsed'
     --  END AS [Status]
          , NULL AS [Status]
          , [Last_Campaign_Interaction] AS [Last_NonFinEngagement_Interaction_Date]
          , NULL AS [Contact_Source_Date]
     FROM [DiabetesDWH].[OneSupporterSSV].[Non_Financial_Engagement]
     WHERE [Campaign_Interactions_Ever] >= 1),

---------------------------------------------------------------------------------------------------
----------------------End Non Financial Engagement-------------------------------------------------
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
----------------------Beneficiaries----------------------------------------------------------------
---------------------------------------------------------------------------------------------------

     cte_beneficiaries
     AS (
     SELECT [con].[contact_number]
          , '17 - Beneficiary - LEAD GENERATION' AS [activity]
		  , 170 AS act_sort
          , NULL AS [status]
          , NULL AS [Last_NonFinEngagement_Interaction_Date]
          , [con].[source_date] AS [Contact_Source_Date]
--into #BeneficiariesStatus
     FROM [DiabetesDWH].[cis].[contacts] AS [con]
     WHERE [source] IN('0XARGXLCK'					 --Pedometer campaigns
                     , 'PXMMAXP01'						 --100 Things campaign
                     , 'Q5DDLXP00')					 --Engagement campaign
           OR [source] LIKE 'P5MMAXU%'				 --100 Things campaign
     UNION
     SELECT [con].[contact_number]
          , '17 - Beneficiary - F2F ENGAGEMENT' AS [activity]
		  , 170 AS act_sort
          , NULL AS [status]
          , NULL AS [Last_NonFinEngagement_Interaction_Date]
          , [con].[source_date] AS [Contact_Source_Date]
     FROM [DiabetesDWH].[cis].[contacts] AS [con]
     WHERE [con].[source] IN
     (
         SELECT [source]
         FROM [DiabetesDWH].[cis].[sources]
         WHERE [source_desc] LIKE '%LWDD%'				 --Living With Diabetes days
         UNION
         SELECT [source]
         FROM [DiabetesDWH].[cis].[sources]
         WHERE [source_desc] LIKE '%Weekend%'			 --Care Events & Family Weekends
               OR [source_desc] LIKE '%Family%'
               OR [source_desc] LIKE '%KidEvent%'
               OR [source_desc] LIKE '%Children%Event%'
               OR [source_desc] LIKE '%Young%Adult%'
               OR [source_desc] LIKE '%CEvent%'
               OR [source_desc] LIKE '%Care%Event%'
         UNION
         SELECT [source]								 --Regional Events
         FROM [DiabetesDWH].[cis].[sources]
         WHERE SUBSTRING([source], 7, 1) = 'E'
               AND SUBSTRING([source], 6, 1) <> 'X'
               AND SUBSTRING([source], 3, 3) = 'CHH'
         UNION
         SELECT [source]								 --Conferences
         FROM [DiabetesDWH].[cis].[sources]
         WHERE [source_desc] LIKE '%conf%'
               AND SUBSTRING([source], 4, 2) <> 'OH'
         UNION
         SELECT [source]								 --Foot Care Events
         FROM [DiabetesDWH].[cis].[sources]
         WHERE [source_desc] LIKE '%foot%'
               AND [source_desc] NOT LIKE '%football%'
     )
     UNION
     SELECT [con].[contact_number]
          , '17 - Beneficiary - NON-F2F ENGAGEMENT' AS [activity]
		  , 170 AS act_sort
          , NULL AS [status]
          , NULL AS [Last_NonFinEngagement_Interaction_Date]
          , [con].[source_date] AS [Contact_Source_Date]
     FROM [DiabetesDWH].[cis].[contacts] AS [con]
     WHERE [con].[source] IN
     (
         SELECT [source]								 --Advocacy, Helpline and CCC calls			 
         FROM [DiabetesDWH].[cis].[sources]
         WHERE SUBSTRING([source], 4, 2) IN('CC'
                                          , 'OP')
         UNION
         SELECT [source]								 --Diabetes and Me
         FROM [DiabetesDWH].[cis].[sources]
         WHERE [source_desc] LIKE '%Diabetes%&%Me%'
               OR [source_desc] LIKE '%Diabetes%and%Me%'
         UNION
         SELECT [source]								 --Peer Support
         FROM [DiabetesDWH].[cis].[sources]
         WHERE SUBSTRING([source], 4, 2) = 'OE'
         UNION
         SELECT [source]								 --eNews
         FROM [DiabetesDWH].[cis].[sources]
         WHERE [source] = '0SAWEB007'
     )
     UNION
     SELECT [con].[contact_number]
          , '17 - Beneficiary - RISK' AS [activity]
		  , 170 AS act_sort
          , NULL AS [status]
          , NULL AS [Last_NonFinEngagement_Interaction_Date]
          , [con].[source_date] AS [Contact_Source_Date]
     FROM [DiabetesDWH].[cis].[contacts] AS [con]
     WHERE SUBSTRING([con].[source], 4, 2) IN('GI'		 --Roadshows
                                            , 'GL'		 --Business development roadshows
                                            , 'GK'		 --BUPA roadshows
                                            , 'RA' 		 --Know Your Risk score
                                            , 'RB'		 --Know Your Risk score								
                                            , 'RS' 		 --Know Your Risk score
                                            , 'RT'		 --Know Your Risk score
     ))

---------------------------------------------------------------------------------------------------
----------------------End Beneficiaries------------------------------------------------------------
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
----------------------dimFinancialRelationship-----------------------------------------------------
---------------------------------------------------------------------------------------------------
     SELECT [Contact_Number]
          , [Activity] AS [Relationship]
		  , [act_sort]
		   , [Status] AS [Relationship_Status]
          , [Last_NonFinEngagement_Interaction_Date]
          , [Contact_Source_Date]
--INTO [#dimFinancialRelationship]
     FROM [cte_IndividualGivingStatus]
     WHERE [Activity] <> 'Other'
     UNION
     SELECT [contact_number]
          , '2 - Legacy'
		  , 2 AS [act_sort]
          , [status]
          , [Last_NonFinEngagement_Interaction_Date]
          , [Contact_Source_Date]
     FROM [cte_LegacyStatus]
     UNION
     SELECT [contact_number]
          , [activity]
		  , [act_sort]
          , [status]
          , [Last_NonFinEngagement_Interaction_Date]
          , [Contact_Source_Date]
     FROM [cte_majorsupportersstatus]
     UNION
     SELECT [contact_number]
          , [activity]
		  , [act_sort]
          , CAST([status] AS VARCHAR(100)) AS [status]
          , [Last_NonFinEngagement_Interaction_Date]
          , [Contact_Source_Date]
     FROM [cte_NonFinancialEngagement]
     UNION
     SELECT [contact_number]
          , [activity]
		  , [act_sort]
          , CAST([status] AS VARCHAR(100)) AS [status]
          , [Last_NonFinEngagement_Interaction_Date]
          , [Contact_Source_Date]
     FROM [cte_beneficiaries];

---------------------------------------------------------------------------------------------------
----------------------End dimFinancialRelationship-------------------------------------------------
---------------------------------------------------------------------------------------------------
--SELECT * FROM [#dimFinancialRelationship]