CREATE VIEW [GDPR].[vw_ContactEventFACT]
AS
SELECT [transaction_date], 'FIN' AS [Type], [contact_number], [source]/*,[payment_method_desc]*/ , [product_desc]
FROM    
(SELECT DISTINCT
       [fh].[contact_number]
     , CAST([fh].[transaction_date] AS DATE) AS [transaction_date]
     , [fhd].[source]
     , [pym].[payment_method_desc]
     , [prd].[product_desc]
	 ,RANK() OVER (PARTITION BY contact_number  ORDER BY [fh].[transaction_date] DESC, [fhd].[source] )  AS rnk
FROM [DiabetesDWH].[cis].[financial_history] AS [fh]
     INNER JOIN [DiabetesDWH].[cis].[financial_history_details] AS [fhd] ON [fh].[batch_number] = [fhd].[batch_number]
                                                              AND [fh].[transaction_number] = [fhd].[transaction_number]
     LEFT OUTER JOIN  [DiabetesDWH].[cis].[payment_methods] AS [pym] ON [fh].[payment_method] = [pym].[payment_method]
     LEFT OUTER JOIN  [DiabetesDWH].[cis].[products] AS [prd] ON [fhd].[product] = [prd].[product]
WHERE [transaction_date] BETWEEN DATEADD([mm], -60, GETDATE()) AND GETDATE()
) t

 UNION ALL
SELECT [mailing_date], 'MAI' AS [Type], [contact_number], [mailing], [mailing_desc]
FROM   
(SELECT DISTINCT
       [cml].[contact_number]
     , [mhy].[mailing]
     , [mai].[mailing_desc]
     , CAST([mhy].[mailing_date] AS DATE) AS [mailing_date]
	  ,RANK() OVER (PARTITION BY contact_number  ORDER BY [mailing_date] DESC, [mhy].[mailing])  AS rnk
FROM [DiabetesDWH].[cis].[mailing_history] AS [mhy]
     INNER JOIN  [DiabetesDWH].[cis].[contact_mailings] AS [cml] ON [mhy].[mailing_number] = [cml].[mailing_number]
     INNER JOIN  [DiabetesDWH].[cis].[mailings] AS [mai] ON [mhy].[mailing] = [mai].[mailing]
                                                           AND SUBSTRING([mhy].[mailing],7,1) = 'D'
WHERE [mhy].[mailing_date] BETWEEN DATEADD([mm], -60, GETDATE()) AND GETDATE()
AND cml.contact_number IS NOT null
) t1

WHERE t1.rnk = 1