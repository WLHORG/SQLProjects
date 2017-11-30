CREATE TABLE [cis].[legacy_bequest_receipts] (
    [legacy_number]      NUMERIC (18)   NOT NULL,
    [bequest_number]     NUMERIC (18)   NOT NULL,
    [receipt_number]     NUMERIC (18)   NOT NULL,
    [amount]             NUMERIC (9, 2) NOT NULL,
    [batch_number]       NUMERIC (18)   NOT NULL,
    [transaction_number] NUMERIC (18)   NOT NULL,
    [line_number]        NUMERIC (18)   NOT NULL,
    [amended_by]         VARCHAR (14)   NOT NULL,
    [amended_on]         DATETIME       NOT NULL,
    [date_received]      DATETIME       NOT NULL,
    [notes]              VARCHAR (1)    NULL,
    [status]             VARCHAR (1)    NULL
);

