CREATE TABLE [cis].[duk_sources] (
    [source]               VARCHAR (15) NULL,
    [source_desc]          VARCHAR (60) NULL,
    [df_flag]              CHAR (1)     NULL,
    [df_batch_type]        CHAR (1)     NULL,
    [df_mapping]           VARCHAR (10) NULL,
    [acq_source_group]     VARCHAR (4)  NULL,
    [acq_source_sub_group] VARCHAR (4)  NULL,
    [donation_product]     VARCHAR (20) NULL,
    [donation_rg_product]  VARCHAR (20) NULL,
    [web_alias]            VARCHAR (20) NULL,
    [rate]                 VARCHAR (4)  NULL,
    [amended_by]           VARCHAR (14) NULL,
    [amended_on]           DATETIME     NULL,
    [num_ring_fence_days]  INT          NULL,
    [is_event]             CHAR (1)     NULL
);

