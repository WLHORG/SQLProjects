CREATE VIEW [GDPR].[GDPR_DimContactSegmentation]

AS


WITH cte_emailaddress AS (
SELECT [com].[contact_number]
,[com].[number] AS [email_address]
, [amended_on] AS [email_amended_on]
FROM [DiabetesDWH].[cis].[communications] AS [com]
WHERE [number] LIKE '%_@%'
      AND [number] NOT LIKE '@@%'
      AND [contact_number] IS NOT NULL
      AND [contact_number] > 0
) ,

cte_rankemail AS  (
				SELECT [ead].[contact_number]
			       , ead.email_address
				   ,[email_amended_on]
                   , ROW_NUMBER() OVER(PARTITION BY [ead].[contact_number] ORDER BY [ead].[email_address] ) AS [email_address_rows]
                   , DENSE_RANK() OVER(PARTITION BY [ead].[contact_number] ORDER BY [ead].[email_address]) AS [email_address_dense_rank]
                FROM cte_emailaddress AS ead
						)    ,
 
					          
cte_sharedcontact AS (
  SELECT [rrc].[contact_number]
		,rrc.[email_address]
       , [rrc].[email_address_rows]
       , [rrc].[email_address_dense_rank]
	  
       , CASE WHEN [shm].[contact_number] IS NOT NULL THEN 1 ELSE 0 END AS contact_shares_email_with_other_contact
	   ,  [shm].[contact_number]  AS shared_contact_number
         FROM 
		 cte_rankemail [rrc] 
        LEFT JOIN (SELECT DISTINCT [contact_number]
                          FROM cte_emailaddress
                          WHERE [email_address] IN          (SELECT [email_address]
                                                               FROM cte_emailaddress
                                                                  GROUP BY [email_address]
                           HAVING COUNT(DISTINCT [contact_number]) > 1)) AS shm ON rrc.contact_number=shm.contact_number 
 ),

 cte_segmentation AS (
 SELECT t.contact_number 
, CASE WHEN MAX(contact_shares_email_with_other_contact) = 1 THEN 1
WHEN MAX(contact_shares_email_with_other_contact) = 0 AND MAX(t.[email_address_rows]) = 1 AND MAX([email_address_dense_rank]) = 1 THEN 2
WHEN MAX(contact_shares_email_with_other_contact) = 0 AND MAX(t.[email_address_rows]) > 1   AND MAX([email_address_dense_rank]) = 1 THEN 3
WHEN MAX(contact_shares_email_with_other_contact) = 0 AND  MAX(t.[email_address_rows]) > 1  AND NOT (MAX([email_address_dense_rank]) < MAX(t.[email_address_rows]) AND MAX([email_address_dense_rank]) > 1) AND (MAX([email_address_dense_rank]) = MAX(t.[email_address_rows])
                AND MAX(t.[email_address_rows]) > 1) THEN 4
WHEN MAX(contact_shares_email_with_other_contact) = 0 AND  MAX(t.[email_address_rows]) > 1  AND  (MAX([email_address_dense_rank]) < MAX(t.[email_address_rows]) AND MAX([email_address_dense_rank]) > 1) AND NOT (MAX([email_address_dense_rank]) = MAX(t.[email_address_rows])
                AND MAX(t.[email_address_rows]) > 1)
THEN 5
ELSE 6 END AS SEGMENT
FROM cte_sharedcontact t
GROUP  BY contact_number   )


SELECT t1.contact_number
, eml.email_address
, eml.email_amended_on  
, CASE WHEN t1.SEGMENT = 1 THEN 'Segment 1: Shared Email Address' WHEN t1.SEGMENT = 2 THEN 'Segment 2b: Individual Single Email Address'  WHEN t1.SEGMENT = 3 THEN 'Segment 2ai: Individual Multiple Duplicate Email Address' WHEN t1.SEGMENT = 4 THEN 'Segment 2aii: Individual Multiple Alternative Email Address' WHEN t1.SEGMENT = 5 THEN 'Segment 2aiii: Individual Multiple Alternative Duplicate Email Address' ELSE 'OTHER' END AS SegDesc
     
 FROM cte_segmentation t1

INNER JOIN 
	 (SELECT    DISTINCT(contact_number),  [email_address], 
	  RANK() OVER(PARTITION BY contact_number ORDER BY  [email_amended_on] desc, [email_address] ) AS [latest_email] 
	   , [email_amended_on] 
		FROM cte_emailaddress ead  
	 ) as eml
	 ON t1.contact_number = eml.contact_number
	  
	
 WHERE  
 
 eml.[latest_email] = 1 
-- AND
--  t1.contact_number IN (
--  25,
--'13167'
--,'2598'
--,'4655'
--,'731'
--,'387'
--,'516'
--,'543'
--,'591'
--,'910'
--,'568'
--,'941'
--  )
--  order by 1