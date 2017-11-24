-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimCommunications]
AS
BEGIN

	 SELECT  CAST((ISNULL((SELECT o.contact_number from  [DiabetesDWH].[cis].[contacts] o where contact_type = 'O' AND o.contact_number = c.contact_number), 0 )) as INT) as CISOrg_Number
			,CAST((ISNULL((SELECT o.contact_number from  [DiabetesDWH].[cis].[contacts] o where contact_type IN ('C', 'J') AND o.contact_number = c.contact_number), 0 )) as INT) as  CISContact_Number
			,'CL' as CommsType
			,cl.direction
			,cl.dated 
			,cs.topic
			, t.topic_desc
			,cs.sub_topic
			, st.sub_topic_desc
			,NULL as [address]
			,'' as [mailing_by] 
			,0 as mailing_number
			,0 as [number_in_mailing]
			,'' as [mailing_filename]
			,GETDATE() as [DW_LoadDate]
			FROM [DiabetesDWH].[cis].[communications_log] cl 
			INNER JOIN [DiabetesDWH].[cis].[communications_log_subjects] cs ON cl.communications_log_number = cs.communications_log_number
			INNER JOIN [DiabetesDWH].[cis].[topics] t ON cs.topic = t.topic
			INNER JOIN [DiabetesDWH].[cis].[sub_topics] st ON cs.topic = st.topic AND st.sub_topic = cs.sub_topic
			INNER JOIN [DiabetesDWH].[cis].[contacts] c ON cl.contact_number = c.contact_number
			WHERE cl.dated  >  DATEADD(YEAR, DATEDIFF(YEAR, 0, DATEADD(YEAR, -3, GETDATE())), 0)
			
UNION ALL 

SELECT * FROM (
	SELECT  DISTINCT  CAST((ISNULL((SELECT o.contact_number from  [DiabetesDWH].[cis].[contacts] o where contact_type = 'O' AND o.contact_number = cm.contact_number), 0 )) as INT) as CISOrg_Number
				      ,CAST((ISNULL((SELECT o.contact_number from  [DiabetesDWH].[cis].[contacts] o where contact_type IN ('C', 'J') AND o.contact_number = cm.contact_number), 0 )) as INT) as  CISContact_Number
					  ,'M' as CommsType
					  ,'O' as Direction
					  ,mh.mailing_date as dated
					  ,mh.mailing as topic
					  ,m.mailing_desc as topic_desc
					  ,'' as sub_topic
					  ,'' as sub_topic_desc
					  ,a.[address] 
					  ,mh.[mailing_by]
					  ,mh.mailing_number
					  ,mh.[number_in_mailing] 
					  ,mh.[mailing_filename]
					  ,GETDATE() as [DW_LoadDate]
	FROM       DiabetesDWH.cis.mailing_history AS mh 
	INNER JOIN DiabetesDWH.cis.contact_mailings AS cm ON mh.mailing_number = cm.mailing_number
	INNER JOIN DiabetesDWH.cis.mailings AS m ON mh.mailing = m.mailing
	INNER JOIN DiabetesDWH.cis.Addresses a ON cm.address_number = a.address_number
	WHERE mh.mailing_date >  DATEADD(YEAR, DATEDIFF(YEAR, 0, DATEADD(YEAR, -3, GETDATE())), 0)
						   ) t

END
