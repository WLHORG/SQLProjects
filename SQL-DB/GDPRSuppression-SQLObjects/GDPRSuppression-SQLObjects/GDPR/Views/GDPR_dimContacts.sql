CREATE VIEW [GDPR].[GDPR_dimContacts]
AS
SELECT t.contact_number, t.[source], t.source_date, t.[status], t.ownership_group, dt.activity_value_desc AS DiabetesType
, [sc].[source_desc]
		  , [sc].[amended_on]
		  , [sc].[cost_centre_team_desc]
		  , [sc].[cost_centre_activity_desc]
		  , [sc].[region_desc]
		  , [sc].[channel_desc]
		  , [sc].[Has_Sufficient_Campaign_Detail]
		  ,	[sc].[date_of_code]
FROM [DiabetesDWH].cis.contacts t
 LEFT OUTER JOIN [GDPR].[GDPR_dimSources] sc ON t.[source] = sc.new_source
LEFT OUTER JOIN (SELECT contact_number, Activity_value_desc FROM [DiabetesDWH].cis.contact_categories AS cct
INNER JOIN [DiabetesDWH].cis.activity_values AS acv ON cct.activity=acv.activity
AND cct. Activity_value=acv.activity_value
WHERE cct.activity = 'DIAT'
AND GETDATE() BETWEEN cct.valid_from AND cct.valid_to) dt  ON t.contact_number = dt.contact_number