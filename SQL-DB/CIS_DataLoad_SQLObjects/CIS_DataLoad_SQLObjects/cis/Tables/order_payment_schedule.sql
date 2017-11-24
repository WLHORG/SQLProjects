CREATE TABLE [cis].[order_payment_schedule] (
    [scheduled_payment_number] NUMERIC (18)   NOT NULL,
    [order_number]             NUMERIC (18)   NOT NULL,
    [due_date]                 DATETIME       NOT NULL,
    [claim_date]               DATETIME       NULL,
    [amount_due]               NUMERIC (9, 2) NOT NULL,
    [amount_outstanding]       NUMERIC (9, 2) NOT NULL,
    [revised_amount]           NUMERIC (9, 2) NULL,
    [expected_balance]         NUMERIC (9, 2) NOT NULL,
    [scheduled_payment_status] VARCHAR (1)    NOT NULL,
    [schedule_creation_reason] VARCHAR (2)    NOT NULL,
    [amended_by]               VARCHAR (14)   NOT NULL,
    [amended_on]               DATETIME       NOT NULL
);

