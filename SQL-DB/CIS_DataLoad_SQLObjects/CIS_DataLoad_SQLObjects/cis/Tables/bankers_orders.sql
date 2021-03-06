﻿CREATE TABLE [cis].[bankers_orders] (
    [bankers_order_number]       NUMERIC (18)   NOT NULL,
    [contact_number]             NUMERIC (18)   NOT NULL,
    [address_number]             NUMERIC (18)   NOT NULL,
    [order_number]               NUMERIC (18)   NOT NULL,
    [reference]                  VARCHAR (18)   NULL,
    [start_date]                 DATE           NULL,
    [amount]                     NUMERIC (9, 2) NOT NULL,
    [bank_account]               VARCHAR (4)    NOT NULL,
    [bank_details_number]        NUMERIC (18)   NOT NULL,
    [cancellation_reason]        VARCHAR (4)    NULL,
    [cancelled_on]               DATE           NULL,
    [cancelled_by]               VARCHAR (14)   NULL,
    [amended_by]                 VARCHAR (14)   NOT NULL,
    [amended_on]                 DATETIME       NOT NULL,
    [source]                     VARCHAR (10)   NOT NULL,
    [standing_order_type]        VARCHAR (1)    NULL,
    [cancellation_source]        VARCHAR (10)   NULL,
    [created_by]                 VARCHAR (14)   NULL,
    [created_on]                 DATETIME       NULL,
    [future_cancellation_reason] VARCHAR (4)    NULL,
    [future_cancellation_date]   DATETIME       NULL,
    [future_cancellation_source] VARCHAR (10)   NULL
);

