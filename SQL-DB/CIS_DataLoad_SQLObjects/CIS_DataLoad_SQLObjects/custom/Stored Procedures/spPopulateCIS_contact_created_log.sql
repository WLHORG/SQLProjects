
-- ==============================================================================================================
-- Author:		Lindsay Scott

-- Create date: 19/01/2015

-- Description:	Populates cis_contact_created_log table (custom.cis_contact_created_log)
								
-- ============================================================================================================
CREATE PROCEDURE [custom].[spPopulateCIS_contact_created_log] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

insert into custom.cis_contact_created_log
(contact_number
, source
, source_date
, created_by
, created_on
, log_updated_on)
select c.contact_number
	, c.source
	, c.source_date
	, c.amended_by
	, c.amended_on
	, DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE()))
from cis.contacts c
where c.contact_number not in (select contact_number 
								from custom.cis_contact_created_log)

END

