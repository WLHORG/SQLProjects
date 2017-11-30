
-- ==============================================================================================================
-- Author:		Lindsay Scott

-- Create date: 09/01/2015

-- Description:	Populates CIS Contact_To_Topic and Subtopic table ([custom].[cis_contact_topic_subtopic])
--				This table is used to map contact_numberss to topics and sub topics in CIS
								
-- ============================================================================================================
CREATE PROCEDURE [custom].[spPopulateCIS_contact_topic_subtopic] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

truncate table [custom].[cis_contact_topic_subtopic]

insert into [custom].[cis_contact_topic_subtopic]
(communications_log_number
, [source]
, contact_number
, topic
, topic_desc
, sub_topic
, sub_topic_desc
, amended_on
, dated
, created_by
, direction)
select cl.communications_log_number
		, cl.[source]
		, cl.contact_number
		, cls.topic
		, tpc.topic_desc
		, cls.sub_topic
		, stp.sub_topic_desc
		, cls.amended_on
		, cl.dated
		, cl.created_by
		, cl.direction
from cis.communications_log cl
inner join cis.communications_log_subjects cls on cl.communications_log_number=cls.communications_log_number
inner join cis.topics as tpc on cls.topic=tpc.topic
inner join cis.sub_topics as stp on cls.topic=stp.topic 
									and cls.sub_topic=stp.sub_topic
END
