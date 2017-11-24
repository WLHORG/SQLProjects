-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimOrg]
AS
BEGIN
	SELECT	DISTINCT	'N/A' as name 
			, 'N/A' as label_name
			, 0 as CISContactNumber
			, '' as salutation
			, '' as [source]
			, '' as source_date 
			,'' as  [status]
			, ''  as status_date
			, ''  as status_reason
			, ''  as contact_type	
			, ''  as ownership_group
			, ''   as branch
			, GETDATE()  as [DW_LoadDate]



	UNION ALL




SELECT		 t.surname as name 
			, t.label_name
			,t.contact_number as CISContactNumber
			, t.salutation
			, t.[source]
			, t.source_date 
			, ISNULL(t.[status], '') as [status]
			, ISNULL(t.status_date, '')    as status_date
			, ISNULL(t.status_reason, '')    as status_reason
			, t.contact_type	
			, t.ownership_group
			--, t.diabetes_type 
			, ISNULL(t1.branch, '')    as branch
			, GETDATE()  as [DW_LoadDate]
		
	FROM [DiabetesDWH].[cis].[Contacts]t   -- where is contacts  C not O
	LEFT OUTER JOIN [DiabetesDWH].[custom].[cis_contact_to_nation] t1 ON t.contact_number = t1.contact_number
	WHERE t.contact_type = 'O'

END
