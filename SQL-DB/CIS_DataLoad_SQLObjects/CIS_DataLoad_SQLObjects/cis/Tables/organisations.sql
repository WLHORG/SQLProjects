CREATE TABLE [cis].[organisations] (
    [organisation_number] NUMERIC (18)   NOT NULL,
    [address_number]      NUMERIC (18)   NOT NULL,
    [contact_number]      NUMERIC (18)   NOT NULL,
    [name]                VARCHAR (80)   NOT NULL,
    [sort_name]           VARCHAR (20)   NOT NULL,
    [abbreviation]        VARCHAR (10)   NULL,
    [dialling_code]       VARCHAR (5)    NULL,
    [std_code]            VARCHAR (8)    NULL,
    [telephone]           VARCHAR (50)   NULL,
    [source]              VARCHAR (10)   NOT NULL,
    [source_date]         DATETIME       NOT NULL,
    [status]              VARCHAR (4)    NULL,
    [status_date]         DATETIME       NULL,
    [status_reason]       VARCHAR (80)   NULL,
    [department]          VARCHAR (4)    NOT NULL,
    [notes]               NVARCHAR (MAX) NULL,
    [amended_by]          VARCHAR (14)   NOT NULL,
    [amended_on]          DATETIME       NOT NULL,
    [organisation_group]  VARCHAR (4)    NULL,
    [ownership_group]     VARCHAR (4)    NULL
);

