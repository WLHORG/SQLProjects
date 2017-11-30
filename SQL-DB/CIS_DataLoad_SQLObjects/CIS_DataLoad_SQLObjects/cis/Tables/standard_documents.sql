CREATE TABLE [cis].[standard_documents] (
    [standard_document]      VARCHAR (10)   NOT NULL,
    [standard_document_desc] VARCHAR (30)   NOT NULL,
    [document_type]          VARCHAR (4)    NOT NULL,
    [instant_print]          VARCHAR (1)    NOT NULL,
    [topic]                  VARCHAR (6)    NOT NULL,
    [sub_topic]              VARCHAR (4)    NOT NULL,
    [history_only]           VARCHAR (1)    NOT NULL,
    [mailmerge_header]       VARCHAR (6)    NULL,
    [amended_by]             VARCHAR (14)   NOT NULL,
    [amended_on]             DATETIME       NOT NULL,
    [standard_document_text] VARBINARY (1)  NULL,
    [package]                VARCHAR (10)   NULL,
    [in_use_by]              VARCHAR (14)   NULL,
    [precis]                 VARCHAR (2000) NULL,
    [subject]                VARCHAR (80)   NULL,
    [document_class]         VARCHAR (4)    NULL
);

