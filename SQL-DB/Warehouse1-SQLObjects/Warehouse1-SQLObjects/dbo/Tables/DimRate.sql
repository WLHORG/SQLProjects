﻿CREATE TABLE [dbo].[DimRate] (
    [PK_ID]                       INT          IDENTITY (1, 1) NOT NULL,
    [rate]                        VARCHAR (4)  NOT NULL,
    [product]                     VARCHAR (20) NULL,
    [current_price]               FLOAT (53)   NULL,
    [future_price]                FLOAT (53)   NULL,
    [price_change_date]           DATETIME     NULL,
    [history_only]                VARCHAR (1)  NULL,
    [nominal_account_suffix]      VARCHAR (15) NULL,
    [rate_desc]                   VARCHAR (30) NULL,
    [concessionary]               VARCHAR (1)  NULL,
    [vat_exclusive]               VARCHAR (1)  NULL,
    [amended_by]                  VARCHAR (14) NULL,
    [amended_on]                  DATETIME     NULL,
    [currency_code]               VARCHAR (3)  NULL,
    [subsequent_nominal_suffix]   VARCHAR (15) NULL,
    [current_price_lower_limit]   FLOAT (53)   NULL,
    [current_price_upper_limit]   FLOAT (53)   NULL,
    [future_price_lower_limit]    FLOAT (53)   NULL,
    [future_price_upper_limit]    FLOAT (53)   NULL,
    [fixed_price]                 VARCHAR (1)  NULL,
    [upper_lower_price_mandatory] VARCHAR (1)  NULL,
    [days_prior_from]             INT          NULL,
    [days_prior_to]               INT          NULL,
    [membership_lookup_group]     VARCHAR (4)  NULL,
    [use_modifiers]               VARCHAR (1)  NULL,
    [price_is_percentage]         VARCHAR (1)  NULL,
    [web_publish]                 VARCHAR (1)  NULL,
    [DW_LoadDate]                 DATETIME     NULL,
    CONSTRAINT [PK_DimRate] PRIMARY KEY CLUSTERED ([PK_ID] ASC)
);

