-- ==============================================================================================================
-- Author:		Lindsay Scott

-- Create date:	24/02/2015

-- Description:	Populates custom.[cis_catalogue_financial_history] and custom.[cis_catalogue_financial_history_detail]
--				This replaces the vw_catalogue_financial_history 
--					and vw_catalogue_financial_history_detail from Cisreporting
--				
-- ============================================================================================================
CREATE PROCEDURE [custom].[spPopulateCIS_catalogue_financial_history] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


truncate table custom.[cis_catalogue_financial_history]

insert into custom.[cis_catalogue_financial_history]
(batch_number
,transaction_number
,contact_number
,transaction_date
,transaction_type
,bank_details_number
,amount
,payment_method
,reference
,posted
,address_number
,[status]
,currency_amount
,transaction_origin)

SELECT   fnh.batch_number
		,MIN(fnh.transaction_number) AS transaction_number
		,fnh.contact_number
		,fnh.transaction_date
		,MIN(fnh.transaction_type) AS transaction_type
		,fnh.bank_details_number
		,SUM(fnh.amount) AS amount
		,fnh.payment_method
		,MIN(fnh.reference) AS reference
		,fnh.posted
		,fnh.address_number
		,MAX(fnh.status) AS status
		,SUM(fnh.currency_amount) AS currency_amount
		,fnh.transaction_origin
FROM	 cis.financial_history			fnh 
WHERE	 fnh.transaction_origin IN ('BTBE', 'BTBP', 'BTBT', 'BTBW') 
GROUP BY fnh.batch_number
		,fnh.contact_number
		,fnh.transaction_date
		--,fnh.transaction_type
		,fnh.bank_details_number
		,fnh.payment_method
		,fnh.posted
		,fnh.address_number
		,fnh.transaction_origin
UNION
SELECT   fnh.batch_number
		,fnh.transaction_number
		,fnh.contact_number
		,fnh.transaction_date
		,fnh.transaction_type
		,fnh.bank_details_number
		,fnh.amount
		,fnh.payment_method
		,fnh.reference
		,fnh.posted
		,fnh.address_number
		,fnh.status
		,fnh.currency_amount
		,fnh.transaction_origin
FROM	 cis.financial_history			fnh 
WHERE	 fnh.transaction_origin = 'WBSW'

truncate table custom.cis_catalogue_financial_history_detail

insert into custom.cis_catalogue_financial_history_detail
(batch_number
,transaction_number
,line_number
,original_transaction_number
,original_line_number
,amount
,IsFree
,product
,rate
,source
,quantity
,vat_rate
,vat_amount
,status
,sales_contact_number
,invoice_payment
,distribution_code
,currency_amount
,currency_vat_amount)
SELECT   fhd.batch_number
		,(SELECT	MIN(t.transaction_number)
			FROM	cis.financial_history	t
			WHERE	t.batch_number		= fnh.batch_number
			AND		t.contact_number	= fnh.contact_number) AS transaction_number
		,ROW_NUMBER() OVER(PARTITION BY fnh.batch_number, fnh.contact_number ORDER BY fhd.transaction_number ASC) AS line_number
		,fhd.transaction_number AS original_transaction_number
		,fhd.line_number		AS original_line_number
		,fhd.amount
		,CASE
			WHEN fhd.amount <> 0.00
			THEN 'N'
			ELSE 'Y'
		 END AS IsFree
		,fhd.product
		,fhd.rate
		,fhd.source
		,fhd.quantity
		,fhd.vat_rate
		,fhd.vat_amount
		,fhd.status
		,fhd.sales_contact_number
		,fhd.invoice_payment
		,fhd.distribution_code
		,fhd.currency_amount
		,fhd.currency_vat_amount
FROM	 cis.financial_history			fnh 
		 INNER JOIN
         cis.financial_history_details	fhd 
         ON  fnh.batch_number		= fhd.batch_number
         AND fnh.transaction_number	= fhd.transaction_number
WHERE	 fnh.transaction_origin IN ('BTBE', 'BTBP', 'BTBT', 'BTBW')
UNION
SELECT   fhd.batch_number
		,fhd.transaction_number
		,fhd.line_number
		,fhd.transaction_number AS original_transaction_number
		,fhd.line_number		AS original_line_number
		,fhd.amount
		,CASE
			WHEN fhd.amount <> 0.00
			THEN 'N'
			ELSE 'Y'
		 END AS IsFree		
		,fhd.product
		,fhd.rate
		,fhd.source
		,fhd.quantity
		,fhd.vat_rate
		,fhd.vat_amount
		,fhd.status
		,fhd.sales_contact_number
		,fhd.invoice_payment
		,fhd.distribution_code
		,fhd.currency_amount
		,fhd.currency_vat_amount
FROM	 cis.financial_history			fnh 
		 INNER JOIN
         cis.financial_history_details	fhd 
         ON  fnh.batch_number		= fhd.batch_number
         AND fnh.transaction_number	= fhd.transaction_number
WHERE	 fnh.transaction_origin = 'WBSW'


END



