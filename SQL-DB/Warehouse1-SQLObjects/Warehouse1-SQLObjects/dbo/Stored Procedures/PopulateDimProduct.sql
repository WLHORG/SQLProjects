-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimProduct]
AS
BEGIN

SELECT    '0' as product
		, 'N/A' as product_desc
		, '' as product_vat_category
		, '' as nominal_account
		, '' as expenditure_group
		, '' as company
		, '' as sales_group
		,  '' as donation
		,  '' as course
		,  '' as accommodation
		,  '' as eligible_for_gift_aid
		,  'N' as history_only
			, GETDATE() AS [DW_LoadDate]
UNION ALL 

SELECT    p.product
		, p.product_desc
		, p.product_vat_category
		, p.nominal_account
		, ISNULL(pg.expenditure_group, '') as expenditure_group
		, p.company
		, ISNULL(p.sales_group, '') as sales_group
		, p.donation
		, p.course
		, p.accommodation
		, p.eligible_for_gift_aid
		, p.history_only
		, GETDATE() AS [DW_LoadDate]
	 FROM [DiabetesDWH].[cis].[products] p 
	 LEFT OUTER JOIN [DiabetesDWH].[cis].[product_groups] pg ON p.product = pg.product


END
