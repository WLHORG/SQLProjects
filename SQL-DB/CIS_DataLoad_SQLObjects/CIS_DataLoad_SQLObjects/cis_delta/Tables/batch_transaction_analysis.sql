﻿CREATE TABLE [cis_delta].[batch_transaction_analysis] (
    [batch_number]            NUMERIC (18)    NOT NULL,
    [transaction_number]      NUMERIC (18)    NOT NULL,
    [line_number]             NUMERIC (18)    NOT NULL,
    [line_type]               VARCHAR (1)     NOT NULL,
    [product]                 VARCHAR (20)    NULL,
    [rate]                    VARCHAR (4)     NULL,
    [quantity]                NUMERIC (18)    NULL,
    [issued]                  NUMERIC (18)    NULL,
    [gross_amount]            NUMERIC (9, 2)  NULL,
    [amount]                  NUMERIC (9, 2)  NOT NULL,
    [currency_amount]         NUMERIC (13, 2) NULL,
    [discount]                NUMERIC (9, 2)  NULL,
    [vat_rate]                VARCHAR (1)     NULL,
    [vat_amount]              NUMERIC (9, 2)  NULL,
    [currency_vat_amount]     NUMERIC (13, 2) NULL,
    [order_number]            NUMERIC (18)    NULL,
    [member_number]           VARCHAR (9)     NULL,
    [covenant_number]         NUMERIC (18)    NULL,
    [deceased_contact_number] NUMERIC (18)    NULL,
    [accept_as_full]          VARCHAR (1)     NULL,
    [despatch_method]         VARCHAR (4)     NULL,
    [source]                  VARCHAR (10)    NOT NULL,
    [when]                    DATETIME        NULL,
    [contact_number]          NUMERIC (18)    NULL,
    [address_number]          NUMERIC (18)    NULL,
    [distribution_code]       VARCHAR (10)    NULL,
    [amended_by]              VARCHAR (14)    NOT NULL,
    [amended_on]              DATETIME        NOT NULL,
    [sales_contact_number]    NUMERIC (18)    NULL,
    [invoice_number]          NUMERIC (18)    NULL,
    [product_number]          NUMERIC (18)    NULL,
    [warehouse]               VARCHAR (2)     NULL,
    [notes]                   VARCHAR (MAX)   NULL
);
