-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimOrder]
AS
BEGIN
		SET NOCOUNT ON;
		
SELECT  0 as order_number
, NULL AS order_type
, 0 AS contact_number
, NULL AS address_number
, NULL AS  [address]
, NULL AS order_date
, NULL AS renewal_date
, NULL AS payment_method
, NULL AS payment_frequency
, NULL AS frequency_amount
, NULL AS renewal_amount
, NULL AS last_payment
, NULL AS last_payment_date
, NULL AS next_payment_due
, NULL AS bankers_order
, NULL AS direct_debit
, NULL AS covenant
, NULL AS credit_card
, NULL AS payment_number
, NULL AS cancellation_reason
, NULL AS cancelled_on
, NULL AS membership_type
, NULL AS created_by
, NULL AS order_source
, NULL AS cancellation_source
, GETDATE() as DW_LoadDate

UNION ALL

--orders and order_details level
select ord.order_number
, ord.order_type
, CAST(ord.contact_number as INT) AS contact_number
, ord.address_number
, UPPER(a.[address]) as [address]
, ord.order_date
, ord.renewal_date
, ord.payment_method
, ord.payment_frequency
, ord.frequency_amount
, ord.renewal_amount
, ord.last_payment
, ord.last_payment_date
, ord.next_payment_due
, ord.bankers_order
, ord.direct_debit
, ord.covenant
, ord.credit_card
, ord.payment_number
, ord.cancellation_reason
, ord.cancelled_on
, ord.membership_type
, ord.created_by
, ord.[source] as order_source
, ord.cancellation_source
, GETDATE() as DW_LoadDate
--INTO WAREHOUSE1..DimOrder
from DiabetesDWH.cis.orders as ord
INNER JOIN DiabetesDWH.cis.[addresses] a ON a.address_number = ord.address_number


END
