﻿CREATE TABLE [cis].[direct_debits] (
    [direct_debit_number]        NUMERIC (18)   NOT NULL,
    [contact_number]             NUMERIC (18)   NOT NULL,
    [address_number]             NUMERIC (18)   NOT NULL,
    [order_number]               NUMERIC (18)   NOT NULL,
    [start_date]                 DATE           NULL,
    [bank_details_number]        NUMERIC (18)   NOT NULL,
    [bank_account]               VARCHAR (4)    NOT NULL,
    [cancellation_reason]        VARCHAR (4)    NULL,
    [cancelled_on]               DATE           NULL,
    [cancelled_by]               VARCHAR (14)   NULL,
    [amended_on]                 DATETIME       NOT NULL,
    [amended_by]                 VARCHAR (14)   NOT NULL,
    [amount]                     NUMERIC (9, 2) NULL,
    [source]                     VARCHAR (10)   NOT NULL,
    [reference]                  VARCHAR (18)   NULL,
    [first_claim]                VARCHAR (1)    NOT NULL,
    [emandate_created]           DATETIME       NULL,
    [auddis_cancel_notified]     DATETIME       NULL,
    [cancellation_source]        VARCHAR (10)   NULL,
    [mandate_type]               VARCHAR (1)    NULL,
    [created_by]                 VARCHAR (14)   NULL,
    [created_on]                 DATETIME       NULL,
    [future_cancellation_reason] VARCHAR (4)    NULL,
    [future_cancellation_date]   DATETIME       NULL,
    [future_cancellation_source] VARCHAR (10)   NULL
);
