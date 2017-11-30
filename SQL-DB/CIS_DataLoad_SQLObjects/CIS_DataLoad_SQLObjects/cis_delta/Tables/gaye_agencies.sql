CREATE TABLE [cis_delta].[gaye_agencies] (
    [organisation_number]  NUMERIC (18)   NOT NULL,
    [post_batches_to_cb]   VARCHAR (1)    NOT NULL,
    [amended_by]           VARCHAR (14)   NOT NULL,
    [amended_on]           DATETIME       NOT NULL,
    [admin_fee_percentage] NUMERIC (6, 2) NULL,
    [minimum_admin_fee]    NUMERIC (9, 2) NULL,
    [maximum_admin_fee]    NUMERIC (9, 2) NULL
);

