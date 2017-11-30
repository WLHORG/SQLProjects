-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimOrderDetails]
AS
BEGIN
		SET NOCOUNT ON;
SELECT 0 order_number
, NULL as detail_number
, NULL as product
, NULL as rate
, NULL as amount
, NULL as detailline_source
 , GETDATE() as DW_LoadDate

 UNION ALL 

--orders and order_details level
SELECT CAST(odt.order_number as int) as order_number
, odt.detail_number
, odt.product
, odt.rate
, odt.amount
, odt.[source] as detailline_source
 , GETDATE() as DW_LoadDate
FROM DiabetesDWH.cis.order_details odt 

END
