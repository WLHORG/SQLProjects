-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimTeam]
AS
BEGIN

SELECT    CAST(cost_centre_team AS NVARCHAR(1)) as cost_centre_team
		, cost_centre_team_desc
				, GETDATE() as [DW_LoadDate]
FROM [DiabetesDWH].[cis].[duk_cost_centre_teams]


END
