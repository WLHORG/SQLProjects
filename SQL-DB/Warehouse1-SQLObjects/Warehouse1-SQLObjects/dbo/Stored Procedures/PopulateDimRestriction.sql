-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimRestriction]
AS
BEGIN

SELECT '' as anl_code
	, NULL as name 
	, GETDATE() as [DW_LoadDate]

UNION ALL

select anl_code
, name
, GETDATE() as [DW_LoadDate]
from [DiabetesDWH].[sun].[DUK_ANL_CODE]
where anl_cat_id = '23'

END
