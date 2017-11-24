

-- ==============================================================================================================
-- Author:		Lindsay Scott

-- Create date: 22/01/2015

-- Description:	Populates custom.cis_current_rg
--				This replaces the vw_current_rg from Cisreporting
--				
-- ============================================================================================================
CREATE PROCEDURE [custom].[spPopulateCIS_current_rg] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


truncate table custom.cis_current_rg

insert into custom.cis_current_rg
(contact_number)
select distinct o.contact_number 
from cis.orders o 
	inner join cis.order_details od on o.order_number=od.order_number 
where od.product = 'DON-REGGIV-DUK-OS'
and ( (o.payment_frequency in ('M', 'I') and o.last_payment_date>dateadd(mm,-2,getdate()))
	or (o.payment_frequency in ('Q', 'J') and o.last_payment_date>dateadd(mm,-4,getdate()))
	or (o.payment_frequency in ('H', 'K') and o.last_payment_date>dateadd(mm,-7,getdate()))
	or (o.payment_frequency in ('A') and o.last_payment_date>dateadd(mm,-13,getdate())))
and o.cancelled_on is null


END
