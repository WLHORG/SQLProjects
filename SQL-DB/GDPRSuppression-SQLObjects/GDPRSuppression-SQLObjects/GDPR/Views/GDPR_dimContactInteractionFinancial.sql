CREATE VIEW [GDPR].[GDPR_dimContactInteractionFinancial]
AS


SELECT [contact_number], [transaction_date],[Type], [source], [product_desc]
FROM
 (
SELECT [transaction_date], 'FIN' AS [Type], [contact_number], [source]/*,[payment_method_desc]*/ , [product_desc]
FROM    
(SELECT DISTINCT
       [fh].[contact_number]
     , [fh].[transaction_date]
     , [fhd].[source]
     , [pym].[payment_method_desc]
     , [prd].[product_desc]
,RANK() OVER (PARTITION BY contact_number  ORDER BY [fh].[transaction_date] DESC, [fhd].[source] )  AS rnk
FROM [DiabetesDWH].[cis].[financial_history] AS [fh]
     INNER JOIN [DiabetesDWH].[cis].[financial_history_details] AS [fhd] ON [fh].[batch_number] = [fhd].[batch_number]
                                                              AND [fh].[transaction_number] = [fhd].[transaction_number]
    LEFT OUTER JOIN  [DiabetesDWH].[cis].[payment_methods] AS [pym] ON [fh].[payment_method] = [pym].[payment_method]
    LEFT OUTER JOIN [DiabetesDWH].[cis].[products] AS [prd] ON [fhd].[product] = [prd].[product]
--WHERE [transaction_date] BETWEEN DATEADD([mm], -60, GETDATE()) AND GETDATE()
) t
WHERE t.rnk = 1
) sub