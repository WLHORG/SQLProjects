CREATE TABLE [cis].[invoice_pay_statuses] (
    [invoice_pay_status]      VARCHAR (1)  NOT NULL,
    [invoice_pay_status_desc] VARCHAR (30) NOT NULL,
    [not_paid]                VARCHAR (1)  NOT NULL,
    [part_paid]               VARCHAR (1)  NOT NULL,
    [fully_paid]              VARCHAR (1)  NOT NULL,
    [pending_dd_payment]      VARCHAR (1)  NOT NULL
);

