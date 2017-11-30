-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimAddressLinks]
AS
BEGIN

SELECT  ISNULL(def.isDefault, '0') as isDefault
		, cu.address_usage
		, ISNULL((SELECT CAST(o.contact_number as INT) contact_number from  [DiabetesDWH].[cis].[contacts] o where contact_type IN ('C', 'J') AND o.contact_number = ca.contact_number AND o.label_name <> 'N/A'), 0)  as ContactNumber
		, ISNULL((SELECT CAST(o.contact_number as INT) contact_number from [DiabetesDWH].[cis].[contacts] o where contact_type = 'O' AND o.contact_number = ca.contact_number), 0)  as OrgNumber
		, UPPER(a.[address]) as Address
		, ca.historical
		, ca.valid_from
		, ca.valid_to
		, GETDATE() as [DW_LoadDate]
		FROM [DiabetesDWH].[cis].[contact_addresses]  ca 
INNER JOIN [DiabetesDWH].[cis].[addresses] a ON ca.address_number = a.address_number
LEFT OUTER JOIN (SELECT address_usage, address_number, contact_number from  [DiabetesDWH].[cis].[contact_address_usages] UNION ALL SELECT address_usage,  address_number, organisation_number from  [DiabetesDWH].[cis].[organisation_address_usages]) cu
ON ca.contact_number = cu.contact_number
LEFT OUTER JOIN (SELECT '1' as isDefault, c.contact_number, c.address_number FROM [DiabetesDWH].[cis].[contact_addresses] a INNER JOIN [DiabetesDWH].[cis].contacts c ON a.contact_number = c.contact_number) def
				ON cu.contact_number = def.contact_number AND cu.address_number = def.address_number



END
