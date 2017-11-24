﻿CREATE TABLE [cis_delta].[organisation_groups] (
    [organisation_group]           VARCHAR (4)   NOT NULL,
    [organisation_group_desc]      VARCHAR (30)  NOT NULL,
    [client]                       VARCHAR (14)  NULL,
    [name]                         VARCHAR (50)  NOT NULL,
    [sequence_no]                  NUMERIC (18)  NOT NULL,
    [rgb_value]                    NUMERIC (18)  NOT NULL,
    [tab_prefix]                   VARCHAR (6)   NOT NULL,
    [organisation_number]          NUMERIC (18)  NULL,
    [address_number]               NUMERIC (18)  NULL,
    [hidden_attributes]            VARCHAR (255) NULL,
    [named_attributes]             VARCHAR (255) NULL,
    [use_house_names]              VARCHAR (1)   NOT NULL,
    [amended_by]                   VARCHAR (14)  NOT NULL,
    [amended_on]                   DATETIME      NOT NULL,
    [graph_activity]               VARCHAR (6)   NULL,
    [unknown_address]              VARCHAR (35)  NULL,
    [unknown_town]                 VARCHAR (35)  NULL,
    [all_addresses_unknown]        VARCHAR (1)   NOT NULL,
    [primary_relationship]         VARCHAR (4)   NULL,
    [position_activity_prompt]     VARCHAR (1)   NULL,
    [position_relationship_prompt] VARCHAR (1)   NULL,
    [custom_table_names]           VARCHAR (255) NULL,
    [name_format]                  VARCHAR (20)  NULL,
    [last_used_id]                 INT           NULL
);

