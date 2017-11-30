


-- ==============================================================================================================
-- Author:		Lindsay Scott

-- Create date: 23/02/2015

-- Description:	Populates cis_phoneable (custom.cis_phoneable) 
				
-- ============================================================================================================
CREATE PROCEDURE [custom].[spPopulateCIS_phoneable] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


truncate table custom.cis_phoneable

insert into custom.cis_phoneable
(contact_number)

select distinct c.contact_number 
from cis.contacts c
inner join cis.communications co on c.contact_number=co.contact_number
where co.device in ('T','TD','MB','S','TW')
and co.is_active = 'Y'
and c.[status] is null
and c.contact_number not in (select contact_number 
						from cis.contact_suppressions
						--where mailing_suppression = 'nt'
						where mailing_suppression in ('nt'
													, 'NXXD')
						and getdate() between valid_from and isnull(valid_to,'31 dec 2199'))






END



