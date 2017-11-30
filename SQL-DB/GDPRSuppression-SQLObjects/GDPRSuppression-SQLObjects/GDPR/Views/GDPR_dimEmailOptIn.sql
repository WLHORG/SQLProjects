CREATE VIEW [GDPR].[GDPR_dimEmailOptIn]
AS  
WITH   cte_emailaddress AS (

		SELECT t.[contact_number], 
		t.amended_by, t.amended_on,[latest_email]
		FROM (
		SELECT [com].contact_number,[com].amended_by, [com].amended_on,   RANK() OVER(PARTITION BY [com].contact_number ORDER BY  [com].[amended_on] DESC ,[com].[number] ) AS [latest_email] 
		 FROM [DiabetesDWH].[cis].[communications] [com] 
		WHERE   [number] LIKE '%_@%'
			AND [number] NOT LIKE '@@%'
			AND  [contact_number] IS NOT NULL
			AND  [contact_number] > 0
		 ) t
			) ,


   cte_eoi
     AS (
     SELECT [sup].[contact_number]
          , [sup].[mailing_suppression]
          , [sup].[mailing_suppression_valid_from]
          , [sup].[mailing_suppression_valid_to]
          , [sup].[mailing_suppression_source]
          , [sup].[mailing_suppression_amended_by]
          --, [sup].[amended_by_specific]
          , [sup].[mailing_suppression_amended_on]
          , [sup].[mailing_suppression_notes]
          , [sup].[eoi_count]
		  , [sc].[source_desc]
		  , [sc].[amended_on]
		  , [sc].[cost_centre_team_desc]
		  , [sc].[cost_centre_activity_desc]
		  , [sc].[region_desc]
		  , [sc].[channel_desc]
		  , [sc].[Has_Sufficient_Campaign_Detail]
		  ,	[sc].[date_of_code]
		  , DATEDIFF(dd,  [sup].[mailing_suppression_amended_on], [sc].[amended_on]) AS SC_Diff
     FROM
     (
         SELECT [csp].[contact_number]
              ,  [csp].[valid_from]  AS [mailing_suppression_valid_from]
              ,  [csp].[valid_to]  AS [mailing_suppression_valid_to]
              , [csp].[mailing_suppression]
              , [csp].[source] AS [mailing_suppression_source]
              , [csp].[amended_by] AS [mailing_suppression_amended_by]
              --, CASE
              --      WHEN [emn].[specific_amended_by] IS NOT NULL
              --      THEN 1
              --      ELSE 0
              --  END AS [amended_by_specific]
              , [csp].[amended_on]   AS [mailing_suppression_amended_on]
              , CASE
                    WHEN [csp].[notes] LIKE '%Amended%'
                    THEN 1
                    ELSE 0
                END AS [mailing_suppression_notes]
              , ROW_NUMBER() OVER(PARTITION BY [contact_number] ORDER BY [valid_from] DESC) AS [eoi_row]
              , ROW_NUMBER() OVER(PARTITION BY [contact_number] ORDER BY [valid_from]) AS [eoi_count]
         FROM [DiabetesDWH].[cis].[contact_suppressions] AS [csp]
              --LEFT JOIN cte_email_amended AS [emn] ON [csp].[amended_by] = [emn].[specific_amended_by]
         WHERE [csp].[mailing_suppression] IN('EOI')
               AND GETDATE() BETWEEN [valid_from] AND [valid_to]
     ) AS [sup]
	 LEFT OUTER JOIN [GDPR].[GDPR_dimSources] sc ON sup.[mailing_suppression_source] = sc.new_source
     WHERE [eoi_row] = 1)
	  

     SELECT [eoi].[contact_number]
	     --, [eml].[amended_on]				  as email_amended_on
          , [msp].[mailing_suppression_desc]
          , [eoi].[mailing_suppression_valid_from]
          , [eoi].[mailing_suppression_valid_to]
          , [eoi].[mailing_suppression_source]
          , [eoi].[mailing_suppression_amended_on]
          , [eoi].[mailing_suppression_amended_by]
          --, [eoi].[amended_by_specific]
          , [eoi].[mailing_suppression_notes]
          , [eoi].[eoi_count]
		  , [eoi].[source_desc]
		  ,  [eoi].[amended_on]  
		  , [eoi].[cost_centre_team_desc]
		  , [eoi].[cost_centre_activity_desc]
		  , [eoi].[region_desc]
		  , [eoi].[channel_desc]
		  , [eoi].[Has_Sufficient_Campaign_Detail]
		  ,	[eoi].[date_of_code]
		  , [eoi].[SC_Diff]
		  , DATEDIFF(dd, eml.amended_on, eoi.[mailing_suppression_amended_on]) AS AmdedDiff
		  , CASE WHEN eml.amended_by = eoi.[mailing_suppression_amended_by] THEN 1 ELSE 0 END AS AmendMatch
	 
     FROM [cte_eoi] AS [eoi]
          INNER JOIN [DiabetesDWH].[cis].[mailing_suppressions] AS [msp] ON [eoi].[mailing_suppression] = [msp].[mailing_suppression]
		LEFT OUTER JOIN cte_emailaddress eml ON [eoi].[contact_number] = eml.contact_number
		WHERE latest_email  = 1