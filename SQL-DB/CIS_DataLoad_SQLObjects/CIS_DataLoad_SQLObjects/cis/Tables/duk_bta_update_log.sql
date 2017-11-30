CREATE TABLE [cis].[duk_bta_update_log] (
    [contact_number]        NUMERIC (38)  NOT NULL,
    [batch_number]          NUMERIC (38)  NOT NULL,
    [transaction_number]    NUMERIC (38)  NOT NULL,
    [line_number]           NUMERIC (38)  NOT NULL,
    [source]                VARCHAR (10)  NOT NULL,
    [product]               VARCHAR (20)  NOT NULL,
    [rate]                  VARCHAR (4)   NOT NULL,
    [distribution_code]     VARCHAR (10)  NULL,
    [amended_by]            VARCHAR (14)  NOT NULL,
    [amended_on]            DATETIME2 (7) NOT NULL,
    [new_source]            VARCHAR (10)  NULL,
    [new_product]           VARCHAR (40)  NULL,
    [new_rate]              VARCHAR (4)   NULL,
    [new_distribution_code] VARCHAR (10)  NULL
);

