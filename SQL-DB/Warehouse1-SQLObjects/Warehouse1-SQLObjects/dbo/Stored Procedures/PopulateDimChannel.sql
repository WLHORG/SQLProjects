-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimChannel]
AS
BEGIN

SELECT	 CAST(Channel as NVARCHAR(1)) as Channel
		,Channel_desc 
	, getdate() AS [DW_LoadDate]
FROM [DiabetesDWH].[cis].[duk_channels]

END
