-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimTranOrigin]
AS
BEGIN
SELECT 'N/A' as transaction_origin, 'N/A' as [transaction_origin_desc], GETDATE() as [DW_LoadDate] 

UNION ALL 

SELECT transaction_origin, [transaction_origin_desc], GETDATE() as [DW_LoadDate]  FROM [DiabetesDWH].[cis].[transaction_origins]


END
