CREATE TABLE [cis_delta].[bank_accounts] (
    [bank_account]           VARCHAR (4)  NOT NULL,
    [bank_account_desc]      VARCHAR (30) NOT NULL,
    [company]                VARCHAR (4)  NOT NULL,
    [cash_book_bank_account] VARCHAR (16) NOT NULL,
    [sort_code]              VARCHAR (6)  NULL,
    [account_number]         VARCHAR (9)  NULL,
    [so_clearance_account]   VARCHAR (16) NULL,
    [cash_batch_prefix]      VARCHAR (2)  NOT NULL,
    [cash_batch_number]      NUMERIC (18) NOT NULL,
    [claim_day]              NUMERIC (18) NULL,
    [amended_by]             VARCHAR (14) NOT NULL,
    [amended_on]             DATETIME     NOT NULL,
    [interface_code]         VARCHAR (4)  NULL,
    [default_source]         VARCHAR (10) NULL,
    [default_product]        VARCHAR (20) NULL,
    [default_rate]           VARCHAR (4)  NULL
);

