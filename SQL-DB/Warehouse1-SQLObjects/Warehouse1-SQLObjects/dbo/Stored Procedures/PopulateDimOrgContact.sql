-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimOrgContact]
AS
BEGIN

SELECT DISTINCT UPPER(c.label_name) as ContactName
, CAST((ISNULL((SELECT o.contact_number from  [DiabetesDWH].[cis].[contacts] o where contact_type = 'O' AND o.contact_number = c.contact_number), 0 )) as INT) as CISOrg_Number
,CAST((ISNULL((SELECT o.contact_number from  [DiabetesDWH].[cis].[contacts] o where contact_type IN ('C', 'J') AND o.contact_number = c.contact_number), 0 )) as INT) as  CISContact_Number,

CAST((REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(o.name, 'LTD', ''), 'LIMITED', ''), '&', 'AND'), '(GAYE)', ''), 'OLD', '')) as VARCHAR(200)) as OrgName,
 cr.[role],
 cr.is_active, 
 cr.valid_from as RoleValidFrom, 
 cr.valid_to as RoleValidTo, 
 cp.position,  
 cp.single_position,  
 cp.[current], 
 cp.[started] as PosValidFrom, 
 cp.[finished] as PosValidTo 
, getdate() as [DW_LoadDate] 
 FROM [DiabetesDWH].[cis].[contact_positions] cp
LEFT OUTER JOIN  [DiabetesDWH].[cis].[contact_roles] cr ON cp.contact_number = cr.contact_number AND cp.organisation_number = cr.organisation_number
INNER JOIN [DiabetesDWH].[cis].[contacts] c ON cp.contact_number = c.contact_number 
INNER JOIN [DiabetesDWH].[cis].[organisations] o on cp.organisation_number = o.organisation_number
WHERE (cr.[role] is not null AND cp.position is not null )
 AND cp.contact_number <> cp.organisation_number


END
