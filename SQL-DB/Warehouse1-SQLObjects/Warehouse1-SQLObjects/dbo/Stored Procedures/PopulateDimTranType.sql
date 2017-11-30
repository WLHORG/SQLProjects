-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimTranType]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT  [transaction_type]
      ,[transaction_type_desc]
      ,[transaction_sign]
      ,[negatives_allowed]
	  , GETDATE()  as  [DW_LoadDate]
  FROM [DiabetesDWH].[cis].[transaction_types]
END
