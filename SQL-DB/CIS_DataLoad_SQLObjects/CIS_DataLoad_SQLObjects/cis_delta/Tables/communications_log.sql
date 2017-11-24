﻿CREATE TABLE [cis_delta].[communications_log] (
    [communications_log_number] NUMERIC (18)    NOT NULL,
    [contact_number]            NUMERIC (18)    NOT NULL,
    [address_number]            NUMERIC (18)    NOT NULL,
    [document_type]             VARCHAR (4)     NULL,
    [created_by]                VARCHAR (14)    NOT NULL,
    [precis]                    VARCHAR (2000)  NULL,
    [document_class]            VARCHAR (4)     NOT NULL,
    [direction]                 VARCHAR (1)     NOT NULL,
    [our_reference]             VARCHAR (20)    NULL,
    [their_reference]           VARCHAR (20)    NULL,
    [document]                  VARBINARY (MAX) NULL,
    [department]                VARCHAR (4)     NOT NULL,
    [standard_document]         VARCHAR (10)    NULL,
    [archiver]                  VARCHAR (4)     NULL,
    [recipient]                 VARCHAR (4)     NULL,
    [forwarded]                 DATETIME        NULL,
    [completed]                 DATETIME        NULL,
    [dated]                     DATETIME        NOT NULL,
    [received]                  DATETIME        NULL,
    [package]                   VARCHAR (10)    NULL,
    [in_use_by]                 VARCHAR (14)    NULL,
    [distributed]               VARCHAR (1)     NULL,
    [call_duration]             VARCHAR (6)     NULL,
    [total_duration]            VARCHAR (6)     NULL,
    [source]                    VARCHAR (10)    NULL,
    [subject]                   VARCHAR (80)    NULL,
    [selection_set]             NUMERIC (18)    NULL,
    CONSTRAINT [PK_communications_log_1] PRIMARY KEY CLUSTERED ([communications_log_number] ASC)
);

