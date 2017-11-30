--NT	Do not contact by Telephone
--NSMS	Do not contact by Text Message
--SMS	Text Messaging Opt-in
--AGA	Gone Away - Agency Advised
--TOI	Telephone Opt-In
--DPA	Data Protection opt out


--Blocked Opt_Outs
CREATE VIEW [GDPR].[GDPR_dimSuppression_GoneAway]
AS 
SELECT DISTINCT
       [contact_number]
	   , [mailing_suppression]
	   ,  valid_from
	   ,  valid_to
	   , [source]
	   --, CASE WHEN [mailing_suppression] IN ('JUN', 'DPA')  THEN 1 ELSE 0 END AS Blocked_OptOut
	   --, CASE WHEN  [mailing_suppression] IN ('NMD' ,'NEMD','NNOM','NCB','NALL','NCL','NACQ','NFD','NDMX','DSN') THEN [mailing_suppression]  ELSE NULL END AS Alternative_OptIn
	   , [sc].[source_desc]
		, [sc].[amended_on]   AS [amended_on]
		, [sc].[cost_centre_team_desc]
		, [sc].[cost_centre_activity_desc]
		, [sc].[region_desc]
		, [sc].[channel_desc]
		, [sc].[Has_Sufficient_Campaign_Detail]
		,	[sc].[date_of_code]

FROM [DiabetesDWH].[cis].[contact_suppressions] t
LEFT OUTER JOIN [GDPR].[GDPR_dimSources] sc ON t.[source] = sc.new_source
WHERE [mailing_suppression] IN ('AGA')
 
							 
     AND GETDATE() BETWEEN [valid_from] AND [valid_to]