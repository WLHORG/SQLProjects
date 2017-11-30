--Blocked Opt_Outs
CREATE VIEW [GDPR].[GDPR_dimContactSuppressions]
AS 
SELECT DISTINCT
       [contact_number]
	   , [mailing_suppression]
	   ,  valid_from
	   ,  valid_to
	   , [source]
	   , CASE WHEN [mailing_suppression] IN ('JUN', 'DPA')  THEN 1 ELSE 0 END AS Blocked_OptOut
	   , CASE WHEN  [mailing_suppression] IN ('RNNE','EHCP','ELRT','EMD','IDLD','IEFD','IGUD','IGVD','ITOD', 'ADE', 'ECPO') THEN [mailing_suppression]  ELSE NULL END AS Alternative_OptIn
	   , [sc].[source_desc]
		, [sc].[amended_on]
		, [sc].[cost_centre_team_desc]
		, [sc].[cost_centre_activity_desc]
		, [sc].[region_desc]
		, [sc].[channel_desc]
		, [sc].[Has_Sufficient_Campaign_Detail]
		,	[sc].[date_of_code]

FROM [DiabetesDWH].[cis].[contact_suppressions] t
LEFT OUTER JOIN [GDPR].[GDPR_dimSources] sc ON t.[source] = sc.new_source
WHERE [mailing_suppression] IN('JUN'
                             , 'DPA'
							 , 'NMD'
                             , 'NRGB'
                             , 'NEMD'
                             , 'CELE'
							 , 'RNNE'
							 , 'EHCP'
							 , 'ELRT'
							 , 'EMD'
							 , 'IDLD'
							 , 'IEFD'
							 , 'IGUD'
							 , 'IGVD'
							 , 'ITOD'
							 , 'ADE'
							 , 'ECPO')
							 
     AND GETDATE() BETWEEN [valid_from] AND [valid_to]