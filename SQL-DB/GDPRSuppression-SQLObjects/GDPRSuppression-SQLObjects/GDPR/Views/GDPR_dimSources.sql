CREATE VIEW  [GDPR].[GDPR_dimSources]
AS


SELECT [dns].[new_source]
     , [src].[source_desc]
     , [src].[amended_on]
     , [cct].[cost_centre_team_desc]
     , [cca].[cost_centre_activity_desc]
     , [reg].[region_desc]
     , [chn].[channel_desc]
     , CASE
           WHEN SUBSTRING([src].[source], 1, 1) = '0'
                OR SUBSTRING([src].[source], 2, 1) = 'X'
                OR SUBSTRING([src].[source], 7, 1) = 'X'
           THEN 'N'
           ELSE 'Y'
       END AS [Has_Sufficient_Campaign_Detail]
     , CAST(CASE
                WHEN SUBSTRING([dns].[new_source], 1, 1) LIKE '[A-Y]'
                     AND (SUBSTRING([dns].[new_source], 2, 1) LIKE '[0-9]'
                          OR SUBSTRING([dns].[new_source], 2, 1) LIKE '[ABC]')
                THEN CONCAT('01-',
                           (
                               SELECT [mth].[month_code_desc]
                               FROM [DiabetesDWH].[cis].[duk_month_codes] AS [mth]
                               WHERE [mth].[month_code] = SUBSTRING([dns].[new_source], 2, 1)
                           ), '-',
                           (
                               SELECT [yer].[year_code_desc]
                               FROM [DiabetesDWH].[cis].[duk_year_codes] AS [yer]
                               WHERE [yer].[year_code] = SUBSTRING([dns].[new_source], 1, 1)
                           ))
                WHEN SUBSTRING([dns].[new_source], 1, 1) LIKE '[A-Y]'
                     AND (SUBSTRING([dns].[new_source], 2, 1) NOT LIKE '[0-9]'
                          OR SUBSTRING([dns].[new_source], 2, 1) NOT LIKE '[ABC]')
                THEN CONCAT('31-Dec-',
                           (
                               SELECT [yer].[year_code_desc]
                               FROM [DiabetesDWH].[cis].[duk_year_codes] AS [yer]
                               WHERE [yer].[year_code] = SUBSTRING([dns].[new_source], 1, 1)
                           ))
                ELSE '31-Dec-9999'
            END AS DATE) AS [date_of_code]
FROM [DiabetesDWH].[cis].[duk_new2015_sources] AS [dns]
     INNER JOIN [DiabetesDWH].[cis].[sources] AS [src] ON [dns].[new_source] = [src].[source]
     LEFT JOIN [DiabetesDWH].[cis].[duk_cost_centre_teams] AS [cct] ON SUBSTRING([src].[source], 3, 1) = [cct].[cost_centre_team]
     LEFT JOIN [DiabetesDWH].[cis].[duk_cost_centre_activities] AS [cca] ON SUBSTRING([src].[source], 4, 2) = [cca].[cost_centre_activity]
     LEFT JOIN [DiabetesDWH].[cis].[duk_regions] AS [reg] ON SUBSTRING([src].[source], 6, 1) = [reg].[region]
     LEFT JOIN [DiabetesDWH].[cis].[duk_channels] AS [chn] ON SUBSTRING([src].[source], 7, 1) = [chn].[channel]
WHERE [dns].[new_source] = [dns].[source]
      AND [dns].[new_product] IS NULL
      AND [dns].[region] IS NULL