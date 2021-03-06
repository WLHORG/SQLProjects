﻿CREATE TABLE [cis].[products] (
    [product]                    VARCHAR (20)   NOT NULL,
    [product_desc]               VARCHAR (60)   NOT NULL,
    [extra_key]                  VARCHAR (20)   NULL,
    [product_vat_category]       VARCHAR (1)    NOT NULL,
    [nominal_account]            VARCHAR (16)   NOT NULL,
    [company]                    VARCHAR (4)    NOT NULL,
    [sales_group]                VARCHAR (6)    NULL,
    [stock_item]                 VARCHAR (1)    NOT NULL,
    [despatch_method]            VARCHAR (4)    NULL,
    [subscription]               VARCHAR (1)    NOT NULL,
    [donation]                   VARCHAR (1)    NOT NULL,
    [cost_of_sale]               NUMERIC (9, 2) NULL,
    [cost_of_sale_account]       VARCHAR (16)   NULL,
    [cost_of_sale_accrual]       VARCHAR (16)   NULL,
    [course]                     VARCHAR (1)    NOT NULL,
    [accommodation]              VARCHAR (1)    NOT NULL,
    [postage_packing]            VARCHAR (1)    NOT NULL,
    [uses_product_numbers]       VARCHAR (1)    NULL,
    [next_product_number]        NUMERIC (18)   NULL,
    [max_numbers_allowed]        NUMERIC (18)   NULL,
    [source]                     VARCHAR (10)   NULL,
    [warehouse]                  VARCHAR (2)    NULL,
    [bin_number]                 VARCHAR (6)    NULL,
    [weight]                     NUMERIC (5, 3) NULL,
    [sort_group]                 NUMERIC (18)   NULL,
    [history_only]               VARCHAR (1)    NOT NULL,
    [activity]                   VARCHAR (6)    NULL,
    [activity_value]             VARCHAR (4)    NULL,
    [secondary_group]            VARCHAR (4)    NULL,
    [product_category]           VARCHAR (8)    NULL,
    [start_date]                 DATETIME       NULL,
    [last_stock_count]           NUMERIC (18)   NULL,
    [original_cost]              NUMERIC (9, 2) NULL,
    [amended_by]                 VARCHAR (14)   NOT NULL,
    [amended_on]                 DATETIME       NOT NULL,
    [sales_description]          VARCHAR (255)  NULL,
    [subsequent_nominal_account] VARCHAR (16)   NULL,
    [sales_quantity]             NUMERIC (18)   NULL,
    [minimum_quantity]           NUMERIC (18)   NULL,
    [maximum_quantity]           NUMERIC (18)   NULL,
    [sponsorship_event]          VARCHAR (1)    NULL,
    [eligible_for_gift_aid]      VARCHAR (1)    NOT NULL,
    [pack_product]               VARCHAR (1)    NOT NULL,
    [web_publish]                VARCHAR (1)    NULL
);

