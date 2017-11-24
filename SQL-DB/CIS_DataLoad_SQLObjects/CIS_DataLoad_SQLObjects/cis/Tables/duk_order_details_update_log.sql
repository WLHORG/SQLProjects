CREATE TABLE [cis].[duk_order_details_update_log] (
    [contact_number]        NUMERIC (38)  NULL,
    [order_number]          NUMERIC (38)  NOT NULL,
    [detail_number]         NUMERIC (38)  NOT NULL,
    [source]                VARCHAR (10)  NOT NULL,
    [product]               VARCHAR (20)  NOT NULL,
    [rate]                  VARCHAR (4)   NOT NULL,
    [distribution_code]     VARCHAR (10)  NULL,
    [created_by]            VARCHAR (14)  NOT NULL,
    [created_on]            DATETIME2 (7) NOT NULL,
    [new_source]            VARCHAR (10)  NULL,
    [new_product]           VARCHAR (40)  NULL,
    [new_rate]              VARCHAR (4)   NULL,
    [new_distribution_code] VARCHAR (10)  NULL
);

