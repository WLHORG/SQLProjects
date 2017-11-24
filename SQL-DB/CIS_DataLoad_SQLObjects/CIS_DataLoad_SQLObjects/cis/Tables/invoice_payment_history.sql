CREATE TABLE [cis].[invoice_payment_history] (
    [invoice_number]                NUMERIC (18)   NOT NULL,
    [batch_number]                  NUMERIC (18)   NOT NULL,
    [transaction_number]            NUMERIC (18)   NOT NULL,
    [line_number]                   NUMERIC (18)   NOT NULL,
    [amount]                        NUMERIC (9, 2) NOT NULL,
    [status]                        VARCHAR (1)    NULL,
    [provisional_invoice_number]    NUMERIC (18)   NULL,
    [allocation_date]               DATETIME       NULL,
    [allocation_batch_number]       NUMERIC (18)   NULL,
    [allocation_transaction_number] NUMERIC (18)   NULL,
    [allocation_line_number]        NUMERIC (18)   NULL
);

