CREATE TABLE [cis].[order_payment_history] (
    [batch_number]             NUMERIC (18)   NOT NULL,
    [transaction_number]       NUMERIC (18)   NOT NULL,
    [line_number]              NUMERIC (18)   NOT NULL,
    [payment_number]           NUMERIC (18)   NOT NULL,
    [order_number]             NUMERIC (18)   NOT NULL,
    [amount]                   NUMERIC (9, 2) NOT NULL,
    [balance]                  NUMERIC (9, 2) NOT NULL,
    [status]                   VARCHAR (1)    NULL,
    [scheduled_payment_number] NUMERIC (18)   NULL,
    [posted]                   VARCHAR (1)    NULL
);

