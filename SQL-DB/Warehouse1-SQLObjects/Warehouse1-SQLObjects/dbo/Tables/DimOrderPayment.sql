CREATE TABLE [dbo].[DimOrderPayment] (
    [PK_ID]                        INT          IDENTITY (1, 1) NOT NULL,
    [FK_Order]                     INT          NOT NULL,
    [scheduled_payment_number]     INT          NULL,
    [batch_number]                 INT          NULL,
    [transaction_number]           INT          NULL,
    [line_number]                  INT          NULL,
    [due_date]                     DATETIME     NULL,
    [claim_date]                   DATETIME     NULL,
    [schedule_amount_due]          FLOAT (53)   NULL,
    [scheduled_payment_status]     VARCHAR (19) NULL,
    [payment_number]               INT          NULL,
    [order_payment_history_amount] FLOAT (53)   NULL,
    [order_payment_history_status] VARCHAR (75) NULL,
    [posted]                       VARCHAR (1)  NULL,
    [line_type_desc]               VARCHAR (30) NULL,
    [discount]                     FLOAT (53)   NULL,
    [vat_rate]                     VARCHAR (1)  NULL,
    [DW_LoadDate]                  DATETIME     NOT NULL,
    CONSTRAINT [PK_DimOrderPayment] PRIMARY KEY CLUSTERED ([PK_ID] ASC),
    CONSTRAINT [FK_DimOrderPayment_DimOrder] FOREIGN KEY ([FK_Order]) REFERENCES [dbo].[DimOrder] ([PK_ID])
);

