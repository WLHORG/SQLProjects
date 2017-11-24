﻿CREATE TABLE [cis_delta].[ext_tf_report] (
    [organisation_number]      INT            NOT NULL,
    [organisation_source_date] DATETIME       NOT NULL,
    [organisation_number_2]    INT            NOT NULL,
    [organisation_name]        VARCHAR (80)   NOT NULL,
    [relationship]             VARCHAR (4)    NOT NULL,
    [contact_number]           INT            NOT NULL,
    [label_name]               VARCHAR (80)   NOT NULL,
    [source]                   VARCHAR (10)   NOT NULL,
    [source_desc]              VARCHAR (60)   NOT NULL,
    [product]                  VARCHAR (20)   NOT NULL,
    [product_desc]             VARCHAR (60)   NOT NULL,
    [amount]                   NUMERIC (9, 2) NOT NULL,
    [donation]                 VARCHAR (1)    NOT NULL,
    [status]                   VARCHAR (1)    NULL,
    [source_date]              DATETIME       NOT NULL,
    [transaction_date]         DATETIME       NOT NULL,
    [reference]                VARCHAR (18)   NULL,
    [batch_number]             INT            NOT NULL,
    [transaction_number]       INT            NOT NULL,
    [line_number]              INT            NULL,
    [transaction_type]         VARCHAR (3)    NOT NULL,
    [financial_links_ind]      VARCHAR (1)    NULL,
    [report_ind]               VARCHAR (2)    NULL
);

