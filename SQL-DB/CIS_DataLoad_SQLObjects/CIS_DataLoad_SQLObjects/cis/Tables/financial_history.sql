CREATE TABLE [cis].[financial_history] (
    [batch_number]        NUMERIC (18)    NOT NULL,
    [transaction_number]  NUMERIC (18)    NOT NULL,
    [contact_number]      NUMERIC (18)    NOT NULL,
    [transaction_date]    DATETIME        NOT NULL,
    [transaction_type]    VARCHAR (3)     NOT NULL,
    [bank_details_number] NUMERIC (18)    NULL,
    [amount]              NUMERIC (9, 2)  NOT NULL,
    [payment_method]      VARCHAR (4)     NOT NULL,
    [reference]           VARCHAR (18)    NULL,
    [posted]              DATETIME        NULL,
    [address_number]      NUMERIC (18)    NOT NULL,
    [status]              VARCHAR (1)     NULL,
    [currency_amount]     NUMERIC (13, 2) NOT NULL,
    [transaction_origin]  VARCHAR (10)    NULL,
    [notes]               VARCHAR (MAX)   NULL
);

