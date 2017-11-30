
-- ==============================================================================================================
-- Author:		Lindsay Scott

-- Create date: 12/01/2015

-- Description:	Populates CIS Comms Log Detail table (custom.cis_comms_log_detail)
--				
-- ============================================================================================================
CREATE PROCEDURE [custom].[spPopulateCIS_comms_log_detail] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

truncate table custom.cis_comms_log_detail

insert into custom.cis_comms_log_detail
(communications_log_number
, contact_number
, dated
, topic
, sub_topic
, source
, standard_document
, direction
, precis
, created_by
, subject
, sub_topic_desc
, topic_desc)

select cl.communications_log_number
, cl.contact_number
, cl.dated
, cls.topic
, cls.sub_topic
, cl.source
, cl.standard_document
, cl.direction
, cl.precis
, cl.created_by
, cl.subject
, st.sub_topic_desc
, t.topic_desc
from cis.communications_log cl
left join cis.communications_log_subjects cls on cl.communications_log_number=cls.communications_log_number
left join cis.topics t on cls.topic = t.topic
left join cis.sub_topics st	on cls.sub_topic = st.sub_topic
								and cls.topic = st.topic




END

