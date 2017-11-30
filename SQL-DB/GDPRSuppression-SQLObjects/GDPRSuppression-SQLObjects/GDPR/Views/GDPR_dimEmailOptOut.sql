CREATE VIEW  [GDPR].[GDPR_dimEmailOptOut]
AS     
     
WITH cte_nec
     AS (
     SELECT [sup].[contact_number]
          , [sup].[mailing_suppression]
          , [sup].[mailing_suppression_valid_from]
          , [sup].[mailing_suppression_valid_to]
          , [sup].[mailing_suppression_source]
          , [sup].[mailing_suppression_amended_by]
          , [sup].[mailing_suppression_amended_on]
          , [sup].[mailing_suppression_notes]
          , [sup].[nec_count]
		   , [sc].[source_desc]
		  , [sc].[amended_on]
		  , [sc].[cost_centre_team_desc]
		  , [sc].[cost_centre_activity_desc]
		  , [sc].[region_desc]
		  , [sc].[channel_desc]
		  , [sc].[Has_Sufficient_Campaign_Detail]
		  ,	[sc].[date_of_code]
     FROM
     (
         SELECT [csp].[contact_number]
              ,  [csp].[valid_from]  AS [mailing_suppression_valid_from]
              ,  [csp].[valid_to]  AS [mailing_suppression_valid_to]
              , [csp].[mailing_suppression]
              , [csp].[source] AS [mailing_suppression_source]
              , [csp].[amended_by] AS [mailing_suppression_amended_by]
              ,  [csp].[amended_on]  AS [mailing_suppression_amended_on]
              , CASE
                    WHEN [csp].[notes] LIKE '%Amended%'
                    THEN 1
                    ELSE 0
                END AS [mailing_suppression_notes]
              , ROW_NUMBER() OVER(PARTITION BY [contact_number] ORDER BY [valid_from] DESC) AS [nec_row]
              , ROW_NUMBER() OVER(PARTITION BY [contact_number] ORDER BY [valid_from]) AS [nec_count]
         FROM [DiabetesDWH].[cis].[contact_suppressions] AS [csp]
         WHERE [csp].[mailing_suppression] IN('NEC')
               AND GETDATE() BETWEEN [csp].[valid_from] AND [csp].[valid_to]
     ) AS [sup]
	 LEFT OUTER JOIN [GDPR].[GDPR_dimSources] sc ON sup.[mailing_suppression_source] = sc.new_source
     WHERE [nec_row] = 1)


     SELECT [nec].[contact_number]
          , [msp].[mailing_suppression_desc]
          , [nec].[mailing_suppression_valid_from]
          , [nec].[mailing_suppression_valid_to]
          , [nec].[mailing_suppression_source]
          ,  [nec].[mailing_suppression_amended_on]   AS [mailing_suppression_amended_on]
          , [nec].[mailing_suppression_amended_by]
          , [nec].[mailing_suppression_notes]
		  , [nec].[source_desc]
		  ,  [nec].[amended_on] 
		  , [nec].[cost_centre_team_desc]
		  , [nec].[cost_centre_activity_desc]
		  , [nec].[region_desc]
		  , [nec].[channel_desc]
		  , [nec].[Has_Sufficient_Campaign_Detail]
		  ,	[nec].[date_of_code]
          , [nec].[nec_count]
     FROM [cte_nec] AS [nec]
          INNER JOIN  [DiabetesDWH].[cis].[mailing_suppressions] AS [msp] ON [nec].[mailing_suppression] = [msp].[mailing_suppression];