


/* ==============================================================================================================
-- Author:		Lindsay Scott

-- Create date: 09/02/2015

-- Description:	Populates custom.cis_current_wl
--				This replaces the vw_current_wl from Cisreporting
--	
#01	02/06/2015	EAS	Removed payment methods checks to ensure picking up all current weekly lottery players, not 
					just those with payment methods of 'DD', 'CASH', 'CC', 'CHQ'

			
-- ============================================================================================================ */
CREATE PROCEDURE [custom].[spPopulateCIS_current_wl] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


truncate table custom.cis_current_wl


insert into custom.cis_current_wl
(contact_number)
select distinct	contacts.contact_number
from cis.contacts as contacts
inner join cis.orders as orders on contacts.contact_number=orders.contact_number							
inner join cis.order_details as order_details on orders.order_number=order_details.order_number
where ((order_details.product in ('SRLTWANULTIC','SRLTWINVANULTIC') 
		and orders.last_payment_date between dateadd(mm,-14,getdate())and getdate()
		and orders.cancelled_on is null) 
	or (order_details.product in ('SRLTWBIANTIC','SRLTWINVBIANTIC') 
		and orders.last_payment_date between dateadd(mm,-8,getdate())and getdate()
		and orders.cancelled_on is null	)
	or (order_details.product in ('SRLTWQTRLTIC','SRLTWINVQTRLTIC') 
		and orders.last_payment_date between dateadd(mm,-5,getdate())and getdate()
		and orders.cancelled_on is null	)
	or (order_details.product in ('SRLTWMTHTIC','SRLTWINVMTHTIC') 
		and orders.last_payment_date between dateadd(mm,-3,getdate())and getdate()
		and orders.cancelled_on is null))							
-- and orders.payment_method = 'DD'								-- #01
																	
--current weekly lottery players -- Cash 						
union
select distinct	fin_hist.contact_number
--from vw_fin_hist as fin_hist
from [wft].[wft_financial_history_merge] as fin_hist
where ((product in ('SRLTWANULTIC', 'SRLTWINVANULTIC') and transaction_date between dateadd(mm,-14,getdate()) and getdate())
	or (product in ('SRLTWBIANTIC', 'SRLTWINVBIANTIC') and transaction_date between dateadd(mm,-8,getdate())and getdate())
	or (product in ('SRLTWQTRLTIC', 'SRLTWINVQTRLTIC') and transaction_date between dateadd(mm,-5,getdate())and getdate())
	or (product in ('SRLTWMTHTIC', 'SRLTWINVMTHTIC') and transaction_date between dateadd(mm,-3,getdate())and getdate()))	
--and fin_hist.payment_method in ('CASH',						-- #01
--								'CC',							-- #01
--								'CHQ')							-- #01
END



