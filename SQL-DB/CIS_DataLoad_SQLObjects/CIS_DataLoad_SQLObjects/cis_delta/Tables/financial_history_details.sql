CREATE TABLE [cis_delta].[financial_history_details] (
    [batch_number]         NUMERIC (18)    NOT NULL,
    [transaction_number]   NUMERIC (18)    NOT NULL,
    [line_number]          NUMERIC (18)    NOT NULL,
    [amount]               NUMERIC (9, 2)  NOT NULL,
    [product]              VARCHAR (50)    NULL,
    [rate]                 VARCHAR (50)    NULL,
    [source]               VARCHAR (50)    NOT NULL,
    [quantity]             NUMERIC (18)    NULL,
    [vat_rate]             VARCHAR (50)    NULL,
    [vat_amount]           NUMERIC (9, 2)  NULL,
    [status]               VARCHAR (50)    NULL,
    [sales_contact_number] NUMERIC (18)    NULL,
    [invoice_payment]      VARCHAR (50)    NOT NULL,
    [distribution_code]    VARCHAR (50)    NULL,
    [currency_amount]      NUMERIC (13, 2) NOT NULL,
    [currency_vat_amount]  NUMERIC (13, 2) NOT NULL
);

