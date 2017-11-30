CREATE VIEW  [GDPR].[GDPR_dimFinancialHistory]
AS
SELECT DISTINCT
       [fh].[contact_number]
     , [fh].[transaction_date]
     , [fhd].[source]
     , [pym].[payment_method_desc]
     , [prd].[product_desc]
FROM [DiabetesDWH].[cis].[financial_history] AS [fh]
     INNER JOIN [DiabetesDWH].[cis].[financial_history_details] AS [fhd] ON [fh].[batch_number] = [fhd].[batch_number]
                                                              AND [fh].[transaction_number] = [fhd].[transaction_number]
     LEFT OUTER  JOIN [DiabetesDWH].[cis].[payment_methods] AS [pym] ON [fh].[payment_method] = [pym].[payment_method]
     LEFT OUTER  JOIN [DiabetesDWH].[cis].[products] AS [prd] ON [fhd].[product] = [prd].[product]
WHERE [transaction_date] BETWEEN DATEADD([mm], -60, GETDATE()) AND GETDATE();