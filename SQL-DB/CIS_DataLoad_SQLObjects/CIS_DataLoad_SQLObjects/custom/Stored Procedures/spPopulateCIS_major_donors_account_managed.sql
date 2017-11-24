


-- ==============================================================================================================
-- Author:		Lindsay Scott

-- Create date: 13/01/2015

-- Description:	Populates CIS Major Donors Account managed ([custom].[cis_major_donors_account_managed])
--				This table replaces the [dbo].[vw_MS_LC_MD_Account_Managed] view
				
--	AMENDED: 30 JUNE 2015 --http://camdukcppv01:8080/redmine/issues/6495				
-- ============================================================================================================
CREATE PROCEDURE [custom].[spPopulateCIS_major_donors_account_managed] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

truncate table custom.cis_major_donors_account_managed

insert into custom.cis_major_donors_account_managed
(contact_number
, label_name
, activity_value
, activity_value_desc)
select     
c.contact_number
,c.label_name
,cc.activity_value
,a.activity_value_desc
from cis.contacts c
inner join cis.contact_categories cc
on c.contact_number = cc.contact_number
inner join cis.activity_values a
on cc.activity = a.activity and cc.activity_value = a.activity_value
where cc.activity = 'corpam'
and cc.activity_value in ('mp','be','eho','kl'
							,'AW','BB','LSM','PMO','SKA','TB'-- #6495 Changes
							, 'AHA') --#8731 change -  
and cc.valid_to >= getdate()
union
select
o.organisation_number
,o.name
,oc.activity_value
,a.activity_value_desc
from
cis.organisations o
inner join cis.organisation_categories oc
on o.organisation_number = oc.organisation_number
inner join cis.activity_values a
on oc.activity = a.activity and oc.activity_value = a.activity_value
where oc.activity = 'corpam'
and oc.activity_value in ('mp','be','eho','kl'
							,'AW','BB','LSM','PMO','SKA','TB'-- #6495 Changes)
							, 'AHA') --#8731 change -
and oc.valid_to >= getdate()

END



