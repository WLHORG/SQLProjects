﻿CREATE TABLE [cis].[gift_aid_declarations] (
    [declaration_number]  INT           NOT NULL,
    [contact_number]      INT           NOT NULL,
    [declaration_date]    DATETIME      NOT NULL,
    [declaration_type]    CHAR (1)      NOT NULL,
    [source]              VARCHAR (10)  NOT NULL,
    [confirmed_on]        DATETIME      NULL,
    [method]              CHAR (1)      NOT NULL,
    [start_date]          DATETIME      NULL,
    [end_date]            DATETIME      NULL,
    [notes]               VARCHAR (MAX) NULL,
    [amended_by]          VARCHAR (14)  NOT NULL,
    [amended_on]          DATETIME      NOT NULL,
    [batch_number]        INT           NULL,
    [transaction_number]  INT           NULL,
    [order_number]        INT           NULL,
    [cancellation_reason] VARCHAR (4)   NULL,
    [cancelled_by]        VARCHAR (14)  NULL,
    [cancelled_on]        DATETIME      NULL,
    [cancellation_source] VARCHAR (10)  NULL,
    [created_by]          VARCHAR (14)  NULL,
    [created_on]          DATETIME      NULL
);

