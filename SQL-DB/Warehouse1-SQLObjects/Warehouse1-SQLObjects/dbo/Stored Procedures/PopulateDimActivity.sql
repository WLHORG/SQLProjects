-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimActivity]
AS
BEGIN
SELECT CAST(cost_centre_activity as NVARCHAR(2)) as cost_centre_activity, cost_centre_activity_desc, GETDATE() as [DW_LoadDate] FROM [DiabetesDWH].[cis].[duk_cost_centre_activities]

END
