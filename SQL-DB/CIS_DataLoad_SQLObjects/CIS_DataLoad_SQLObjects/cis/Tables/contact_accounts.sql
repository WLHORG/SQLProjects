CREATE TABLE [cis].[contact_accounts] (
    [bank_details_number] NUMERIC (18)  NOT NULL,
    [contact_number]      NUMERIC (18)  NOT NULL,
    [sort_code]           VARCHAR (6)   NULL,
    [account_number]      VARCHAR (34)  NULL,
    [account_name]        VARCHAR (80)  NULL,
    [amended_by]          VARCHAR (14)  NOT NULL,
    [amended_on]          DATETIME      NOT NULL,
    [bank_payer_name]     VARCHAR (18)  NULL,
    [notes]               VARCHAR (MAX) NULL,
    [default_account]     VARCHAR (1)   NULL,
    [history_only]        VARCHAR (1)   NOT NULL
);

