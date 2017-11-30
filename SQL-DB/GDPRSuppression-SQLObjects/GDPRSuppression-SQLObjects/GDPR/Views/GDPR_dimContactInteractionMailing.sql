CREATE VIEW [GDPR].[GDPR_dimContactInteractionMailing]
AS



SELECT CAST ([contact_number] AS NUMERIC(18,0)) [contact_number], [mailing_date],[Type], [mailing], [mailing_desc]
FROM
 (
SELECT [mailing_date], 'MAI' AS [Type], [contact_number], [mailing], [mailing_desc]
FROM   
(SELECT DISTINCT
       [cml].[contact_number]
     , [mhy].[mailing]
     , [mai].[mailing_desc]
     , [mhy].[mailing_date]
	 ,RANK() OVER (PARTITION BY contact_number  ORDER BY [mailing_date] DESC, [mhy].[mailing])  AS rnk
FROM [DiabetesDWH].[cis].[mailing_history] AS [mhy]
  INNER JOIN  [DiabetesDWH].[cis].[contact_mailings] AS [cml] ON [mhy].[mailing_number] = [cml].[mailing_number]
     INNER JOIN  [DiabetesDWH].[cis].[mailings] AS [mai] ON [mhy].[mailing] = [mai].[mailing]
                                                           AND SUBSTRING([mhy].[mailing],7,1) = 'D'

) t1
WHERE t1.rnk = 1
) sub