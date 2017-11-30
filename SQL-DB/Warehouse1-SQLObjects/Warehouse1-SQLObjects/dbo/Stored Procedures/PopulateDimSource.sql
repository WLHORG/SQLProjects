-- =============================================
CREATE PROCEDURE [dbo].[PopulateDimSource]
AS
BEGIN

SELECT DISTINCT [source]
      ,[source_desc]
      ,[incentive_trigger_level]
      ,[thank_you_letter]
      ,[incentive_scheme]
      ,[history_only]
      ,[distribution_code]
      ,[discount_percentage]
      ,[df_flag]
      ,[df_batch_type]
      ,[df_mapping]
      ,[acq_source_group]
      ,[acq_source_sub_group]
      ,[donation_product]
      ,[donation_rg_product]
      ,[web_alias]
      ,[rate]
      ,[num_ring_fence_days]
      ,[is_event]
      ,[IC_mapped_product]
      ,[IC_mapped_region]
      ,[new_source]
      ,[new_source_desc]
      ,[new_cost_centre]
      ,[new_programme]
      ,[creative_version]
      ,[test_control]
      ,[yearofcampaign]
      ,[businessfunction]
      ,[category]
      ,[ask]
      ,[channel]
      ,[campaign]
      ,[campaign_desc]
      ,[campaign_type]
      ,[campaign_year]
	  ,[mh].[number_in_mailing]
	  ,[cold_list_mailing_volume]
      ,[costs]
      ,[campaign_plain_desc]
	  ,  GETDATE() as  [DW_LoadDate]
	  FROM diabetesdwh.warehouse.duk_combined_sources cs
LEFT OUTER JOIN diabetesdwh.cis.mailing_history mh
ON cs.[source] = mh.mailing


END
