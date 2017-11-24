CREATE TABLE [cis].[financial_history_details] (
    [batch_number]         NUMERIC (18)    NOT NULL,
    [transaction_number]   NUMERIC (18)    NOT NULL,
    [line_number]          NUMERIC (18)    NULL,
    [amount]               NUMERIC (9, 2)  NOT NULL,
    [product]              VARCHAR (20)    NULL,
    [rate]                 VARCHAR (4)     NULL,
    [source]               VARCHAR (10)    NOT NULL,
    [quantity]             NUMERIC (18)    NULL,
    [vat_rate]             VARCHAR (1)     NULL,
    [vat_amount]           NUMERIC (9, 2)  NULL,
    [status]               VARCHAR (1)     NULL,
    [sales_contact_number] NUMERIC (18)    NULL,
    [invoice_payment]      VARCHAR (1)     NOT NULL,
    [distribution_code]    VARCHAR (10)    NULL,
    [currency_amount]      NUMERIC (13, 2) NOT NULL,
    [currency_vat_amount]  NUMERIC (13, 2) NOT NULL
);

