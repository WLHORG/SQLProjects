-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimOrderPayment]
AS
BEGIN
		SET NOCOUNT ON;

		

 SELECT 0 as order_number
, NULL AS scheduled_payment_number
, NULL AS batch_number
, NULL AS transaction_number
, NULL AS line_number
, NULL AS due_date
, NULL AS claim_date
, NULL AS  schedule_amount_due
, NULL AS  scheduled_payment_status
, NULL AS payment_number
, NULL AS  order_payment_history_amount
, NULL AS  order_payment_history_status
, NULL AS posted --Notes from cis.maintenance_attributes table:'Y/N. Set to Y by Batch Update to show that the payment has been posted.'
, NULL AS  line_type_desc
, NULL AS discount
, NULL AS vat_rate
, GETDATE() as DW_LoadDate



 UNION ALL 

--orders and order_details level
--Order_Payment_Schedule, Order_Payment_History and Batch_Transaction_Analysis level
select CAST(ops.order_number as int) as order_number
, ops.scheduled_payment_number
, bta.batch_number
, bta.transaction_number
, bta.line_number
, ops.due_date
, ops.claim_date
, ops.amount_due as schedule_amount_due
, case when ops.scheduled_payment_status = 'A' then 'Arrears'
              when ops.scheduled_payment_status = 'C' then 'Cancelled'
              when ops.scheduled_payment_status = 'D' then 'Due'
              when ops.scheduled_payment_status = 'F' then 'Fully Paid'
              when ops.scheduled_payment_status = 'P' then 'Part Paid'
              when ops.scheduled_payment_status = 'S' then 'Skipped Payment'
              when ops.scheduled_payment_status = 'U' then 'Unprocessed Payment'
              when ops.scheduled_payment_status = 'V' then 'Provisional'
              when ops.scheduled_payment_status = 'W' then 'Written Off'
       end as scheduled_payment_status
, oph.payment_number
, oph.amount as order_payment_history_amount
, case when oph.[status] is NULL then 'Normal'
              when oph.[status] = 'A' then 'Payment Has Been Adjusted'
              when oph.[status] = 'B' then 'Status Of I Changed To This When In-advance Payment Allocated Against Order'
              when oph.[status] = 'I' then 'Record Created By An In-Advance Payment'
              when oph.[status] = 'M' then 'Payment Has Been Moved'
              when oph.[status] = 'R' then 'Payment Has Been Reversed'
       end as order_payment_history_status
, oph.posted --Notes from cis.maintenance_attributes table:'Y/N. Set to Y by Batch Update to show that the payment has been posted.'
, case when bta.line_type = 'B' then 'Legacy Bequest Receipt'
              when bta.line_type = 'C' then 'Covenant Payment'
              when bta.line_type = 'D' then 'Gift In-memoriam & Hard Credit'
              when bta.line_type = 'F' then 'Gift In-memoriam & Soft Credit'
              when bta.line_type = 'G' then 'Gift In-memoriam'
              when bta.line_type = 'H' then 'Hard Credit'
              when bta.line_type = 'I' then 'Incentive'
              when bta.line_type = 'L' then 'S/L Allocation of Cash-Invoice'
              when bta.line_type = 'M' then 'Membership Payment'
              when bta.line_type = 'N' then 'S/L Invoice Payment'
              when bta.line_type = 'O' then 'Payment Plan Payment'
              when bta.line_type = 'P' then 'Product Sale'
              when bta.line_type = 'S' then 'Soft Credit'
              when bta.line_type = 'U' then 'S/L Unallocated Cash'
              when bta.line_type = 'X' then 'Event Pricing Matrix'
       end as line_type_desc
,  bta.discount
,  bta.vat_rate
, GETDATE() as DW_LoadDate
from DiabetesDWH.cis.order_payment_schedule as ops
inner join DiabetesDWH.cis.order_payment_history as oph on ops.scheduled_payment_number=oph.scheduled_payment_number
                                                                                  and ops.order_number=oph.order_number
left join DiabetesDWH.cis.batch_transaction_analysis as bta on oph.batch_number=bta.batch_number
                                                                                  and oph.transaction_number=bta.transaction_number
                                                                                  and oph.line_number=bta.line_number


END
