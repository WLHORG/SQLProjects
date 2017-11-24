﻿CREATE TABLE [dbo].[DimOrder] (
    [PK_ID]               INT          IDENTITY (1, 1) NOT NULL,
    [order_number]        INT          NOT NULL,
    [order_type]          VARCHAR (1)  NULL,
    [FK_Contact]          INT          NULL,
    [FK_Address]          INT          NULL,
    [order_date]          DATETIME     NULL,
    [renewal_date]        DATETIME     NULL,
    [payment_method]      VARCHAR (4)  NULL,
    [payment_frequency]   VARCHAR (1)  NULL,
    [frequency_amount]    FLOAT (53)   NULL,
    [renewal_amount]      FLOAT (53)   NULL,
    [last_payment]        FLOAT (53)   NULL,
    [last_payment_date]   DATETIME     NULL,
    [next_payment_due]    DATETIME     NULL,
    [bankers_order]       VARCHAR (1)  NULL,
    [direct_debit]        VARCHAR (1)  NULL,
    [covenant]            VARCHAR (1)  NULL,
    [credit_card]         VARCHAR (1)  NULL,
    [payment_number]      INT          NULL,
    [cancellation_reason] VARCHAR (4)  NULL,
    [cancelled_on]        DATE         NULL,
    [membership_type]     VARCHAR (4)  NULL,
    [created_by]          VARCHAR (20) NULL,
    [order_source]        VARCHAR (10) NULL,
    [cancellation_source] VARCHAR (10) NULL,
    [DW_LoadDate]         DATETIME     NOT NULL,
    CONSTRAINT [PK_DimOrder] PRIMARY KEY CLUSTERED ([PK_ID] ASC),
    CONSTRAINT [FK_DimOrder_DimAddresses] FOREIGN KEY ([FK_Address]) REFERENCES [dbo].[DimAddresses] ([PK_ID]),
    CONSTRAINT [FK_DimOrder_DimContact] FOREIGN KEY ([FK_Contact]) REFERENCES [dbo].[DimContact] ([PK_ID])
);

