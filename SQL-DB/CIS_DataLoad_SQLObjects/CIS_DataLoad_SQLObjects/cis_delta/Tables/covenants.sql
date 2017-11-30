﻿CREATE TABLE [cis_delta].[covenants] (
    [contact_number]         NUMERIC (18)   NOT NULL,
    [address_number]         NUMERIC (18)   NOT NULL,
    [covenant_number]        NUMERIC (18)   NOT NULL,
    [covenant_type]          VARCHAR (1)    NOT NULL,
    [covenant_term]          NUMERIC (18)   NOT NULL,
    [fixed]                  VARCHAR (1)    NOT NULL,
    [covenant_status]        VARCHAR (4)    NULL,
    [covenanted_amount]      NUMERIC (9, 2) NOT NULL,
    [start_date]             DATETIME2 (7)  NOT NULL,
    [signature_date]         DATETIME2 (7)  NOT NULL,
    [deposited_deed]         VARCHAR (1)    NOT NULL,
    [net]                    VARCHAR (1)    NOT NULL,
    [annual_claim]           VARCHAR (1)    NOT NULL,
    [order_number]           NUMERIC (18)   NOT NULL,
    [last_tax_claim]         DATETIME2 (7)  NULL,
    [tax_claimed_to]         DATETIME2 (7)  NULL,
    [r185_return]            DATETIME2 (7)  NULL,
    [r185_sent]              DATETIME2 (7)  NULL,
    [cancellation_reason]    VARCHAR (4)    NULL,
    [cancelled_on]           DATETIME2 (7)  NULL,
    [cancelled_by]           VARCHAR (14)   NULL,
    [source]                 VARCHAR (10)   NOT NULL,
    [amended_by]             VARCHAR (14)   NOT NULL,
    [amended_on]             DATETIME2 (7)  NOT NULL,
    [created_by]             VARCHAR (14)   NOT NULL,
    [created_on]             DATETIME2 (7)  NOT NULL,
    [payment_number]         NUMERIC (18)   NOT NULL,
    [r185_payment_number]    NUMERIC (18)   NULL,
    [initial_payment_number] NUMERIC (18)   NULL,
    [cancellation_source]    VARCHAR (10)   NULL
);

