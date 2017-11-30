CREATE TABLE [cis].[duk_fin_hist_reconciliation] (
    [batch_number]          NUMERIC (38)    NOT NULL,
    [transaction_number]    NUMERIC (38)    NOT NULL,
    [line_number]           NUMERIC (38, 2) NOT NULL,
    [transaction_date]      DATETIME2 (7)   NOT NULL,
    [amount]                NUMERIC (9, 2)  NOT NULL,
    [payment_method]        VARCHAR (4)     NOT NULL,
    [transaction_type]      VARCHAR (3)     NOT NULL,
    [fh_status]             VARCHAR (1)     NULL,
    [transaction_origin]    VARCHAR (10)    NULL,
    [fhd_status]            VARCHAR (1)     NULL,
    [old_product]           VARCHAR (20)    NULL,
    [old_rate]              VARCHAR (4)     NULL,
    [old_source]            VARCHAR (10)    NOT NULL,
    [old_distribution_code] VARCHAR (10)    NULL,
    [new_product]           VARCHAR (40)    NULL,
    [new_rate]              VARCHAR (4)     NULL,
    [new_source]            VARCHAR (10)    NULL,
    [new_distribution_code] VARCHAR (10)    NULL
);

