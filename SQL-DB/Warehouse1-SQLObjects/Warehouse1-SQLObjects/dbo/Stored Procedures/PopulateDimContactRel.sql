-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimContactRel]
AS
BEGIN
SET NOCOUNT ON;

    SELECT  c.label_name as contact1
, CAST(c.contact_number as int) as contact_number
      , c2.label_name as contact2
	  ,  CAST(c2.contact_number as int) as contact_number2
      , l.[relationship]
	  , r.relationship_desc
      , l.[historical]
	  , l.[valid_from]
      , l.[valid_to]  
	  , GETDATE() as  [DW_LoadDate]

  FROM [DiabetesDWH].[cis].[contact_links] l 
  INNER JOIN [DiabetesDWH].[cis].[relationships] r ON l.relationship = r.[relationship]
  INNER JOIN [DiabetesDWH].[cis].[contacts] c ON l.contact_number_1 = c.contact_number
  INNER JOIN [DiabetesDWH].[cis].[contacts] c2 ON l.contact_number_2 = c2.contact_number
END
