

-- ==============================================================================================================
-- Author:		Lindsay Scott

-- Create date: 19/01/2015

-- Description:	Populates cis_emailable (custom.cis_emailable) 
--				and populates cis_emailable_benefit (custom.cis_emailable_benefit) tables
--					
--				custom.cis_emailable
--				Table of contact numbers where contacts have email address
--				current Email Optin (EOI) suppression
--				and no current 'No Emails' Opt out (NEC) suppression
--
--				custom.cis_emailable_benefit
--				Table of contact numbers where contacts have email address
--				and no current 'No Emails' Opt out (NEC) suppression

--				Edited 26/10/2017.  Changed to allow GA contacts through, GA is postal.
				
-- ============================================================================================================
CREATE PROCEDURE [custom].[spPopulateCIS_emailable] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


truncate table custom.cis_emailable

insert into custom.cis_emailable
(contact_number)
select distinct c.contact_number 
from cis.contacts c
inner join cis.communications co on c.contact_number=co.contact_number
where co.device in ('wr','em','ec')
and co.is_active = 'Y'
and (co.valid_to is null 
	or co.valid_to >getdate())
and (co.valid_from is null
	or co.valid_from <getdate())
and (c.[status] is null 
	or [status] <> 'GA')		-- edited 26/10/2017 by paul mehta
and c.contact_number in (select contact_number 
						from cis.contact_suppressions
						--where mailing_suppression ='eoi'
						where mailing_suppression in ('eoi','IXXD')
						and getdate() between valid_from and isnull(valid_to,'31 dec 2199'))
and c.contact_number not in (select contact_number 
						from cis.contact_suppressions
						--where mailing_suppression = 'nec'
						where mailing_suppression in ('nec','NXXD')
						and getdate() between valid_from and isnull(valid_to,'31 dec 2199'))



truncate table custom.cis_emailable_benefit

insert into custom.cis_emailable_benefit
(contact_number)
select distinct c.contact_number 
from cis.contacts c
inner join cis.communications co on c.contact_number=co.contact_number
where co.device in ('wr','em','ec')
and co.is_active = 'Y'
and (co.valid_to is null 
	or co.valid_to >getdate())
and (co.valid_from is null
	or co.valid_from <getdate())
and (c.[status] is null 
	or [status] <> 'GA')		-- edited 26/10/2017 by paul mehta
and c.contact_number not in (select contact_number 
						from cis.contact_suppressions
						--where mailing_suppression = 'nec'
						where mailing_suppression in ('nec','NXXD')
						and getdate() between valid_from and isnull(valid_to,'31 dec 2199'))







END


