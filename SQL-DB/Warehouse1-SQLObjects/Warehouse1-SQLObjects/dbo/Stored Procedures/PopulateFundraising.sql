-- =============================================
CREATE PROCEDURE [dbo].[PopulateFundraising] 

@YrsToLoad int  = NULL
AS
BEGIN 
DECLARE  @LoadDate DATETIME
SET @LoadDate =  CASE WHEN @YrsToLoad IS NULL  THEN   '1800-01-01' ELSE  CAST((YEAR(GETDATE()) - @YrsToLoad) as varchar(4))    + '0101' END 


SELECT		 fh.transaction_date
			, fhd.[source]
			, s.new_source
			, UPPER(ISNULL((SELECT o.label_name from  [DiabetesDWH].[cis].[contacts] o where contact_type = 'O' AND o.contact_number = c.contact_number), 'N/A'))  as OrgName
			, UPPER(ISNULL((SELECT o.label_name from  [DiabetesDWH].[cis].[contacts] o where contact_type IN ('C', 'J') AND o.contact_number = c.contact_number), 'N/A'))  as ContactName
			, ISNULL((SELECT CAST(o.contact_number as INT) contact_number from  [DiabetesDWH].[cis].[contacts] o where contact_type IN ('C', 'J')  AND o.contact_number = c.contact_number), 0)  as ContactNumber
			, UPPER(a.[address]) as [address]
			, ISNULL((SELECT CASE WHEN ad.address LIKE '%Unknown%' THEN 'UNKNOWN' WHEN ad.address LIKE  '%Unmatched S/O%'  THEN 'UNKNOWN' WHEN ad.address LIKE  '%N/A%'  THEN 'UNKNOWN' WHEN ad.address LIKE  '%ANON%'  THEN 'UNKNOWN' WHEN ad.country NOT IN ('UK', 'NI') THEN 'OVERSEAS'  ELSE ad.postcode END as postcode from  [DiabetesDWH].[cis].[addresses] ad where ad.[address_number] =  a.[address_number]), 'UNKNOWN')  as postcode			
			, a.branch
			, fhd.batch_number
			, fhd.transaction_number
			, fhd.line_number
			, fh.transaction_type
			, ISNULL(fh.transaction_origin ,'N/A') as transaction_origin
			, fh.payment_method
			, ISNULL(CAST(oph.order_number as INT), 0)  AS order_number
			, UPPER(a.county) as county
			, UPPER(a.town) as town
			, UPPER(ISNULL(fhd.product, 0)) as product
			, ISNULL(fhd.rate, '') as rate
			,  ISNULL(fhd.distribution_code, '') as distribution_code
			, fhd.quantity
			, ga.amount_claimed as giftaid
			, SUM(fhd.amount) as amount
			, fhd.vat_amount
			, 0 as [WkLotteryActiveLine]
			, GETDATE() as DateLoad


from [DiabetesDWH].[cis].[financial_history] as fh
inner join [DiabetesDWH].[cis].[financial_history_details] as fhd on fh.batch_number=fhd.batch_number and fh.transaction_number=fhd.transaction_number
left join (select batch_number
                           , transaction_number
                           , line_number
                           , order_number
                     from [DiabetesDWH].[cis].[order_payment_history]
					 where posted = 'Y' ) as oph on fhd.batch_number=oph.batch_number and fhd.transaction_number=oph.transaction_number
                                                                                                 and fhd.line_number=oph.line_number
LEFT OUTER JOIN (
				SELECT		dl.batch_number
							,dl.transaction_number
							,dl.line_number
							,dl.amount_claimed 
			FROM [DiabetesDWH].[cis].[declaration_tax_claims] d
			INNER JOIN [DiabetesDWH].[cis].[declaration_tax_claim_lines]  dl 
			ON d.claim_number = dl.claim_number) ga ON fhd.batch_number = ga.batch_number AND fhd.transaction_number = ga.transaction_number AND fhd.line_number = ga.line_number
INNER JOIN [DiabetesDWH].[cis].[contacts] c ON fh.contact_number = c.contact_number
LEFT OUTER JOIN [DiabetesDWH].[cis].[addresses] a ON fh.address_number = a.address_number 
LEFT OUTER JOIN (SELECT DISTINCT source, new_source FROM [DiabetesDWH].[cis].[duk_new2015_sources]) s ON fhd.source = s.source
WHERE fh.transaction_date >= @LoadDate
GROUP BY    fh.transaction_date 
			,fhd.batch_number  
			,fhd.transaction_number
			,fhd.line_number
			,c.label_name
			, c.contact_number
			,a.[address]
			,a.branch
			,fh.batch_number
			,fh.transaction_number
			,fh.contact_number
			,fh.transaction_date
			,fh.transaction_origin
			,fh.transaction_type
			,fh.payment_method
			,fhd.product
			,fhd.rate
			,fhd.distribution_code
			,fhd.rate
			,fhd.[source]
			,fhd.quantity
			,oph.order_number
			,ga.amount_claimed
			,fhd.vat_amount
			,c.contact_number
			,a.postcode
			,a.town
			,a.county
			,a.[address_number]
			,s.new_source
	


END
