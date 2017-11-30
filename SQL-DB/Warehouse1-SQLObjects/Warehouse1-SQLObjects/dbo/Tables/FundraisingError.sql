﻿CREATE TABLE [dbo].[FundraisingError] (
    [transaction_date]   DATETIME        NULL,
    [source]             VARCHAR (10)    NULL,
    [OrgName]            VARCHAR (80)    NULL,
    [ContactName]        VARCHAR (80)    NULL,
    [CISContactNumber]   INT             NULL,
    [address]            VARCHAR (200)   NULL,
    [postcode]           VARCHAR (10)    NULL,
    [branch]             VARCHAR (4)     NULL,
    [batch_number]       NUMERIC (18)    NULL,
    [transaction_number] NUMERIC (18)    NULL,
    [rate]               VARCHAR (4)     NULL,
    [line_number]        NUMERIC (18)    NULL,
    [transaction_type]   VARCHAR (3)     NULL,
    [FundrasingRegion]   NVARCHAR (50)   NULL,
    [transaction_origin] VARCHAR (3)     NULL,
    [payment_method]     VARCHAR (4)     NULL,
    [order_number]       NUMERIC (18)    NULL,
    [distribution_code]  VARCHAR (10)    NULL,
    [product]            VARCHAR (20)    NULL,
    [quantity]           NUMERIC (18)    NULL,
    [amount]             NUMERIC (38, 2) NULL,
    [vat_amount]         NUMERIC (9, 2)  NULL,
    [ErrorMsg]           NVARCHAR (50)   NULL,
    [ErrorDate]          DATETIME        NULL
);

