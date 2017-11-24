CREATE TABLE [cis_delta].[invoices] (
    [contact_number]             NUMERIC (18)   NOT NULL,
    [address_number]             NUMERIC (18)   NOT NULL,
    [company]                    VARCHAR (4)    NOT NULL,
    [batch_number]               NUMERIC (18)   NOT NULL,
    [transaction_number]         NUMERIC (18)   NOT NULL,
    [invoice_number]             NUMERIC (18)   NULL,
    [invoice_date]               DATETIME       NULL,
    [payment_due]                DATETIME       NULL,
    [sales_ledger_batch]         VARCHAR (6)    NULL,
    [sales_ledger_account]       VARCHAR (9)    NULL,
    [invoice_pay_status]         VARCHAR (1)    NULL,
    [invoice_dispute_code]       VARCHAR (4)    NULL,
    [amount_paid]                NUMERIC (9, 2) NULL,
    [record_type]                VARCHAR (1)    NULL,
    [reprint_count]              NUMERIC (18)   NOT NULL,
    [deposit_amount]             NUMERIC (9, 2) NULL,
    [print_invoice]              VARCHAR (1)    NULL,
    [print_job_number]           NUMERIC (18)   NULL,
    [provisional_invoice_number] NUMERIC (18)   NULL
);

