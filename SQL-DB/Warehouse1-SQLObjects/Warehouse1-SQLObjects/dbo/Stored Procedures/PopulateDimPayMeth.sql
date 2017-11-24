-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimPayMeth]
AS
BEGIN
SELECT payment_method, payment_method_desc, getdate() as DW_LoadDate FROM [DiabetesDWH].[cis].[payment_methods]

END
